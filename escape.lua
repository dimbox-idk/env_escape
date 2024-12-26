if not getgenv then return "UnSupported", "getgenv = nil" end
if type(getgenv) ~= 'function' then return "UnSupported", "getgenv != function" end
if not getgenv().game then return "UnSupported", "fake getgenv function, no game" end
if not getgenv().Game then return "UnSupported", "fake getgenv function, no Game" end
if not loadstring then return "UnSupported", "loadstring = nil" end
if type(loadstring) ~= 'function' then return "UnSupported", "loadstring != function" end

local cache = {}
cache.game = getgenv().game
cache.Game = getgenv().Game
cache.getgenv = getgenv

getgenv().Game = nil
local BYPASSED_GAME = loadstring([==[
    return loadstring([=[
        return loadstring([[
            local res, lol = pcall(function()
                local S = Game:GetService("ScriptContext")

                local file = "BYPASSED_GAME_TEST.TXT"

                local textToSave = "TEST"
                local filereal = S:SaveScriptProfilingData(textToSave, file)
            end)
            if res then
                print("BYPASSED_GAME")
                return Game
            else
	        return "Failed"
            end
        ]])()
    ]=])()
]==])()
getgenv().Game = Game
getgenv = cache.getgenv
return BYPASSED_GAME
