# What is TeX?

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
