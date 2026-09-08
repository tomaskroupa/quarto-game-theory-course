# Computational Game Theory textbook

This Quarto project is the authoritative student textbook and course website:

- `quarto render` builds the HTML book;
- `quarto render --profile print` builds a Typst PDF without LaTeX;
- once GitHub Pages is enabled, pushing `main` makes GitHub Actions rebuild
  and deploy the complete site.

The published chapters are designed for reading and self-study. Live lectures
use a separate blackboard plan, so the structure and level of detail of a
chapter are not constrained by a presentation format.

## 1. Install

Install:

1. Quarto CLI 1.9.38 or newer from <https://quarto.org/docs/download/>.
2. VS Code.
3. The official `quarto.quarto` VS Code extension. VS Code will recommend it
   when this folder is opened.

Open the **project root** in VS Code, not an individual subdirectory. Check the
installation in the integrated terminal:

```bash
quarto check
```

Quarto uses Chrome or Edge to turn Mermaid diagrams into images for the Typst
PDF. If neither browser is installed, add Quarto's lightweight renderer once:

```bash
quarto install chrome-headless-shell
```

## 2. Daily work in VS Code

Edit textbook chapters in `lectures/` and course information in `course-info/`.
The chapter order and sidebar are defined in `book.chapters` and
`book.appendices` in `_quarto.yml`. While writing:

```bash
make preview
```

To build both textbook formats:

```bash
make render
```

The same commands are available from **Terminal -> Run Task**. The default VS
Code build task is **Quarto: Render everything**.

After changing a page title, chapter numbering, navigation, `_variables.yml`,
a theme, a bibliography, or a shared diagram, perform a full build before
committing. A live preview may update only the currently open document.
Use `make render` to build HTML first and PDF second: an HTML-only rebuild
can remove the previously generated PDF.

## 3. Writing textbook chapters

Each file in `lectures/` is a chapter of the textbook. Organize it according to
the mathematical argument rather than the timing of a live lecture:

- begin with motivation and a short map of the chapter;
- use a small number of descriptive sections and subsections;
- distinguish definitions, examples, propositions, and procedures;
- explain notation where it first appears;
- develop important calculations as complete worked examples;
- connect claims to references and related chapters;
- end with the conclusions that students should retain.

The book should be concise but self-contained: a student who misses a lecture
must still be able to reconstruct the definitions, assumptions, arguments, and
examples from the published chapter.

Use the private, read-only legacy materials as a coverage checklist. Preserve
their substantive definitions, results, arguments, and examples across the
textbook, but rewrite them as concise textbook exposition. Never copy private
source files or decorative or unattributed assets into this repository.

Conditional content should be used only when the HTML and printable books need
different rendering treatment. It should not be used to maintain a second
pedagogical version of a chapter.

Conditional visibility does not prevent a code cell from executing. If a
costly calculation should run only in one format, condition the execution in
the code or precompute and freeze the result.

## 4. Reusing games

All reusable normal-form examples are in the single `_variables.yml` file.
Insert one in any chapter with:

```markdown
{{< var games.prisoners_dilemma.matrix >}}
```

This keeps one editable catalogue while allowing each chapter to select only
the games it needs.

Simple extensive-form games are stored as Mermaid text under
`games/extensive-form/`. A chapter includes one with:

````markdown
```{mermaid}
%%| file: ../games/extensive-form/contingent-plans.mmd
```
````

For a graph that needs the richer `game-theoryst`/`pi-games` Typst notation,
keep the `.typ` source under `games/extensive-form/`, compile it to SVG, and
embed that SVG in the canonical chapter. Both textbook formats can then reuse
the same accessible figure.

## 5. Directory structure

