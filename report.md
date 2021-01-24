# TeX

## What is TeX?

TeX, pronounced roughly like "tech", is a suite of software and technologies
for writing documents, originally written by Donald Knuth over the course of
about a year and released in 1978. That's a pretty vague description, because,
as we'll see, TeX is in fact a combination of many different kinds of tools and
programs in one interconnected system.

In the TeXbook, the 494-page manual describing TeX and its features, Donald
Knuth describes TeX as "a new typesetting system intended for the creation of
beautiful books --- and especially for books that contain a lot of mathematics"
(p. v), but "a typesetting system" somehow fails to encapsulate some of TeX's
stranger features, like a startlingly complex macro language built on top of a
register-based virtual machine.

Part of the difficulty here is that "TeX" isn't really just the `tex` program
that Knuth wrote in 1978 --- or `metafont` and `initex` and so on, which went
with it. Under the hood of any modern TeX distribution is a *large* collection
of seemingly unrelated utilities as well as an enormous collection of hacks to
cope with the fact that TeX was designed in 1978. Which leads us to ask: what
did computing look like in 1978?

Sources are vague, but as far as I can tell, TeX was written (at least
initially, or near the beginning) at the Stanford Artificial Intelligence Lab
(SAIL) on its [DEC PDP-10][sail-pdp-10] with, by 1977, a KA10 and KL10
processor. The KL10 processor was much more powerful than the decade-old KA10
(the [clock speed for the KA10][pdp-10-processors] is just listed as "async"),
with the KL10 running at about 25 MHz. The PDP-10 system at SAIL had 196,608
36-bit words of memory, equivalent to about 0.9MB, or about 1/3 of my most
recently-taken picture of a kitten.

Though SAIL, at the time one of the best-equipped computing labs on the planet,
had video terminals for the PDP-10's users (i.e. screens and keyboards
connected to the computer), video terminals weren't yet commonplace --- the
influential VT100 terminal wasn't released until late 1978, and the ADM-3A
terminal was released only two years earlier in 1976.

More commonly, computers were used with line printers (which are roughly
receipt printers capable of printing full-sized pages, one line of text at a
time) or teletype terminals (roughly electronic typewriters which printed
output from the computer automatically, in response to other text typed by the
computer user). These paper-based devices were incredibly slow and
low-bandwidth compared to the high-resolution full-color displays we're used to
today, and they facilitated a very different sort of software design.

As a result, the TeXbook urges you to "go to the lab where the graphic output
device is" (p. 23), because line printers and teletypes couldn't print
formatted text, so there was no way to preview a document without printing it,
and because of the wide variety of printers, all with different interfaces, TeX
produced its output in its own proprietary "device independent" `dvi` format,
"capable of being printed on almost any kind of typographic output device" (p.
23).

TeX's age makes its mark throughout the text, leading Knuth to write phrases
like "the machine will type another asterisk at you" (p. 23) or "TeX doesn't
have any idea where the ink will go --- only the output device knows this" (p.
63) because, at the time, humans interacted with computers by passing back and
forth control of a typewriter.

Conceptually, it's not clear that TeX is even intended for *writing* with;
sentences like "a wise typist will look through a document before typing
anything, thereby getting a feeling for what sorts of problems will arise and
what sorts of [macro] definitions will be helpful" (p. 199) explicitly separate
*writing* a manuscript from *typing* and *typesetting* it, though almost every
modern toolchain has irrevocably merged the two.

After its initial release, TeX would be extended and augmented in several
significant ways:

- TeX can't produce or design fonts on its own, so even from the beginning it
  came with a companion program, also of Knuth's invention, called `metafont`.
  Unfortunately, `metafont`'s design was too complex and obscure for most
  typographers to interact with, so it never caught on, though it allowed the
  design of what are now catching on as "variable fonts" -- which can smoothly
  transition from thin to bold, or upright to italic, serif to sans-serif, and
  so on.

  TeX's insistence on `metafont` input posed another problem as well: being
  designed with, again, a completely bespoke input and output format, no
  existing digital or analogue fonts were compatible with `metafont`, and
  translating them took serious artistic effort; it wasn't really until pdfTeX
  released in 1997 that TrueType fonts could be used, and most other formats
  were unusable until XeTeX was released in 2004-2006.

