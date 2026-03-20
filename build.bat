@echo off
setlocal EnableDelayedExpansion

set "BUILD_DIR=build"
set "GENERATOR=Ninja"

echo.
echo ============================================
echo   CMake Build Script
echo ============================================
echo.

rem ----------------
rem Check CMake
rem ----------------
where cmake >nul 2>&1
if errorlevel 1 (
    echo [ERROR] CMake not found. Please install CMake and ensure it is in PATH.
    exit /b 1
) else (
    echo [OK] CMake found.
)

rem ----------------
rem Check Ninja
rem ----------------
set "HAS_NINJA=1"
where ninja >nul 2>&1
if errorlevel 1 (
    set "HAS_NINJA=0"
    echo [WARN] Ninja not found. Will use CMake's default generator and compiler.
) else (
    echo [OK] Ninja found.
)

rem ----------------
rem Detect Clang (only used if Ninja available)
rem ----------------
set "CMAKE_C_COMPILER="
set "CMAKE_CXX_COMPILER="
set "COMPILER_DESC=default toolchain"

if "%HAS_NINJA%"=="1" (
    where clang-cl >nul 2>&1
    if not errorlevel 1 (
        set "CMAKE_C_COMPILER=-DCMAKE_C_COMPILER=clang-cl"
        set "CMAKE_CXX_COMPILER=-DCMAKE_CXX_COMPILER=clang-cl"
        set "COMPILER_DESC=clang-cl"
    ) else (
        where clang >nul 2>&1
        if not errorlevel 1 (
            set "CMAKE_C_COMPILER=-DCMAKE_C_COMPILER=clang"
            set "CMAKE_CXX_COMPILER=-DCMAKE_CXX_COMPILER=clang++"
            set "COMPILER_DESC=clang/clang++"
        )
    )
)

if "%HAS_NINJA%"=="1" (
    echo [INFO] Using generator : %GENERATOR%
    echo [INFO] Compiler       : %COMPILER_DESC%
) else (
    echo [INFO] Using generator : CMake default (no -G)
    echo [INFO] Compiler       : CMake default
)
echo.

rem ----------------
rem Prepare build dir
rem ----------------
if exist "%BUILD_DIR%" (
    echo [INFO] Cleaning existing build directory "%BUILD_DIR%"...
    rmdir /s /q "%BUILD_DIR%"
)

echo [INFO] Creating build directory "%BUILD_DIR%"...
mkdir "%BUILD_DIR%" || (
    echo [ERROR] Failed to create build directory.
    exit /b 1
)

cd "%BUILD_DIR%" || (
    echo [ERROR] Failed to enter build directory.
    exit /b 1
)

rem ----------------
rem Configure
rem ----------------
echo.
echo ============================================
echo   Configuring project with CMake
echo ============================================
echo.

if "%HAS_NINJA%"=="1" (
    echo cmake .. -G "%GENERATOR%" %CMAKE_C_COMPILER% %CMAKE_CXX_COMPILER%
    cmake .. -G "%GENERATOR%" %CMAKE_C_COMPILER% %CMAKE_CXX_COMPILER%
) else (
    echo cmake ..
    cmake ..
)

if errorlevel 1 (
    echo.
    echo [ERROR] CMake configuration failed.
    exit /b 1
)

echo.
echo [OK] CMake configuration completed successfully.
echo.

rem ----------------
rem Build
rem ----------------
echo ============================================
echo   Building project
echo ============================================
echo.

if "%HAS_NINJA%"=="1" (
    cmake --build . -j
) else (
    cmake --build .
)

if errorlevel 1 (
    echo.
    echo [ERROR] Build failed.
    exit /b 1
)

echo.
echo ============================================
echo   Build completed successfully
echo ============================================
echo.

echo [INFO] Build artifacts are located in "%BUILD_DIR%".
echo [INFO] You can run the built executable from this directory via "%BUILD_DIR%\RestaurantBillingSystem.exe".

endlocal
exit /b 0