```text
.
├── _quarto.yml                     # HTML textbook and course website
├── _quarto-print.yml               # Typst/PDF textbook profile
├── _variables.yml                  # reusable normal-form games
├── index.qmd
├── course-info/                    # course information and project pages
│   ├── _metadata.yml
│   ├── index.qmd
│   ├── schedule.qmd
│   ├── topics.qmd
│   ├── tutorial-topics.qmd
│   ├── assessment.qmd
│   ├── semestral-project.qmd
│   └── semestral-projects.qmd       # public project-catalogue placeholder
├── lectures/                       # canonical textbook chapters
│   └── 01-strategic-games.qmd
├── games/
│   ├── normal-form-game-catalogue.qmd
│   └── extensive-form/
│       └── contingent-plans.mmd
├── styles/
│   └── book.scss
├── references.bib
├── references.qmd
├── _drafts/                        # optional local drafts; ignored by Git
├── project-context/                # local planning material; ignored by Git
├── AGENTS.md                       # local assistant instructions; ignored by Git
├── .gitignore
├── .vscode/
│   ├── extensions.json
│   └── tasks.json
├── .github/workflows/publish.yml
├── Makefile
└── README.md
```

Rendered files go to:

```text
_site/
├── index.html
├── course-info/...
├── lectures/...
├── games/...
├── references.html
└── downloads/computational-game-theory.pdf
```

`_site/` is generated and deliberately excluded from Git.

## 6. Keep provisional material locally

Store unfinished copies of this project's course pages in `_drafts/`.
The folder is excluded by `.gitignore` and by `project.render` in
`_quarto.yml`. These drafts are not backed up to GitHub.

To keep a provisional page in the public menu, leave its original `.qmd`
file in `course-info/` and its entry in `_quarto.yml`. Replace its body with
a placeholder while retaining an unnumbered heading, for example:

```markdown
---
subtitle: "Computational Game Theory · Winter semester 2026/2027"
---

# Semestral project catalogue {.unnumbered}

Project suggestions will be published here soon.
```

The heading supplies the sidebar label; `.unnumbered` prevents the page from
incrementing textbook chapter numbers. For links to unnumbered sections, use
named links such as `[AI policy](#sec-semestral-project-ai-policy)`.

HTML comments hide text on the rendered page but leave it readable in the
public source. Ignoring a file also does not erase content already committed
to Git history. Review that history before the first public upload if it
contains drafts that should stay local.

## 7. Connect and upload the source to GitHub

The course repository is
[tomaskroupa/quarto-game-theory-course](https://github.com/tomaskroupa/quarto-game-theory-course).
This local project uses a Git repository on `main`. Check its GitHub
connection without transferring files:

```bash
git remote -v
```

Both entries should show
`https://github.com/tomaskroupa/quarto-game-theory-course.git`.
If no remote is listed (for example, after initializing fresh Git history),
restore the connection:

```bash
git remote add origin https://github.com/tomaskroupa/quarto-game-theory-course.git
```

Run this only when `origin` is absent. There is no need to initialize Git again.

When ready for the first upload, build and review the local changes:

```bash
make render
git status --short
git diff
```

Also inspect newly created files listed by `git status`, since `git diff`
does not show untracked files. Then stage and review the intended changes:

```bash
git add .
git diff --cached
```

After reviewing, commit locally and upload:

```bash
git commit -m "Prepare course textbook for publication"
git push -u origin main
```

Only `git push` uploads the commits. Ignored drafts, local planning files,
and generated `_site/` output are excluded from normal staging.

## 8. Enable GitHub Pages once

In the GitHub repository:

1. Open **Settings -> Pages**.
2. Under **Build and deployment -> Source**, select **GitHub Actions**.
3. After uploading the source, open **Actions** and watch the
   `Publish Quarto textbook` workflow. If needed, select **Run workflow**
   for `main` after enabling Pages.
4. Confirm the deployment succeeds and open the website link shown in
   **Settings -> Pages**.

These are the remaining publishing steps after the local connection;
configuring `origin` alone does not upload files or activate the website.
See [GitHub's publishing-source instructions](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).

After that, normal work is only:

```bash
make render
git status --short
git add .
git diff --cached
git commit -m "Revise chapter 1"
git push
```

Every push to `main` renders the HTML and printable textbooks and deploys the
`_site` artifact. No generated HTML is committed, no `gh-pages` branch is
maintained, and no manual Quarto publishing command is required.

## 9. Adding another chapter

1. Add a numbered `.qmd` file under `lectures/`.
2. Add it to `book.chapters` in `_quarto.yml`.
3. Add any required bibliography entries, reusable games, and source-native
   diagrams.
4. Run `make render` and inspect both outputs.
