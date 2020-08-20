import { FirebaseService } from './../../services/firebase.service';
import { MatDialog } from '@angular/material/dialog';
import { Component, OnInit, AfterViewInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  showFiller = false;
  constructor(
    private dialog: MatDialog,
    public auth: FirebaseService
  ) { }

  ngOnInit() {
    this.dialog.closeAll();
  }
}
