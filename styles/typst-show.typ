#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

// Book parts are navigation groups, not numbered textbook chapters.
#let part(title) = heading(level: 1, numbering: none, title)

// Equations in unnumbered chapters must not reuse the preceding textbook
// chapter's prefix. Keep their local numbers and their cross-references.
#let textbook-equation-numbering = equation-numbering
#let equation-numbering(num) = {
  let chapters = query(selector(heading.where(level: 1)).before(here()))
  if chapters != () and chapters.last().numbering == none {
    numbering("(1)", num)
  } else {
    textbook-equation-numbering(num)
  }
}
#let textbook-callout-numbering = callout-numbering
#let callout-numbering(num) = {
  let chapters = query(selector(heading.where(level: 1)).before(here()))
  if chapters != () and chapters.last().numbering == none {
    numbering("1", num)
  } else {
    textbook-callout-numbering(num)
  }
}

// Keep chapter-title frames within the text area.
#show: book.with(
  title: [$title$],
  subtitle: [$subtitle$],
  author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
  lang: "$lang$",
  main-color: brand-color.at("primary", default: blue),
  heading-style: 1,
)

// Quarto gives labelled equations an explicit numbering function. Leave
// ordinary display mathematics unnumbered, as in the HTML edition.
#set math.equation(numbering: none)
#set figure(numbering: callout-numbering)

// The source syntax ([-@eq-...]) supplies its own parentheses. Typst's
// equation numbering includes parentheses, so print only the number for
// these empty-supplement references, evaluated at the target's location.
#show ref.where(supplement: []): it => context {
  let target = it.element
  if target == none or target.func() != math.equation or it.form != "normal" {
    it
  } else {
    let loc = target.location()
    let num = counter(math.equation).at(loc).first()
    let chapters = query(selector(heading.where(level: 1)).before(loc))
    let bare-number = if chapters != () and chapters.last().numbering == none {
      numbering("1", num)
    } else {
      let pattern = if state("appendix-state", none).at(loc) != none { "A.1" } else { "1.1" }
      numbering(pattern, counter(heading).at(loc).first(), num)
    }
    link(loc, bare-number)
  }
}

// The bundled theme adds chapter numbers to running headers even when the
// heading is unnumbered. Preserve its header for numbered textbook chapters.
#show: body => context {
  let numbered-header = page.header
  set page(header: context {
    let chapters = query(selector(heading.where(level: 1)).before(here()))
    if chapters == () or chapters.last().numbering != none {
      numbered-header
    }
  })
  body
}

// references.qmd already supplies the bibliography heading.
#set bibliography(title: none)
