   - use SINGLE QUOTE only or 'noglob zmv ...'
   - see zmv -<TAB>
   - -n for dry run
   - with -w,  implicitly add parenthesis to wildcards in the pattern

#+begin_src sh
autoload zmv 

# uppercase file and directory
zmv -wn '**/*' '$1:u$2:u'


# rename a section of a filename, i. e. example.1.{txt,conf,db} or 12345.1.{wav,ogg,mp3} and
# change the 1 to a 2 in the filename while preserving the rest of it. 
zmv -n '(*.)(<->)(.[^.]#)' '$1$(($2+1))$3' # would rename x.0001.y to x.2.y.
zmv -n '(*.0#)(<->)(.[^.]#)' '$1$(($2+1))$3'

# Rename files to lower case
zmv '*' '${(L)f}'

# serially all files (foo.foo > 1.foo, fnord.foo > 2.foo, ..)
autoload zmv
ls *
  1.c  asd.foo  bla.foo  fnord.foo  foo.fnord  foo.foo
c=1 zmv '*.foo' '$((c++)).foo'
ls *
  1.c  1.foo  2.foo  3.foo  4.foo  foo.fnord

# Rename "file.with.many.dots.txt" by substituting dots (exept for the last 
# one!) with a space
touch {1..20}-file.with.many.dots.txt
zmv '(*.*)(.*)' '${1//./ }$2'

# Remove the first 4 chars from a filename
zmv -n '*' '$f[5,-1]' # NOTE: The "5" is NOT a mistake in writing!

# Rename names of all files under the current Dir to lower case, but keep Dir names as-is. 
zmv -Qv '(**/)(*)(.D)' '$1${(L)2}' 
