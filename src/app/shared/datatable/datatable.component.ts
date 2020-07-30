import { MatPaginator } from '@angular/material/paginator';
import { AngularFirestore } from '@angular/fire/firestore';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Component, AfterViewInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import * as faker from 'faker';

@Component({
  selector: 'app-datatable',
  templateUrl: './datatable.component.html',
  styleUrls: ['./datatable.component.scss']
})

export class DatatableComponent implements AfterViewInit {

  displayedColumns = ['name', 'age', 'email', 'phrase', 'edit'];
  dataSource: MatTableDataSource<any>;


  @ViewChild(MatSort) sort: MatSort;
  @ViewChild(MatPaginator, { static: true }) paginator: MatPaginator;

  constructor(private afs: AngularFirestore, public dialog: MatDialog) { }


  ngAfterViewInit() {
    this.afs.collection<any>(`users`).valueChanges().subscribe(data => {
      this.dataSource = new MatTableDataSource(data);
      this.dataSource.sort = this.sort;
      this.dataSource.paginator = this.paginator;
    });
  }


  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();
  }


  // Database seeding
  addOne() {
    const user = {
      name: faker.name.findName(),
      age: String(faker.random.number({ min: 18, max: 99 })),
      email: faker.internet.email(),
      phrase: faker.hacker.phrase(),
      uid: faker.random.alphaNumeric(16)
    };
    this.afs.collection('users').doc(user.uid).set(user);
  }

  deleteOne(elm) {
    this.dataSource.data = this.dataSource.data
      .filter(i => i !== elm)
      .map((i, idx) => (i.position = (idx + 1), i));
    const uid = this.trackByUid(elm);
    this.afs.collection('users').doc(uid).delete();
  }

  editOne(elm) {
    const uid = this.trackByUid(elm);
    this.afs.collection('users').doc(uid).set({
      name: 'Chamath',
      age: '20',
      email: 'chamathwanigasooriya@gmail.com',
      phrase: 'Never Settle'
    }, { merge: true });
  }

  trackByUid(item) {
    return item.uid;
  }

}

