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
like "the machine will type another asterisk at you" (p. 23) because, at the
time, humans interacted with computers by passing back and forth control of a
typewriter.

However, TeX wasn't really workable until 1982, with the release of TeX82(?).

[sail-pdp-10]: https://forum.stanford.edu/wiki/index.php/Early_Computers_at_Stanford#DEC_PDP-10_2
[pdp-10-processors]: http://pdp10.nocrew.org/cpu/processors.html
