import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DataService } from './data.service';

@NgModule({
    imports: [

    ],
    exports: [ // components that we want to make available
    ],
    declarations: [ // components for use in THIS module
    ],
    providers: [ // singleton services
        DataService
    ]
})
export class DataModule { 

}