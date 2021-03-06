import { Component, NgZone, OnChanges, OnInit } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { MailService } from 'src/app/services/mail.service';
import { ModalComponent } from 'src/app/shared/modal/modal.component';
import { CAS } from './../../interfaces/cas';
import { Mark } from './../../interfaces/mark';
import { ExcelService } from './../../services/excel.service';
import { FirebaseService } from './../../services/firebase.service';
import { SqlService } from './../../services/sql.service';

@Component({
  selector: 'app-marksheet',
  templateUrl: './marksheet.component.html',
  styleUrls: ['./marksheet.component.scss']
})
export class MarksheetComponent implements OnInit, OnChanges {
  hide = {
    marksheet: false,
    returnsheet: false
  };
  panelOpenState = false;
  submited = false;
  isChecked = false;
  topGrades: any[] = [];
  poorGrades: any[] = [];
  importMarks: Mark[] = [];
  exportMarks: Mark[] = [];
  importCAS: CAS[] = [];
  roles: any[] = [];
  casMark = 30;
  endSemMark = 70;
  remark: string;
  modules: any[] = [];
  databaseResult: any[] = [];
  selectFormControl = new FormControl('', Validators.required);

  constructor(
    private excelSrv: ExcelService,
    private apiServce: SqlService,
    public auth: FirebaseService,
    private dialog: MatDialog,
    private router: Router,
    public mail: MailService,
    private zone: NgZone
  ) { }

  ngOnInit() {
    this.checkSubmission();
    this.apiServce.readModule().subscribe(mod => {
      mod.forEach(ele => {
        this.modules.push(ele.mod_id);
      });
    });
    this.apiServce.readResult().subscribe(res => {
      res.forEach(element => {
        this.databaseResult.push(element);
      });
    });
    this.apiServce.readRole().subscribe(role => {
      role.forEach(ro => {
        this.roles.push(ro);
        this.auth.user$.subscribe(user => {
          if (user.uid === ro.uid) {
            this.panelOpenState = true;
          }
        });
      });
    });
  }

  checkSubmission() {
    this.auth.user$.subscribe(res => {
      this.apiServce.readLecturer().subscribe((lec) => {
        lec.forEach(elem => {
          if (res && (res.email === elem.lec_email)) {
            this.apiServce.readLecResult().subscribe(result => {
              for (const element of result) {
                if (element.lec_id === elem.lec_id) {
                  this.submited = true;
                  this.openDialog('Already Submitted', 'You have already submitted once do you want to resubmit?');
                  return;
                } else {
                  this.submited = false;
                  break;
                }
              }
            });
          }
        });
      });
    });
  }

  onFileChange(evt: any) {
    this.poorGrades = [];
    this.topGrades = [];
    const target: DataTransfer = (evt.target as DataTransfer);
    if (target.files.length !== 1) { throw new Error('Cannot use multiple files'); }

    const reader: FileReader = new FileReader();
    reader.onload = (e: any) => {

      const bstr: string = e.target.result;
      const data = this.excelSrv.importFromFile(bstr) as any[];

      const header: string[] = Object.getOwnPropertyNames(new Mark());
      const importedData = data.slice(1, -1);

      this.importMarks = importedData.map(arr => {
        const obj = {};
        for (let i = 0; i < header.length; i++) {
          const k = header[i];
          obj[k] = arr[i];
        }
        return obj as Mark;
      });
    };

    reader.readAsBinaryString(target.files[0]);
  }

  onCASFileChange(evt: any) {
    this.poorGrades = [];
    this.topGrades = [];
    const target: DataTransfer = (evt.target as DataTransfer);
    if (target.files.length !== 1) { throw new Error('Cannot use multiple files'); }

    const reader: FileReader = new FileReader();
    reader.onload = (e: any) => {

      const bstr: string = e.target.result;
      const data = this.excelSrv.importFromFile(bstr) as any[];

      const header: string[] = Object.getOwnPropertyNames(new CAS());
      const importedData = data.slice(1, -1);

      this.importCAS = importedData.map(arr => {
        const obj = {};
        for (let i = 0; i < header.length; i++) {
          const k = header[i];
          obj[k] = arr[i];
        }
        return obj as CAS;
      });
    };

    reader.readAsBinaryString(target.files[0]);
  }


  exportData(tableId: string) {
    this.excelSrv.exportToFile(Date(), tableId);
  }

  onSuccess() {
    this.auth.user$.subscribe(user => {
      if (user.roles.setter) {
        this.importMarks.forEach((mark, index) => {
          const marksetter = {
            st_id: mark.Index,
            mod_id: String(this.selectFormControl.value),
            cas: this.importCAS && (this.checkCASIndex(mark) !== -1) ?
              String(this.importCAS[this.checkCASIndex(mark)].CAS) :
              String(this.databaseResult.indexOf(mark) !== -1 ? this.databaseResult[this.checkCASIndex(mark)].cas : ''),
            es_1: String(this.getFinal(mark)),
            es_2:
              this.databaseResult.length > 0 && this.checkESIndex(mark) !== -1 ?
                String(this.databaseResult[this.checkESIndex(mark)].es_2) : '',
            final: '',
            mark: `${mark.Q1 ? mark.Q1 : 0},${mark.Q2 ? mark.Q2 : 0},${mark.Q3 ? mark.Q3 : 0},${mark.Q4 ? mark.Q4 : 0},${mark.Q5 ? mark.Q5 : 0},${mark.Q6 ? mark.Q6 : 0}`,
            lastUpdate: null
          };
          this.apiServce.createResult(marksetter).subscribe();
        });
      }
      if (user.roles.moderator) {
        this.importMarks.forEach((mark, index) => {
          const marksmoderator = {
            st_id: mark.Index,
            mod_id: String(this.selectFormControl.value),
            cas: this.importCAS && (this.checkCASIndex(mark) !== -1) ?
              String(this.importCAS[this.checkCASIndex(mark)].CAS) :
              String(this.databaseResult.indexOf(mark) !== -1 ? this.databaseResult[this.checkCASIndex(mark)].cas : ''),
            es_1:
              this.databaseResult.length > 0 && this.checkESIndex(mark) !== -1 ?
                String(this.databaseResult[this.checkESIndex(mark)].es_1) : '',
            es_2: String(this.getFinal(mark)),
            final: '',
            mark: `${mark.Q1 ? mark.Q1 : 0},${mark.Q2 ? mark.Q2 : 0},${mark.Q3 ? mark.Q3 : 0},${mark.Q4 ? mark.Q4 : 0},${mark.Q5 ? mark.Q5 : 0},${mark.Q6 ? mark.Q6 : 0}`,
            lastUpdate: null
          };
          this.apiServce.createResult(marksmoderator).subscribe();
        });
      }
      const data = {
        lec_id: user.uid,
        mod_id: this.selectFormControl.value
      };
      this.apiServce.createLecResult(data).subscribe();
      this.mail.sendEmail('Marksheet Submission', `Marksheet for ${this.selectFormControl.value} has been submitted by ${user.uid}. Please check for any conflicts in the result`);
    });
  }

