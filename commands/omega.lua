require("util")

addCommand("lul",function(m,args)
	if args[1] == "" then return end

	local rep = table.concat(args,",")

	m:setContent(string.gsub(rep,"[oO]","<:omegalul:450179262876614657>"))
end)