#!/bin/sh
# Leak test for gunzip. Watch top for growing process size.

# Just using urandom will make gzip use method 0 (store) -
# not good for test coverage!

cat /dev/urandom \
| while true; do read junk; echo "junk $RANDOM $junk"; done \
| ../opptattkasse gzip \
| ../opptattkasse gunzip -c >/dev/null
