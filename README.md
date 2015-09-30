# ggc
Generative Grammar Compiler

Usage:

    ./ggc.sh <input.gg >output.py


Format:

    name:=option1,option2,$namedoption,$namedportion rest of option,option3
    namedoption:={$namedoption,$namedportion {$namedportion,$namedoption},hello}
    namedportion:=foo,bar,baz
