#!/bin/sh
# Extract uuencoded and bzipped opptattkasse binaries
# from system-image-*.log files

for logfile in system-image-*.log; do
	grep -q '^begin 744 opptattkasse.bz2' "$logfile" \
	|| { echo "No opptattkasse.bz2 in $logfile"; continue; }

	arch=${logfile%.log}
	arch=${arch#system-image-}

	test -e "opptattkasse-$arch" \
	&& { echo "opptattkasse-$arch exists, not overwriting"; continue; }

	uudecode -o - "$logfile" | bunzip2 >"opptattkasse-$arch" \
	&& chmod 755 "opptattkasse-$arch"
done