- The American Mathematical Society (AMS) would use Michael Spivak's AMS-TeX
  macro package from 1983 to 1985, until they were superceded by the AMS-LaTeX
  macro packages built on LaTeX.

- In 1984, Leslie Lamport (Ph.D., Brandeis) released LaTeX, a "document
  preparation system". In the introduction to the accompanying LaTeX book
  (1994), he notes that the "first widely available version [of LaTeX was]
  mysteriously numbered 2.09" (p. 2), but the 1994 version was "numbered"
  LaTeX2ε, which Lamport calls for some reason "somewhat less mysterious".

  LaTeX is a *format* for TeX, a predefined "compiled" set of commands that TeX
  can quickly load into memory; where the TeXbook introduced "plain TeX", LaTeX
  introduces an entirely different set of commands in its prelude (the set of
  commands available before anything else is loaded).

  LaTeX is in many ways more verbose and consistent than TeX is, and as a
  result its macro system is generally easier to grok; however, it's still
  ultimately built on the TeX macro system, so it's easy and barely discouraged
  to create and use commands in confusing, unparsable "plain TeX" ways. Lamport
  warns users in Appendix E (p. 232):

  > Most Plain TeX commands can be used in LaTeX, but only with care. LaTeX is
  > designed so its commands fit together as a single system. Many compromises
  > have been made to ensure that a command will work properly when used in any
  > reasonable way with other LaTeX commands. A LaTeX command may not work
  > properly when used with Plain TeX commands not described in this book.

  As a result, plain TeX and LaTeX are both "in the common consciousness" from
  people who learn from the TeXbook and aging academics who learned the minimal
  amount of TeX decades ago and never bothered to brush up or investigate
  further, but plain TeX and LaTeX do not play nicely together, and this leads
  to documents that are inconsistent and difficult to understand.

  Additionally, the LaTeX book introduces the MakeIndex program, which can be
  run before/after TeX to process index entries and generate an index, and
  BibTeX (1985), "a separate program that provides an automatic bibliography
  feature for LaTeX" (p. 4).

  Nowadays, Biber (c. 2011), a "backend bibliography processor for biblatex" is
  used instead of BibTeX. Of course, Biber takes a different input format and
  produces a different output format, so there's all kinds of incompatability
  issues where Biber, BibTeX, and biblatex interact.

  LaTeX, along with other distributions/programs based on it, have been the
  most widely used TeX programs since about the 2000s.

- In 1989, TeX3 was released, extending input from 7 to 8 bits and enabling
  fonts to have up to 256 characters.

  But this was before Unicode, so they invented their own bespoke encoding for
  TeX's Latin fonts, called T1.

- In 1987, Knuth worked along with Pierre MacKay to create TeX-XeT (which
  outputted DVI-IVD files instead of DVI files), a modification of TeX
  attempting to enable typesetting of right-to-left languages mixed inline with
  the left-to-right languages TeX was designed for.

  A second version of TeX--XeT with two hyphens smoothed over some of the hacks
  in the first version, though it was still largely experimental.

- Around 1991, ConTeXt, another modification of TeX with additional macros
  somewhat like LaTeX.

- Next, in 1994, a tool called Omega (Ω) which "enabled (probably) every sort
  of writing directions" ("A brief history of TeX, volume II", p. 70) and
  expanded TeX's font formats from 8 bits (allowing 256 glyphs) to 16 bits
  (allowing a much healthier 65,536 glyphs --- although we should note that
  Unicode was originally a 16-bit encoding, which proved unfit for purpose with
  regards to the large number of CJK [Chinese, Japanese, and Koren] characters
  which needed to be encoded and represented).

- In 1997, pdfTeX was released, allowing TeX to output the PDF file format
  directly and use TrueType fonts.

- At the same time, ε-TeX ("extended TeX") was being developed, based on and
  incorporating the changes from TeX--XeT; later, ε-TeX would be merged into
  pdfTeX as pdfε-TeX, which eventually became pdfTeX again.

