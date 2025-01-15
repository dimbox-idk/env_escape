if not getgenv then return "UnSupported", "getgenv = nil" end
if type(getgenv) ~= 'function' then return "UnSupported", "getgenv != function" end
if not loadstring then return "UnSupported", "loadstring = nil" end
if type(loadstring) ~= 'function' then return "UnSupported", "loadstring != function" end

local cache = {}
cache.game = getgenv().game
cache.Game = getgenv().Game
cache.getgenv = getgenv

getgenv().Game = nil
Game = nil
getfenv().Game = nil
getfenv(0).Game = nil
getfenv(1).Game = nil

getgenv = function() return { game = game } end

local BYPASSED_GAME = loadstring([===[
	if getgenv then getgenv().Game = nil end
	getgenv = function() return { game = game } end
    return loadstring([==[
		if getgenv then getgenv().Game = nil end
	    getgenv = function() return { game = game } end
        return loadstring([=[
			if getgenv then getgenv().Game = nil end
	        getgenv = function() return { game = game } end
            return loadstring([[
				if getgenv then getgenv().Game = nil end
	            getgenv = function() return { game = game } end
                local res, why = pcall(function()
                    local S = Game:GetService("ScriptContext")

                    local file = "BYPASSED_GAME_TEST.TXT"

                    local textToSave = "TEST"
                    local filereal = S:SaveScriptProfilingData(textToSave, file)
                end)
                if res then
                    return Game
                else
	                return why
                end
            ]])()
        ]=])()
    ]==])()
]===])()
getgenv = cache.getgenv
getgenv().Game = cache.Game
Game = cache.Game
getfenv().Game = cache.Game
getfenv(0).Game = cache.Game
getfenv(1).Game = cache.Game
return BYPASSED_GAME
