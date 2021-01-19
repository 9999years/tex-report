# Why do I care about this, and why should you?

- Computers are disappointing, and should be better, and to make them better we
  have to start by dreaming bigger about what they can do for us.

- Writing TeX is really hard with limited working memory and shitty devtools.

- I need notes and documents to be *good* --- not only easy to write and
  well-formatted, but easy to share, interact with, and read.

- I need my tools to help me, and TeX just gets in my way too much.

**Computers disappoint me deeply.** I find them difficult to use and frequently
unable of answering the questions I want to ask, even when they're obviously
capable of doing so. Most web apps (which, for the past decade or so, has been
"most apps") are a light user interface over a relational database. But even
paid apps or highly-funded ones can rarely answer more than the simplest
questions.

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

- lll

xxx

- The difference between being able to *see* your data (i.e. rearrange order in
  a list, see due dates, etc.) and being able to ask *questions* of it (i.e.
  how many tasks are due on monday?)

[todoist-filters]: https://todoist.com/help/articles/introduction-to-filters
