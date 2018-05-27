require("util")

addCommand("blocks",function(m,args)
	local rep = ""
	rep = rep..args[1]
	for i = 2,#args do
		rep = rep..","..args[i]
	end

	m:setContent(string.gsub(rep,"%a",":regional_indicator_%1:"):lower())
end)