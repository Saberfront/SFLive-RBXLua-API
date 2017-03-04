local SDB2Service = {}
local SDB2_HOST = "https://saberfrontlive-acosf.c9users.io/"
SDB2Service.UniversalToken = ""
SDB2Service.LoadoutToken = ""
SDB2Service.InventoryToken = ""
	local inventories =  game.HttpService:JSONDecode(game:GetService("HttpService"):GetAsync(SDB2_HOST.."api/inventory/all",false,{["Authorization"] = "Bearer " .. SDB2Service.InventoryToken,Accept = 'application/json'})).data 
	print(#inventories)
	local data = nil 
	for i = 1,#inventories,1 do
		if tonumber(inventories[i].userId) == plrId then
			print(game.Players:GetNameFromUserIdAsync(plrId) .. " has a secondary inventory!")
			data = inventories[i] 
		end
	end
	print(data)
	return data
end
local function getUserIdForGameServer(userId)
	return game.HttpService:JSONDecode(game.HttpService:GetAsync(SDB2_HOST.."api/user/getByRID/"..userId,false,{
		["Accept"] = "application/json",
		["Authorization"] = "Bearer " .. SDB2Service.UniversalToken
	})).id
end
function SDB2Service:GetUserLoadout(userId,loadoutId)
	local loadout = game.HttpService:JSONDecode(game.HttpService:GetAsync(SDB2_HOST.."api/users/"..getUserIdForGameServer(userId).."/loadouts/"..loadoutId,false,{
		["Authorization"] = "Bearer " .. SDB2Service.LoadoutToken,
		["Accept"] = "application/json"
	}))
	return loadout.data
end
return SDB2Service
