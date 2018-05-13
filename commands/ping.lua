require("util")

addCommand("ping",false,function(m) -- Simple ping command

	m:setContent("Pong!")
	timer.sleep(3000)
	m:delete()
	
end)