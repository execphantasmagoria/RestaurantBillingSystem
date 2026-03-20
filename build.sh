#!/usr/bin/env bash

set -e

# ------------- Colors -------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

info()  { echo -e "${CYAN}[INFO]${RESET}  $*"; }
ok()    { echo -e "${GREEN}[ OK ]${RESET}  $*"; }
warn()  { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
error() { echo -e "${RED}[ERR ]${RESET}  $*"; }

echo
echo -e "${BOLD}============================================${RESET}"
echo -e "${BOLD}  CMake Build Script (Unix)                ${RESET}"
echo -e "${BOLD}============================================${RESET}"
echo

# ------------- Check CMake -------------
if ! command -v cmake >/dev/null 2>&1; then
    error "CMake not found. Please install CMake and ensure it is in PATH."
    exit 1
else
    ok "CMake found: $(command -v cmake)"
fi

# ------------- Check Ninja -------------
HAS_NINJA=1
if ! command -v ninja >/dev/null 2>&1; then
    HAS_NINJA=0
    warn "Ninja not found. Will use CMake's default generator and compiler."
else
    ok "Ninja found: $(command -v ninja)"
fi

# ------------- Detect Clang (only with Ninja) -------------
CMAKE_C_COMPILER=""
CMAKE_CXX_COMPILER=""
COMPILER_DESC="default toolchain"

if [ "$HAS_NINJA" -eq 1 ]; then
    if command -v clang >/dev/null 2>&1 && command -v clang++ >/dev/null 2>&1; then
        CMAKE_C_COMPILER="-DCMAKE_C_COMPILER=$(command -v clang)"
        CMAKE_CXX_COMPILER="-DCMAKE_CXX_COMPILER=$(command -v clang++)"
        COMPILER_DESC="clang/clang++"
    fi
fi

if [ "$HAS_NINJA" -eq 1 ]; then
    info "Using generator : Ninja"
    info "Compiler       : $COMPILER_DESC"
else
    info "Using generator : CMake default (no -G)"
    info "Compiler       : CMake default"
fi

# ------------- Prepare build dir -------------
BUILD_DIR="build"

if [ -d "$BUILD_DIR" ]; then
    info "Removing existing build directory '$BUILD_DIR'..."
    rm -rf "$BUILD_DIR"
fi

info "Creating build directory '$BUILD_DIR'..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# ------------- Configure -------------
echo
echo -e "${BOLD}============================================${RESET}"
echo -e "${BOLD}  Configuring project with CMake           ${RESET}"
echo -e "${BOLD}============================================${RESET}"
echo

if [ "$HAS_NINJA" -eq 1 ]; then
    set -x
    cmake .. -G "Ninja" -DCMAKE_BUILD_TYPE=Release \
        $CMAKE_C_COMPILER $CMAKE_CXX_COMPILER
    set +x
else
    set -x
    cmake .. -DCMAKE_BUILD_TYPE=Release
    set +x
fi

ok "CMake configuration completed successfully."

# ------------- Build -------------
echo
echo -e "${BOLD}============================================${RESET}"
echo -e "${BOLD}  Building project                          ${RESET}"
echo -e "${BOLD}============================================${RESET}"
echo

if [ "$HAS_NINJA" -eq 1 ]; then
    set -x
    cmake --build . -- -j
    set +x
else
    set -x
    cmake --build .
    set +x
fi

echo
ok "Build completed successfully."
echo

echo -e "${BOLD}============================================${RESET}"
echo -e "${BOLD}  Build Summary                            ${RESET}"
echo -e "${BOLD}============================================${RESET}"

echo "Executable: $(realpath RestaurantBillingSystem)"
echo "Build Type : Release"
echo "Generator  : $(if [ "$HAS_NINJA" -eq 1 ]; then echo "Ninja"; else echo "CMake default"; fi)"
echo "Compiler   : $(if [ -n "$CMAKE_C_COMPILER" ]; then echo "$COMPILER_DESC"; else echo "CMake default"; fi)"
echo "Build Dir  : $(realpath .)"
echo -e ""
echo "You can run the built executable from this directory via:"
echo -e "${CYAN}  ./RestaurantBillingSystem${RESET}"
echo -e "${BOLD}============================================${RESET}"