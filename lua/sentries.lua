function _G.stringify(data)
    if data == nil then
        return "nil"
    end

    return tostring(data)
end


function _G.listToString(data)
    local s = "{"
    for k, v in pairs(data) do
        local toAppend = stringify(v)
        
        if type(v) == "table" then
            toAppend = listToString(v)
        end

        s = s .. stringify(k) .. ": " .. toAppend .. ",  "
    end

    return s .. "}"
end


-- ToDo:
--   Fire rate etc. not determined by host
--   Custom laser color for sentry
--   

Hooks:PostHook(SentryGunWeapon, "setup", "opsentry_init",
    function (self, unit)
        if OpSentriesMenu:enabled() then
            log("Sentry init")
            self._auto_reload = true
            self._shot_cooldown = OpSentriesMenu:shot_cooldown()
        end
    end
)


Hooks:PostHook(SentryGunWeapon, "_set_fire_mode", "opsentry_change_firerate",
    function (self, unit)
        if OpSentriesMenu:enabled() then
            self._fire_rate_reduction = self._shot_cooldown
        end
    end
)


Hooks:PostHook(SentryGunWeapon, "fire", "opsentry_no_ammo_usage",
    function (self, blanks, expend_ammo, shoot_player, target_unit)
        if expend_ammo then
            if not OpSentriesMenu:use_ammo() then
                self:change_ammo(1)
            end
        end
    end
)
