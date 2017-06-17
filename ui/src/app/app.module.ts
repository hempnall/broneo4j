import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { DataModule } from './data/data.module';
import { AppComponent } from './app.component';
import { NavBarComponent } from './navbar/navbar.component';
import { SideBarComponent } from './sidebar/sidebar.component';
import { ViewportComponent } from './viewport/viewport.component';
import { GraphComponent } from './graph/graph.component';
import { LabelSelectComponent } from './labelselect/labelselect.component';
import { MultiSelectModule } from 'primeng/primeng';
import { ButtonModule } from 'primeng/primeng';
import { SelectItem } from 'primeng/primeng';
import { PanelModule } from 'primeng/primeng';
import { SearchComponent  } from './search/search.component';

@NgModule({
  declarations: [
    AppComponent,
    NavBarComponent,
    SideBarComponent,
    ViewportComponent,
    GraphComponent,
    LabelSelectComponent,
    SearchComponent
  ],
  imports: [
    DataModule,
    BrowserModule,
    FormsModule,
    HttpModule,
    MultiSelectModule,
    ButtonModule,  
    PanelModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
