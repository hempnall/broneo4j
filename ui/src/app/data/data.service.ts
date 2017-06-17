import { Injectable } from '@angular/core';
import {SelectItem} from 'primeng/primeng';
// import '../../dist/js/sigma.min.js';
// import '../../dist/js/sigma.parsers.json.min.js';


declare var sigma: any;

@Injectable()
export class DataService {

    graph_: any;
    nodetypes_ : SelectItem[] = [];
    edgetypes_ : SelectItem[] = [];
    ipaddresses_ : SelectItem[] = [];

    setGraph( graph : any ) {
        this.graph_ = graph;
    }

    getGraph() : any {
        return this.graph_;
    }

    graphRefresh() {
        this.getGraph().graph.refresh();
    }

    applyFilter( collection , func ) {
        collection.forEach( func  );
    }

    refreshEdgesWithFilter( func ) {
        this.applyFilter(  this.getGraph().graph.edges()  , func ) ;   
        this.graphRefresh();
    }


    refreshNodesWithFilter( func ) {
        this.applyFilter(  this.getGraph().graph.nodes()  , func ) ;  
        this.graphRefresh();      
    }



    afterDataLoaded(s) {

        function string_to_selectitem(s) : SelectItem {
            return {
                label: s,
                value: s
            };
        }

        var nodetypes  = [];
        var edgetypes  = [];
        var ipaddresses  = [];

        s.graph.nodes().forEach(function (n) {
            n.neo4j_labels.forEach( n =>  nodetypes[n] = 1  );
            n.label = n.neo4j_data.ip_addr;
            ipaddresses.push( n.label );
            n.type = "square";
            n.hidden = false;
        });

        s.graph.edges().forEach(function (e) {
            edgetypes[ e.label ] = 1;
            s.controller.edgetypes_ = Object.keys(edgetypes);
            e.weight = Math.random();
            e.weight = e.weight > 0.1 ? 0 : 11;
            e.hidden = false;
        });

        s.controller.nodetypes_ = Object.keys(  nodetypes ).map(string_to_selectitem);
        s.controller.edgetypes_ = Object.keys(  edgetypes ).map(string_to_selectitem);
        s.controller.ipaddresses_ = ipaddresses.map(string_to_selectitem) ;
        s.refresh();

        s.startForceAtlas2({
            worker: true,
            slowDown: 1,
            edgeWeightInfluence: 1,
            outboundAttractionDistribution: true,
            linLogMode: true,
            strongGravityMode: true,
            barnesHutOptimize: false
        });

    }

    createGraph(  graph_component_id  ) {

        var gcomponent = new sigma( graph_component_id );
        this.setGraph( gcomponent );
        gcomponent.class = new sigma.classes.graph();
        gcomponent.controller = this;

        sigma.neo4j.cypher(
            { url: 'http://localhost:7474', user: 'neo4j', password: 'admin' },
            'MATCH (n) OPTIONAL MATCH (n)-[r]->(m) RETURN n,r,m LIMIT 500',
            gcomponent,
            this.afterDataLoaded
        );  

    }

    filterEdges( type : string[] ) {

        let graphcomp = this.getGraph();
        graphcomp.graph.edges().forEach(function (e) {
            e.weight = Math.random();
            e.weight = e.weight > 0.1 ? 0 : 11;
            e.hidden = true;
        });   
        graphcomp.refresh();
    }



}