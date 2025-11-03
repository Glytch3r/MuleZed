

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

MuleZed.sprList = {
    ["walls_garage_01_54"] = true,
}

function MuleZed.getSprName(obj)
    if not obj then return nil end
    local spr = obj:getSprite()
    return spr and spr:getName() or nil
end

function MuleZed.isMuleCont(obj)
    if not obj then return false end
    local sprName = MuleZed.getSprName(obj)
    if not sprName then return false end
    local cont = obj:getContainer()
    if cont ~= nil then
        if cont:getType() == "MuleZed" then
            return MuleZed.sprList[sprName]
        end
    end
    return false
end

function MuleZed.getContObj(sq)
    if not sq then return nil end
    for i = 0, sq:getObjects():size() - 1 do
        local obj = sq:getObjects():get(i)
        if obj and instanceof(obj, "IsoObject") then
            if MuleZed.isMuleCont(obj) then
                return obj
            end
        end
    end
    return nil
end

function MuleZed.findMuleObj(sq)
    local rad = 15
    local cell = getCell()
    local x, y, z = sq:getX(), sq:getY(), sq:getZ()
    for xDelta = -rad, rad do
        for yDelta = -rad, rad do
            local sq2 = cell:getOrCreateGridSquare(x + xDelta, y + yDelta, z)
            for i = 0, sq2:getObjects():size() - 1 do
                local obj = MuleZed.getContObj(sq2)
                if obj then return obj end
            end
        end
    end
    return nil
end
function MuleZed.setMuleObj(sq)
    if not sq then return end
    local sprName = "walls_garage_01_54"
    local obj = IsoThumpable.new(getCell(), sq, sprName, false, nil)
    if not obj then return end
    obj:setIsContainer(true)
    sq:AddTileObject(obj)
    obj:getContainer():setType("MuleZed")
    obj:setAlpha(0.0)
    --obj:setTargetAlpha(0.0)
   -- obj:setAlphaToTarget()

    if isClient() then
        obj:transmitCompleteItemToServer();
        obj:transmitUpdatedSpriteToServer()
        obj:transmitUpdatedSpriteToClients()
    end
    ISInventoryPage.renderDirty = true
    return obj, obj:getContainer()
end

function MuleZed.transferItems(srcCont, destCont)
    if not srcCont or not destCont then return end
    for i = srcCont:getItems():size() - 1, 0, -1 do
        local item = srcCont:getItems():get(i)
        if item then
            destCont:AddItem(item)
            srcCont:Remove(item)
        end
    end
    local pl = getPlayer() 
	getPlayerInventory(pl:getPlayerNum()):refreshBackpacks();
	getPlayerLoot(pl:getPlayerNum()):refreshBackpacks();
end

function MuleZed.stepContForZed(zed)
    if not zed then return end
    local sq = zed:getSquare()
    if zed:isDead() then return end
    if not sq then return end
    if MuleZed.getContObj(sq) ~= nil then return end
    
    local oldObj = MuleZed.findMuleObj(sq)
    if not oldObj then 
        MuleZed.setMuleObj(sq)
        return 
    end


    local oldCont = oldObj:getContainer()
    if not oldCont then return end
    
    local newObj, newCont = MuleZed.setMuleObj(sq)
    if newCont then 
        MuleZed.transferItems(oldCont, newCont)
        MuleZed.doSledge(oldObj)
    end


   
end

function MuleZed.stepCont(origSq, destSq)
    if not origSq or not destSq then return end
    local oldObj = MuleZed.getContObj(origSq)
    if not oldObj then return end
    if origSq == destSq then return end

    local newObj, newCont = MuleZed.setMuleObj(destSq)
    if not newObj or not newCont then return end

    local oldCont = oldObj:getContainer()
    if oldCont and newCont then
        MuleZed.transferItems(oldCont, newCont)
    end
    MuleZed.doSledge(oldObj)

    ISInventoryPage.renderDirty = true
end

function MuleZed.doSledge(obj)
    if isClient() then
        sledgeDestroy(obj)
    else
        local sq = obj:getSquare()
        if sq then
            sq:RemoveTileObject(obj);
            sq:getSpecialObjects():remove(obj);
            sq:getObjects():remove(obj);
            sq:transmitRemoveItemFromSquare(obj)
        end
    end
end
