require("util")

addCommand("ping",function(m) -- Simple ping command

	m:setContent("Pong!")
	timer.sleep(3000)
	m:delete()
	
end)
