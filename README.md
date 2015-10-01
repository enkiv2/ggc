# ggc
Generative Grammar Compiler

Usage:

    ./ggc.sh <input.gg >output.py

See [examples/test.gg](examples/test.gg), [examples/zizek.gg](examples/zizek.gg), and [examples/herosjourney.gg](examples/herosjourney.gg) for examples of grammars of varying complexity.

Notes:

* Anonymous rules are possible by enclosing options in braces ({})
* Named rules can be substituted using a single dollar sign before the named rule. If two dollar signs are used, then a cached expansion of that rule will be used instead (and everywhere that the double-dollarsign version is used will be the same).
* Lines beginning with '#' are comments, unless they begin with '#include' -- in which case, the second (space-separated) token is a filename to include. This filename cannot include spaces, because the spaces cannot be escaped.
* Duplicated spaces or separators will not be deduplicated; this is a FEATURE.
* Arbitrary python code can be inserted into a rule, if you're clever about it. (See the definition for HeroPronoun in [herosjourney](examples/herosjourney.gg) as an example.) This is currently the only way to do conditionals. This code is not sanitized or sandboxed. Obviously, you should manually check any untrusted grammar.

Bugs:

* Recursive grammars are not possible, because the generated python code will generate all possible components immediately, whether or not they are used.
* Mismatched braces are neither detected nor handled gracefully. (WONTFIX)

Todo:

* Includes should be idempotent.
