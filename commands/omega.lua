require("util")

addCommand("lul",function(m,args)

	local rep = ""
	rep = rep..args[1]
	for i = 2,#args do
		rep = rep..","..args[i]
	end

	m:setContent(string.gsub(rep,"o","<:omegalul:450179262876614657>"))
end)