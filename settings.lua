---------------------------------------------------------------------------------------
--                     Author: Xavier CHOPIN <www.github.com/xchopin>                --
--                                 License: Apache 2.0                               --
---------------------------------------------------------------------------------------

local settings = {}

settings.db.host = "127.0.0.1"
settings.db.name = "gta5_gamemode_essential"
settings.db.user = "root"
settings.db.password = "root"

settings.drawablePrice = 15
settings.texturePrice  = 5

local parts = {
    ["Face"] = 0,
    ["Hair"] = 2,
    ["Hands"] = 3,
    ["Pants"] = 4,
    ["Shoes"] = 6,
    ["Shirts"] = 8,
    ["Jackets"] = 11,
    ["Hats"] = "p0",
    ["Glasses"] = "p1",
    ["Ears"] = "p2",
    ["Watches"] = "p6"
}


return settings
