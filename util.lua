-- Helper function to get a user object from a mention.
function userFromMention(mention)
	local id = string.match(mention,"[^<@>!]+")
	return client:getUser(id)
end

-- Because getMessage does not work from a client, this does it instead.
function getMessage(chan,id)
	local msg = chan:getMessagesAround(id,2)
	local out
	for t in msg:iter() do
		if t.id == id then
			out = t
		end
	end
	return out
end

function emoteFromString(str)
	local _,id = string.match(str,":(.*):(.*[^>])")
	return id
end

-- Helper function to see if a file attachment is an image.
function isImg(str)
	str = string.lower(str)
	if str:find(".jpg") then return true end
	if str:find(".jpeg") then return true end
	if str:find(".png") then return true end
	if str:find(".gif") then return true end
	return false
end

-- Helper functions to create embeds.

embed = {
	addAuthor = function(self)
		local a = {}
		self.author = a
	end,

	setAuthor = function(self,name)
		self.author.name = name
	end,
	
	setAuthorImage = function(self,image)
		self.author.icon_url = image
	end,

	setAuthorUrl = function(self,link)
		self.author.url = link
	end,

	setColor = function(self,color)
		self.color = color
	end,

	addImage = function(self)
		local i = {}
		self.image = {}
	end,

	setImage = function(self,str)
		self.image.url = str
	end,

	addFooter = function(self)
		local f = {}
		self.footer = f
	end,

	setFooter = function(self,str)
		self.footer.text = str
	end,

	setFooterIcon = function(self,url)
		self.footer.icon_url = url
	end,

	setTitle = function(self,text)
		self.title = text
	end,

	setTimestamp = function(self,time)
		self.timestamp = time
	end,

	setDescription = function(self,desc)
		self.description = desc
	end,

	setContent = function(self,text)
		self.content = text
	end

}


function newEmbed()
	return setmetatable( {}, {__index = embed} )
end
