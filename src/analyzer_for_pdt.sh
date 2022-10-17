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
	elif [[ $KEYWORD =~ "all" ]]; then
		analyze_all
	else 
		analyze
	fi
}

analyze (){
	cd $HOME/go/src/github.com/bountylabs/service

	COMMAND="github.com/bountylabs/service/tools/lint/passes/pdtv2/cmd"
	TARGET="github.com/bountylabs/service/$KEYWORD/..."
	RESULT=$(go run $COMMAND combined -json $TARGET 2> /dev/null)
	echo $RESULT \
		| sed 's/\\\\/\\/g' \
		| jq 'to_entries|.[]|select(.key|contains(".test")|not)|.value|.pdtv2|.[]|.[]' \
		| grep -E --color 'notice|warning|complete|provide|specified|unhandled|$'
}

analyze_all (){
	directories=(
		"github.com/bountylabs/service/safety_service"
		"github.com/bountylabs/service/guest"
		"github.com/bountylabs/service/channels"
		"github.com/bountylabs/service/proxsee_service/user"
		"github.com/bountylabs/service/proxsee_service/tickets"
		"github.com/bountylabs/service/api_common"
		"github.com/bountylabs/service/proxsee_service/chatman"
		"github.com/bountylabs/service/audit-trail"
		"github.com/bountylabs/service/email"
		"github.com/bountylabs/service/hlspull"
		"github.com/bountylabs/service/fleets"
		"github.com/bountylabs/service/lambda_spam_requests"
		"github.com/bountylabs/service/text-classification"
		"github.com/bountylabs/service/tools"
		"github.com/bountylabs/service/payman"
		"github.com/bountylabs/service/periscope_admin"
		"github.com/bountylabs/service/public-api"
		"github.com/bountylabs/service/proxsee_service/abuse"
		"github.com/bountylabs/service/proxsee_service/appmessage"
		"github.com/bountylabs/service/proxsee_service/authentication"
		"github.com/bountylabs/service/proxsee_service/bcast"
		"github.com/bountylabs/service/proxsee_service/cdn"
		"github.com/bountylabs/service/proxsee_service/copyrightviolation"
		"github.com/bountylabs/service/proxsee_service/dmca"
		"github.com/bountylabs/service/proxsee_service/editorial"
		"github.com/bountylabs/service/proxsee_service/feature"
		"github.com/bountylabs/service/proxsee_service/ingest"
		"github.com/bountylabs/service/proxsee_service/installation"
		"github.com/bountylabs/service/proxsee_service/known_device_token"
		"github.com/bountylabs/service/proxsee_service/metadata"
		"github.com/bountylabs/service/proxsee_service/clips"
		"github.com/bountylabs/service/proxsee_service/rank"
		"github.com/bountylabs/service/proxsee_service/spam"
		"github.com/bountylabs/service/proxsee_service/tagging"
		"github.com/bountylabs/service/proxsee_service/themes"
		"github.com/bountylabs/service/proxsee_service/tickets"
		"github.com/bountylabs/service/proxsee_service/tos"
		"github.com/bountylabs/service/proxsee_service/user"
		"github.com/bountylabs/service/proxsee_service/moderation"
		"github.com/bountylabs/service/proxsee_service/traffic"
		"github.com/bountylabs/service/proxsee_service/turn"
		"github.com/bountylabs/service/proxsee_service/vip"
		"github.com/bountylabs/service/proxsee_service/watch"
	)

	cd $HOME/go/src/github.com/bountylabs/service

	for d in ${directories}; do
		term_color_red
		echo Result for $d
		term_color_white

		COMMAND="github.com/bountylabs/service/tools/lint/passes/pdtv2/cmd"
		TARGET="$d/..."
		RESULT=$(go run $COMMAND combined -json $TARGET 2> /dev/null)
		echo $RESULT \
			| sed 's/\\\\/\\/g' \
			| jq 'to_entries|.[]|select(.key|contains(".test")|not)|.value|.pdtv2|.[]|.[]' \
			| grep -E --color -A 2 'notice|warning'
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
post
