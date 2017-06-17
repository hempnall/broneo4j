ip_addresses.headers:
	echo "ip_addr:ID" > $@

ip_addresses: \
	conn.log.ip_addresses \
	http.log.ip_addresses \
	ssl.log.ip_addresses \
	dns.log.ip_addresses \
	dhcp.log.ip_addresses 
	cat $^ | sort | uniq  > $@

ip_addresses.clean:
	rm -rf ip_addresses
	rm -rf  *.unique
	rm -rf *.sorted
	rm -rf  *.with_fields
	rm -rf *.log.ip_addresses
	rm -rf *.selected_fields

%.ip_addresses: %.ip_addresses.unique_and_sorted
	mv $< $@

%.ip_addresses.unique_and_sorted: %.ip_addresses.used_fields 
	cat $< | sort | uniq > $@

define get_field_from_bro_log
	awk -F '\t' '{ print $$$1 }' < $< | grep -v '^$$'  >> $@	
endef


%.ip_addresses.used_fields: %.selected_fields
	$(call get_field_from_bro_log ,1) 
	$(call get_field_from_bro_log ,2) 


dhcp.log.selected_fields: $(BRO_LOG_DIR)/dhcp.log
	$(call run_bro_cut,id.orig_h id.resp_h assigned_ip)

%.selected_fields: $(BRO_LOG_DIR)/%
	$(call run_bro_cut,id.orig_h id.resp_h)
	




	
 
	


	
