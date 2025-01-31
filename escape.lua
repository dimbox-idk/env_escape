if not getgenv then
    return "UnSupported", "getgenv = nil";
end

if (type(getgenv) ~= "function") then
    return "UnSupported", "getgenv != function";
end

if not loadstring then
    return "UnSupported", "loadstring = nil";
end

if (type(loadstring) ~= "function") then
    return "UnSupported", "loadstring != function";
end

local cache = {};
cache.getgenv = getgenv;

local function s(i, v)
    getfenv(2)[i] = v;
    getfenv(1)[i] = v;
    getfenv(0)[i] = v;
    getfenv()[i] = v;
    getfenv(debug.info(0, "f"))[i] = v;
    getfenv(debug.info(1, "f"))[i] = v;
    getfenv(debug.info(2, "f"))[i] = v;
end

getgenv = nil;
local FAKE_ENV = {};

function getgenv()
    return FAKE_ENV;
end

FAKE_ENV = { game = game, loadstring = loadstring, getgenv = getgenv };

s("getgenv", getgenv);

setmetatable(getgenv(), {
    __newindex = function(arg1, arg2, arg3)
        rawset(arg1, arg2, arg3);
        s(arg2, arg3);
    end;
});

local BYPASSED_ENV = loadstring([===[
    getgenv = nil
    local FAKE_ENV = {}
    getgenv = function() return FAKE_ENV end
    FAKE_ENV = { game = game, loadstring = loadstring, getgenv = getgenv }
    
    local function s(i, v)
        getfenv(2)[i] = v
        getfenv(1)[i] = v
        getfenv(0)[i] = v
        getfenv()[i] = v
        getfenv(debug.info(0, 'f'))[i] = v
        getfenv(debug.info(1, 'f'))[i] = v
        getfenv(debug.info(2, 'f'))[i] = v
    end

    s("getgenv", getgenv)

    setmetatable(getgenv(), {
        __newindex = function(arg1, arg2, arg3)
            rawset(arg1, arg2, arg3)
            s(arg2, arg3)
        end;
    })

    for i, v in pairs(getgenv()) do
        s(tostring(i), v)
    end

    return loadstring([===[
        getgenv = nil
        local FAKE_ENV = {}
        getgenv = function() return FAKE_ENV end
        FAKE_ENV = { game = game, loadstring = loadstring, getgenv = getgenv }
        
        local function s(i, v)
            getfenv(2)[i] = v
            getfenv(1)[i] = v
            getfenv(0)[i] = v
            getfenv()[i] = v
            getfenv(debug.info(0, 'f'))[i] = v
            getfenv(debug.info(1, 'f'))[i] = v
            getfenv(debug.info(2, 'f'))[i] = v
        end

        s("getgenv", getgenv)

        setmetatable(getgenv(), {
            __newindex = function(arg1, arg2, arg3)
                rawset(arg1, arg2, arg3)
                s(arg2, arg3)
            end;
        })

        for i, v in pairs(getgenv()) do
            s(tostring(i), v)
        end

        return loadstring([=[
            if getgenv then getgenv().getgenv = nil end
            getgenv = nil
            local FAKE_ENV = {}
            getgenv = function() return FAKE_ENV end
            FAKE_ENV = { game = game, loadstring = loadstring, getgenv = getgenv }

            local function s(i, v)
                getfenv(2)[i] = v
                getfenv(1)[i] = v
                getfenv(0)[i] = v
                getfenv()[i] = v
                getfenv(debug.info(0, 'f'))[i] = v
                getfenv(debug.info(1, 'f'))[i] = v
                getfenv(debug.info(2, 'f'))[i] = v
            end

            s("getgenv", getgenv)

            setmetatable(getgenv(), {
                __newindex = function(arg1, arg2, arg3)
                    rawset(arg1, arg2, arg3)
                    s(arg2, arg3)
                end;
            })

            for i, v in pairs(getgenv()) do
                s(tostring(i), v)
            end

            return loadstring([[
                getgenv = nil
                local FAKE_ENV = {}
                getgenv = function() return FAKE_ENV end
                FAKE_ENV = { game = game, loadstring = loadstring, getgenv = getgenv }

                local function s(i, v)
                    getfenv(2)[i] = v
                    getfenv(1)[i] = v
                    getfenv(0)[i] = v
                    getfenv()[i] = v
                    getfenv(debug.info(0, 'f'))[i] = v
                    getfenv(debug.info(1, 'f'))[i] = v
                    getfenv(debug.info(2, 'f'))[i] = v
                end

                s("getgenv", getgenv)

                setmetatable(getgenv(), {
                    __newindex = function(arg1, arg2, arg3)
                        rawset(arg1, arg2, arg3)
                        s(arg2, arg3)
                    end;
                })

                for i, v in pairs(getgenv()) do
                    s(tostring(i), v)
                end

                local res, why = pcall(function()
                    local S = Game:GetService("ScriptContext")
                    local file = "BYPASSED_ENV_TEST.EXE"
                    local textToSave = "TEST"
                    local filereal = S:SaveScriptProfilingData(textToSave, file)
                    return true, true
                end)

                if res then
                    local env = getfenv(0)
                    env.game = Game
                    env.getgenv = nil
                    env.loadstring = nil
                    return env
                else
                    return why
                end
            ]])()
        ]=])()
    ]==])()
]===])();

getgenv = cache.getgenv;
s("getgenv", cache.getgenv)

return BYPASSED_ENV;
