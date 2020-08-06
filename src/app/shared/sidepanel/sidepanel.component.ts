import { FirebaseService } from './../../services/firebase.service';
import { Component, AfterViewInit } from '@angular/core';
declare var M: any;
@Component({
  selector: 'app-sidepanel',
  templateUrl: './sidepanel.component.html',
  styleUrls: ['./sidepanel.component.scss']
})
export class SidepanelComponent implements AfterViewInit{
  constructor(public auth: FirebaseService) { }

  ngAfterViewInit(): void {
    M.AutoInit();
  }
}
