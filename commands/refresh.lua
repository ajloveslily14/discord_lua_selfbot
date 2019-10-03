require("util")


local function isCommand(str) -- Check to make sure the command exists
	local name = ""
	if str:sub(-4) == ".lua" then -- If we added a lua extension keep it, else just add one.
		name = str
	else
		name = str..".lua"
	end
	local f = io.popen("ls commands","r") -- Get a list of files in commands/
	for line in f:lines() do
		if line == name then
			return name
		end
	end
	return false
end


function refreshFile(m,args)
	if args[1] == "" then
		m:setContent("I need a file!")
		timer.sleep(3000)
		m:delete()
		return
	end
	local file = isCommand(args[1]) -- Check if the input is actually a file.
	if not file then
		m:setContent("Can't find that file")
		timer.sleep(5000)
		m:delete()
		return
	end

	local func,err = loadfile("commands/"..file) -- Load the file and check for syntax errors
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
end

addCommand("reload",refreshFile)
addCommand("refresh",refreshFile)