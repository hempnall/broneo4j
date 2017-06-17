import { Component, AfterViewInit } from '@angular/core';
import { OnInit } from '@angular/core';
import { DataService } from '../data/data.service';
import { Http, HttpModule, JsonpModule } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';




@Component({
    selector: 'graph',
    template: `
                <div id="graph-container"></div>
`,
    styles: [`
  #graph-container {
    position: absolute;
    width: 100%;
    height:90%;
    left: 0;
        }
  `]
})
export class GraphComponent implements OnInit {



    constructor( private dataService: DataService ) {} 

    ngOnInit() {
        this.dataService.createGraph('graph-container');
    }


}