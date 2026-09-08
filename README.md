# Computational Game Theory

Source files for the course website and textbook by Tomáš Kroupa, built with
[Quarto](https://quarto.org/).

**[Read the course website](https://tomaskroupa.github.io/quarto-game-theory-course/)**

## Source structure

- `course-info/`: course information and semester-project instructions.
- `lectures/`: textbook chapters.
- `games/`: game catalogue and diagrams.
- `_quarto.yml`: book structure, navigation, and website configuration.
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
