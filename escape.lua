if not getgenv then return "UnSupported", "getgenv = nil" end
if type(getgenv) ~= 'function' then return "UnSupported", "getgenv != function" end
if not loadstring then return "UnSupported", "loadstring = nil" end
if type(loadstring) ~= 'function' then return "UnSupported", "loadstring != function" end

local cache = {}
cache.getgenv = getgenv

getgenv = nil

getgenv = function() return {} end

local BYPASSED_GAME = loadstring([===[
	if getgenv then getgenv = nil end
	getgenv = function() return {} end
    return loadstring([==[
		if getgenv then getgenv = nil end
	    getgenv = function() return {} end
        return loadstring([=[
			if getgenv then getgenv = nil end
	        getgenv = function() return {} end
            return loadstring([[
				if getgenv then getgenv = nil end
	            getgenv = function() return {} end
                local res, why = pcall(function() -- help me to replace that check please
                    local S = Game:GetService("ScriptContext")

                    local file = "BYPASSED_ENV_TEST.EXE"

                    local textToSave = "TEST"
                    local filereal = S:SaveScriptProfilingData(textToSave, file)
                end)
                if res then
                    return getfenv(0)
                else
	                return why
                end
            ]])()
        ]=])()
    ]==])()
]===])()
getgenv = cache.getgenv
return BYPASSED_ENV
