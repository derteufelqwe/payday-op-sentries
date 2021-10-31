if managers.player:player_unit() == self._setup.user_unit then
    self.set_ammo(self, 1.0)
end


-- Weapon fire rate
NewRaycastWeaponBase.fire_rate_multiplier = function(self) return 10 end


if managers.player:player_unit() == self._setup.user_unit and self:get_ammo_total() == 0 then
    self.set_ammo(self, 1.0)
end


-- Warp to bullet
if not _lastBullet then _lastBullet = nil end
if _lastBullet then managers.player:warp_to(_lastBullet, managers.player:player_unit():rotation()) end
if not _bulletCollision then _bulletCollision = InstantBulletBase.on_collision end
function InstantBulletBase:on_collision( col_ray, weapon_unit, user_unit, damage, blank )
    if user_unit == managers.player:player_unit() then
        _lastBullet = col_ray.hit_position
    end
    return _bulletCollision(self, col_ray, weapon_unit, user_unit, damage, blank)
end