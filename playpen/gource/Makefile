etl:
	cat ${BROLOGSDIR}/http.log |  docker run -i hempnall/bro /usr/local/bro/bin/bro-cut ts id.orig_h host | \
		awk 'BEGIN {FS="\t";OFS="|"} \
		{ cnt=split($$3,host_parts,"."); \
		  joined=host_parts[cnt]; \
		  for (i=cnt-1;i>0;i--) {\
		  	joined=joined"/"host_parts[i]};\
			print NR,$$2,"M",joined  \
		  }' > $@


show: etl
	gource -f --log-format custom --path $<

