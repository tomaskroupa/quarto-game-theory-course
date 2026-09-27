# Computational Game Theory

Source files for the course website and textbook by Tomáš Kroupa, built with
[Quarto](https://quarto.org/).

**[Read the course website](https://tomaskroupa.github.io/quarto-game-theory-course/)**

## Source structure

- `course-info/`: course information and semester-project instructions.
- `lectures/`: textbook chapters.
- `exercises/`: the cumulative student exercise PDF.
- `classroom-games/`: experimental classroom games, mathematical analyses,
  and anonymous classroom results.
- `games/`: game catalogue and diagrams.
- `_quarto.yml`: shared book configuration.
- `_quarto-web.yml`: website navigation and course pages.
- `_quarto-print.yml`: study-only PDF chapters and layout.
- `_variables.yml` and `references.bib`: shared game definitions and bibliography.

## Preview and build

Requires Quarto 1.9.38 or newer and Make. For PDF diagrams, install Quarto’s
browser renderer once with `quarto install chrome-headless-shell`.

```bash
make preview  # preview locally
make render   # build the website and PDF
```

Generated files are written to `_site/` and are not tracked by Git.
Pushes to `main` automatically build and publish the website and PDF through
GitHub Actions.

The anonymous calculator export for Two Thirds of the Average is stored in
`classroom-games/data/`.

## Updating the exercises

Replace `exercises/exercises.pdf` with the updated collection, keeping the
filename unchanged. In `course-info/exercises.qmd`, update the PDF date to
match the document and add any confirmed weekly assignments using the
exercise numbers in the PDF. Run `make render`, check the Exercises page
and its download link, then commit and push the changes to `main`.
