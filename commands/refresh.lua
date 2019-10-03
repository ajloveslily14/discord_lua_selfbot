require("util")


local function getCommandFile(cmd) -- Fetch the name of the file that handles the given command (function by Pegasus_Epsilon)
	local p = io.popen("grep 'addCommand' commands/* | grep '\""..cmd.."\"' | head -n 1 | cut -d: -f1")
	cmd = p:read("*a"):trim()
	p:close()
    return cmd
end


function refreshFile(m,args)
	if args[1] == "" then
		m:setContent("I need a file!")
		timer.sleep(3000)
		m:delete()
		return
	end
	local file = getCommandFile(args[1]) -- Check if the input is actually a file.
	if not file then
		m:setContent("Can't find that file")
		timer.sleep(5000)
		m:delete()
		return
	end

	local func,err = loadfile(file) -- Load the file and check for syntax errors
	if not func then
		m:setContent("Syntax error while loading "..file..": ```"..err.."```")
		timer.sleep(5000)
		m:delete()
		return
	end
	setfenv(func,_G)
	local ok,err = pcall(func) -- Run the code and check for runtime errors
	if not ok then
		m:setContent("Runtime error while loading "..file..": ```"..err.."```")
		timer.sleep(5000)
		m:delete()
		return
	end
	m:setContent("Reloaded "..file)
	timer.sleep(3000)
	m:delete()
end

addCommand("reload",refreshFile)
addCommand("refresh",refreshFile)
