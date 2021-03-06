import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MaterialModule } from '../../core/material.module';
import { MarksEditComponent } from './marks-edit.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { MarksEditRoutingModule } from './marks-edit-routing.module';


@NgModule({
  declarations: [MarksEditComponent],
  imports: [
    CommonModule,
    MaterialModule,
    ReactiveFormsModule,
    FormsModule,
    MarksEditRoutingModule
  ],
  exports: [
    MarksEditComponent
  ]
})
export class MarksEditModule { }