- In 2004, XeTeX was released, intended to make TeX better with multilingual
  input (by supporting Unicode input and easy native font selection).

  It has been largely popular since then, allowing users to experiment with
  non-`metafont` typefaces; as Arthur Reutenauer describes (p. 71):

  > XeTeX’s main distinction — and its overwhelming advantage for many of its
  > adherents — is to get rid of nearly all the hassle in font selection, font
  > installation, etc., while opening up at the same time a whole new world of
  > possibilities: people can suddenly use the bleeding-edge features of the
  > newest font technologies with no particular problem. The key to this was
  > the use of a lot of external libraries — which of course comes at a price:
  > users lose part of the control over every detail of the processing chain
  > which had always been a great advantage of TeX; but many find this tradeoff
  > acceptable.

  Instead of `dvi`, XeTeX outputs `xdvi`, "extended dvi", which is converted to
  PDF with `xdv2pdf` or `xdvipdfmx`; though when using a program like `latexmk`
  to manage running LaTeX, MakeIndex, Biber, and so on, output will usually be
  converted to PDF automatically.

- Finally, we should mention LuaTeX, released in 2007, which embeds the Lua
  scripting language into TeX because the TeX macro language is terrible to
  work with.

Though some of these extensions vary only by adding additional commands to use
in TeX documents, many of them replace the base macro set, or enormously extend
it, more akin to Racket's `#lang` concept than simple packages. As a result,
it's difficult to ensure that certain commands are defined, and because TeX has
no notion of versioning or backwards/forwards compatability, there's no way to
declare specific versions, formats, and programs to use when
compiling/processing a LaTeX document, though some editors/tools have added
in... you guessed it, a hack that parses magic comments to determine which
program and options should be invoked to compile a TeX document, though these
don't specify other programs to run (like MakeIndex or Biber), which order to
run them in, and how many times they need to be run --- and many TeX documents,
particularly larger ones, need to be compiled 5-10 times in a row or between
Biber/MakeIndex runs before references and pages "stabilize", leading to a
slow, arduous development/writing process, where feedback on new changes takes
minutes to propagate to document previewers.

Unfortunately, all this historical baggage gets carried around with TeX --- to
understand which advice to follow, users have to know which advice is outdated,
which requires a solid historical understanding of the hacks and updates that
have proliferated with TeX over the years. Pretty much nobody bothers to learn
that much about their typesetting/document preparation systems, so users often
find themselves confused and upset with a sea of conflicting advice spanning
four decades and tooling (programs like `xelatex` and so on) which doesn't help
them catch or resolve issues.

[sail-pdp-10]: https://forum.stanford.edu/wiki/index.php/Early_Computers_at_Stanford#DEC_PDP-10_2
[pdp-10-processors]: http://pdp10.nocrew.org/cpu/processors.html

## Macros in TeX

### Category Codes

Category codes impose a complex system on top of TeX. This takes a bit to
explain, but it's unfortunately necessary.

