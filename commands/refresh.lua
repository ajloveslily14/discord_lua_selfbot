require("util")

function refreshFile(m,args) -- Command to refresh other commands.
	local reload
	if args[1] ~= "" then
		local todo = args[1]..".lua"
		local f = io.popen("ls commands","r") -- Iterate through all files in commands/
		for v in f:lines() do
			if v == todo then
				reload = v 
			end
		end
		if reload then -- If the command we are trying to refresh is valid, reload the file.
			local f,e = loadfile("commands/"..reload) -- Check for syntax errors
				if not f then
					m:setContent("Error loading "..reload..": ```"..e.."```")
					timer.sleep(5000)
					m:delete()
				else
					setfenv(f,_G)
					local func,err = pcall(f) -- Check for runtime errors.
					if not func then
						m:setContent("Error loading "..reload..": ```"..err.."```")
						timer.sleep(5000)
						m:delete()
					else
						m:setContent("Reloaded "..reload)
						timer.sleep(3000)
						m:delete()
					end
				end
		else
			m:setContent("Couldn't find "..todo)
		end
	else
		m:setContent("I need args!")
		timer.sleep(3000)
		m:delete()
	end
end


addCommand("reload",refreshFile)
addCommand("refresh",refreshFile)