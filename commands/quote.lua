require("util")




local function parseReply(msg,comment)
	local member
	if msg.guild then
		member = msg.guild:getMember(msg.author.id)
	else
		member = nil
	end
	local rep = newEmbed() -- Build embed reply
	rep:addAuthor()
	rep:setAuthor(msg.author.tag)
	rep:setAuthorImage(msg.author:getAvatarURL())
	rep:setColor(member and member:getColor() or Color(math.random(255),math.random(255),math.random(255)))
	rep:setDescription(msg.content)
	if msg.attachment and isImg(msg.attachment['filename']) then -- If the message was an image, add it to the embed.
		rep:addImage()
		rep:setImage(msg.attachment['url'])
	end
	rep:addFooter()
	if msg.editedTimestamp then -- If the message was edited, show what time it was edited, else just show sent time.
		rep:setFooter("Edited ")
		rep:setTimestamp(msg.editedTimestamp)
	else
		rep:setFooter("Sent ")
		rep:setTimestamp(msg.timestamp)
	end

	if comment then -- If we add a comment to the post, append it.
		rep:setContent(comment)
	end
	return rep
end


addCommand("quote",function(m,args) -- Command to quote posts

	if (#args >=1) then -- If we have arguments

		local msg = args[1]
		if tonumber(msg) then
			msg = getMessage(m.channel,msg) -- Make sure that it's an actual message ID posted
			if msg then
				local comment = args[2]
				for i = 3,#args do
					comment = comment..","..args[i]
				end
				local rep = parseReply(msg,comment)
				m:setContent(rep.content) -- Set the invoking message to the quote comment.
				m:setEmbed(rep) -- Set the invoking messages embed to the quote.
			else
				m:setContent("Couldn't find that message")
				timer.sleep(3000)
				m:delete()
			end
		else
			m:setContent("Couldn't find that message")
			timer.sleep(3000)
			m:delete()
		end
		
	end
	
end)