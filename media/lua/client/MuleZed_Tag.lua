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
function MuleZed.getDogTag(zed)
    if not zed then return nil end
    local inv = zed:getInventory()
    if not inv then return nil end
    local items = inv:getItemsFromType("Base.Necklace_DogTag")
    if not items or items:isEmpty() then return nil end
    for i = 0, items:size() - 1 do
        local tag = items:get(i)
        if tag and tag:getName() == "MuleZed" then
            return tag
        end
    end
    return nil
end

function MuleZed.addDogTag(zed)
    if not zed then return end
    local inv = zed:getInventory()
    if not inv then return end
    local tag = MuleZed.getDogTag(zed)
    if tag then return tag end
    tag = inv:AddItem("Base.Necklace_DogTag")
    if tag then tag:setName("MuleZed") end
    return tag
end

function MuleZed.removeDogTag(zed)
    if not zed then return end
    local inv = zed:getInventory()
    if not inv then return end
    local tag = MuleZed.getDogTag(zed)
    if tag then inv:Remove(tag) end
end


function MuleZed.isMuleZed(zed)
    if not zed then return false end
    if MuleZed.getDogTag(zed) or MuleZed.isMuleZedSkin(zed) then return true end
    return false
end


