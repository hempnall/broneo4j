BRO_LOG_DIR := ./brologs
DIR := ${CURDIR}
DBNAME := netgraph.db

include ip_addresses.mk
include timestamps.mk
include brologs.mk

define run_bro_cut
        cat $< |  docker run -i hempnall/bro /usr/local/bro/bin/bro-cut $1 > $@
endef


start: 
	docker run \
    	--publish=7474:7474 --publish=7687:7687 \
    	--volume=$(DIR)/data:/data \
    	--volume=$(DIR)/logs:/logs \
   	--env=NEO4J_dbms_active__database=$(DBNAME) \
   	--env=NEO4J_dbms_directories_data=/data \
	--env=NEO4J_dbms_security_auth__enabled=false \
    	neo4j:3.1

graph: 	ip_addresses \
	ip_addresses.headers \
	dns.log.relationships.headers dns.log.relationships \
	http.log.relationships.headers http.log.relationships \
	data logs csv 
	###
	mv ip_addresses ip_addresses.headers ./csv
	mv *.log.relationships* ./csv	
	docker run \
		--volume=$(DIR)/data:/data \
		--volume=$(DIR)/logs:/logs \
		--volume=$(DIR)/csv:/csv \
		neo4j:3.1 \
		/var/lib/neo4j/bin/neo4j-import --into /data/databases/$(DBNAME) \
		--delimiter "\t" \
		--nodes:BRO.ADDR "/csv/ip_addresses.headers,/csv/ip_addresses" \
		--relationships:BRO.DNS.LOG "/csv/dns.log.relationships.headers,/csv/dns.log.relationships" \
		--relationships:BRO.HTTP.LOG "/csv/http.log.relationships.headers,/csv/http.log.relationships"

clean: \
	ip_addresses.clean \
	timestamps.clean
	rm -rf data logs csv

data logs csv:
	mkdir -p ./$@


 
	


	
