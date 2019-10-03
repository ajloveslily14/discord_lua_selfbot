require("util")

addCommand("shell",function(m,args) -- Passthrough to bash/cmd
	if args[1] == "" then return end

	local code = table.concat(args,",") -- Because commands may include commas, concatenate all arguments into one string.

	local shell = io.popen(code)
	local out = shell:read("*a")
	
	local rep = [[input:
	```%s```
	output:
	```%s```]]

	m:setContent(string.format(rep,code,out))
	shell:close()

end)
