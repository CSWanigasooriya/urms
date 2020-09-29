import { HttpClient } from '@angular/common/http';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Observable, Subject } from 'rxjs';
import { User } from './../../interfaces/user';
import { FirebaseService } from './../../services/firebase.service';
import { MailService } from './../../services/mail.service';
import { SqlService } from './../../services/sql.service';


@Component({
  selector: 'app-editor',
  templateUrl: './editor.component.html',
  styleUrls: ['./editor.component.scss']
})
export class EditorComponent implements OnInit, OnDestroy {
  users: User[];
  user;
  notice;
  groupedByModule: any[] = [];
  public subscribeForm: FormGroup;
  public email: FormControl;
  private unsubscribe = new Subject<void>();
  selectedUser: User = {
    uid: null, displayName: null, email: null, photoURL: null, roles: { subscriber: true }, lastUpdate: null
  };
  constructor(
    public apiService: SqlService,
    public mail: MailService,
    public auth: FirebaseService
  ) {
    this.auth.getMessage().subscribe(note => {
      this.notice = note;
    });
  }
  ngOnInit() {
    this.createFormControls();
    this.createForm();
    this.apiService.readModule().subscribe(res => {
      this.groupedByModule.push(this.groupModule(res));
    });
  }

  groupModule(myArray: any[]) {
    const groupKey = 0;
    const groups = myArray.reduce((r, o) => {
      const m = o.mod_id;
      (r[m]) ? r[m].data.push(o) : r[m] = { group: m, data: [o] };
      return r;
    }, {});

    const result = Object.keys(groups).map((k) => groups[k]);
    console.log(result);
    return result;
  }

  createFormControls() {
    this.email = new FormControl('', [
      Validators.required
    ]);
  }

  createForm() {
    this.subscribeForm = new FormGroup({
      email: this.email
    });
  }

  createOrUpdateUser(form) {
    if (this.selectedUser && this.selectedUser.uid) {
      form.value.id = this.selectedUser.uid;
      this.apiService.updateUser(form.value).subscribe((user: User) => {
        console.log('User updated', user);
      });
    }
    else {

      this.apiService.createUser(form.value).subscribe((user: User) => {
        console.log('User created, ', user);
      });
    }

  }

  selectUser(user: User) {
    this.selectedUser = user;
  }
  sendMail() {
    this.mail.sendEmail('Chamath', 'Hello');
  }
  deleteUser(id) {
    this.apiService.deleteUser(id).subscribe((user: User) => {
      console.log('User deleted, ', user);

      this.apiService.readUsers().subscribe((users: User[]) => {
        this.users = users;
      });
    });
  }
  ngOnDestroy(): void {
    this.unsubscribe.next();
    this.unsubscribe.complete();
  }

}
