#!/bin/bash
groupmod -g $gid voc
usermod -u $uid -g $gid voc

# check if homedir is mounted
if grep -q '/home/voc' /proc/mounts; then
	# homedir is mounted into the docker...
	true
else
	# fixup for changed uid and gid
	chown -R voc:voc /home/voc
fi

if grep -q '/video' /proc/mounts; then
	echo "INFO: /video is mounted! Starting voctocore..."
	# run voctocore as voc user
	if [ -x /bin/gosu ]; then
		gosu voc /opt/voctomix/voctocore/voctocore.py -v
	else
		echo "no gosu found..."
		exec su -l -c "/opt/voctomix/voctocore/voctocore.py -v" voc
	fi
else
	echo "ERROR: /video is not mounted!! exiting.."
	exit 1
fi
