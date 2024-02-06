#!/bin/bash

ORIGINALDIR=/content/app
# Use predefined DATADIR if it is defined
[[ x"${DATADIR}" == "x" ]] && DATADIR=/content/data

# make persistent dir from original dir
function linkreplace () {
	local data_source=$ORIGINALDIR/$1
	local data_target=$DATADIR/$1
	mkdir -p $DATADIR
	if [ -d $data_source ] || [ -f $data_source ]; then
		mv -if $data_source $data_target
	else
		mkdir -p $data_target
	fi
	ln -s $data_target $data_source
}

# models
linkreplace models

# outputs
linkreplace outputs

# Start application
cd $ORIGINALDIR
python entry_with_update.py --listen --port 3001  ${CMDARGS} > $DATADIR/fooocus.log 2>&1