TeX (as of 1990's TeX 3.0) assumes characters are 8 bits each, for a total of
256 characters. (It's unclear exactly how this interacts with newer engines
like XeTeX.)

In addition to each character's codepoint (that is, its numeric index from 0 to
255), each character in TeX is assigned a *category* or *catcode*. The 16
catcodes are as follows, from p. 37:

    Category  Meaning
     0        Escape character   (\ in this manual)
     1        Beginning of group ({ in this manual)
     2        End of group       (} in this manual)
     3        Math shift         ($ in this manual)
     4        Alignment tab      (& in this manual)
     5        End of line        (<return> in this manual)
     6        Parameter          (# in this manual)
     7        Superscript        (^ in this manual)
     8        Subscript          (_ in this manual)
     9        Ignored character  (<null> in this manual)
    10        Space              (␣ in this manual)
    11        Letter             (A, ..., Z and a, ..., z)
    12        Other character    (none of the above or below)
    13        Active character   (~ in this manual)
    14        Comment character  (% in this manual)
    15        Invalid character  (<delete> in this manual)

At the end of the page, Knuth makes a comment will become more alarming as we
learn more about category codes:

> The category code for any character can be changed at any time, but it is
> usually wise to stick to a particular scheme.

When we read it, it's unclear what "at any time" means, though it turns out to
be fairly literal: catcodes can be changed dynamically and programatically, at
runtime! In fact, it's used to implement many TeX features.

As one example, "private" commands are often given names with `@`s in them,
like `\m@keb@x`, with a horrible little vowel-substitution scheme that makes
everything very hard to read and write. In `.sty` and `.cls` files --- for
package and document class authors --- `@` is given category 11, letter, and in
`.tex` files `@` is given category 12, other. Then, the command `\m@keb@x` is
parsed as one command in `.sty` and `.cls` files, but split into the command
`\m` followed by the characters `@keb@x`, because command names can contain any
number of category 11 "letter" characters *or* exactly one category 12 "other"
character, but not both.

Okay, let's read some of the "dangerous bend" sections to learn more:

> When TeX reads a line of text ... it converts that text into a list of
> "tokens." A token is either (a) a single character with an attached category
> code, or (b) a control sequence.
>
> For example, if the normal conventions of TeX are in place, the text `{\hskip
> 36 pt}` is converted into a list of 8 tokens:
>
> 1. `{` of category 1 (begin group)
> 2. The control sequence `\hskip`
> 3. `3` of category 12 (other)
> 4. `6` of category 12
> 5. ` `, a space of category 10 (space)
> 6. `p` of category 11 (letter)
> 7. `t` of category 11
> 8. `}` of category 2 (end group)
>
> ... Notice that the space after `\hskip` does not get into the token list,
> because it follows a control word.

Now, is it inconsistent that the tokenizer eliminates the space after `\hskip`?
Let's read on to learn a little more:

> It is convenient to learn the concept [of token lists] by thinking of TeX as
> if it were a living organism. The individual lines of input in your files are
> only seen by TeX's "eyes" and "mouth"; but after the text has been gobbled
> up, it is sent to TeX's "stomach" in the form of a token list, and the
> digestive processes that do the actual typesetting are based entirely on
> tokens. As far as the stomach is concerned, the input flows in as a stream of
> tokens, somewhat as if your TeX manuscript had been typed all on one
> extremely long line.
>
> You should remember two chief things about TeX's tokens:
>
> 1. A control sequence is considered to be a single object that is no longer
>    composed of a sequence of symbols. Therefore long control sequence names
>    are no harder for TeX to deal with than short ones, after they have been
>    replaced by tokens. Furthermore, spaces are not ignored after control
>    sequences inside a token list; the ignore-space rule applies only in an
>    input file, during the time that strings of characters are being
>    tokenized.
>
> 2. Once a category code has been attached to a character token, the
>    attachment is permanent. For example, if character `{` were suddenly
>    declared to be of category 12 instead of category 1, the characters `{` of
>    category 1 already inside token lists of TeX would still remain of
>    category 1; only newly made lists would contain `{` of category 12 tokens.
>    In other words, individual characters receive a fixed interpretation as
>    soon as they have been read from a file, based on the category they have
>    at the time of reading. Control sequences are different, since they can
>    change their interpretation at any time. TeX’s digestive processes
>    always know exactly what a character token signifies, because the category
>    code appears in the token itself; but when the digestive processes
>    encounter a control sequence token, they must look up the current
>    definition of that control sequence in order to figure out what it means.

Okay, let's go over some of the more significant things we learned here:

1. A token list consists of characters and their category codes *at the time
   the input was tokenized.*
2. In contrast, the meaning of a control sequences is only looked up when it's
   executed.
3. Catcodes can be changed at any time.

Because of *this feature alone,* TeX cannot have a separate tokenizer, parser,
and interpreter, so that even static analysis as trivial as determining if all
groups match up (that is, are all the braces balanced, except the brace
character can change at any time, including in a nested macro expansion) isn't
possible without executing the TeX code itself, because category codes aren't
known until runtime.

That's a bit of an interesting complaint, because the term "static analysis"
wasn't in wide use until the 1990s; in "Industrial perspective on static
analysis" (Software Engineering Journal, March 1995), Wichmann et. al. write
that "static analysis tools are gaining ground as a complementary technique to
conventional dynamic testing in order to obtain additional assurance on
critical items of software," and that "the idea that computer software should
be used to analyse source programs rather than compile them, has a history of
at least 25 years", citing "the `PFORT` program, [which] was designed to locate
potential problems with the portability of Fortran code." Though I don't know
if it's fair to fault Knuth for failing to foresee the plethora of static
analysis tools 20 years in advance, it's certainly fair to talk about how TeX
isn't working for contemporary use, and to talk about the ways its design
inhibits accessible tooling.

But back to catcodes. Knuth then asks in Exercise 7.4:

> Suppose that the commands
>
>     \catcode`\<=1
>     \catcode`\>=2
>
> appear next to the beginning of a group that begins with `{`; these
> specifications instruct TeX to treat `<` and `>` as group delimiters.
> According to TeX's rules of locality, the characters `<` and `>` will revert
> to their previous categories when the group ends. But should the group end
> with `}` or `>`?

I'd never bothered to actually look up the answer before, treating the
exercise's mere existence as a strange joke --- I always imagine that the
ability to create these sorts of complex puzzles from emergent properties of a
system would be proof that the system's axioms need reworking to make the
system more consistent with itself, but Knuth seems to consider TeX's confusing
and unintuitive design a fun fact for parties rather than an engineering
failure.

However, the exercise's solution reveals it was a trick question (i.e., useless
for actually learning and not simply feeling tricked) all along. On p. 307:

