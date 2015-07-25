# Pretty-printer program implemented in Standard ML in 1996

[![Build Status](https://travis-ci.org/FranklinChen/schreiner-friedman-pretty-printer.png)](https://travis-ci.org/FranklinChen/schreiner-friedman-pretty-printer)

I implemented a pretty-printer from Schreiner and Friedman's
"Introduction to Compiler Construction with UNIX", 1985.

This repository is for historical interest only. It is code I wrote in
1996, some of the earliest examples of
[Standard ML](http://sml-family.org/) code I wrote (I started learning
the language in summer 1995).

Amusingly, I discovered the RCS repository for my little project and
ended up importing it into Git, using this
[useful script](https://github.com/Oblomov/rcs-fast-export)! So you
can see all my embarrassing commits between July 1996 and May 1998
when I stopped maintaining the project.

## An experiment

I was very interested in Knuth's idea of "literate programming" at the
time, and although I abandoned it eventually, I used Norman Ramsey's
[Noweb](https://www.cs.tufts.edu/~nr/noweb/) system in order to
generate LaTeX and HTML "literate code" as well as Standard ML code
for [Moscow ML](http://mosml.org/).

## It still builds today!!

With a little bit of coaxing, I actually got everything to build on my
Mac **19 years later**! The only minor change I made was to generate
PDF instead of DVI.

By coincidence, a month ago I discovered Moscow ML was still alive,
and I [contributed a Homebrew formula](https://github.com/kfl/mosml/issues/33
).

Also, I had to fix the Homebrew formula for Noweb, and today I no
longer have Noweb LaTeX stuff in my `TEXINPUTS`.

And I use `latexmk` not installed through Homebrew but as part of the
[MacTeX](https://tug.org/mactex/) distribution.

```console
$ brew install mosml
$ brew install noweb
$ make TEXINPUTS=/usr/local/opt/noweb/tex/generic/noweb:
```
