local function include_cl(f)
	if (SERVER) then
		AddCSLuaFile(f)
	elseif (CLIENT) then
		include(f)
	end
end

console = console or {}

include_cl('colors.lua')
include_cl('overwrites.lua')
include_cl('funcs.lua')
include_cl('menu.lua')

local msg = {
	 [[        _____                      _      ]],
	 [[       / ____|                    | |     ]],
	 [[  __ _| |     ___  _ __  ___  ___ | | ___ ]],
	 [[ / _` | |    / _ \| '_ \/ __|/ _ \| |/ _ \]],
	 [[| (_| | |___| (_) | | | \__ \ (_) | |  __/]],
	 [[ \__, |\_____\___/|_| |_|___/\___/|_|\___|]],
	 [[  __/ |                                   ]],
	 [[ |___/                                    ]],
}

table.foreach(msg, function(_, msg)
	MsgC(Color(255,255,255), msg .. '\n')
end)

concommand.Add('console_test', function()
	table.foreach(msg, function(_, msg)
		MsgC(Color(255,255,255), msg .. '\n')
	end)
	MsgN('-----------------------------------------------')
	MsgC(Color(255,102,255), 'wat\n')
	MsgC(Color(255,128,0), 'wat\n')
	MsgC(Color(51,128,255), 'hello\n')
	MsgC(Color(255,255,51), 'hello\n')
	MsgC(Color(255,0,0), 'You are a beautiful console\n')
	MsgC(Color(0,255,0), 'Being colorful is nothing to be ashamed of. ', Color(255,255,255), 'Test single line multi color MsgC()\n')
	MsgN('MsgN() test')
	Msg('Msg() test')
	print('print() test')
	chat.AddText(Color(0,255,0), 'aStonedPenguin', Color(255,255,255), ':', Color(255,255,255), 'chat.AddText() support')
	MsgN('-----------------------------------------------')
	Error('Error() test. You\'re a bad coder and you should feel bad.')
	ErrorNoHalt('Test ErrorNoHalt()')
	error('Test error()')
end)


