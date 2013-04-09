#!/bin/sh

MONO_VERSION=$1
: ${MONO_VERSION:="3.0.6"}

# amusing hack to [fix the mono make file][1]
export echo=echo

# tell binfmt how to launch CLR executables
echo ':CLR:M::MZ::/usr/local/bin/mono:' > /proc/sys/fs/binfmt_misc/register