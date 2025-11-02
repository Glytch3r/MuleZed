

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
    ["furniture_shelving_01_36"] = true,
    ["furniture_shelving_01_37"] = true,
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
    return MuleZed.sprList[sprName] or false
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
    local sprName = "furniture_shelving_01_37"
    local obj = IsoThumpable.new(getCell(), sq, sprName, false, nil)
    if not obj then return end
    obj:setIsContainer(true)
    sq:AddTileObject(obj)
    obj:transmitCompleteItemToServer()
    obj:transmitModData()
    obj:transmitUpdatedSpriteToServer()
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
    destCont:requestSync()
    srcCont:requestSync()
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

    origSq:RemoveTileObject(oldObj)
    oldObj:transmitCompleteItemToServer()
    newObj:transmitCompleteItemToServer()
    ISInventoryPage.renderDirty = true
end

function MuleZed.doSledge(obj)
    if not obj then return end
    if isClient() then
        sledgeDestroy(obj)
    else
        local sq = obj:getSquare()
        if sq then
            sq:RemoveTileObject(obj)
            sq:getSpecialObjects():remove(obj)
            sq:getObjects():remove(obj)
            sq:transmitRemoveItemFromSquare(obj)
        end
    end
end

function MuleZed.dead(zed)
    if instanceof(zed, "IsoZombie") and MuleZed.isMuleZed(zed) then
        local sq = zed:getSquare()
        if not sq then return end
        local obj = MuleZed.getContObj(sq)
        if not obj then
            obj = MuleZed.findMuleObj(sq)
        end
        if not obj then return end
        local cont = obj:getContainer()
        if cont then
            for i = cont:getItems():size() - 1, 0, -1 do
                local item = cont:getItems():get(i)
                if item then
                    sq:AddWorldInventoryItem(item, 0.5, 0.5, 0)
                    cont:Remove(item)
                end
            end
            cont:requestSync()
        end
        MuleZed.doSledge(obj)
        ISInventoryPage.renderDirty = true
    end
end

Events.OnCharacterDeath.Add(MuleZed.dead)
