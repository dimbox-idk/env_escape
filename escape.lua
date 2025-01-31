if not getgenv then return "UnSupported", "getgenv = nil" end
if type(getgenv) ~= 'function' then return "UnSupported", "getgenv != function" end
if not loadstring then return "UnSupported", "loadstring = nil" end
if type(loadstring) ~= 'function' then return "UnSupported", "loadstring != function" end

local cache = {}
cache.getgenv = getgenv

getgenv = nil

getgenv = function() return { game = game } end

getfenv(loadstring).getgenv = getgenv

local BYPASSED_ENV = loadstring([===[
	if getgenv then getgenv = nil end
	local getgenv = function() return { game = game } end
	getfenv(debug.info(0, 'f')).getgenv = getgenv
	getfenv(debug.info(1, 'f')).getgenv = getgenv
	getfenv(debug.info(2, 'f')).getgenv = getgenv
    return loadstring([==[
		if getgenv then getgenv = nil end
	    local getgenv = function() return { game = game } end
        getfenv(debug.info(0, 'f')).getgenv = getgenv
	    getfenv(debug.info(1, 'f')).getgenv = getgenv
	    getfenv(debug.info(2, 'f')).getgenv = getgenv
        return loadstring([=[
			if getgenv then getgenv = nil end
	        local getgenv = function() return { game = game } end
	        getfenv(debug.info(0, 'f')).getgenv = getgenv
	        getfenv(debug.info(1, 'f')).getgenv = getgenv
		    getfenv(debug.info(2, 'f')).getgenv = getgenv
            return loadstring([[
				if getgenv then getgenv = nil end
	            local getgenv = function() return { game = game } end
	            getfenv(debug.info(0, 'f')).getgenv = getgenv
	            getfenv(debug.info(1, 'f')).getgenv = getgenv
	            getfenv(debug.info(2, 'f')).getgenv = getgenv
                local res, why = pcall(function() -- help me to replace that check please
                    local S = Game:GetService("ScriptContext")

                    local file = "BYPASSED_ENV_TEST.EXE"

                    local textToSave = "TEST"
                    local filereal = S:SaveScriptProfilingData(textToSave, file)
                end)
                if res then
                    local env = getfenv(0)
                    env.game = Game
                    return env
                else
	                return why
                end
            ]])()
        ]=])()
    ]==])()
]===])()
getgenv = cache.getgenv
getfenv(loadstring).getgenv = cache.getgenv
getfenv(debug.info(0, 'f')).getgenv = cache.getgenv
getfenv(debug.info(1, 'f')).getgenv = cache.getgenv
return BYPASSED_ENV
