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
	gource -f --title "My Graph"  --log-format custom --path $<

video.mp4: etl
	gource -1280x720  --log-format custom --path $< -o -   | \
	 ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 $@

