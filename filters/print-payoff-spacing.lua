-- Pandoc translates payoff arrays to Typst alignment points without the
-- original column spacing. Add explicit space to keep labels and cells apart.
function Math(el)
  if FORMAT:match("typst")
      and el.mathtype == "DisplayMath"
      and el.text:find("\\begin{array}{c|", 1, true) then
    el.text = el.text:gsub("&", "&\\quad ")
    return el
  end
end
