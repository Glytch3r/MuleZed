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


MuleZed = MuleZed or {}

function MuleZed.hit(zed, pl, bodyPartType, wpn)
	if zed and MuleZed.isMuleZed(zed) then
      local immortal = SandboxVars.MuleZed.immortal
      if immortal then
         zed:setImmortalTutorialZombie(immortal)
         zed:setNoDamage(immortal)
         zed:setAvoidDamage(immortal)
      end
	end
end
Events.OnHitZombie.Remove(MuleZed.hit)
Events.OnHitZombie.Add(MuleZed.hit)



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
                    if SandboxVars.MuleZed.isDropOnGround then
                        sq:AddWorldInventoryItem(item, 0.5, 0.5, 0)
                    else
                        zed:getInventory():AddItem(item)
                    end
                    cont:Remove(item)
                end
            end
        end
        MuleZed.doSledge(obj)
        ISInventoryPage.renderDirty = true
    end
end

Events.OnCharacterDeath.Remove(MuleZed.dead)
Events.OnCharacterDeath.Add(MuleZed.dead)


----------------------------------------------------------------
----- ▄   ▄   ▄▄▄   ▄   ▄   ▄▄▄     ▄      ▄   ▄▄▄▄  ▄▄▄▄  -----
----- █   █  █   ▀  █   █  ▀   █    █      █      █  █▄  █ -----
----- ▄▀▀ █  █▀  ▄  █▀▀▀█  ▄   █    █    █▀▀▀█    █  ▄   █ -----
-----  ▀▀▀    ▀▀▀   ▀   ▀   ▀▀▀   ▀▀▀▀▀  ▀   ▀    ▀   ▀▀▀  -----
----------------------------------------------------------------