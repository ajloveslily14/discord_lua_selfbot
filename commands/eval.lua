require("util")

addCommand("eval",function(m,args) -- Command to run lua.
	
	local code = table.concat(args,",")
	local env = setmetatable({},{__index = _G}) -- Setup environment for code to be ran in
	env.m = m -- Add invoking message to environment
	env.send = function(...) -- Helper function to print text to channel
		local t = {}
		if #{...} == 0 then 
			t = {"nil"}
		else
			for k,v in pairs({...}) do
				table.insert(t,tostring(v))
			end
		end
		m:reply(table.concat(t,"\t"))
	end 
	env.args = args
	local fn,err = load(code,"Eval","t",env) -- Check for syntax errors.
	if not fn then
		m:setContent("There was an error: ```lua\n"..err.."```")
		timer.sleep(5000)
		m:delete()
		return
	end

	local ran,err2 = pcall(fn) -- Check for runtime errors
	if not ran then
		m:setContent("There was an error: ```lua\n"..err2.."```")
		timer.sleep(5000)
		m:delete()
	end

end)