> It ends with either `>` or `}` or any character of category 2; ...

Oh, because ``\catcode`\>=2`` only changes `>`'s category to 2 and doesn't make
`}` a *different* category. Sure, okay.

> ... then the effects of all `\catcode` definitions within the group are wiped
> out, except those that were `\global`. TeX doesn't have any built-in
> knowledge about how to pair up particular kinds of grouping characters.

But... why not? The syntax is based on grouping. There's two entire catcodes
for it! It would seem useful for TeX to have *some* inherent ability to deal
with that, right? Regardless, Knuth continues:

> New category codes take effect as soon as a `\catcode` assignment has been
> digested. For example,
>
>     {\catcode`\>=2 >
>
> is a complete group. But without the space after `2` it would not be
> complete, since TeX would have read the `>` and converted it to a token
> before knowing what category code was being specified; TeX always reads the
> token following a constant before evaluating that constant.

Again, I find myself wondering why the necessity of writing these kinds of
facts didn't lead Knuth to seriously rework TeX: oh, you need a space here or
it completely breaks, but you can't have a space here, but TeX doesn't really
care about whitespace, and it doesn't matter until the assignment has been
"digested", a term which doesn't appear in the index despite seeming central to
TeX's model of parsing and macro expansion.

#### Consequences of Category Codes

One thing that category codes make intensely difficult in TeX is comparison of
values and tokens, because the question "should `@` of category 12 and `@` of
category 11 compare equal?" lacks a simple and obvious answer.

<details class=TODO><summary>TODO</summary>
</details>

### Macros

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


<details class=TODO><summary>TODO</summary>

`\edef`, `\global`, etc. ...?

</details>

#### Types

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

<details class=TODO><summary>TODO</summary>

- subscripts and unbraced arguments ?

</details>

## Frustrations with TeX & expl3

<details class=TODO><summary>TODO</summary>

Talk about expl3 and what it does; hungarian notation, sort of a
type system, etc., but ultimately hindered by TeX's underlying model.

</details>

## Why is TeX so hard to replace?

<details class=TODO><summary>TODO</summary>

- TeX's flaws are well known --- why hasn't anyone done anything about it?

- TeX's design is poor and feels unfinished; in chapter 14, titled "How TeX
  Breaks Paragraphs into Lines", Knuth notes that one possible item in a
  horizontal list is "a 'whatsit' (something special to be explained later)"
  (p. 95) --- it feels like there are parts Knuth barely bothered to design.
  "He probably knew it was bad and just wanted to finish it and do other
  things", a friend speculates while we chat.

