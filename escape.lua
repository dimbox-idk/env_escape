if not getgenv then return "UnSupported", "getgenv = nil" end
if not getgenv().game then return "UnSupported", "fake getgenv function" end
if not loadstring then return "UnSupported", "loadstring = nil" end
if clonefunction then
    if print ~= clonefunction(print) then
        local clonefunction = function(func) return func end
    end
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
    	result, _ = pcall(function()
		    loadstring(
	    	    [[
		    	    getfenv()]] .. func .. "." .. method .. [[(table.unpack(args))
		        ]]
	        )()
	    end)
	else
        result, _ = pcall(function()
            loadstring(
	    	    [[
		        	getfenv()]] .. func .. ":" .. method .. [[(table.unpack(args))
		        ]]
            )()
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
result = test("game", ":", [[GetService("ScriptContext"):SaveScriptProfilingData("test.exe" .. ":troll:")]], {})
if result ~= "Failed" then return result end
result = test("Game", ":", [[GetService("ScriptContext"):SaveScriptProfilingData("test.exe" .. ":troll:")]], {})
if result ~= "Failed" then return result end
return "Failed"
