require("util")

addCommand("quote",function(m,args) -- Command to quote posts

	if (#args >=1) then -- If we have arguments

		local msg = args[1]
		local comment = args[2]
		if tonumber(msg) then 

			msg = getMessage(m.channel,msg) -- Make sure that it's an actual message ID posted
			if msg then
				local member = msg.guild:getMember(msg.author.id)
				local rep = newEmbed() -- Build embed reply
				rep:addAuthor()
				rep:setAuthor(msg.author.fullname)
				rep:setAuthorImage(msg.author:getAvatarURL())
				rep:setColor(member:getColor())
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

				if args[2] then -- If we add a comment to the post, append it.
					rep:setContent(args[2])
				end
				m:reply({embed = rep,content = rep.content}) -- Post the embedded reply.
				m:delete() -- Delete the invoking message.
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