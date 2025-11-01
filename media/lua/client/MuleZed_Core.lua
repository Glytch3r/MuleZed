

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
-----------------------        core*       ---------------------------
MuleZed.zedContainers = MuleZed.zedContainers or {}

function MuleZed.attachToZed(zed)
    if not zed then return end
    local sq = zed:getSquare()
    if not sq then return end
    local obj, cont = MuleZed.setMuleObj(sq)
    MuleZed.zedContainers[zed] = {obj = obj, cont = cont}
end

function MuleZed.stepContForZed(zed)
    if not zed or zed:isDead() then
        if MuleZed.zedContainers[zed] then
            MuleZed.doSledge(MuleZed.zedContainers[zed].obj)
            MuleZed.zedContainers[zed] = nil
        end
        return
    end

    local destSq = zed:getSquare()
    if not destSq then return end

    local data = MuleZed.zedContainers[zed]
    if not data then return end

    local oldObj = data.obj
    local oldCont = data.cont

    local oldSq = oldObj:getSquare()
    if oldSq ~= destSq then
        oldSq:RemoveTileObject(oldObj)
        destSq:AddTileObject(oldObj)
        oldObj:transmitCompleteItemToServer()
    end
end

function MuleZed.coreFunc(zed)
    local pl = getPlayer()
    if not pl or not zed then return end
    if  MuleZed.isMuleZed(zed) then 
        if not zed:getVariableBoolean("isMuleZed") then
            zed:setVariable("isMuleZed", true)
        end

        if not zed:isUseless() then
            zed:setUseless(true)
        end

        local sq = zed:getSquare()
        if sq then
            local obj = MuleZed.getContObj(sq)
            if not obj then
                obj = MuleZed.findMuleObj(sq)
                if not obj then return end
                local origSq = obj:getSquare()
                if not origSq then return end
                MuleZed.stepCont(origSq, sq)
            end
            MuleZed.doBehavior(zed)
        end

    end
end

Events.OnZombieUpdate.Remove(MuleZed.coreFunc)
Events.OnZombieUpdate.Add(MuleZed.coreFunc)
-----------------------            ---------------------------

---------------------------
--[[ 
function MuleZed.hit(zed, pl, bodyPartType, wpn)
    local immortal = SandboxVars.MuleZed.immortal or true 
	zed:setImmortalTutorialZombie(immortal)
	zed:setNoDamage(immortal)
	zed:setAvoidDamage(true)
	if zed and MuleZed.isMuleZed(zed) then
		zed:setVariable("HitReaction", "HeadLeft")
		if MuleZed.WasHurt ~= nil then return end	
		MuleZed.sayMsg(zed, "hurt")		
		MuleZed.WasHurt = true

		MuleZed.pause(10, function()
			MuleZed.WasHurt = false
		end)

	end
end
Events.OnHitZombie.Remove(MuleZed.hit)
Events.OnHitZombie.Add(MuleZed.hit)

 ]]
-----------------------            ---------------------------
