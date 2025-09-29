TITLE 测试VVC支持

ffmpeg -hide_banner -encoders | findstr /I "vvenc"
@REM  V....D libvvenc             libvvenc H.266 / VVC (codec vvc)

ffmpeg -hide_banner -encoders | findstr /I "flac"
@REM  A....D flac                 FLAC (Free Lossless Audio Codec)

ECHO Linux

ffmpeg -hide_banner -encoders | grep -i vvenc
ffmpeg -hide_banner -encoders | grep -i flac