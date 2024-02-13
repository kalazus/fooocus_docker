#!/bin/bash

ORIGINALDIR=/content/app

# make persistent dir from original dir
function linkdir () {
	local data_source=$ORIGINALDIR/$1
	local data_target=$DATADIR/$1
	ln -s $data_target $data_source
}

if [ ! -d $DATADIR/models ]; then
	#mkdir -p $DATADIR/outputs
	cp -r $ORIGINALDIR/models.org $DATADIR/models/
fi

# models
linkdir models

# outputs
#sed -i -e "s+$ORIGINALDIR/outputs+$DATADIR/outputs+g" $ORIGINALDIR/config.txt

# Start application
cd $ORIGINALDIR
FOOOCUS_LOGS=$DATADIR/fooocus.log
python entry_with_update.py --listen --port 3001  ${CMDARGS} > $FOOOCUS_LOGS 2>&1 &

# check usage
touch $FOOOCUS_LOGS
vast_usage 20 $FOOOCUS_LOGS

