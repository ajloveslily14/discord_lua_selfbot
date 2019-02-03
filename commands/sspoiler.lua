require('util')


local function sspoil(m,args)
	if #args < 1 then return end

	local rep = table.concat(args,",")

	rep = rep:gsub("","||||")
	rep = rep:sub(3)
	rep = rep:sub(1,#rep-2)
	m:setContent(rep)
end

addCommand('sspoiler',sspoil)
addCommand('sspoil',sspoil)