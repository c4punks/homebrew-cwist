# homebrew-cwist

Homebrew tap for [CWIST](https://github.com/c4punks/CWIST), a C17 web
framework and application server (HTTP/1.1, HTTP/2, HTTP/3, WebSocket,
hybrid post-quantum TLS).

## Usage

```sh
brew tap c4punks/cwist
brew install cwist
```

Or install directly without tapping:

```sh
brew install c4punks/cwist/cwist
```

The formula builds from the release source tarball
(`dist/cwist-<version>.tar.gz`, vendored dependencies included) and installs
`libcwist.a`, public headers, the `cwist` CLI, and `cwist.pc` pkg-config
metadata under the Homebrew prefix.

The canonical formula source lives in the CWIST repository at
`packaging/homebrew/cwist.rb`; `Formula/cwist.rb` here is the published copy.
