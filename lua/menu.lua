_G.OpSentriesMenu = _G.OpSentriesMenu or {}
OpSentriesMenu._path = ModPath
OpSentriesMenu._data_path = ModPath .. "saved_menu.txt"
OpSentriesMenu._data = {}


function OpSentriesMenu:Save()
	local file = io.open( self._data_path, "w+" )
	if file then
		file:write( json.encode( self._data ) )
		file:close()
	end
end


function OpSentriesMenu:Load()
	local file = io.open( self._data_path, "r" )
	if file then
		self._data = json.decode( file:read("*all") )
		file:close()
	end
	self._data = self._data or {}
end


function OpSentriesMenu:enabled()
    return self._data.enabled_value or false
end


function OpSentriesMenu:shot_cooldown()
    return self._data.cooldown_value or 2.5
end


function OpSentriesMenu:reload_time()
    return self._data.reload_value or 2
end


function OpSentriesMenu:use_ammo()
    return self._data.useammo_value or true
end


Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_OpSentriesMenu", function( loc )
	loc:load_localization_file( OpSentriesMenu._path .. "en.txt")
end)


Hooks:Add( "MenuManagerInitialize", "MenuManagerInitialize_OpSentriesMenu", function( menu_manager )
	MenuCallbackHandler.op_sentries_enabled_callback = function(self, item)
        OpSentriesMenu._data.enabled_value = item:value()
        OpSentriesMenu:Save()
	end

    MenuCallbackHandler.op_sentries_cooldown_callback = function(self, item)
        OpSentriesMenu._data.cooldown_value = item:value()
        OpSentriesMenu:Save()
	end

    MenuCallbackHandler.op_sentries_reload_callback = function(self, item)
        OpSentriesMenu._data.reload_value = item:value()
        OpSentriesMenu:Save()
	end

	MenuCallbackHandler.op_sentries_useammo_callback = function(self, item)
        OpSentriesMenu._data.useammo_value = item:value()
        OpSentriesMenu:Save()
	end

	OpSentriesMenu:Load()
	MenuHelper:LoadFromJsonFile( OpSentriesMenu._path .. "menu.txt", OpSentriesMenu, OpSentriesMenu._data )
end )
