#!/bin/bash

SOURCE_DIR=`pwd`

EXTERNAL_DIR_PATH="$SOURCE_DIR/SharedExternal"

IOKIT_INCLUDE_DIR="/usr/local/include/IOKit"

BOOST_URL="https://github.com/WooKeyWallet/ofxiOSBoost.git"
BOOST_DIR_PATH="$EXTERNAL_DIR_PATH/ofxiOSBoost"

OPEN_SSL_URL="https://github.com/x2on/OpenSSL-for-iPhone.git"
OPEN_SSL_DIR_PATH="$EXTERNAL_DIR_PATH/OpenSSL"

LMDB_DIR_URL="https://github.com/LMDB/lmdb.git"
LMDB_DIR_PATH="lmdb/Sources"

SODIUM_URL="https://github.com/jedisct1/libsodium --branch stable"
SODIUM_PATH="$EXTERNAL_DIR_PATH/libsodium"

MONERO_URL="https://github.com/WooKeyWallet/monero.git"
MONERO_DIR_PATH="$SOURCE_DIR/monero"

BOOST_LIBRARYDIR="${BOOST_DIR_PATH}/build/ios/prefix/lib"
BOOST_INCLUDEDIR="${BOOST_DIR_PATH}/build/ios/prefix/include"

OPENSSL_INCLUDE_DIR="${OPEN_SSL_DIR_PATH}/include"
OPENSSL_ROOT_DIR=$OPEN_SSL_DIR_PATH

SODIUM_LIBRARY="${SODIUM_PATH}/libsodium-ios/lib/libsodium.a"
SODIUM_INCLUDE="${SODIUM_PATH}/libsodium-ios/include"

INSTALL_PREFIX="${SOURCE_DIR}/monero-libs"

echo "Init external libs."
mkdir -p $EXTERNAL_DIR_PATH

echo "============================ Boost ============================"

echo "Cloning ofxiOSBoost from - $BOOST_URL"
git clone -b build $BOOST_URL $BOOST_DIR_PATH
cd $BOOST_DIR_PATH/scripts/
export BOOST_LIBS="random regex graph random chrono thread signals filesystem system date_time locale serialization program_options"
./build-libc++
cd $SOURCE_DIR

echo "============================ OpenSSL ============================"

echo "Cloning Open SSL from - $OPEN_SSL_URL"
git clone $OPEN_SSL_URL $OPEN_SSL_DIR_PATH
cd $OPEN_SSL_DIR_PATH
git checkout OpenSSL-1.0.2l
./build-libssl.sh --archs="arm64"
cd $SOURCE_DIR

echo "============================ LMDB ============================"
echo "Cloning lmdb from - $LMDB_DIR_URL"
git clone $LMDB_DIR_URL $LMDB_DIR_PATH
cd $LMDB_DIR_PATH
git checkout b9495245b4b96ad6698849e1c1c816c346f27c3c
cd $SOURCE_DIR

echo "============================ SODIUM ============================"
echo "Cloning SODIUM from - $SODIUM_URL"
git clone -b build $SODIUM_URL $SODIUM_PATH
cd $SODIUM_PATH
./dist-build/ios.sh
cd $SOURCE_DIR

echo "============================ Monero ============================"
git clone -b build-ios $MONERO_URL $MONERO_DIR_PATH
cd $MONERO_DIR_PATH
git submodule update --recursive --init
rm -r build > /dev/null
mkdir -p build/release
pushd build/release
cmake \
 -D CMAKE_BUILD_TYPE=release \
 -D BUILD_GUI_DEPS=ON \
 -D STATIC=ON \
 -D IOS=ON \
 -D ARCH=arm64 \
 -D BOOST_LIBRARYDIR=${BOOST_LIBRARYDIR} \
 -D BOOST_INCLUDEDIR=${BOOST_INCLUDEDIR} \
 -D OPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} \
 -D OPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR} \
 -D INSTALL_VENDORED_LIBUNBOUND=ON \
 -D SODIUM_LIBRARY=$SODIUM_LIBRARY \
 -D SODIUM_INCLUDE_DIR=$SODIUM_INCLUDE \
 -D IOKIT_INCLUDE_DIR=$IOKIT_INCLUDE_DIR \
 -D CMAKE_INSTALL_PREFIX=$INSTALL_PREFIX \
 -D MANUAL_SUBMODULES=1 \
 -D MONERUJO_HIDAPI=ON \
 -D USE_DEVICE_TREZOR=OFF \
 ../..
make -j4 && make install

echo "====================Copy librandomx.a to lib dir================="
cp $SOURCE_DIR/monero/build/release/external/randomx/librandomx.a $SOURCE_DIR/monero-libs/lib-armv8-a/
