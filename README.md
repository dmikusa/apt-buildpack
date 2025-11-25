# apt Buildpack

[![Version](https://img.shields.io/badge/dynamic/json?url=https://cnb-registry-api.herokuapp.com/api/v1/buildpacks/fagiani/apt&label=Version&query=$.latest.version)](https://github.com/dmikusa/apt-buildpack)

This is a [Cloud Native Buildpack](https://buildpacks.io/) that adds support for `apt`-based dependencies during both build and runtime.

This buildpack is based on [fagiani/apt-buildpack](https://github.com/fagiani/apt-buildpack) and [heroku-buildpack-apt](https://github.com/heroku/heroku-buildpack-apt).


## Usage

This buildpack is not meant to be used on its own, and instead should be in used in combination with other buildpacks.

Include a list of `apt` package names to be installed in a file named `Aptfile`; be aware that line ending should be LF, not CRLF.

The buildpack automatically downloads and installs the packages when you run a build:

```
$ pack build --buildpack dmikusa/apt myapp
```

#### Aptfile

    # you can list packages
    libexample-dev

    # or include links to specific .deb files
    http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-precise-amd64.deb

    # or add custom apt repos (only required if using packages outside of the standard Ubuntu APT repositories)
    :repo:deb http://cz.archive.ubuntu.com/ubuntu artful main universe

    # or import GPG keys for custom repos
    :repo:key https://example.com/repo-signing-key.gpg

    # Note: Keys can be imported in both .asc and .gpg formats
    :repo:key https://example.com/repo-signing-key.asc

    # You can also import from keyserver.ubuntu.com: 
    :repo:key CADA0F77901522B3
    
    # ...or from a file URL:
    :repo:key file://key.asc

    # NOTE: This key must be relative to the repository root, i.e. file:///etc/keys/foo.asc will not work.

## License

MIT

## Disclaimer

This buildpack is experimental and not yet intended for production use.
