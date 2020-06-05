#!/bin/bash

pip3 install -U youtube-dl
source /app/youtube-archive.conf

echo "### Youtube Archive Vars ###"
echo "Channels File:   ${CHANNELS_FILE}"
echo "Archive File:    ${ARCHIVE_FILE}"
echo "Quality:         ${QUALITY}"
echo "Rate Limit:      ${RATE_LIMIT}"
echo "Video Uid:       ${VIDEO_UID}"
echo "Video Gid:       ${VIDEO_GID}"
echo "Output Format:   ${OUTPUT_FORMAT}"
echo "Download Format: ${format}"
echo "### End Youtube Archive Vars ###"

echo "Starting youtube-archive..."
pushd /youtube-directory

youtube-dl \
	--format "${format}" \
	--limit-rate "${RATE_LIMIT}" \
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
	--output "${OUTPUT_FORMAT}" \
	--download-archive "${ARCHIVE_FILE}" \
	--batch-file "${CHANNELS_FILE}" 

# Find all newly downloaded files
while IFS=  read -r -d $'\0'; do
	array+=("$REPLY")
done < <(find . -not -name "*.txt" -iname "*.mkv" -type f -user 0 -group 0 -print0)

# Print out newly downloaded files
ARRAY_LEN=${#array[@]}
if [ "${ARRAY_LEN}" -eq 0 ]; then
	echo "No New Videos Downloaded..."
	exit 0
else
	echo "### Newly Downloaded Videos ###"
	for i in "${array[@]}"; do
	       echo "$i" | sed 's#\./##g' | sed 's#/#: #g' | sed 's/\.mkv//'
	done
	echo "### End Newly Downloaded Videos ###"
fi

merge() {
	filename="$1"
	sequence_num="$2"
	video_name="$(echo $1 | sed 's#\./##g' | sed 's#/#: #g' | sed 's/\.mkv//')"

	echo "Adding thumbnail: (${sequence_num}/${ARRAY_LEN}) ${video_name}"
	ffmpeg -v warning -i "${filename}" -i "${filename/mkv/jpg}" -map 1 -map 0 \
                -c copy -disposition:0 attached_pic \
                -f matroska "${filename}.tempfile" \
		&& mv -f "${filename}.tempfile" "${filename}"
		
	rm -f "${filename/mkv/jpg}"
	chown "${VIDEO_UID}":"${VIDEO_GID}" "${filename}"
}

export -f merge
export ARRAY_LEN VIDEO_UID VIDEO_GID SHELL=$(type -p bash) 

# Merge thumbnail into mkv
echo "### Start Post-Processing ###"
parallel -k merge "{}" "{#}" ::: "${array[@]}"
echo "### End Post-Processing ###"

