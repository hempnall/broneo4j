noop=
tab=$(noop)	$(noop)
space=$(noop) $(noop)
STD_LOG_HEADERS=id.orig_h	id.resp_h	id.orig_p      	id.resp_p
#STD_LOG_PREFIX="$(subst @COLON@,:,@COLON@START_ID\t@COLON@END_ID id.orig_p       id.resp_p)"
STD_LOG_PREFIX=:START_ID	:END_ID	id.orig_p	id.resp_p
DNS_LOG_HEADERS=

%.relationships.headers: $(BRO_LOG_DIR)/%
	echo "$(STD_LOG_PREFIX)" > $*.relationships.headers

%.relationships: $(BRO_LOG_DIR)/%
	$(call run_bro_cut,$(STD_LOG_HEADERS))

http.log.relationships.headers: $(BRO_LOG_DIR)/http.log
	echo "$(STD_LOG_PREFIX)	method	host	uri" > http.log.relationships.headers

http.log.relationships: $(BRO_LOG_DIR)/http.log
	$(call run_bro_cut,$(STD_LOG_HEADERS) method host uri)


testcolon:
	echo $(STD_LOG_PREFIX)\\t$(HTTP_LOG_HEADERS) | hexdump -C

