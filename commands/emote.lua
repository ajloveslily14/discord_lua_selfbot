require("util")

addCommand("emote",function(m,args)

	local emote = emoteFromString(args[1])
	emote = client:getEmoji(emote)
	if emote then
		local rep = newEmbed()
		local desc = string.format("%s :%s:\nId: %s\nGuild Name: %s",emote.mentionString,emote.name,emote.id,emote.guild.name)
		rep:setDescription(desc)
		rep:addImage()
		rep:setImage(emote.url)
		rep:setColor(emote.guild:getMember(client.user):getColor())
		m:delete()
		m:reply({embed = rep})
	else
		m:setContent("Couldn't find that emote?")
		timer.sleep(3000)
		m:delete()
	end
end)