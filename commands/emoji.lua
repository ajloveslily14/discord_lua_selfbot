require("util")


replace = {}

-- System to add custom "emojis" or macros
-- Works like <prefix>add foo,bar
-- when :foo: is posted, it gets edited to be bar.

function refreshHandle() -- Add/refresh handle testing when a message with an emoji is posted.
	return client:on("messageCreate",function(message)
		local _,count = string.gsub(message.content,":",":") 
		if count >= 2 and message.author == client.user then -- If there are at least two colons in the message
			local rep = {}
			for i in string.gmatch(message.content,"(:[%a%d_]+:)") do -- Separate emojis(s) from surrounding colons.
				i = string.gsub(i,":","")
				table.insert(rep,i)
			end
			local repstring = message.content
			for _,str in next,rep do
				if replace[str] then
					repstring = string.gsub(repstring,":"..str..":",replace[str]) -- Replace emojis
				end
			end
			if repstring ~= message.content then
				message:setContent(repstring) -- Edit message with replaced emojis.
			end
		end
	end)
end
local emotes
emoteHandle = nil
function updateToJSON()
	local t = io.open("emoji.json","r")
	if t ~= nil then return t:close() end
	local f = io.open("emoji.json","w")
	f:write(json.encode(replace))
	f:close()
end
function updateEmotes() -- Refresh replace table.
	local t = io.open("emoji.json","r")
	if not t then
		local f = fs.readFileSync("customemotes.txt","r")
		emotes = f
		replace = {}
		for k,v in pairs(emotes:split("\002")) do -- Separate replacements.
			local temp = {}
			for emote in string.gmatch(v,"[^\001]+") do -- Separate string and replacement.
				table.insert(temp,emote)
			end
			temp[1] = string.gsub(temp[1],"\\n","\n") -- Replace escaped return line with actual return line.
			temp[2] = string.gsub(temp[2],"\\n","\n")
			replace[temp[1]] = temp[2]
		end
		emoteHandle = refreshHandle() -- Refresh handle to use new replacement table.
		updateToJSON()
		os.remove("customemotes.txt")
	else
		t:close()
		local f = fs.readFileSync("emoji.json","r")
		replace = json.decode(f)
		emoteHandle = refreshHandle() 
	end

end
updateEmotes() -- Initial load of emojis.

function addEmote(trigger,replacement) -- Adds an emoji to the storage file, format `trigger\001replacement\002trigger\001replacement`
	replace[trigger] = replacement
	fs.writeFileSync("emoji.json",json.encode(replace)) -- Write to storage file.
	client:removeListener("messageCreate",emoteHandle) -- Refresh handle.
	updateEmotes()
end

function delEmote(m,trigger) -- Remove emoji from storage file.
	local rem = replace[trigger]
	if rem then
		replace[trigger] = nil
		fs.writeFileSync("emoji.json",json.encode(replace)) 
		client:removeListener("messageCreate",emoteHandle) -- Refresh handle.
		updateEmotes()
		m:setContent("Removed emote '"..trigger.."'")
		timer.sleep(3000)
		m:delete()
	else
		m:setContent("Couldn't find the emote '"..trigger.."'")
		timer.sleep(3000)
		m:delete()
	end
end


addCommand("set",function(m,args) -- Command to add custom emoji.

	if #args < 2 then
		m:setContent("I need 2 args man")
		timer.sleep(3000)
		m:delete()
	else
		local emote = args[2]
		for i = 3,#args do 
			emote = emote..","..args[i] -- Concatenate all arguments.
		end

		addEmote(args[1],emote)
		m:setContent("Added emote :"..args[1]..": -> "..emote)
		timer.sleep(3000)
		m:delete()
	end

end)

addCommand("remove",function(m,args) -- Command to remove custom emoji.
	
	if args[1] ~= "" then
		delEmote(m,args[1])
	else
		m:setContent("I need arguments")
		timer.sleep(3000)
		m:delete()
	end

end)


addCommand("list",function(m)
	local ret = "```"
	for trigger,replacement in pairs(replace) do
		ret = ret.."\n"..trigger.." -> "..replacement:sub(1,30).."..."
	end
	m:setContent(ret.."```")
end)
