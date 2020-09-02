import { FormControl, Validators } from '@angular/forms';
import { Module } from './../../interfaces/module';
import { Lecturer } from './../../interfaces/lecturer';
import { FirebaseService } from './../../services/firebase.service';
import { Mark } from './../../interfaces/mark';
import { SqlService } from './../../services/sql.service';
import { ExcelService } from './../../services/excel.service';
import { Component, OnInit, AfterViewInit } from '@angular/core';

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

  importMarks: Mark[] = [];
  exportMarks: Mark[] = [];
  modules = [];
  selectFormControl = new FormControl('', Validators.required);

  constructor(
    private excelSrv: ExcelService,
    private apiServce: SqlService,
    public auth: FirebaseService
  ) { }

  async ngOnInit() {
    await this.auth.user$.subscribe(user => {
      this.apiServce.readLecturer().subscribe((lec: Lecturer[]) => {
        this.apiServce.readModule().subscribe(mod => {
          for (const element of lec) {
            if (user.email === element.lec_email) {
              const lecId = element.lec_id;
              mod.forEach(module => {
                if (lecId === module.lec_id) {
                  this.modules.push(module.mod_id);
                }
              });
            }
          }
        });
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

  exportData(tableId: string) {
    this.excelSrv.exportToFile(Date(), tableId);
  }

  onSuccess() {
    for (const i of this.importMarks) {
      const data = {
        res_id: '123',
        st_id: 'i.Index',
        mod_id: '2',
        cas: '3',
        end_sem: 'i.Total',
        final: '5'
      };
      this.apiServce.createResult(data).subscribe(res => {
        if (res != null) {
          this.hide.marksheet = true;
        }
      });
    }
  }

  dataChange(event: any[]) {
    this.importMarks = event;
  }


  filterModule(element) {
    return element >= 18;
  }

  addMark(mark: Mark) {
    return String(mark.Q1 + mark.Q2 + mark.Q3 + mark.Q4 + mark.Q5 + mark.Q6);
  }

}
