# ggc
Generative Grammar Compiler

Usage:

    ./ggc.sh <input.gg >output.py

See [test.gg](test.gg) and [zizek.gg](zizek.gg) for examples of grammars of varying complexity.

Bugs:

* Recursive grammars are not possible, because the generated python code will generate all possible components immediately, whether or not they are used.
