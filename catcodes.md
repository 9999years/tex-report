# Category Codes

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
> You should remember two chief things about TEX’s tokens:
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
>     \catcode`\<=1
>     \catcode`\>=2
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
>     {\catcode`\>=2 >
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

## Consequences of Category Codes

One thing that category codes make intensely difficult in TeX is comparison of
values and tokens, because the question "should `@` of category 12 and `@` of
category 11 compare equal?" lacks a simple and obvious answer.

