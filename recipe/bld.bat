@echo on

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 -vcvars_ver=14.0

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


:: WITH_SHARED_LIB must be off - the cmake config doesn't support shared libs yet

set "CMAKE_GENERATOR=Visual Studio 15 2017 Win64" -T "v140"

cmake -G "%CMAKE_GENERATOR%" -DCMAKE_BUILD_TYPE=Release ^
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
