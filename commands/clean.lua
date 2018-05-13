require("util")

function cleanUp(m,args) -- Command to remove messages in bulk.
	local ch = m.channel
	if args[1] == "" then -- If no arguments delete as much as we can.
		local del = ch:getMessagesBefore(m,100) -- Get cache of messages.
		local todie = {}
		for msg in del:iter() do 
			if msg.author == client.user then
				table.insert(todie,msg)
			end
		end
		m:setContent("removing "..#todie.." messages...")
		for k,v in pairs(todie) do
			v:delete()
		end
		m:delete()
	elseif tonumber(args[1]) then -- If arguments delete that amount.
		local del = ch:getMessagesBefore(m,tonumber(args[1])) -- Get cache of messages.
		local todie = {}
		for msg in del:iter() do 
			if msg.author == client.user then
				table.insert(todie,msg)
			end
		end
		m:setContent("removing "..#todie.." (out of "..#del..") messages...")
		for k,v in pairs(todie) do
			v:delete()
		end
		m:delete()
	else
		m:setContent("I need a number not whatever you gave me")
		timer.sleep(3000)
		m:delete()
	end
end

addCommand("clean",true,cleanUp)
addCommand("clear",true,cleanUp)