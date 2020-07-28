# prips.sh

[![build status](https://img.shields.io/travis/honzahommer/prips.sh/master.svg)](http://travis-ci.org/honzahommer/prips.sh)

> Print the IP addresses in a given range

## Usage

Invoking `prips.sh -h` prints usage information:

    $ prips.sh -h
    $ usage: prips.sh [options] <start> <end>
    $         -n <x> set the number of addresses to print (<end> must not be set)
    $         -f <x> set the format of addresses (hex, dec, or dot)
    $         -i <x> set the increment to 'x'
    $         -h     display this help message and exit
    $         -v     display the version number and exit

Display all the addresses in a reserved subnet:

    $ prips.sh 192.168.0.0 192.168.0.255

Display every fourth address in a weird block:

    $ prips.sh -i4 192.168.0.10 192.168.0.250

## Installing prips.sh from source

Check out a copy of the prips.sh repository. Then, either add the prips.sh
`bin` directory to your `$PATH`, or run the provided `install.sh` command 
with the location to the prefix in which you want to install prips.sh.
For example, to install prips.sh into `/usr/local`:

    $ git clone https://github.com/honzahommer/prips.sh.git
    $ cd prips.sh
    $ ./install.sh /usr/local

Note that you may need to run `install.sh` with `sudo` if you do not
have permission to write to the installation prefix.

Or use on-line install script:

    $ wget -qO- https://git.io/prips.sh | sh [-s - PREFIX]`

## Support

The prips.sh source code repository is [hosted on
GitHub](https://github.com/honzahommer/prips.sh). There you can file bugs
on the issue tracker or submit tested pull requests for review.

## Version history

*0.1.0* (March 15, 2020)

* Initial public release.

---

© 2020 Honza Hommer. prips.sh is released under an MIT-style license;
see `LICENSE` for details.
