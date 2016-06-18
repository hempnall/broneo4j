#!/bin/bash
for brologfile in bro_logs/*.log; do

	
	sed '1,6d;8d;$d;s/^#fields	//' $brologfile > $brologfile.neo4jbrolog


done 
