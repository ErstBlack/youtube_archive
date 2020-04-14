## Usage

Simple Docker Run example:
`docker run -v /your/path/to/download/directory/:/youtube-directory erstblack/youtube_archive`

## Environment Variables

There are other environment variables if you want to customize various things inside the docker container:

| Docker Environment Var. | Description |
| ----------------------- | ----------- |
| `QUALITY: <1080p\|720p>`<br/> *Default: 1080p* | Sets the quality of the downloaded video. |
| `ARCHIVE_FILE: <Filename>`<br/> *Default: archive.log* | Sets the archive log created by youtube-dl. |
| `CHANNELS_FILE: <Filename>`<br/> *Default: channels.txt* | Sets the channels file read by youtube-dl. |
| `OUTPUT_FORMAT: <Format>`<br/> *Default: %(uploader)s/%(title)s.%(ext)s* | Sets the output format used youtube-dl. |

