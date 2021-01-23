# A graphical editor

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
