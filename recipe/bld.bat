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

cd %SRC_DIR%\build

set "CC=cl.exe"
set "CXX=cl.exe"

:: WITH_SHARED_LIB must be off - the cmake config doesn't support shared libs yet

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release ^
                             -DCMAKE_POLICY_DEFAULT_CMP0074=NEW ^
                             -DOpenSSL_ROOT="%LIBRARY_PREFIX%" ^
                             -DOPENSSL_ROOT_DIR="%LIBRARY_PREFIX%" ^
                             -DLIBEVENT_ROOT="%SRC_DIR%\thirdparty\src\libevent" ^
                             -DFLEX_EXECUTABLE="%SRC_DIR%\thirdparty\dist\winflexbison\win_flex.exe" ^
                             -DBISON_EXECUTABLE="%SRC_DIR%\thirdparty\dist\winflexbison\win_bison.exe" ^
                             -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
                             -DBUILD_PYTHON=OFF ^
                             -DBUILD_JAVA=OFF ^
                             -DBUILD_C_GLIB=OFF ^
                             -DWITH_SHARED_LIB=OFF ^
                             "%SRC_DIR%"

cmake --build . --target install --config Release