</details>

## Why do I care, and why should you?

<details class=TODO><summary>TODO</summary>

- Computers are disappointing, and should be better, and to make them better we
  have to start by dreaming bigger about what they can do for us.

- Writing TeX is really hard with limited working memory and shitty devtools.

- I need notes and documents to be *good* --- not only easy to write and
  well-formatted, but easy to share, interact with, and read.

- I need my tools to help me, and TeX just gets in my way too much.

</details>

**Computers disappoint me deeply.** I find them difficult to use and frequently
unable of answering the questions I want to ask, even when they're obviously
capable of doing so. Most web apps (which, for the past decade or so, has been
"most apps") are a light user interface over a relational database. But even
paid apps or highly-funded ones can rarely answer more than the simplest
questions.

### Todoist

For instance, let's consider a to-do list app. Actually, let's step back a bit:
let's consider a physical to-do list.

Though you can create fancy planner systems or get special paper for it,
ultimately a to-do list is just a bulleted list of tasks, which can be marked
as completed by erasing or striking them through. And... that's pretty much it.

There's a few ways paper to-do lists are elegant. First, formatting is a
non-issue. Instead of thinking about how to convey information to an app as
text, you can just write and draw whatever seems right. Second, there's no
learning curve; a piece of paper doesn't really have *features*, you just write
whatever you need.

In the early days of graphical consumer computing, the "desktop metaphor" was
emphasized to kickstart understanding of computers --- the desktop is like a
physical desktop; files are arranged into folders; files can be deleted by
putting them in the trash; cutting, copying, and pasting is like doing it by
hand with glue and scissors, and so on. I think the *framing* this creates is
interesting; the desktop metaphor positions computers as a *replacement* for
physical desktop tools and systems, which (theoretically, at least) helps
people quickly understand some things a computer can do, but at the same time
the desktop metaphor limits our potential understanding of computers by
obscuring their actual benefits, with no language to talk about things a
computer can do that are difficult or impossible with paper-based systems.

Now, modern to-do list apps have many more features. Here's a list of the
features Todoist, the app I've used most in the past few years, provides when
adding and editing tasks:

- Tasks have an optional *due date*; unlike most to-do apps, Todoist lets you
  specify a date in a flexible format, permitting relative and vaguely defined
  times like "tomorrow", "later this week", "this weekend", "next thursday", or
  "first tuesday of april".
- Tasks can be *repeating*; that is, they can recur on a schedule. Again,
  Todoist accepts expressions like "first tuesday monthly", "every other week",
  and so on.
- Tasks must be assigned to exactly one *project*.
  - The default project is the inbox.
  - Projects can be shared with other Todoist users and edited collaboratively.
    - In shared projects, tasks can be *assigned* to a particular user.
  - Projects can be nested under other projects.
  - Projects can be commented on, which Todoist recommends using for keeping
    high-level information organized.
- Tasks can be given any number of *labels*.
- Tasks have a priority from 1 (highest, most urgent) to 4 (lowest, default).
- Tasks can have any number of reminders, which send a notification to remind
  you to complete the task.
  - Reminders can be given a date/time, like task due dates.
  - Alternatively, reminders can be given a location (like your home address)
    and be set to remind you when you arrive at or leave the location.
- Tasks can have any number of (nested) *sub-tasks*.
- Tasks can have any number of *comments*, which can contain file attachments
  and voice recordings.

Okay, so we can associate a fair amount of structured information (information
with a known *meaning*, like priorities and due dates) to our tasks. What tools
does Todoist provide for analyzing and interacting with that data? In other
words, how does Todoist 1. justify the effort-cost of entering that structured
information into the app and 2. how does Todoist use that information to help
users plan and accomplish tasks?

Todoist lets you view your tasks in a few different ways.

- There's default menu items for a few views, including:
  - Tasks in the inbox (default) project.
  - Tasks due today.
  - Upcoming tasks, a scrollable list with a section for each day showing tasks
    due that day, if any, and otherwise a button to add a task due that day.
