# Gource Visualisation

Animated view of web connections based on bro logs

## Installation

on Mac OS...

```
$ brew install gource
$ git clone <this repo>
$ cd playpen/gource
$ make show BROLOGSDIR=/path/to/bro/logs
```
To make a video...
```
$ brew install ffmpeg
$ make video.mp4
$ open video.mp4
```

## TODO://

* convert bro-log timestamps to unix timestamps