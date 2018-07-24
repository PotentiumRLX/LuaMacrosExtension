local macros = {																																																									} local secret, ez = "see, sah bess k yah-yay vo oon rah tuwn me ron, dough, tay. tang oh kay bye lar cone tee go hoy. dee why. vee... kay too mee rah dah yah estaba yah mon dough may... mwe straw may el camino kay yo voy. deh, spa, see tow. key row rez pier are to kway yo, deh spa see tow... day ha kay tay dee gah coas ass al we dough. pair uh kay tee ack wear dess see no estas cone me go. deh, spa, see tow", {say = lmc_say, start = lmc_spawn, ["type"] = function(str) lmc_send_keys(str:lower()) end;} macros = {
	
	uniqueKeyboardName1 = {
		
		["81, 87, 69"] = function()
			print("This is a test to show that LuaMacros works with key combinations.");
		end;
		
		["112"] = function()
			ez.start("notepad");
		end;
		
		["113"] = function()
			ez.say(secret);
		end;
		
		["114"] = function()
			ez.type("{CAPSLOCK}");
		end;
		
	};
	
	uniqueKeyboardName2 = {
	};
	
};

--[[
	
	When using ez.type, use the presets given here:
		https://github.com/me2d13/luamacros/wiki/List-of-Keys
	
	Created for use with LuaMacros (this was NOT created for AutoHotKey integration), download LuaMacros at this link:
		https://github.com/me2d13/luamacros
	
	Please watch the tutorial if you need to:
		https://youtu.be/LsHhLZXrQsI
	
	Features:
	
		- Access to simple commands as well as being fully-customizable and open source.
		- Fixes the issue of executing a command multiple times by holding the button while still running scripts on KeyDown.
		- Support for multiple keyboards, capacity is untested.
		- Support for multi-key combinations.
		- If you don't know the keycode of a button you're pressing, it will be printed in the output.
	
	This project was inspired by the King of Macros (Taran Van Hemert) after I watched his LTT video on LuaMacros:
		https://youtu.be/Arn8ExQ2Gjg
	And then, I watched the follow-ups on his personal channel:
		https://youtu.be/y3e_ri-vOIo
		https://youtu.be/Hn18vv--sFY
	In the follow-up videos, he states that he had been encountering issues with LuaMacros as well as the platform he switched to.  I
	have been learning Lua since the summer of 2016, so I figured that I could find out what the issues were.  A couple of hours later,
	I've prepared an in-depth template for anybody to use, complete with user-friendly scripts for the most commonly-used functions.
	
	It is suggested that you do not edit past this line without intensive knowledge of Lua.
	
--]]

clear();
for keyboard, m in pairs(macros) do
	local functions = {};
	local pressed = {};
	for keys, funct in pairs(m) do
		keys = keys:gsub("%s", "");
		local triggers = {};
		while keys:find(",") do
			table.insert(triggers, keys:sub(1, keys:find(",") - 1));
			keys = keys:sub(keys:find(",") + 1);
		end;
		if functions["ID:" .. keys] then
			table.insert(functions["ID:" .. keys], {a = triggers, b = funct});
		else
			functions["ID:" .. keys] = {{a = triggers, b = funct}};
		end;
	end;
	lmc_assign_keyboard(keyboard);
	lmc_set_handler(keyboard, function(pressByte, pressDirection)
		if pressDirection == 0 then
			if pressed["ID:" .. tostring(pressByte)] then
				pressed["ID:" .. tostring(pressByte)] = false;
			end;
		else
			if not pressed["ID:" .. tostring(pressByte)] then
				pressed["ID:" .. tostring(pressByte)] = true;
				print("You pressed: " .. tostring(pressByte) .. ".");
				if functions["ID:" .. tostring(pressByte)] then
					for _, v in pairs(functions["ID:" .. tostring(pressByte)]) do
						local f = true;
						for _, trigger in pairs(v.a) do
							if not pressed["ID:" .. trigger] then
								f = false;
							end;
						end;
						if f then
							v.b();
						end;
					end;
				end;
			end;
		end;
	end);
end;