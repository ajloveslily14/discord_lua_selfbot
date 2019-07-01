require("util")
addCommand("avatar",function(m,args) -- Command to retrieve the avatar of a user.

	local url = userFromMention(args[1]) -- Get user object from mention
	if url then
		local rep = newEmbed()
		rep:setTitle(url.tag)
		rep:addImage()
		rep:setImage(url:getAvatarURL().."?size=1024")
		rep:setColor(math.random(0xFFFFFF))
		m:delete()
		m:reply({embed = rep})
	else
		m:setContent("Invalid user")
		timer.sleep(3000)
		m:delete()
	end
	
end)