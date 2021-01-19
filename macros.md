# TeX's macro system

- `\edef`, `\global`, etc. ...?

Next, let's examine TeX's macro system. Macros are named with a control
sequence, and may have up to 9 parameters, and are defined with the `\def`
command:

    \def<control sequence><parameter text>{<replacement text>}

1. Control sequences are like `\title` or `\divides`, but the `\csname ...
   \endcsname` macros can be used to construct arbitrary control sequence
   names.

2. The parameter text allows templating within the replacement text. Usually, a
   number of parameters are declared like `#1#2#3`, to indicate three
   parameters, but TeX allows parameters to be parsed and delimited with nearly
   any text, allowing definitions like the following, taken from p. 202:

       \def\proclaim #1. #2\par{{\bf#1.\enspace}{\sl#2}\par}

   to be used like

        \proclaim Theorem 1. \TeX\ has an over-complicated macro
        capability.\par

3. The replacement text can use the parameters the same way, with `#1` and so
   on indicating the given arguments.

This system has a few consequences. Though the way arguments can be delimited
is shockingly general, and leaves a lot of ambiguity to be resolved by the
implementation, we also note that there's several ways to parameterize macros.
One can rely on passing arguments, the values of other control sequences,
registers, or more to customize macros.

Ultimately, this pushes TeX users away from well-scoped programming styles,
like Scheme and functional languages encourage, and towards the precarious
management of an enormous amount of global state.

Now, remember how category codes are assigned at tokenization-time? These two
systems interacting create another set of confusing errors. Consider the LaTeX
commands `\makeatletter` and `\makeatother`, which assign the character `@` to
category 11 (letter) and 12 (other) respectively, so that it can and cannot be
used in control sequence names. As a result, this definition

    \def\hello{%
      \makeatletter
      \@hello
      \makeatother
    }

has a replacement text of the tokens `\makeatletter`, `\@`, `e`, `l`, `l`, `o`,
and `\makeatother`, whereas the following

    \makeatletter
    \def\hello{%
      \@hello
    }
    \makeatother

is tokenized as the single control sequence `\@hello`, because the
`\makeatletter` command is executed *before* the replacement text is tokenized,
rather than where the replacement text is being used. But TeX doesn't make it
clear, syntactically or semantically, when tokens are being saved and when
they're being executed, leading to all sorts of order-of-execution related
errors such as this one.

Consider the way which `\def\a{\b}` causes `\a` to expand to whatever `\b`'s
definition is when `\a` is used, versus `\let\a=\b`, which causes `\a` to
expand to what `\b` was defined as *when* the `\let\a=\b` was executed.

To some extent, this is how many scripting languages work; there's global
state, which can be manipulated immediately with top-level code, and
function/procedure definitions, which save bits of code to be run later, and
possibly some rules about forward-references to names that haven't been defined
yet (like JavaScript's "hoisting" feature). However, whereas it's pretty common
to see entire JavaScript, Python, and even Perl files consisting of nothing or
almost nothing but definitions, TeX forces its users to constantly interact
with its sometimes-immediate and sometimes-delayed execution.

Let's examine the source file `multicol.dtx`, one of the smallest packages
which is required in any LaTeX distribution. At 4482 lines, it includes the
(literate-ish) source code for the `multicol.sty` package, as well as the
entire documentation manual, and, in fact, literate code for the documentation
manual as well. Here's a package option definition from line 991, at the start
of the package's actual code:

    \DeclareOption{colaction}{%
      \def\mc@col@status@write{%
             \protected@write\@auxout{}%
                  {\string\mc@col@status
                  {\ifmc@firstcol 1\else 2\fi}}%
             \mc@firstcolfalse}%
      \def\mc@lastcol@status@write{%
             \protected@write\@auxout{}%
                  {\string\mc@col@status{3}}}%
    }

Note that, similar to the replacement text argument of `\def`, the second
argument to `\DeclareOption` is executed later, conditionally, like a
functional programming language's thunk, except the only thing the option
definition does is manipulate *local* state (note that the code doesn't use
`\global\def`s) in the scope where the arguments are *parsed*; we don't know
where that is, yet, or what that namespace will look like, though it happens to
be in the top-most scope here --- and one simply has to know that
`\ProcessOptions` will execute all the saved code from `\DeclareOption`s;
there's no syntactic or language-level way to indicate which commands add to
hooks and which commands execute hooks, even though LaTeX and expl3 provide
various hook-like interfaces. (And one could observe that hooks themselves are
just part of the execute/delay/scope confusions.)

## Types

There's another problem, as well; macro definitions are TeX's only real tool
for building abstractions, and they offer no way to verify or inspect the types
of arguments, leading to confusing code and difficult-to-detect bugs.

TeX is a programming language, so (unsurprisingly) people have written large
and non-trivial programs with it. Ultimately, these are usually in favor of
typesetting text or graphics, but TeX's foundations are so weak that these
programs often end up quite generic --- on CTAN one can find implementations of
stacks, hashmaps, numeric arrays, and other data structures, simply because TeX
lacks an easy way to represent them.

Let's consider some examples.

- subscripts and unbraced arguments
