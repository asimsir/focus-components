#!/bin/bash
#Initialise the file
OUTPUT_DIR="./dist"
OUTPUT_FILE="$OUTPUT_DIR/focus_components.externals.js"
mkdir -p $OUTPUT_DIR
cat webpack_utils/webpack.config.begin > $OUTPUT_FILE
#list the files AND directories
find src/ | {
	#inverse-filter (keeps non-matching line)
	grep -Ev '__tests__|index.js|.md|.html|.scss|.png|example|.json|style|.svg|.css|.pdf'
} | {
	# change src to focus-core, remove .js and trailing slash
	sed -f webpack_utils/patterns.sed
} | {
	#will create something like echo <string> | sed -f...
	# first sed will do the transformation bla-bla/foo to : { root : ['blaBla'], ['foo']...
	# second one is used to add a new line before, with content bla-bla/foo
	xargs -L1 -I% echo "echo % | sed -f webpack_utils/patterns2.sed | sed \"1i '%'\""
	} | {
	#execute the line before (ugly)
	sh
	} | {
	#change \n to \f (special char), so string is one-lined
	tr '\n' '\f'
	} | {
	#remove additional \n
	sed -e 's/\f: {/: {/g'
	} | {
	# back to \n
	tr '\f' '\n'
	} | {
	# focusCore in PascalCase
	sed -e "s/'focusComponents'/'FocusComponents'/g"
} >> $OUTPUT_FILE
cat webpack_utils/webpack.config.end >> $OUTPUT_FILE
