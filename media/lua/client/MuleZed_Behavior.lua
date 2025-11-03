MuleZed = MuleZed or {}
MuleZed.mark = nil

function MuleZed.doBehavior(zed)
    if not zed then return end
    local md = zed:getModData()
    if not md or md.AutoFollow ~= true then return end
    local pl = getPlayer()
    if not pl then return end
    if MuleZed.isClosestPl(pl, zed) then
        if pl:isMoving() then
            MuleZed.stopMove(zed)
        else       
            MuleZed.doFollow(zed, pl)
        end      
    end
end

function MuleZed.doFollow(zed, pl)
    pl = pl or getPlayer()
    if not pl or not zed then return end
    local distSq = zed:DistToSquared(pl:getX(), pl:getY())
    if not distSq then return end
    zed:addLineChatElement(tostring(distSq))

    if distSq > 3 then
        local targSq = MuleZed.getTargPlSq(pl)
        if targSq and MuleZed.mark == nil then
            MuleZed.addTempMarker(targSq)
            local x, y, z = targSq:getX(), targSq:getY(), targSq:getZ()
            if not (x and y and z) then return end        
            MuleZed.moveToXYZ(zed, x, y, z)   
        end
        if not MuleZed.mark then
            MuleZed.stopMove(zed)
        end
    else      
        zed:faceLocation(pl:getX(), pl:getY())
    end

end


function MuleZed.addTempMarker(sq, isBad)
	if not sq then return end
	local r, g, b = 0.4,0.4,1
	if isBad then
		r, g, b = 1,0.4,0.4
	end
	MuleZed.mark = getWorldMarkers():addGridSquareMarker("circle_center", "circle_only_highlight", sq ,r,g,b, true, 0.5)
	timer:Simple(1, function()
        if MuleZed.mark then
            MuleZed.mark:remove()
            MuleZed.mark = nil
        end
	end)
end

function MuleZed.moveToXYZ(zed, x, y, z)
    if not zed or not x or not y or not z then return end
    local pl = getPlayer()
    if not pl then return end
   
    local sq = getCell():getOrCreateGridSquare(x, y, z)
    if not sq then return end
    if zed:getSquare() ~= sq then
        zed:pathToLocation(sq:getX(), sq:getY(), sq:getZ())
    end
    if sq:getZ() == zed:getSquare():getZ() then
        zed:setVariable("bPathfind", true)
        zed:setVariable("bMoving", false)
    end
end
function MuleZed.stopMove(zed)
    if not zed then return end
    if getCore():getDebug() then zed:addLineChatElement("stop") end    
	zed:getPathFindBehavior2():cancel()
    zed:setPath2(nil);
    zed:setVariable("bPathfind", false)
    zed:setVariable("bMoving", false)
end



function MuleZed.getTargPlSq(pl)
    if not pl then return nil end
    local px, py, pz = pl:getX(), pl:getY(), pl:getZ()
    local dist = ZombRand(1, 3)
    local dirX = ZombRand(-1, 1)
    local dirY = ZombRand(-1, 1)
    if dirX == 0 and dirY == 0 then dirX = 1 end
    local sq = getCell():getGridSquare(px + dirX * dist, py + dirY * dist, pz)
    return sq
end

function MuleZed.getMuleZedFromSq(sq)
    if not sq then return nil end
    local zeds = sq:getMovingObjects()
    if not zeds then return nil end
    for i = 0, zeds:size() - 1 do
        local zed = zeds:get(i)
        if instanceof(zed, "IsoZombie") and MuleZed.isMuleZed(zed) then
            return zed
        end
    end
    return nil
end

function MuleZed.getMuleZed(x, y, z)
    if not (x and y and z) then return nil end
    local sq = getCell():getOrCreateGridSquare(x, y, z)
    if not sq then return nil end
    return MuleZed.getMuleZedFromSq(sq)
end

function MuleZed.faceTarget(zed, targ)
    if not zed or not targ then return end
    local zTarg = zed:getTarget()
    if not zTarg or zTarg ~= targ then
        zed:setTarget(targ)
    end
    zed:faceLocation(targ:getX(), targ:getY())
end
