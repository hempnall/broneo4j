// load bro log data - delete superflous lines upfront

CREATE CONSTRAINT ON (host:Host) ASSERT host.ip IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///Users/James/labs/ex2/bro_logs/conn.log.neo4jbrolog" AS line FIELDTERMINATOR '\t'

with line

MERGE (host_o:Host { ip: line.`id.orig_h`
					  })

MERGE (host_r:Host { ip: line.`id.resp_h` })

MERGE (host_o)-[:CONNECTS_TO { 
	uid: line.uid,
	sport: line.`id.orig_p`,
	ts: line.`ts`,
	dport: line.`id.resp_p`,
	proto: line.proto,
	service: line.service,
	dur: line.duration, 
	orig_bytes: line.orig_bytes,
	resp_bytes: line.resp_bytes
	} ]->(host_r)
;

// can't decide whether it is best to update the existing connections or create new data for DHCP log entries

// ts	uid	id.orig_h	id.orig_p	id.resp_h	id.resp_p	mac	assigned_ip	lease_time	trans_id
// 1416103971.526819	CHlF3w39F1weq6A6dk	172.16.165.165	68	172.16.165.254	67	f0:19:af:02:9b:f1	172.16.165.165	0.000000 2464664567
// 1416104378.485550	C5kJmK2I0cTGxdFhgg	172.16.165.165	68	172.16.165.254	67	f0:19:af:02:9b:f1	172.16.165.165	1800.000000	
// 3608315598


LOAD CSV WITH HEADERS FROM "file:///Users/James/labs/ex2/bro_logs/dhcp.log.neo4jbrolog" AS line FIELDTERMINATOR '\t'
with line
MERGE (host_o:Host { ip: line.`id.orig_h`})
MERGE (host_r:Host { ip: line.`id.resp_h` })
MERGE (host_o)-[:DHCP {
	ts: line.ts,
	uid: line.uid,
	sport: line.`id.orig_p`,
	dport: line.`id.resp_p`,
	mac: line.mac,
	assigned_ip: line.assigned_ip,
	lease_time: line.lease_time,
	trans_id: line.trans_id			
}]->(host_r)
;


// similarly for DNS
// ts	uid	id.orig_h	id.orig_p	id.resp_h	id.resp_p	proto	trans_id	rtt	query	qclass	qclass_name	qtype	qtype_name	rcode	rcode_name	AA	TC	RD	RA	Z	answers	TTLs	rejected
// 1416103910.994963	CU3uBL2ytQx9XA0uXi	172.16.165.165	62720	172.16.165.2	53	udp	51895	0.919931	ssl.bing.com	1	C_INTERNET	1	A	0	NOERROR	F	F	T	T	0	ssl-bing-com.a-0001.a-msedge.net,a-0001.a-msedge.net,204.79.197.200	5.000000,5.000000,5.000000	F
LOAD CSV WITH HEADERS FROM "file:///Users/James/labs/ex2/bro_logs/dns.log.neo4jbrolog" AS line FIELDTERMINATOR '\t'
With line
MERGE (host_o:Host { ip: line.`id.orig_h`})
MERGE (host_r:Host { ip: line.`id.resp_h` })
MERGE (host_o)-[:DNS {
	ts: line.ts,
	uid: line.uid,
	sport: line.`id.orig_p`,
	dport: line.`id.resp_p`,
	proto: line.proto,
	rtt: line.rtt,
	query: line.query,
	qclass: line.qclass	,
	qclass_name: line.qclass_name,
	qtype: line.qtype,
	answers: line.answers

}]->(host_r)
;


// files
CREATE CONSTRAINT ON (file:File) ASSERT file.uid IS UNIQUE;
LOAD CSV WITH HEADERS FROM "file:///Users/James/labs/ex2/bro_logs/files.log.neo4jbrolog" AS line FIELDTERMINATOR '\t'
with line
MERGE (host_o:Host {ip: line.`tx_hosts`})
MERGE (host_r:Host {ip: line.`rx_hosts`})
MERGE (file:File { 
	uid: line.`fuid`,
	type: line.mime_type,
	source: line.source
})
WITH host_o,host_r,file
CREATE (host_o)-[:SENDS_FILE]->(file)-[:RECVS_FILE]->(host_r);






