
MuleZed = MuleZed or {}

function MuleZed.getPointer()
	if not isIngameState() then return nil end
	local sq = nil
	local zPos = getPlayer():getZ() or 0
	local mx, my = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), zPos)
	if mx and my then
		local sq = getCell():getGridSquare(math.floor(mx), math.floor(my), zPos)
		if not sq then return nil end
		return sq ;
	end
	return nil
end

function MuleZed.dbgProperties(sq)
    local sq = MuleZed.getPointer()
    if  sq then 
        local obj = MuleZed.getContObj(sq)
        if  obj then 
            print(obj:getProperties():getPropertyNames())
        end
    end
end
function MuleZed.dbgContProperties(sq)
    local sq = MuleZed.getPointer()
    if  sq then 
        local obj = MuleZed.getContObj(sq)
        if  obj then 
            local cont = obj:getContainer()
            if cont then
                dbgClip.clipMetaFunc(cont)
            end
        end
    end
end

function MuleZed.dbgProperties(sq)
    local sq = MuleZed.getPointer()
    if  sq then 
        local obj = MuleZed.getContObj(sq)
        if  obj then 
            print(obj:Collision())
        end
    end
end

-----------------------        

function MuleZed.zedWear(pl)
	pl = pl or getPlayer()

    local pl = dbgZed
    --pl = getPlayer()
	local item = InventoryItemFactory.CreateItem('Base.Tshirt_Fossoil')
	local inv = pl:getInventory()
    if not inv then 
        print('no inv')
        return 
    end
	local equip = inv:addItem(item);
	pl:setWornItem(equip:getBodyLocation(), equip);
	--triggerEvent("OnClothingUpdated", pl)
    equip:synchWithVisual();
	pl:resetModelNextFrame();
end
--[[ 

local zed = dbgZed
if zed and instanceof(zed, "IsoZombie") then
    local itemVisuals = ItemVisuals.new()
    zed:getItemVisuals(itemVisuals)            
    for i=1,itemVisuals:size() do
        local item = itemVisuals:get(i-1):getClothingItemName()
        print(item)
    end
end

    local zed = dbgZed
    local inv = zed:getInventory()
    local vis = zed:getHumanVisual()
    local iVis = zed:getItemVisuals()

 dbgClip.clipMetaFunc(vis)
    if not inv or not vis or not iVis then return end

    local items = {
        "Base.Gloves_LongWomenGloves",
        "Base.HolsterAnkle",
        "Base.Shoes_Fancy",
        "Base.StockingsBlack",
        "Base.FrillyUnderpants_Black",
        "Base.Makeup_LipsBlack",
        "Base.Makeup_EyesShadowBlue",
    }

    for _, type in ipairs(items) do
        local item = InventoryItemFactory.CreateItem(type)
        if item then
            inv:AddItem(item)
            iVis:setItem(item)
        end
    end

    zed:resetModelNextFrame()
    zed:resetModel()

 ]]
--[[ 
local zed = dbgZed
zed:addVisualDamage("ZedDmg_MuleZed");		
zed:resetModel() 
]]
--[[ 
local zed = dbgZed
local hv = zed:getHumanVisual()



local tshirt = InventoryItemFactory.CreateItem("Base.TShirt_Fossoil")
local e = tshirt:getClothingItem()
print(e)

hv:addBodyVisual(tshirt:getClothingItem())
zed:resetModelNextFrame()
 ]]