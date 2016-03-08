REM Do a minimalistic build of LuaJIT using the MinGW compiler

set PATH=C:\MinGW\bin;%PATH%
@echo on
REM retrieve and unpack source
curl -fLsS -o %1.zip http://luajit.org/download/%1.zip
unzip -q %1

REM tweak Makefile for a static LuaJIT build (Windows defaults to "dynamic" otherwise)
sed -i "s/BUILDMODE=.*mixed/BUILDMODE=static/" %1\src\Makefile

mingw32-make TARGET_SYS=Windows -C %1\src

REM copy luajit.exe to project dir
copy %1\src\luajit.exe %APPVEYOR_BUILD_FOLDER%

@echo off
REM clean up (remove source folders and archive)
rm -rf %1/*
rm -f %1.zip