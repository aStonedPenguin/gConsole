console.texts = console.texts or {}

function console.AddText(...)
	local count = #console.texts + 1
	local tbl = {...}

	if (count > 1000) then
		table.remove(console.texts, 1)
		count = count - 1
	end
	
	console.texts[count] = {color = tbl[1] or color_grey, text = tbl[2]}
	console.Refresh()
end

function console.GetTextSize(str)
	surface.SetFont('console.Font')
	return surface.GetTextSize(str)
end

