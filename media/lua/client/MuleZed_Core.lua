

----------------------------------------------------------------
-----  ▄▄▄   ▄    ▄   ▄  ▄▄▄▄▄   ▄▄▄   ▄   ▄   ▄▄▄    ▄▄▄  -----
----- █   ▀  █    █▄▄▄█    █    █   ▀  █▄▄▄█  ▀  ▄█  █ ▄▄▀ -----
----- █  ▀█  █      █      █    █   ▄  █   █  ▄   █  █   █ -----
-----  ▀▀▀▀  ▀▀▀▀   ▀      ▀     ▀▀▀   ▀   ▀   ▀▀▀   ▀   ▀ -----
----------------------------------------------------------------
--                                                            --
--   Project Zomboid Modding Commissions                      --
--   https://steamcommunity.com/id/glytch3r/myworkshopfiles   --
--                                                            --
--   ▫ Discord  ꞉   glytch3r                                  --
--   ▫ Support  ꞉   https://ko-fi.com/glytch3r                --
--   ▫ Youtube  ꞉   https://www.youtube.com/@glytch3r         --
--   ▫ Github   ꞉   https://github.com/Glytch3r               --
--                                                            --
----------------------------------------------------------------
----- ▄   ▄   ▄▄▄   ▄   ▄   ▄▄▄     ▄      ▄   ▄▄▄▄  ▄▄▄▄  -----
----- █   █  █   ▀  █   █  ▀   █    █      █      █  █▄  █ -----
----- ▄▀▀ █  █▀  ▄  █▀▀▀█  ▄   █    █    █▀▀▀█    █  ▄   █ -----
-----  ▀▀▀    ▀▀▀   ▀   ▀   ▀▀▀   ▀▀▀▀▀  ▀   ▀    ▀   ▀▀▀  -----
----------------------------------------------------------------
MuleZed = MuleZed or {}

function MuleZed.isMasterFar(zed)
    local pl = getPlayer()
    if not pl or not zed then return false end
    if zed:getZ() ~= pl:getZ() then return true end
    return zed:DistToSquared(pl:getX(), pl:getY()) > 9
end

function MuleZed.followPlayerStep(zed, pl)
    if not zed or not MuleZed.isMuleZed(zed) then return false end
    if not pl then return false end
    local zx, zy, zz = zed:getX(), zed:getY(), zed:getZ()
    local px, py, pz = pl:getX(), pl:getY(), pl:getZ()
    if zz ~= pz then return false end
    local distSq = zed:DistToSquared(px, py)
    if distSq <= 9 then
        zed:setVariable("bPathfind", false)
        zed:setVariable("bMoving", false)
        return true
    end
    local dx = px - zx
    local dy = py - zy
    local mag = math.sqrt(dx * dx + dy * dy)
    if mag == 0 then return false end
    local stepX = zx + (dx / mag)
    local stepY = zy + (dy / mag)
    local sq = getCell():getGridSquare(stepX, stepY, zz)
    if not sq then return false end
    local success = zed:pathToLocationF(stepX, stepY, zz)
    if success then
        zed:setVariable("bPathfind", true)
        zed:setVariable("bMoving", true)
    else
        zed:setVariable("bPathfind", false)
        zed:setVariable("bMoving", false)
    end
    return success
end

function MuleZed.followMaster(zed)
    local pl = getPlayer()
    if not pl then return end
    MuleZed.followPlayerStep(zed, pl)
end


function MuleZed.coreFunc(zed)
    if not zed or not MuleZed.isMuleZed(zed) then return end
    local pl = getPlayer()
    if not pl then return end
    if not zed:getVariableBoolean("isMuleZed") then
        zed:setVariable("isMuleZed", true)
    end
    if not zed:isUseless() then
        zed:setUseless(true)
    end
    local sq = zed:getSquare()
    if not sq then return end
    MuleZed.stepContForZed(zed)
    MuleZed.doBehavior(zed)

    if zed:isTargetVisible() then
        zed:getModData()['AutoFollow'] = nil
    end

end

Events.OnZombieUpdate.Remove(MuleZed.coreFunc)
Events.OnZombieUpdate.Add(MuleZed.coreFunc)

-----------------------            ---------------------------

---------------------------


-----------------------            ---------------------------
