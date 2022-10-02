# GLOBDOTS lets files beginning with a . be matched without explicitly specifying the dot.
# setopt globdots

# If globs do not match a file, just run the command rather than throwing a no-matches error.
# This is especially useful for some commands with '^', '~', '#', e.g. 'git show HEAD^1'
unsetopt NOMATCH
