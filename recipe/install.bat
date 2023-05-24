@echo on

cd cmake-build

cmake --install .
if %ERRORLEVEL% neq 0 exit 1

if [%PKG_NAME%] == [libthrift] (
  del %PREFIX%\Library\bin\thrift.exe
  if %ERRORLEVEL% neq 0 exit 1
  move %PREFIX%\Library\bin\thriftmd.lib %PREFIX%\Library\lib\thriftmd.lib
  if %ERRORLEVEL% neq 0 exit 1
) else (
  del %PREFIX%\Library\bin\thriftmd.lib
  if %ERRORLEVEL% neq 0 exit 1
)
