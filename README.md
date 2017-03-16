1Password Docker
================

1Password running in wine/docker

Build
=====

```
docker build -t 1password .
```

Setup
=====

* Put the license file in ~/.agilebits

```
$ mkdir ~/.agilebits
$ cat - > ~/.agilebits/OPW4.license <<EOF
LICENSE_TEXT
EOF
```

* Make the 1password vault available under your $HOME

The startup script will look under $HOME for any .opvault files and pass them
on to the running container.

* Once started, in order to get the browser extension running, you might have
to restart the helper:

Go to Help -> Restart 1password Helper

Run
===

```
$ install -m 755 1password /usr/local/bin
$ /usr/local/bin/1password
```
