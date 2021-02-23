## Usage

Simple Docker Run example:
`docker run -v /your/path/to/download/directory/:/youtube-directory erstblack/youtube_archive`

## Environment Variables

There are other environment variables if you want to customize various things inside the docker container:

| Docker Environment Var. | Description |
| ----------------------- | ----------- |
| `QUALITY: <4320p\|2160p\|1440p\|1080p\|720p>`<br/> *Default: 1080p* | Sets the maximum quality of the downloaded video. 8k, 4k, and 2k may also be used. |
| `RATE_LIMIT: <Rate Limit>`<br/> *Default: 5M* | Sets the rate limit used by youtube-dl. |
| `ARCHIVE_FILE: <Filename>`<br/> *Default: archive.log* | Sets the archive log created by youtube-dl. |
| `SAVE_ARCHIVE: <0\|1>`<br/> *Default: 0* | Toggles saving of the archive file.  0 for no, 1 for yes. |
| `CHANNELS_FILE: <Filename>`<br/> *Default: channels.txt* | Sets the channels file read by youtube-dl. |
| `OUTPUT_FORMAT: <Format>`<br/> *Default: %(uploader)s/%(title)s.%(ext)s* | Sets the output format used youtube-dl. |
| `VIDEO_UID: <UID>`<br/> *Default: 1000* | Sets the user ownership for the downloaded videos. |
| `VIDEO_GID: <GID>`<br/> *Default: 1000* | Sets the group ownership for the downloaded videos. |
| `RETRIES: <Retries>`<br/> *Default: 10* | Sets the number of retries for youtube-dl. |
| `BUFFER_SIZE: <Buffer Size>`<br/> *Default: 1024* | Sets the buffer size for youtube-dl. |
| `DAY_DELAY: <Buffer Size>`<br/> *Default: -1* | Sets the minimum age for downloading vidoes.  Youtube may take up to 30 days for transcoding. |
