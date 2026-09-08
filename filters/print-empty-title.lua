-- Quarto requires an index page for a book. Its empty print-only entry
-- must not introduce a blank chapter before the study material.
function Header(el)
  if el.level == 1 and pandoc.utils.stringify(el.content):match("^%s*$") then
    return {}
  end
end
