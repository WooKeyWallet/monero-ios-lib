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
cd #your Xcode.app#
sudo cp ./Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/sys/vmmeter.h ./Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/sys/
sudo cp ./Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/udp_var.h ./Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/netinet/
sudo cp ./Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/netinet/ip_var.h ./Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include/netinet/
```

#### Other headers

You need make available for building following headers:

```bash
$ mkdir /usr/local/include/sys
$ cp /usr/include/sys/vmmeter.h /usr/local/include/sys
$ mkdir /usr/local/include/netinet
$ cp /usr/include/netinet/{udp_var,ip_var}.h /usr/local/include/netinet
```

### Build Monero

#### Checkout

```bash
$ git clone https://github.com/WooKeyWallet/monero-ios-lib.git
$ cd ./monero-ios-lib
$ bash ./build.sh
```

## Thanks

Thanks to Bakhtiyor K. in Uzbekistan for helping us during the development process.

## Donating

Donation Address (XMR): `4Fkrv8JZhhzftCWparEwqv8rnbys5tAXx2JoiZukyQhmXGWWxjbzaRe9MWEzYTrbeocj4abzKfA6GWWt8AkVY1fkcjqVXRUQhkaGLsPjsr`

## License

MIT
