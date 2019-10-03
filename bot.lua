-- Setup variables.
-- With Luvit you have to define them as _G.x to have them actually be in the global scope
_G.fs = require("fs")
_G.timer = require("timer")
_G.discordia = require("discordia")
_G.json = require("json")
_G.client = discordia.Client()
_G.prefix = "./"
discordia.extensions.string()

local botmode = false --  If you want to not have it running on your client set this to true


-- It can be a bit dangerous to have the bot key in the scope in case you want to list it.
function getKey()
	local key = botmode and "botkey.txt" or "key.txt"
	local f = io.open(key)
	key = f:read()
	f:close()
	return key
	
end


-- This is the table that all our commands will be in.
_G.commands = {}

-- If it's running on a client make sure that only the client can execute commands, otherwise let only the owner of the bot execute.
function isAuthorized(author)
	return author == client.user or (botmode and author == client.owner)
end

-- Our main add command function formatting:
-- addCommand(string: command name, function: callback (the actual command code))
function _G.addCommand(name,func)
	
-- A temporary function that parses what kind of command we're giving it.
	local temp = function(m,func) 
		local arglist = string.sub(m.content,#prefix+#name+2):split(",") -- Split up arguments into a table
		func(m,arglist) -- Execute the callback with arguments.
		return true
	end

	commands[name] = function(m) temp(m,func) end -- Insert our command into the global commands table as a function that calls the internal function
	print(string.format("Loaded command %s.",name))
end

-- This function will be the actual function called by the event
function callCommand(m)
	if isAuthorized(m.author) and string.sub(m.content,1,#prefix) == prefix then -- If we're allowed to run a command, and if we typed the prefix
		local ending = string.find(m.content, " ")
		if ending then ending = ending - 1 end
		local command = string.sub(m.content, #prefix+1, ending) -- Grab the word after the prefix
		if commands[command] then -- If the command is valid, execute it.
			commands[command](m) 
		end
	end
end

client:on("messageCreate",callCommand) -- Add the handler

local f = io.popen("ls commands","r") -- Get a list of all files in /commands

for command in f:lines() do
	local f,e = loadfile("commands/"..command) -- Check for syntax errors
	if not f then
		print("Error loading "..command..": "..e)
	else
		setfenv(f,_G)
		local func,err = pcall(f) -- Run the code and check for runtime errors
		if not func then
			print("error! "..err)
		end
	end
end


client:run(getKey(),{afk=true}) -- We use afk=true because it would block mobile push notifications otherwise

client:once("ready", function() -- We"re logged in, good to go!!
	print("Logged in as ".. client.user.username)
end)
