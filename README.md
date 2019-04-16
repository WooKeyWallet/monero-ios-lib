# WooKey Wallet: For Privacy

> Less Privacy Collection; More Privacy Coins; Fully Open Source; Better User Experience

## HOW TO BUILD

### Install tools and dependencies

You need homebrew installed on your Mac. See https://docs.brew.sh/Installation

Install cmake and lrelease(part of QT), type in your terminal:

```bash
$ brew install cmake qt pkg-config
```

Install zmq.hpp dependency:

```bash
$ brew tap bottech/homebrew-outcasts
$ brew install cppzmq
```

### Setting up headers

#### IOKit

There is no IOKit headers installed for iOS by default. Easiest way to obtain it:

- clone git repo

```bash
$ git clone https://github.com/prathumca/iOS-IOKit-Runtime-Headers.git
```

- move to /usr/local/include

```bash
$ mv iOS-IOKit-Runtime-Headers /usr/local/include/IOKit
```

#### XCode

```bash
$ xcode-select --install
$ sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
```

#### Other headers

You need make available for building following headers:

```bash
$ mkdir /usr/local/include/sys
$ cp /usr/include/sys/vmmeter.h /usr/local/include/sys
$ mkdir /usr/local/include/netinet
$ cp /usr/include/netinet/{udp_var,ip_var}.h /usr/local/include/netinet
```

### Build Monero in CakeWallet

#### Checkout

```bash
$ git clone --branch release-3.1.5 https://github.com/fotolockr/CakeWallet.git
$ cd CakeWallet
```

#### Build shared libraries

Install and build util dependencies:

```bash
$ ./install_utils_deps.sh
```

#### Build monero

There is mistype in `CWMonero/install_monero.sh` script, line 5 should be updated to:

```
EXTERNAL_UTILS_DIR_PATH="$SOURCE_DIR/../SharedExternal"
```

Run change dir to CWMonero and run `install_monero.sh`:

```bash
$ cd CWMonero/
$ ./install_monero.sh
```

It will build libsodium, but will fail to build monero because git submodules will be not initialized by script. Do it manually:

```bash
$ cd External/monero-gui/monero
$ git submodule update --recursive --init
```

Back to CWMonero dir:

```bash
$ cd ../../../
```

Run `install_monero.sh` again with custom flags:

```bash
$ env CXX_FLAGS='-Wno-error=user-defined-warnings' CFLAGS='-Wno-error=user-defined-warnings' ./install_monero.sh
```

It will not create 'fat' lmdb static library. Do it manually:

```bash
$ cd External/monero-gui/monero
$ lipo -create lib-armv7/liblmdb.a lib-x86_64/liblmdb.a lib-armv8-a/liblmdb.a -output lib-ios/liblmdb.a
```
## Thanks

Thanks to Bakhtiyor K. in Uzbekistan for helping us during the development process.

## Donating

Donation Address (XMR): `4Fkrv8JZhhzftCWparEwqv8rnbys5tAXx2JoiZukyQhmXGWWxjbzaRe9MWEzYTrbeocj4abzKfA6GWWt8AkVY1fkcjqVXRUQhkaGLsPjsr`

## License

MIT