  getRoleName(value) {
    switch (value) {
      case '2': return 'a Setter';
        break;
      case '1': return 'a Moderator';
        break;
      default: return 'an Editor, for marksheet submission';
        break;
    }
  }

  dataChange(event: any[]) {
    this.importMarks = event;
  }

  addMark(mark: Mark) {
    const data = {
      Q1: mark.Q1 ? mark.Q1 : 0,
      Q2: mark.Q2 ? mark.Q2 : 0,
      Q3: mark.Q3 ? mark.Q3 : 0,
      Q4: mark.Q4 ? mark.Q4 : 0,
      Q5: mark.Q5 ? mark.Q5 : 0,
      Q6: mark.Q6 ? mark.Q6 : 0
    };
    return Number(data.Q1) + Number(data.Q2) + Number(data.Q3) + Number(data.Q4) + Number(data.Q5) + Number(data.Q6);
  }

  checkESIndex(mark): number {
    let temp = -1;
    this.databaseResult.forEach((element, index) => {
      if (element.st_id === mark.Index && element.mod_id === this.selectFormControl.value) {
        temp = index;
      }
    });
    return temp;
  }

  checkCASIndex(mark): number {
    let temp = -1;
    if (this.databaseResult.length > 0) {
      this.databaseResult.forEach((res, index) => {
        if (res.Index === mark.Index) {
          temp = index;
        }
      });
    }
    if (temp === -1) {
      this.importCAS.forEach((element, index) => {
        if (element.Index === mark.Index) {
          temp = index;
        }
      });
    }
    return temp;
  }

  getGrade(mark) {
    const finalMark = this.getFinal(mark);
    if (finalMark <= 100 && finalMark >= 85) {
      return 'A+';
    } else if (finalMark < 85 && finalMark >= 75) {
      return 'A';
    } else if (finalMark < 75 && finalMark >= 70) {
      return 'A-';
    } else if (finalMark < 70 && finalMark >= 65) {
      return 'B+';
    } else if (finalMark < 65 && finalMark >= 60) {
      return 'B';
    } else if (finalMark < 60 && finalMark >= 55) {
      return 'B-';
    } else if (finalMark < 55 && finalMark >= 50) {
      return 'C+';
    } else if (finalMark < 50 && finalMark >= 45) {
      return 'C';
    } else if (finalMark < 45 && finalMark >= 40) {
      return 'C-';
    } else if (finalMark < 40 && finalMark >= 35) {
      return 'D+';
    } else {
      return 'Ie/Ia';
    }
  }

  getCAS(mark: CAS) {
    for (const elem of this.importCAS) {
      if (elem.Index === mark.Index) {
        return (this.casMark * elem.CAS) / 100;
      }
    }
  }

  getFinal(mark) {
    const endMark = this.addMark(mark);
    const cas = this.getCAS(mark);
    if (cas != null && endMark != null) {
      if ((cas + (this.endSemMark * endMark) / 100) < 35) {
        if (!this.poorGrades.includes(mark)) {
          this.poorGrades.push(mark);
        }
      } else if ((cas + (this.endSemMark * endMark) / 100) > 65) {
        if (!this.topGrades.includes(mark)) {
          this.topGrades.push(mark);
        }
      }
      return this.isChecked ? Math.round(cas + (this.endSemMark * endMark) / 100) : cas + (this.endSemMark * endMark) / 100;
    } else {
      return this.isChecked ? Math.round((this.endSemMark * endMark) / 100) : (this.endSemMark * endMark) / 100;
    }
  }

  onChange(event) {
    this.topGrades = [];
    this.poorGrades = [];
  }


  sendRemark() {
    if (this.remark !== '') {
      this.mail.sendEmail('Remarks', `${this.remark}`)
      this.openDialog('Sending Remarks', 'Remarks will be sent to HOD');
    }
  }

  openDialog(title: string, content?: string) {
    this.dialog.closeAll();
    const dialogRef = this.dialog.open(ModalComponent, {
      position: {
        top: '10vh'
      },
      width: '600px',
      disableClose: true,
      data: {
        title,
        content,
        cancelText: 'Cancel',
        confirmText: 'Submit Again'
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      this.submited = !result;
      if (result === false) {
        this.zone.run(() => {
          this.router.navigate(['home/editor/dashboard']);
        });
      }
    });
  }

  ngOnChanges() {
    this.topGrades = [];
    this.poorGrades = [];
  }

}
