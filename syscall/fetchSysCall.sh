#!/bin/bash


function usage()
{
        echo "Usage: ./fetchSysCall.sh -i SESSION_ID"
}

if [ "$#" -ne 2 ]; then
        usage
        exit 1
fi

while [ "$1" != "" ]; do
        case $1 in
                -i )    shift
                        SESSIONID=$1
                        ;;
                * )     usage
                        exit 1
        esac
        shift
done

export PATH=$PATH:/usr/local/bin
export LD_LIBRARY_PATH="/usr/local/lib"

BUFFERDIR=buffer/buffer_$SESSIONID
BUFFERLOCK=buffer/buffer_${SESSIONID}.lock
echo $BUFFERLOCK
TRACEFILE=data/syscall_${SESSIONID}.log

if [ ! -f $TRACEFILE ]
then
        touch $BUFFERLOCK
        babeltrace --clock-date $BUFFERDIR > $TRACEFILE
        rm $BUFFERLOCK
        rm -rf $BUFFERDIR
fi

