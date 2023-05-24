pushd thirdparty\src\libevent
nmake -f Makefile.nmake
mkdir lib
move *.lib lib\
move WIN32-Code\event2\* include\event2\
move WIN32-Code\nmake\* include\event2\
move WIN32-Code\nmake\event2\* include\event2\
move *.h include\
if errorlevel 1 exit 1

popd

set BOOST_ROOT=%PREFIX%
set ZLIB_ROOT=%PREFIX%
set OPENSSL_ROOT=%PREFIX%
set OPENSSL_ROOT_DIR=%PREFIX%

set "CXXFLAGS=%CXXFLAGS% -DNOMINMAX"

cd %SRC_DIR%\build

:: make thrift/windows/config.h available for the compiler:
SET CL=/I"%SRC_DIR%\lib\cpp\src"

cmake -GNinja ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_POLICY_DEFAULT_CMP0074=NEW ^
      -DBIN_INSTALL_DIR="%LIBRARY_BIN%" ^
      -DLIB_INSTALL_DIR="%LIBRARY_LIB%" ^
      -DOpenSSL_ROOT="%LIBRARY_PREFIX%" ^
      -DOPENSSL_ROOT_DIR="%LIBRARY_PREFIX%" ^
      -DLIBEVENT_ROOT="%LIBRARY_PREFIX%" ^
      -DFLEX_EXECUTABLE="%SRC_DIR%\thirdparty\dist\winflexbison\win_flex.exe" ^
      -DBISON_EXECUTABLE="%SRC_DIR%\thirdparty\dist\winflexbison\win_bison.exe" ^
      -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
      -DBUILD_PYTHON=OFF ^
      -DBUILD_JAVA=OFF ^
      -DBUILD_JAVASCRIPT=OFF ^
      -DBUILD_NODEJS=OFF ^
      -DBUILD_C_GLIB=OFF ^
      -DTHRIFT_COMPILER_NETSTD=OFF ^
      -DBoost_ADDITIONAL_VERSIONS="1.70.0" ^
      -DBOOST_ROOT=%LIBRARY_PREFIX% ^
      -DBoost_INCLUDE_DIRS=%LIBRARY_PREFIX%\include ^
      -DBoost_DEBUG=ON ^
      -DBoost_NO_BOOST_CMAKE=ON ^
      -DBUILD_TESTING=OFF ^
      -DBUILD_SHARED_LIBS=ON ^
      "%SRC_DIR%"
if %ERRORLEVEL% neq 0 exit 1

cmake --build .
if %ERRORLEVEL% neq 0 exit 1
