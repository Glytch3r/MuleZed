--[[
----------------------------------------------------------------------------------------------------------------------------⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                       ⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣰⣦⣀⣀⠀⠠⠄⠄⠠⠀⠀⢀⣠⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⡿⢿⣦⠀⠀⠀⠀⠀⠀⠀⢀⡷⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⣩⡿⠋⠙⠉⢩⡿⠟⠀⠀⠀⠀⠀⠀⢀⣶⣾⠟⠋⠛⣿⣷⡄⠀⠀⠀⠀⠀⣴⣿⠂⠀⠀⣼⡿⠀⠀⠀⠀⠀⠀⢀⣠⡴⠶⣤⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠦⠤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⡿⠋⠀⢸⠏⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⢠⡇⠀⠀⠀⢠⣾⠋⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⢠⣿⠋⠀⠀⠀⠀⠛⠛⠁⠀⠀⠀⢀⣾⣿⠏⠀⠀⢀⡿⠃⠀⠀⠀⠀⠀⠶⠋⠁⢀⣰⠟⠀⠀⠀⠀⠀⠀⠀⣹⣿⠀⠀⠀⠀⣨⣿⠇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣾⡟⢀⣠⣤⣴⣶⠆⠀⠀⠀⠀⠀⢰⠃⠀⠀⠀⠀⠀⣾⠀⠀⠀⣰⣿⠃⠀⠀⠀⠀⠀⣿⡀⠀⠀⠀⠀⠀⢀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⠋⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⣠⣶⣯⣅⡀⠀⠀⠀⠀⠀⠀⠀⣿⡇⢀⣠⠴⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣸⡟⠀⠛⠉⣠⣾⠃⠀⠀⠀⠀⠀⠀⣼⠀⠀⠀⠀⠀⠀⢿⣤⡴⢺⢻⠃⠀⠀⠀⠀⠀⢸⡿⠁⠀⠀⠀⠀⠀⠀⢿⠀⠀⠀⠀⢀⣤⠀⠀⠀⠀⠀⢀⣿⣇⡤⠤⢤⣾⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢻⡆⠀⠀⠀⠀⠀⣿⣯⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⢀⣼⠇⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢂⠇⠀⠀⠀⠀⠀⠀⣾⡅⠀⠀⠀⠀⠀⠀⠀⢸⣧⡀⠀⠀⣼⠇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠐⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⠀⢰⡏⠘⣦⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠘⢧⣤⡶⠟⢻⠀⠀⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⢘⠏⠀⠀⠀⠀⠀⠀⢰⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣶⡾⠋⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠞⠁⠀⠀⠀⠀⠀⠀⠁⠀⠈⠙⠂⠔⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠀⠀⠀⠀⠀⢀⣿⣤⠶⠒⠒⠁⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠐⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

----------------------------------------------------------------------------------------------------------------------------
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
Please contact me if you need to hire someone to do mods or other design related tasks
https://steamcommunity.com/id/glytch3r/myworkshopfiles/
https://ko-fi.com/glytch3r
Discord:  glytch3r


----------------------------------------------------------------------------------------------------------------------------
--]]

--[[██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
   ░▒▓█████▓▒░     ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓███████▓▒░   ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓███████▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
  ░▒▓█▓▒░          ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
  ░▒▓█▓▒▒▓███▓▒░   ░▒▓█▓▒░         ░▒▓██████▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█████████▓▒░     ░▒▓███▓▒░     ░▒▓███████▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒▓▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒█▒░
   ░▒▓██████▓▒░    ░▒▓████████▓▒░    ░▒▓█▓▒░         ░▒▓█▓▒░      ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓█▓▒░  ░▒█▒░
|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|                        				 Custom  PZ  Mod  Developer  for  Hire										                      		
|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
|                       	Portfolio:  https://steamcommunity.com/id/glytch3r/myworkshopfiles/			       				         
|                       		                                    														 	 		 	 		 
|                       	Discord:    glytch3r															     	     	     	     	     	     
|                       		                                    														 	              
|                       	Support:    https://ko-fi.com/glytch3r														    	          
|_______________________________________________________________________________________________________________________________-]]
--[[_____________________________________________________________________________________________________________________________
   ░▒▓██████▓▒░    ░▒▓████████▓▒░    ░▒▓█▓▒░         ░▒▓█▓▒░      ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓█▓▒░  ░▒█▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒█▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░  ░▒▓▒░
  ░▒▓█▓▒▒▓███▓▒░   ░▒▓█▓▒░         ░▒▓██████▓▒░      ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█████████▓▒░     ░▒▓███▓▒░     ░▒▓███████▓▒░
  ░▒▓█▓▒░          ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░         ░▒▓█▓▒░ ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
  ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░     ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░  ▒▓░    ░▒▓█▓▒░   ░▒▓█▒░  ░▒▓█▒░
   ░▒▓█████▓▒░     ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓███████▓▒░   ░▒▓██████▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░  ░▒▓███████▓▒░    ░▒▓███████▓▒░
█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████--]]

