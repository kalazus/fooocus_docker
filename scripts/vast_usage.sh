not_used_action() {
	pip install vastai
	vastai stop instance $CONTAINER_ID
}

check_usage() {
	if [[ ! -f $2 ]]; then
		echo "File not found"
		exit 1
	fi
	local timeout=$(($1 * 60))
	local timeleft=$timeout
	while [[ $timeleft -gt 0 ]]; do
		echo $timeleft
		sleep $timeleft
		local timeleft=$(($timeout - ($(date +%s) - $(date -r $2 +%s))))
	done
	echo "Self destruction"
	not_used_action
}

check_usage $1 $2
