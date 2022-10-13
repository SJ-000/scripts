#!/bin/zsh

#set -e

KEYWORD=$1

term_color_red () {
    echo -e "\e[91m"
}

term_color_white () {
    echo -e "\e[39m"
}

confirmation (){
	term_color_red
	echo "========================="
	echo "Given keyword:" $KEYWORD
	term_color_white

	if [[ $KEYWORD == "" ]]; then
		echo "Please give a word to search."
		exit
	fi
}

search (){
	directories=(
		"$HOME/go/src/github.com/bountylabs/service/safety_service"
		"$HOME/go/src/github.com/bountylabs/service/guest"
		"$HOME/go/src/github.com/bountylabs/service/channels"
		"$HOME/go/src/github.com/bountylabs/service/audit-trail"
		"$HOME/go/src/github.com/bountylabs/service/email"
		"$HOME/go/src/github.com/bountylabs/service/hlspull"
		"$HOME/go/src/github.com/bountylabs/service/payman"
		"$HOME/go/src/github.com/bountylabs/service/public-api"

		"$HOME/go/src/github.com/bountylabs/service/fleets"
		"$HOME/go/src/github.com/bountylabs/service/lambda_spam_requests"
		"$HOME/go/src/github.com/bountylabs/service/text-classification"
		"$HOME/go/src/github.com/bountylabs/service/tools"

		#"$HOME/go/src/github.com/bountylabs/service/periscope_admin"
		"$HOME/go/src/github.com/bountylabs/service/api_common"
		"$HOME/go/src/github.com/bountylabs/service/api_common/data/datasets/business"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/user"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/tickets"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/chatman"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/business"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/dmca"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/editorial"

		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/feature"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/ingest"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/installation"

		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/bcast"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/cdn"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/copyrightviolation"

		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/known_device_token"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/metadata"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/clips"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/rank"
		"$HOME/go/src/github.com/bountylabs/service/proxsee_service/spam"
	)

	for d in ${directories[@]}; do
		term_color_red
		echo Result for $d
		term_color_white

		grep -rni --color=always pdt $d | grep -ni --color=always $KEYWORD
	done
}

post (){
	term_color_red
	echo "Done"
	echo "========================="
	term_color_white
}

trap term_color_white EXIT
confirmation
search
post
