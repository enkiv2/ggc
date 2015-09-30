#!/usr/bin/env zsh

# input format:
# line <- <name> ":=" (<name>|<atom>)("," (<name>|<atom>))*
# name <- "$"<atom>

sed 's/:=/,:=,/;s/\\,/%%COMMA%%/g' | awk '
	BEGIN { 
		print "#!/usr/bin/env python\nfrom random import Random\nrandom=Random()\n" 
		FS=","
	}
	{
		if($2==":=") {
			if(!first) {
				first=$1
			}
			print "def " $1 "():"
			ret="\treturn random.choice(["
			for (i=3; i<=NF; i++) {
				ret = ret sep "\"" $i "\""
				sep="," 
			}
			print ret "])" 
		}
	}
	END {
		print "print(" first "())"
	}' | sed 's/\$\([a-zA-Z0-9_][a-zA-Z0-9_]*\)/"+\1()+\"/g;s/\[,/[/;s/%%COMMA%%/,/g;s/{/\"+random.choice(["/g;s/}/"])+"/g'

