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
-----------------------     context*          ---------------------------

MuleZed.muleObjSq = nil

function MuleZed.follow(pl)
	if MuleZed.muleObjSq == nil then return end
	local csq = pl:getCurrentSquare() 
	if csq then
		MuleZed.stepCont(MuleZed.muleObjSq)
		MuleZed.muleObjSq = csq  
	end
end
Events.OnPlayerUpdate.Add(MuleZed.follow)


function MuleZed.Context(plNum, context, worldobjects)
	local dbg =  getCore():getDebug() 
	local pl = getSpecificPlayer(plNum)
	if not pl then return end
	local sq = nil
    if luautils.stringStarts(getCore():getVersion(), "42") then
        sq = ISWorldObjectContextMenu.fetchVars.clickedSquare
    else
        sq = clickedSquare
    end
    if not sq then return end
	if dbg then
		context:addOptionOnTop('self testZedDmg', worldobjects, function()
			pl:addVisualDamage("ZedDmg_MuleZed");	
			dbgZed:resetModelNextFrame()

			context:hideAndChildren()
		end)
		context:addOptionOnTop('self testCropArms', worldobjects, function()
			MuleZed.CropArms(pl)
			context:hideAndChildren()
		end)
		
		context:addOptionOnTop('clear testZedDmg', worldobjects, function()
			MuleZed.clear(pl)
			context:hideAndChildren()
		end)


		local obj = MuleZed.getContObj(sq)
		if obj then
			context:addOptionOnTop('Move Mule Here', worldobjects, function()
				MuleZed.stepCont(sq)
				context:hideAndChildren()
			end)	

			if MuleZed.muleObjSq == nil then 
				context:addOptionOnTop('Mule Follow', worldobjects, function()
					MuleZed.muleObjSq = sq
					context:hideAndChildren()
				end)	
			else
				context:addOptionOnTop('Mule Leave', worldobjects, function()
					MuleZed.muleObjSq = nil				
					context:hideAndChildren()
				end)	
			end

		
		end
	end

	local zed = sq:getZombie()
	if not zed then return end	


	if MuleZed.isMuleZed(zed) then
		local Main = context:addOptionOnTop("MuleZed")
		Main.iconTexture = getTexture("media/textures/Item_MuleZed.png")
		local opt = ISContextMenu:getNew(context)
		context:addSubMenu(Main, opt)

		opt:addOptionOnTop("Follow", worldobjects,  function()
			MuleZed.doFollow(zed, pl)
		end)			
		opt:addOptionOnTop("Auto Follow: "..tostring(MuleZed.getFollowStr(zed)), worldobjects,  function()
			zed:getModData()['AutoFollow'] = not zed:getModData()['AutoFollow']
		end)
	else
		local csq = pl:getCurrentSquare() 
		local zed2
		if csq then
			zed2 = csq:getZombie()
		end
		
		if zed2 and zed2:isBeingSteppedOn()  then
			local optTip = context:addOptionOnTop("Enslave", worldobjects, function()
				if zed2 and zed2:isBeingSteppedOn()  then	
					MuleZed.doEnslave(zed2)
					context:hideAndChildren()
				end
			end)
			optTip.iconTexture = getTexture("media/textures/Item_MuleZed.png")
			if not MuleZed.canEnslave(pl) then
				local tip = ISWorldObjectContextMenu.addToolTip()
				tip.description = "Requires LongBlade or SmallBlade weapon to enslave"
				optTip.notAvailable = true
				optTip.toolTip = tip
			end
		end
	end
end
Events.OnFillWorldObjectContextMenu.Remove(MuleZed.Context)
Events.OnFillWorldObjectContextMenu.Add(MuleZed.Context)

-----------------------               ---------------------------
function MuleZed.doEnslave(zed)	
	local sq = zed:getSquare()
	if not sq then return end
	MuleZed.setMuleObj(sq)   
	zed:addVisualDamage("ZedDmg_MuleZed");		
	zed:resetModelNextFrame()
end

function MuleZed.canEnslave(pl)
    if not pl then return false end
    local wpn = pl:getPrimaryHandItem()
    if not wpn then return false end
	local cat =  wpn:getCategories()
    return cat:contains("LongBlade") or cat:contains("SmallBlade")  
end

function MuleZed.getFollowStr(zed)
    if not zed then return "OFF" end
    local str = zed:getModData().AutoFollow
    if str == true then
        return "ON"
    else
        return "OFF"
    end
end


