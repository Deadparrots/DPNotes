function Initialize()
	local item = 0

	while(SKIN:GetVariable('Item'..(item + 1)):gsub("\r\n", "#*CRLF*#") ~= "") do
		item = item + 1
	end

	if SKIN:GetMeter('Item'..item) == nil then
		SKIN:Bang('[!Refresh]')
		SKIN:Bang('!Log "Reloading to show new meters"')
	elseif SKIN:GetMeter('Item'..(item + 1)) ~= nil then
		SKIN:Bang('[!Refresh]')
		SKIN:Bang('!Log "Reloading to remove old meters"')
	end

	SKIN:Bang('!SetVariable LastItem """'..item..'"""')
	SKIN:Bang('!SetVariable LoopPT '..(SKIN:GetVariable('IsOpen'))..'')
	SKIN:Bang('!SetVariable LastItemPosition [*Item'..item..':YH*]')
end

function AddItem()
	local input, crlf = SKIN:GetVariable('Item0'):gsub("\r\n", "#*CRLF*#")
	local last = SKIN:GetVariable('LastItem')
	if input ~= "" then
		for i = 1, (last + 1) do
			SKIN:Bang('!WriteKeyValue Variables Item'..(i+1)..' """'..SKIN:GetVariable('Item'..i):gsub("\n", "#*CRLF*#")..'""" "#@#DPNotes.txt"')
		end
		SKIN:Bang('!WriteKeyValue Variables Item1 """'..input..'""" "#@#DPNotes.txt"')
		SKIN:Bang('[!Refresh]')
	end
end

function EditItemA(n)
	SKIN:Bang('!Log  "'..n..'"')
	SKIN:Bang('!SetVariable ItemOrig """'..SKIN:GetVariable('Item'..n):gsub("\n", "\r\n")..'"""')
	SKIN:Bang('!CommandMeasure TextInput "ExecuteBatch 2"')
end

function EditItemB(n)
	local input = SKIN:GetVariable('Item0'):gsub("\r\n", "#*CRLF*#")
	if input ~= "" then
		SKIN:Bang('[!WriteKeyValue Variables Item'..n..' """'..input..'""" "#@#DPNotes.txt"][!Refresh]')
	else
		DeleteItem(n)
		SKIN:Bang('[!Refresh]')
	end
end

function DeleteItem(n)
	local last = SKIN:GetVariable('LastItem')

	if SKIN:GetVariable('Item'..(last + 1)) == nil then
		last = last - 1
	end

	for i = n, last do
		SKIN:Bang('!WriteKeyValue Variables Item'..i..' """'..SKIN:GetVariable('Item'..(i+1)):gsub("\n", "#*CRLF*#")..'""" "#@#DPNotes.txt"')
	end
end

function ValidateLoopPT()
		SKIN:Bang('!SetVariable LoopPT [*Loop*]*0.01 ')
end