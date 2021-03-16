function Initialize()
    if SKIN:GetVariable('Item10') ~= "" then
		SKIN:Bang('!SetOption', 'Item0', 'MouseOverAction', '[!SetOption Item0 Text [StringLimit#Language#]][!SetOption Item0 SolidColor "160,0,0,255"][!UpdateMeter Item0][!Redraw]')
		SKIN:Bang('!SetOption', 'Item0', 'MouseLeaveAction', '[!SetOption Item0 Text [StringInfo#Language#]][!SetOption Item0 SolidColor "#colorItems#"][!UpdateMeter Item0][!Redraw]')
		SKIN:Bang('!DisableMouseAction Item0 "LeftMouseDoubleClickAction"')
		SKIN:Bang('!SetOption Item0 LeftMouseUpAction ""')
	end
	CalcLastItem()
end

function CalcLastItem()
	local item
	for i = 1, 9 do
		if SKIN:GetVariable('Item'..i):gsub("\r\n", "#*CRLF*#") ~= "" then
			item = i
		end
		SKIN:Bang('!SetOption Item'..(item)..' Padding #ActivePad#')
	end
	SKIN:Bang('!SetVariable LastItem """'..item..'"""')
	if SKIN:GetVariable('IsOpen') == "1"  then
		SKIN:Bang('!SetVariable Offset 1')
	end
end

function AddItem()
	local input, crlf = SKIN:GetVariable('Item0'):gsub("\r\n", "#*CRLF*#")
	if input ~= "" then
		for i = 1, 9 do
			SKIN:Bang('!WriteKeyValue Variables Item'..(i+1)..' """'..SKIN:GetVariable('Item'..i):gsub("\n", "#*CRLF*#")..'""" "#CURRENTPATH#DPNotes.txt"')
		end
		SKIN:Bang('!WriteKeyValue Variables Item1 """'..input..'""" "#CURRENTPATH#DPNotes.txt"')
		SKIN:Bang('[!Refresh]')
	end
end

function EditItemA(n)
	SKIN:Bang('!SetVariable ItemOrig """'..SKIN:GetVariable('Item'..n):gsub("\n", "\r\n")..'"""')
	SKIN:Bang('!CommandMeasure mInput "ExecuteBatch 2"')
end

function EditItemB(n)
	local input = SKIN:GetVariable('Item0'):gsub("\r\n", "#*CRLF*#")
	if input ~= "" then
		SKIN:Bang('[!WriteKeyValue Variables Item'..n..' """'..input..'""" "#CURRENTPATH#DPNotes.txt"][!Refresh]')
	else
		DeleteItem(n)
	end
end

function ClipItem(n)
	SKIN:Bang('!SetClip "'..SKIN:GetVariable('Item'..n):gsub("\n", "\r\n")..'"')
end

function DeleteItem(n)
	for i = n, 9 do
		SKIN:Bang('!WriteKeyValue Variables Item'..i..' """'..SKIN:GetVariable('Item'..(i+1)):gsub("\n", "#*CRLF*#")..'""" "#CURRENTPATH#DPNotes.txt"')
	end
	SKIN:Bang('[!WriteKeyValue Variables Item10 "" "#CURRENTPATH#DPNotes.txt"][!Refresh]')
end

function SwapItemUp(n)
	if n ~= "1" then
		SKIN:Bang('!WriteKeyValue Variables Item'..n..' """'..SKIN:GetVariable('Item'..(n-1)):gsub("\n", "#*CRLF*#")..'""" "#CURRENTPATH#DPNotes.txt"')
		SKIN:Bang('[!WriteKeyValue Variables Item'..(n-1)..' """'..SKIN:GetVariable('Item'..n):gsub("\n", "#*CRLF*#")..'""" "#CURRENTPATH#DPNotes.txt"][!Refresh]')
	end
end

function SwapItemDown(n)
	if n ~= "10" and SKIN:GetVariable('Item'..(n+1)) ~= "" then
		SKIN:Bang('!WriteKeyValue Variables Item'..n..' """'..SKIN:GetVariable('Item'..(n+1)):gsub("\n", "#*CRLF*#")..'""" "#CURRENTPATH#DPNotes.txt"')
		SKIN:Bang('[!WriteKeyValue Variables Item'..(n+1)..' """'..SKIN:GetVariable('Item'..n):gsub("\n", "#*CRLF*#")..'""" "#CURRENTPATH#DPNotes.txt"][!Refresh]')
	end
end

function InitDelayed(n)
		SKIN:Bang('!SetOption', 'Loop', 'Disabled', '"0"')
	if n == 1 then
		SKIN:Bang('[!SetOption Loop "InvertMeasure" "([LoopState]=1 ? 0:1)"][!SetOption LoopState "Formula" "([LoopState]=1 ? 0:1)"] [!UpdateMeasure Loop]')
		SKIN:Bang('[!SetVariable Offset "(Cos([Loop]/100*PI/2))]"')
	end

end