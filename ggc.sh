#!/usr/bin/env zsh

# input format:
# line <- <name> ":=" (<name>|<atom>)("," (<name>|<atom>))*
# name <- "$"<atom>

function pre() {
	rm -f .includefiles
	awk '/^#include/ { print $2 > ".includefiles" } { if(index($1, "#")!=1) { print } } '
	if [[ -e .includefiles ]] ; then
		cat $(cat .includefiles) | pre
	fi
}

if [[ $# -gt 0 ]] ; then
	cat "$@" | $0
	exit
fi

pre | 
	sed '
		s/:=/,:=,/;
		s/\\,/%%COMMA%%/g;
		s/\\{/%%LBRACK%%/g;
		s/\\}/%%RBRACK%%/g' | awk '
	BEGIN { 
		print "#!/usr/bin/env python\n# coding=UTF-8\nfrom random import Random\nrandom=Random()\n" 
		FS=","
	}
	{
		if($2==":=") {
			cachedItems=cachedItems "\ncached_" $1 "=" $1 "()"
			cachedItems2=cachedItems2 "\ncached_" $1 "=\"\""
			cachedList=cachedList cSep "cached_"$1
			cSep=","
			if(!first) {
				first=$1
			}
			ret=ret "\ndef " $1 "():"
			ret=ret "\n\tglobal " cachedList ""
			ret=ret "\n\treturn random.choice(["
			for (i=3; i<=NF; i++) {
				ret = ret sep "\"" $i "\""
				sep="," 
			}
			ret=ret "])"
		}
	}
	END {
		print cachedItems2
		print ret
		print cachedItems
		print "print(" first "())"
	}' | sed '
		s/\$\$\([a-zA-Z0-9_][a-zA-Z0-9_]*\)/"+cached_\1+\"/g;
		s/\$\([a-zA-Z0-9_][a-zA-Z0-9_]*\)/"+\1()+\"/g;
		s/{/\"+random.choice(["/g;s/}/"])+"/g;
		s/\[,/[/;s/%%COMMA%%/,/g;
		s/%%LBRACK%%/{/g;
		s/%%RBRACK%%/}/g'

