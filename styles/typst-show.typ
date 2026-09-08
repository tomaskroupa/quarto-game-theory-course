#import "@preview/orange-book:0.7.1": book, part, chapter, appendices

// Keep chapter-title frames within the text area.
#show: book.with(
  title: [$title$],
  subtitle: [$subtitle$],
  author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
  lang: "$lang$",
  main-color: brand-color.at("primary", default: blue),
  heading-style: 1,
)

// references.qmd already supplies the bibliography heading.
#set bibliography(title: none)
