@echo off
setlocal enabledelayedexpansion

set "TARGET_BR=120M"
set "MAX_BR=200M"
set "BUFSIZE=200M"
set "PRESET=slow"

for %%F in (*.mp4) do (
  set "IN=%%~fF"
  set "OUT=%%~dpnF.vvc.mkv"
  set "PASSLOG=%%~dpnF.vvc"

  echo ================================================
  echo [1/2] 分析 Pass 1 ：!IN!
  ffmpeg -y -ignore_editlist 1 -fflags +genpts -i "!IN!" ^
    -map 0:v:0 ^
    -c:v libvvenc -preset %PRESET% ^
    -pix_fmt yuv420p10le ^
    -b:v %TARGET_BR% -maxrate %MAX_BR% -bufsize %BUFSIZE% ^
    -g 100 -keyint_min 50 ^
    -pass 1 -passlogfile "!PASSLOG!" ^
    -an -f null NUL

  if errorlevel 1 (
    echo [警告] Pass 1 失败：!IN!
  ) else (
    echo [2/2] 正式输出 Pass 2 ：!IN!
    ffmpeg -ignore_editlist 1 -fflags +genpts -i "!IN!" ^
      -map 0 ^
      -c:v libvvenc -preset %PRESET% ^
      -pix_fmt yuv420p10le ^
      -b:v %TARGET_BR% -maxrate %MAX_BR% -bufsize %BUFSIZE% ^
      -g 100 -keyint_min 50 ^
      -pass 2 -passlogfile "!PASSLOG!" ^
      -c:a flac -sample_fmt s16 -ar 48000 -ac 2 ^
      -dn ^
      "!OUT!"
    if errorlevel 1 (echo [警告] Pass 2 失败：!IN!) else (echo 已完成：!OUT!)
  )
  echo.
)

echo 处理完成；输出 *.vvc.mkv，日志 *.vvc*（与源同目录）
pause
