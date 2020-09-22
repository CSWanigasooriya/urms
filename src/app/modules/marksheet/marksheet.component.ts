import { Component, OnInit } from '@angular/core';
import { FormControl, Validators } from '@angular/forms';
import { CAS } from './../../interfaces/cas';
import { Lecturer } from './../../interfaces/lecturer';
import { Mark } from './../../interfaces/mark';
import { ExcelService } from './../../services/excel.service';
import { FirebaseService } from './../../services/firebase.service';
import { SqlService } from './../../services/sql.service';

@Component({
  selector: 'app-marksheet',
  templateUrl: './marksheet.component.html',
  styleUrls: ['./marksheet.component.scss']
})
export class MarksheetComponent implements OnInit {
  hide = {
    marksheet: false,
    returnsheet: false
  };
  user;
  lecid;
  submited = false;
  topGrades: any[] = [];
  poorGrades: any[] = [];
  importMarks: Mark[] = [];
  exportMarks: Mark[] = [];
  importCAS: CAS[] = [];
  casMark = 25;
  endSemMark = 75;
  modules: any[] = [];
  selectFormControl = new FormControl('', Validators.required);

  constructor(
    private excelSrv: ExcelService,
    private apiServce: SqlService,
    public auth: FirebaseService
  ) { }

  async ngOnInit() {
    await this.auth.user$.subscribe(res => {
      this.user = res;
      this.apiServce.readLecturer().subscribe((lec: Lecturer[]) => {
        lec.forEach(elem => {
          if (this.user.email === elem.lec_email) {
            this.lecid = elem.lec_id;
          }
        });
      });
    });
    this.apiServce.readModule().subscribe(mod => {
      mod.forEach(ele => {
        this.modules.push(ele.mod_id);
      });
    });
    this.apiServce.readLecResult().subscribe(res => {
      res.forEach(elem => {
        if (elem.lec_id === this.lecid) {
          this.submited = true;
        }
      });
    });
  }

  onFileChange(evt: any) {
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
            mod_id: this.selectFormControl.value,
            cas: String(this.importCAS[index].CAS),
            es_1: String(this.getFinal(mark)),
            es_2: '',
            final: '',
            mark: `${mark.Q1 ? mark.Q1 : 0},${mark.Q2 ? mark.Q2 : 0},${mark.Q3 ? mark.Q3 : 0},${mark.Q4 ? mark.Q4 : 0},${mark.Q5 ? mark.Q5 : 0},${mark.Q6 ? mark.Q6 : 0}`
          };
          this.apiServce.createResult(marksetter).subscribe();
        });
      } else if (user.roles.moderator) {
        this.importMarks.forEach((mark, index) => {
          const marksmoderator = {
            st_id: mark.Index,
            mod_id: this.selectFormControl.value,
            cas: String(this.importCAS[index].CAS),
            es_1: '',
            es_2: String(this.getFinal(mark)),
            final: '',
            mark: `${mark.Q1 ? mark.Q1 : 0},${mark.Q2 ? mark.Q2 : 0},${mark.Q3 ? mark.Q3 : 0},${mark.Q4 ? mark.Q4 : 0},${mark.Q5 ? mark.Q5 : 0},${mark.Q6 ? mark.Q6 : 0}`
          };
          this.apiServce.createResult(marksmoderator).subscribe();
        });
      }
      const data = {
        lec_id: user.uid,
        mod_id: this.selectFormControl.value
      };
      this.apiServce.createLecResult(data).subscribe();
    });
  }


  dataChange(event: any[]) {
    this.importMarks = event;
  }


  filterModule(ele) {
    return ele >= 18;
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

  getGrade(mark) {
    const finalMark = this.getFinal(mark);
    if (finalMark <= 100 && finalMark >= 85) {
      return 'A+';
    } else if (finalMark < 84 && finalMark >= 75) {
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
    } else if (finalMark < 35 && finalMark >= 30) {
      return 'D';
    } else if (finalMark < 30 && finalMark >= 0) {
      return 'E';
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
      return cas + (this.endSemMark * endMark) / 100;
    } else {
      return (this.endSemMark * endMark) / 100;
    }
  }

}
