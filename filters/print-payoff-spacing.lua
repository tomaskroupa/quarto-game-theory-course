-- Pandoc's Typst math writer drops array rules and column alignment. Render
-- labelled payoff arrays as native tables, keeping all cell mathematics.
function Math(el)
  if not FORMAT:match("typst") or el.mathtype ~= "DisplayMath" then
    return
  end

  local columns, body = el.text:match(
    "^%s*\\begin{array}{([clr]|[clr]+)}(.-)\\end{array}%s*$")
  if not columns then
    return
  end

  local alignments = { c = "center", l = "left", r = "right" }
  local align = {}
  for column in columns:gmatch("[clr]") do
    align[#align + 1] = alignments[column]
  end

  local cells = {}
  body = body:gsub("\\hline", "")
  for row in (body .. "\\\\"):gmatch("(.-)\\\\") do
    if row:match("%S") then
      local count = 0
      for cell in (row .. "&"):gmatch("(.-)&") do
        count = count + 1
        local content = pandoc.write(pandoc.Pandoc({
          pandoc.Plain({ pandoc.Math("InlineMath", cell) })
        }), "typst"):gsub("%s+$", "")
        cells[#cells + 1] = "[" .. content .. "]"
      end
      assert(count == #align, "Payoff array has an inconsistent column count")
    end
  end

  local result = "#block(width: 100%, breakable: false)[\n#align(center)[\n"
  -- Keep the larger Cournot and Morra matrices inside the text area.
  if #align >= 8 then
    result = result .. "#set text(size: 0.85em)\n"
  end
  result = result .. "#table(\ncolumns: " .. #align .. ",\n"
    .. "align: (" .. table.concat(align, ", ") .. "),\n"
    .. "inset: (x: 0.6em, y: 0.35em),\nstroke: none,\n"
    .. "table.vline(x: 1, stroke: 0.5pt),\n"
    .. "table.hline(y: 1, stroke: 0.5pt),\n"
    .. table.concat(cells, ",\n") .. ",\n)\n]]"
  return pandoc.RawInline("typst", result)
end
