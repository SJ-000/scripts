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
	cd $HOME/go/src/github.com/bountylabs/service

	COMMAND="github.com/bountylabs/service/tools/lint/passes/pdtv2/cmd"
	TARGET="github.com/bountylabs/service/$KEYWORD/..."
	RESULT=$(go run $COMMAND combined -json $TARGET 2> /dev/null)
	echo $RESULT | jq 'to_entries|.[]|select(.key|contains(".test")|not)|.value|.pdtv2|.[]|.[]' | grep -E --color 'notice|warning|complete|provide|specified|unhandled|$'
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
