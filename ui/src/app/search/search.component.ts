import { Component } from '@angular/core';
import { DataService } from '../data/data.service';
import { FormGroup, FormControl, FormBuilder, Validators } from '@angular/forms';


@Component({
  selector: 'search',
  template: `
         <form #form="ngForm" class="form-inline mt-2 mt-md-0" (submit)="search(form.value)">
            <button class="btn btn-outline-failure" (click)="clearSearch()">x</button>
            <input ngModel name="search_text" class="form-control mr-sm-2" type="text" placeholder="Search">
            <button class="btn btn-outline-success " type="submit"   >Search</button>    
        </form> 
  `
})
export class SearchComponent{ 

    constructor(  private dataService: DataService ) {

    }

    ipaddressRegex : any = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/g;


    searchByIpAddress(  search ) {
        this.dataService.refreshNodesWithFilter(
            function( n ) {
                if (  n.label.indexOf( search ) != -1  ) {
                    n.hidden = false;
                } else {
                    n.hidden = true;
                }
            }
        );
        alert(1);
    }

    search( search_obj ) {

        var search = search_obj.search_text.trim();
        if (this.ipaddressRegex.test(search)) {
            this.searchByIpAddress( search );
        } else {
            this.clearSearch();
        }


    }

    clearSearch() {
        this.dataService.refreshNodesWithFilter(
            function( n ) {
                n.hidden = false;
            }
        );
    }

}
