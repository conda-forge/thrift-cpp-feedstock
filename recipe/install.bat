@echo on

cd cmake-build

cmake --install .
if %ERRORLEVEL% neq 0 exit 1

if [%PKG_NAME%] == [libthrift] (
  del "%LIBRARY_BIN%\thrift.exe"
  if errorlevel 1 exit 1
)
