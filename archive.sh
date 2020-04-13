#!/bin/bash

pip3 install -U youtube-dl

echo "Starting youtube-archive..."
pushd /youtube-directory

youtube-dl \
	--format "(bestvideo[vcodec^=av01][height>=1080][fps>30]/bestvideo[vcodec=vp9.2][height>=1080][fps>30]/bestvideo[vcodec=vp9][height>=1080][fps>30]/bestvideo[vcodec^=av01][height>=1080]/bestvideo[vcodec=vp9.2][height>=1080]/bestvideo[vcodec=vp9][height>=1080]/bestvideo[height>=1080]/bestvideo[vcodec^=av01][height>=720][fps>30]/bestvideo[vcodec=vp9.2][height>=720][fps>30]/bestvideo[vcodec=vp9][height>=720][fps>30]/bestvideo[vcodec^=av01][height>=720]/bestvideo[vcodec=vp9.2][height>=720]/bestvideo[vcodec=vp9][height>=720]/bestvideo[height>=720]/bestvideo)+(bestaudio[acodec=opus]/bestaudio)/best" \
	--newline \
	--ignore-errors \
	--no-continue \
	--no-overwrites \
	--force-ipv4 \
	--geo-bypass \
	--add-metadata \
	--all-subs \
	--embed-subs \
	--write-thumbnail \
	--restrict-filenames \
	--merge-output-format "mkv" \
	--output "%(uploader)s/%(title)s.%(ext)s" \
	--download-archive archive.log \
	--batch-file "channels.txt" 

# Find all newly downloaded files
while IFS=  read -r -d $'\0'; do
	array+=("$REPLY")
done < <(find . -not -name "*.txt" -iname "*.mkv" -type f -user 0 -group 0 -print0)

# Print out newly downloaded files
array_len=${#array[@]}
if [ "${array_len}" -eq 0 ]; then
	echo "No New Videos Downloaded..."
	exit 0
else
	echo "### Newly Downloaded Videos ###"
	for i in "${array[@]}"; do
	       echo "$i" | sed 's#\./##g' | sed 's#/#: #g'
	done
	echo "### End Newly Downloaded Videos ###"
fi

# Merge thumbnail into mkv
counter=1
echo "### Start Post-Processing ###"
for i in "${array[@]}"; do
	echo "Adding thumbnail: (${counter}/${array_len})"
	ffmpeg -v warning -i "${i}" -i "${i/mkv/jpg}" -map 1 -map 0 \
		-c copy -disposition:0 attached_pic \
		-f matroska "${i}.tempfile" \
		&& mv "${i}.tempfile" "${i}"

	rm -f "${i/mkv/jpg}"
	chown 1000:1000 "${i}"
	counter=$((counter+1))
done
echo "### End Post-Processing ###"

