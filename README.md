## UPDATE

I'm not really working on this much if at all anymore. My account got warned for using a selfbot(shocker) so I'm staying away from them.
If there's any issues feel free to open an issue or make a pr and I'll fix them!

# Discord selfbot built with Lua and discordia.

## Installation

* Install Luvit from `https://luvit.io/install.html`

* Install Discordia `lit install SinisterRectus/discordia`

* Get either your user token or bot token

  * For bot token put it in botkey.txt

  * for user token put it in key.txt
  
* Clone this repo `git clone git@github.com:ajloveslily14/discord_lua_selfbot.git`

* Run `./luvit bot.lua`

## Included commands

|Name   |Description    |Alias  |Syntax |
|-------|:-------------:|-------|-------|
|Avatar |Returns a users avatar                               |None  |`avatar <user mention>`               |
|Blocks |Replaces text with it's regional indicator equivalent|None  |`blocks <test>`                       |
|Clean  |Removes messages in bulk, defaults to 100            |Clear |`clean (number)`                      |
|Emote	|Shows emote info						              |None  |`emote <emote>`					    |
|Eval   |Runs lua                                             |None  |`eval <luacode>`                      |
|Ping   |Pong!                                                |None  |`ping`                                |
|Refresh|Reloads a command file                               |Reload|`reload <filename without extension>` |
|Remove |Removes a custom emoji                               |None  |`remove <emoji trigger>`              |
|Set    |Sets a custom emoji                                  |None  |`set <trigger,replacement>`           |
|Shell	|Runs a command in cmd on windows or bash on linux    |None  |`shell <command>`                     |
|Sspoiler|Puts spoiler tags between each character            |sspoil|`sspoiler <text>`                     |




## NOTICE

USING SELFBOTS ON DISCORD IS A VOILATION OF THE DISCORD GUIDLINES AND CAN RESULT IN RESTRICTION TO API OR DELETION OF ACCOUNT.
I TAKE NO RESPONSIABLITY IF YOU DECIDE TO USE THIS BOT.
## Credits:

* Ajloveslily14 - Programming.

* SinisterRectus - Discordia library.

* Pegasus_Epsilon - Help with formatting and optimization.
