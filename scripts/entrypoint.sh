#!/bin/bash

ORIGINALDIR=/content/app
# Use predefined DATADIR if it is defined
[[ x"${DATADIR}" == "x" ]] && DATADIR=/content/data

# make persistent dir from original dir
function mklink () {
	mkdir -p $DATADIR
	mv -if $DATADIR/$1 $ORIGINALDIR/$1
	ln -s $DATADIR/$1 $ORIGINALDIR/$1
}

# models
mklink models

# outputs
mklink outputs

# Start application
cd $ORIGINALDIR
python entry_with_update.py --listen --port 3001  ${CMDARGS} > $DATADIR/fooocus.log 2>&1
