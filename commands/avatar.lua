require("util")
addCommand("avatar",true,function(m,args) -- Command to retrieve the avatar of a user.

	local url = userFromMention(args[1]) -- Get user object from mention
	if url then
		m:setContent(url:getAvatarURL().."?size=1024")
	else
		m:setContent("Invalid user")
		timer.sleep(3000)
		m:delete()
	end
	
end)