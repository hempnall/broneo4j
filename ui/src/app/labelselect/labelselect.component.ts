import { Component } from '@angular/core';
import { FormsModule }   from '@angular/forms';
import { MultiSelectModule } from 'primeng/primeng';
import {SelectItem} from 'primeng/primeng';
import { DataService } from '../data/data.service';
import {ButtonModule} from 'primeng/primeng';
import {PanelModule} from 'primeng/primeng';

@Component({
  selector: 'label-select',
  templateUrl: './labelselect.component.html'
})
export class LabelSelectComponent {

    nodetypes_ : SelectItem[];
    edgetypes_ : SelectItem[];
    ipaddresses_ : SelectItem[];

    selectedNodeTypes_  : string[];
    selectedEdgeTypes_  : string[];
    selectedIpAddresses_ : string[];


    constructor(private dataService: DataService) {

    }


    applyNodeFilter( $event  ) {

        this.dataService.refreshNodesWithFilter(
            function( n ) {
                n.neo4j_labels.some(  
                    function ( node_label ) {
                        n.hidden = true;
                        if ( $event.value.indexOf(node_label )  != -1 ) {
                            n.hidden = false;
                            return true;
                        }
                    }
                )
            }
        );
    }

    applyEdgeFilter( $event  ) {
        this.dataService.refreshEdgesWithFilter(
            function( n ) {
                n.hidden = true;
                if ( $event.value.indexOf( n.label ) != -1 ) {
                    n.hidden = false;
                    return true;
                } 
            }
        );       
    }

    applyIpaddressFilter( $event  ) {

        this.dataService.refreshNodesWithFilter(
            function( n ) {
                n.label.some(  
                    function ( node_label ) {
                        n.hidden = true;
                        if ( $event.value.indexOf(node_label )  != -1 ) {
                            n.hidden = false;
                            return true;
                        }
                    }
                )
            }
        );
    }

}
