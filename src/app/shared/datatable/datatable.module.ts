import { FormsModule } from '@angular/forms';
import { MaterialModule } from '../../core/material.module';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { DatatableRoutingModule } from './datatable-routing.module';
import { DatatableComponent } from './datatable.component';


@NgModule({
  declarations: [DatatableComponent],
  imports: [
    MaterialModule,
    FormsModule,
    CommonModule,
    DatatableRoutingModule
  ],
  exports: [
    DatatableComponent
  ]
})
export class DatatableModule { }
