surface.CreateFont ('console.Font', {
	font = 'Lucida Console',
	size = 16,
	weight = 250
})

surface.CreateFont ('console.Font2', {
	font = 'roboto',
	size = 22,
	weight = 450
})

local fr
function console.Open()
	if IsValid(fr) then fr:Remove() end
	local w, h = ScrW() * .6, ScrH() * .6
	fr = vgui.Create('DFrame')
	fr:SetSize(w, h)
	fr:SetTitle('')
	fr:Center()
	fr:MakePopup()
	fr.btnMinim:SetVisible(false)
	fr.btnMaxim:SetVisible(false)
	fr.btnClose:SetVisible(false)

	console.Menu = fr

	function fr:Paint(w, h)
		surface.SetDrawColor(console.c.black)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(console.c.wrapper)
		surface.DrawRect(0, 0, w, 30)
		surface.DrawRect(0, 0, 5, h)
		surface.DrawRect(w - 5, 0, 5, h)
		surface.DrawRect(0, h - 5, w, 5)	
	end

	local title = vgui.Create('DLabel', fr)
	title:SetFont('console.Font2')
	title:SetText('C:/SRCDS/Garrysmod/cmd.lua') -- This isnt actually cmd.lua shhhh
	title:SetTextColor(console.c.background)
	title:SizeToContents()
	title:SetPos(fr:GetWide()/2 - title:GetWide()/2, 5)
	
	local closeb = vgui.Create('DButton', fr)
	closeb:SetSize(50, 25)
	closeb:SetPos(w - 55, 0)
	closeb:SetText('X')
	closeb:SetTextColor(console.c.white)
	closeb:SetFont('console.Font2')
	function closeb:Paint(w, h)
		surface.SetDrawColor(console.c.close)
		surface.DrawRect(0, 0, w, h)
	end
	function closeb:DoClick()
		fr:Remove()
	end

	local pnl = vgui.Create('DScrollPanel', fr)
	pnl:SetSize(w + 25, h - 67.5) 
	pnl:SetPos(10, 35)
	function pnl:ScrollToChild(panel)
		self:PerformLayout()
		
		local x, y = self.pnlCanvas:GetChildPosition(panel)
		local w, h = panel:GetSize()
		
		y = y + h * 0.5
		y = y - self:GetTall() * 0.5

		self.VBar:AnimateTo(y, 0, 0, 0)
	end

	local tx
	local iteration = 0
	local txt
	table.foreach(console.texts, function(k, v)
		local start, en = string.find(v.text, '\n')
		local x, y = console.GetTextSize(v.text)

		txt = vgui.Create('DLabel', pnl)
		txt:SetFont('console.Font')
		txt:SetText(v.text)
		txt:SetTextColor(v.color)
		txt:SetPos(tx, 18 * iteration)
		txt:SizeToContents()
	
		if start ~= nil and en ~= nil then
			tx = 0
			iteration = iteration + 1
		else
			tx = tx + x
		end
	end)

	pnl:ScrollToChild(txt)

	local entry = vgui.Create('DTextEntry', fr)
	entry:SetPos(12.5, h - 32.5)
	entry:SetSize(w - 10, 20)
	entry:SetText('')
	entry:SetFont('console.Font')
	entry:RequestFocus()
	function entry:OnEnter()
		local value = self:GetValue()
		LocalPlayer():ConCommand(value)
		console.AddText(console.c.white, '> ' .. value .. '\n')
	end
	function entry:Paint(w, h)
		self:DrawTextEntryText(console.c.white, console.c.white, console.c.white)
	end
end
concommand.Add('console', console.Open)

function console.Refresh()
	if IsValid(console.Menu) then
		console.Open()
	end
end