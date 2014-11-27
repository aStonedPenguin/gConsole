console.old = console.old or {}

console.old.print = console.old.print or print
function console.print(...)
	console.AddText(console.c.print, ... .. '\n')
	return console.old.print(...)
end
print = console.print

console.old.Msg = console.old.Msg or Msg
function console.Msg(...)
	console.AddText(console.c.print, ... .. '\n')
	return console.old.Msg(...)
end
Msg = console.Msg

console.old.MsgN = console.old.MsgN or MsgN
function console.MsgN(...)
	console.AddText(console.c.print, ... .. '\n')
	return console.old.MsgN(...)
end
MsgN = console.MsgN

console.old.MsgC = console.old.MsgC or MsgC
function console.MsgC(...)
	local iteration = 0
	local cache = {}
	table.foreach({...}, function(k, msg)
		iteration = iteration + 1
		cache[iteration] = msg
		if iteration == 2 then
			console.AddText(cache[1] or console.c.print, cache[2])
			iteration = 0
			cache = {}
		end
	end)
	return console.old.MsgC(unpack({...}))
end
MsgC = console.MsgC

console.chat = console.chat or {}
console.old.ChatAddText = console.old.ChatAddText or chat.AddText
function console.chat.AddText(...)
	local txts = {...}

	local lastcol = console.c.white

	local n = ''
	table.foreach(txts, function(k, v)
		local t = type(v):lower()

		if k == #txts then
			n = '\n'
		end

		if t == 'table' then -- we'll assume it's a color
			lastcol = v
		elseif t == 'player' then
			console.AddText(team.GetColor(v:Team()), v:Name() .. n)
		elseif t == 'string' then
			console.AddText(lastcol, v .. n)
		end
	end)
	return console.old.ChatAddText(...)
end
chat.AddText = console.chat.AddText

console.old.Error = console.old.Error or Error
function console.Error(err)
	local info = debug.getinfo(2)
	console.AddText(console.c.error, '[' .. info.source .. ':' .. info.lastlinedefined .. '] ' .. err .. '\n')
	return console.old.Error(err)
end
Error = console.Error

console.old.ErrorNoHalt = console.old.ErrorNoHalt or ErrorNoHalt
function console.ErrorNoHalt(err)
	local info = debug.getinfo(2)
	console.AddText(console.c.error, '[' .. info.source .. ':' .. info.lastlinedefined .. '] ' .. err .. '\n')
	return console.old.ErrorNoHalt(err)
end
ErrorNoHalt = console.ErrorNoHalt

console.old.error = console.old.error or error
function console.error(err, lvl)
	local info = debug.getinfo(2)
	local space = '  '

	console.AddText(console.c.error, '[ERROR] ' .. info.source .. ':' .. info.lastlinedefined .. ' ' .. err .. '\n')

	local level = 2 -- Edited debug.Trace
	while true do
		local info = debug.getinfo(level, 'Sln')
		if not info then break end
		
		if info.what == 'C' then
		
			console.AddText(console.c.error, '"[C]:" function\n')
		  
		else
			local name = info.name

			if name == nil then
				name = 'unknown'
			end
		
			console.AddText(console.c.error, string.format('%s %i: %s - %s:%d\n', space, level - 1, name, info.short_src, info.currentline))
		end
		space = space .. '  '
		level = level + 1
	end
	return console.old.error(err, lvl)
end
error = console.error
