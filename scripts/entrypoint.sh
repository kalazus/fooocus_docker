#!/bin/bash

ORIGINALDIR=/content/app
# Use predefined DATADIR if it is defined
[[ x"${DATADIR}" == "x" ]] && DATADIR=/content/data

# make persistent dir from original dir
function linkreplace () {
	mkdir -p $DATADIR
	mv -if $ORIGINALDIR/$1 $DATADIR/$1 
	ln -s $DATADIR/$1 $ORIGINALDIR/$1
}

# models
linkreplace models

# outputs
linkreplace outputs

# Start application
cd $ORIGINALDIR
python entry_with_update.py --listen --port 3001  ${CMDARGS} > $DATADIR/fooocus.log 2>&1
