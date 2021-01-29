cd %SRC_DIR%\build
ninja install
if errorlevel 1 exit 1

if [%PKG_NAME%] == [libthrift] (
  del %PREFIX%\Library\bin\thrift.exe
  if errorlevel 1 exit 1
)
