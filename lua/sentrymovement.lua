
log("#### movement hook")
Hooks:PostHook(SentryGunMovement, "post_init", "opsentry_sentrymovement_setup",
    function (self)
        self._tweak.AUTO_RELOAD_DURATION = OpSentriesMenu:reload_time()
        self._tweak.CLIP_SIZE = 20  -- Default clip size. Gets overwritten anyways
    end
)


Hooks:PreHook(SentryGunMovement, "complete_rearming", "opsentry_sentrymovement_rearm_color",
    function (self)
        if Utils:IsInCustody() then
            return
        end

        local unit = self._unit
        local contour = unit:contour()

        -- Remove all previously added contours (see sentryguncontour.lua and contourext.lua)
        contour:remove("deployable_active")
        contour:remove("deployable_interactable")
        -- Remove disabled contour
        contour:remove("deployable_disabled")
        -- Add correct contour
        if self._unit._use_armor_piercing then
            contour:add("deployable_interactable")
        else
            contour:add("deployable_active")
        end
    end
)


Hooks:PostHook(SentryGunMovement, "complete_rearming", "opsentry_sentrymovement_rearm",
    function (self)
        -- if Utils:IsInCustody() then
        --     self._unit._auto_reload = false
        --     return
        -- end

        if Network:is_server() then
            self._unit:weapon():set_ammo(self._unit:weapon():ammo_max())
        end
    end
)