MuleZed = MuleZed or {}

function MuleZed.doBehavior(zed)
    if zed:getModData()['AutoFollow'] == nil then return end
    local pl = getPlayer() 
    if not pl then return end 
    if MuleZed.isClosestPl(pl, zed) then
        MuleZed.doFollow(zed, pl)
    end
end

function MuleZed.doFollow(zed, pl)
    local pl = getPlayer() 
    if not pl then return end 
    if not MuleZed.isWithinRange(pl, zed) then
        local sq = MuleZed.getTargPlSq(pl)
        if not sq then return end
        local x, y, z = round(sq:getX()),  round(sq:getY()),  sq:getZ() or 0
        if not (x and y and z) then return end
        MuleZed.moveToXYZ(zed, x, y, z)
    end
end

-----------------------            ---------------------------
function MuleZed.getTargPlSq(pl)
    if not pl then return nil end
    local px, py, pz = pl:getX(), pl:getY(), pl:getZ()
    local dist = ZombRand(1, 4)
    local dirX = ZombRand(-1, 2)
    local dirY = ZombRand(-1, 2)
    if dirX == 0 and dirY == 0 then dirX = 1 end
    local sq = getCell():getGridSquare(px + dirX * dist, py + dirY * dist, pz)
    return sq
end
    
function MuleZed.moveToXYZ(zed, x, y, z)
	zed:getPathFindBehavior2():pathToLocation(x, y, z)
	local sq = getCell():getOrCreateGridSquare(x, y, z)
	if not sq:TreatAsSolidFloor() and sq:getZ() == zed:getZ() then
		zed:setVariable("bPathfind", false)
		zed:setVariable("bMoving", true)
	end
end


-----------------------   
function MuleZed.getMuleZedFromSq(sq)
    if not sq then return nil end
    local zeds = sq:getMovingObjects()
    if not zeds then return nil end
    for i = 0, zeds:size() - 1 do
        local zed = zeds:get(i)
        if instanceof(zed, "IsoZombie") then
            if MuleZed.isMuleZed(zed) then
                return zed
            end
        end
    end
    return nil
end

function MuleZed.getMuleZed(x,y,z)
    if not (x and y and z) then return nil end
    local sq = getCell():getOrCreateGridSquare(x, y, z)
    if not sq then return nil end
    return MuleZed.getMuleZedFromSq(sq)
end

-----------------------            ---------------------------

-----------------------            ---------------------------
function MuleZed.followMe(zed)
	if not MuleZed.isMuleZed(zed) then return end
	local pl = getPlayer(); if not pl then return end
	local x, y, z = pl:getX(), pl:getY(), pl:getZ()
	zed:setX(x); zed:setY(y); zed:setZ(z)
	zed:setLx(x); zed:setLy(y)
end

function MuleZed.faceTarget(zed, targ)
	local zTarg = zed:getTarget()
	if not zTarg or (zTarg and not targ == zTarg) then
		zed:setTarget(targ)	
	end
	zTarg = targ
	if zed and zTarg then
		zed:faceLocation(zTarg:getX(), zTarg:getY())
	end
end

function MuleZed.moveToXYZ(zed, x, y, z)
	zed:getPathFindBehavior2():pathToLocation(x, y, z)
	local sq = getCell():getOrCreateGridSquare(x, y, z)
	if not sq:TreatAsSolidFloor() and sq:getZ() == zed:getZ() then
		zed:setVariable("bPathfind", false)
		zed:setVariable("bMoving", true)
	end
	--zed:faceLocation(x, y);
end
