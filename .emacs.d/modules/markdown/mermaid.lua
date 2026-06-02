
function CodeBlock(el)
  -- Check if this is a mermaid block
  if el.classes:includes("mermaid") then
    -- Get raw text
    local text = el.text

    -- Fix HTML entities (important)
    text = text:gsub("&gt;", ">")
    text = text:gsub("&lt;", "<")
    text = text:gsub("&amp;", "&")

    -- Trim leading/trailing whitespace
    text = text:gsub("^%s+", "")
    text = text:gsub("%s+$", "")

    -- Remove indentation (critical for Mermaid)
    local lines = {}
    for line in text:gmatch("[^\r\n]+") do
	local cleaned = line:gsub("^%s+", "")
    	table.insert(lines, cleaned)
    end
    text = table.concat(lines, "\n")

    -- Return raw HTML block (no <code>)
    return pandoc.RawBlock(
      "html",
      '<pre class="mermaid">\n' .. text .. '\n</pre>'
    )
  end
end
