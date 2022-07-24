#! /bin/sh

# Version 1.0
# Send Telegram notifications when an IP address has been banned

function sendMessage() {
	message=$1
	curl -s -X POST https://api.telegram.org/bot$TELEGRAM_AUTH_TOKEN/sendMessage -d chat_id=$TELEGRAM_CHAT_ID -d parse_mode=html -d text="${message}" > /dev/null 2>&1
}

function usage() {
	echo "Usage $0 -n \$JAIL_NAME -b \$IP"
	exit 1;
}

if [ $# -eq 0 ]; then
  usage
fi

while getopts "n:b:" opt; do
	case "$opt" in
		n)
			jail_name=$OPTARG
		;;
		b)
			ban=y
			ip_add_ban=$OPTARG
		;;
		\?)
			echo "Invalid option. -$OPTARG"
      usage
		;;
	esac
done

if [[ ${ban} == "y" ]]; then
	sendMessage "⛔️ <b>[$jail_name]</b> $ip_add_ban has been banned!"
	exit 0
else
	usage
fi
