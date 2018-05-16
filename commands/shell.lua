require("util")

addCommand("shell",function(m,args) -- Passthrough to bash/cmd

	local code = "" -- Because commands may include commas, concatenate all arguments into one string.
	if #args > 2 then
		code = args[1]
		for i = 2,#args do
			code = code..","..args[i]
		end
	else
		code = args[1]
	end

	local shell = io.popen(code)
	local out = shell:read("*a")
	
	local rep = [[input:
	```%s```
	output:
	```%s```]]

	m:setContent(string.format(rep,code,out))
	shell:close()

end)
