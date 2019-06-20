require("util")

addCommand("blocks",function(m,args)
	if args[1] == "" then return end
	
	local rep = table.concat(args,",")

	m:setContent(string.gsub(rep,"%a",":regional_indicator_%1:\226\128\139"):lower())
end)