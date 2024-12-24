if not getgenv then return "UnSupported", "getgenv = nil" end
if type(getgenv) ~= 'function' then return "UnSupported", "getgenv != function" end
if not getgenv().game then return "UnSupported", "fake getgenv function, no game" end
if not getgenv().Game then return "UnSupported", "fake getgenv function, no Game" end
if not loadstring then return "UnSupported", "loadstring = nil" end
if type(loadstring) ~= 'function' then return "UnSupported", "loadstring != function" end
if not getexecutorname then return "UnSupported", "getexecutorname = nil" end
if type(getexecutorname) ~= 'function' then return "UnSupported", "getexecutorname != function" end
local clonefunction = clonefunction or getgenv().clonefunction or nil
if clonefunction then
    if print ~= clonefunction(print) then
        clonefunction = function(func) return func end
    end
else
    clonefunction = function(func) return func end
end
local cloneref = cloneref or getgenv().cloneref or nil
if cloneref and getexecutorname() ~= 'Xeno' then
    if getgenv().game ~= cloneref(getgenv().game) then
        cloneref = function(ref) return ref end
    end
else
    cloneref = function(ref) return ref end
end
local cache = {}
cache.game = getgenv().game
cache.Game = getgenv().Game
local test = function(func, type_f, method, args)
    if args == nil then args = {} end
	if type(args) ~= "table" then return error("args need to be table!") end
	if type(method) ~= "string" then return error("method need to be string!") end
	if type(func) ~= "string" then return error("func need to be string of function name in getgenv!") end
	if type(type_f) ~= "string" then return error("type need to be . or :!") end
    local func_2 = getgenv()[func]
    if type(func_2) == 'table' then
        cache[func] = cloneref(func_2)
    elseif type(func_2) == 'function' then
        cache[func] = clonefunction(func_2)
    else
        cache[func] = func_2
    end
	func_2 = nil
	if type_f == "." then
        print(func .. "." .. method .. [[(table.unpack(args))]])
    	result, _ = pcall(function()
		    loadstring(func .. "." .. method .. [[(table.unpack(args))]])()
	    end)
	else
        print(func .. ":" .. method .. [[(table.unpack(args))]])
        result, _ = pcall(function()
            loadstring(func .. ":" .. method .. [[(table.unpack(args))]])()
        end)
	end
	getgenv()[func] = func_2
	if result == false then return "Failed" end
	local bypassed = loadstring(
		[[
			return getfenv()[func]
		]]
	)()
	return bypassed
end
result = test("Game", ":", [[GetService("ScriptContext"):SaveScriptProfilingData]], {"test.exe", ":troll:"})
if result ~= "Failed" then return result end
result = test("game", ":", [[GetService("ScriptContext"):SaveScriptProfilingData]], {"test.exe", ":troll:"})
if result ~= "Failed" then return result end
return "Failed"
