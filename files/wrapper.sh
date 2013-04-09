#!/bin/sh
# a script that exports a shell variable 'echo'
export echo=echo
echo $*
exec $*