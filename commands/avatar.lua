require("util")
addCommand("avatar",function(m,args) -- Command to retrieve the avatar of a user.

	local url = userFromMention(args[1]) -- Get user object from mention
	if url then
		local rep = newEmbed()
		rep:setTitle(m.author.tag)
		rep:addImage()
		rep:setImage(m.author:getAvatarURL().."?size=1024")
		m:delete()
		m:reply({embed = rep})
	else
		m:setContent("Invalid user")
		timer.sleep(3000)
		m:delete()
	end
	
end)