- Next, there's menus to view tasks belonging to a specific project or label.
  - Although projects can be nested, there's no button/toggle to see tasks from
    a given project and its descendants.
- Finally and most interestingly, we can view and edit search queries called
  [*filters*][todoist-filters], which offer some pretty sophisticated
  predicates which can be combined to select different tasks.

These are the ways that Todoist lets us view our data.

Remembering that Todoist, like most web apps, is a relational database with a
user interface, let's think about questions that would be easy to ask of a
relational database (for example, in SQL) that Todoist can't answer.

- Any query asking for an amount; Todoist has (significantly above-average)
  tools for *searching* for tasks, but we can't do any analysis on them. That
  is, we can find overdue tasks, but we can't find out *how many* tasks are
  overdue without manually counting them from the search results. I consider
  this to be a shame because counting items is something that computers are
  exceptionally good at doing quickly and accurately as well as something that
  I am exceptionally bad at doing.

  But in SQL, "how many overdue tasks are there" is `SELECT COUNT(*) FROM
  tasks WHERE completed > due`.



<details class=TODO><summary>TODO</summary>

- The difference between being able to *see* your data (i.e. rearrange order in
  a list, see due dates, etc.) and being able to ask *questions* of it (i.e.
  how many tasks are due on monday?)

</details>

[todoist-filters]: https://todoist.com/help/articles/introduction-to-filters

#### Terminals and terminal emulators

<details class=TODO><summary>TODO</summary>
</details>

## Towards a better system

<details class=TODO><summary>TODO</summary>

- What do other TeX users think a better system looks like? (C.f. Ogawa)

- What capabilities does TeX lack that we want?

</details>

## Beyond plain-text source code

When I started thinking about this project, I thought a lot about what the
syntax should look like. Programming languages often struggle with syntax, and
in particular with sigils (symbols and punctuation like `$` or `%` or `!` with
some intrinsic meaning in a language) --- [the pendulum swings
eternal][pendulum], and designers have gone back and forth on this particular
problem [many times][sigil-cycle]. Sigils are harder to parse for unfamiliar
readers, but afford greater brevity to experienced programmers, and TeX leans
*heavily* on sigils, including features like active characters and catcodes
that allow sigils to execute arbitrary TeX commands

Sigils would be a lot less confusing if there were reliable, cross-language
tools to inspect their meaning and link to relevant documentation, or if the
sigils themselves had a more semantic meaning. However, most programming
languages are still stored in plain text --- that is, what you write and what
you see are the exact same. Plain text formats have been defended on the basis
of exposing a "universal interface" that any program can easily interact with.
But what if our programming languages and tools came with easy ways to dissect,
analyze, and modify source code by exposing tokenizers, lexers, parsers,
language-server-like analysis toolkits, and more? Then, the advantages of plain
text would largely vanish in favor of a far more robust and featureful
interface.

Some of these problems can be solved, however, by displaying the code
differently than what the user sees. Now, I'm not proposing moving to WYSIWYG
editors and workflows, but I'm proposing an annotated, rich interface with the
source code at the editor level. Let me explain what I mean by that, and we can
explore some of the possibilities for better user interfaces to reading,
writing, and editing code.

[scratch]: https://scratch.mit.edu/developers
[blockly]: https://developers.google.com/blockly/
[wolfram-notebooks]: https://www.wolfram.com/notebooks/
[pendulum]: https://buttondown.email/hillelwayne/archive/a21f0eab-404c-472b-b35d-e7d9c58e13fc
[sigil-cycle]: https://xkcd.com/1306/

<details class=TODO><summary>TODO</summary>

- Things we might want in a plain-text-input language.

  - Limitations of plain-text input.

    - There's only so many keys on the keyboard, so typing a lot of special
      characters is hard without a specifically-developed input extension.

    - Plain text editors --- and even IDEs --- are really limited by a
      monospaced grid of glyphs in the way they can present text and metadata
      to users.

      This prevents the program/compiler from easily providing in-depth
      feedback.

- What a *non*-plain-text-input programming language would (or rather, *does*)
  look like, and what advantages it could have.

</details>
