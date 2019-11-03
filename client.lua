ESX = nil
local PlayerLoaded = false
vip = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
	vip = false
	ESX.TriggerServerCallback('pxrp_vip:getVIPStatus', function(vip)
		if vip then
			while not PlayerLoaded do
				Citizen.Wait(1000)
			end

	ESX.ShowNotification("Status VIP: Activé")
		end
	end)
end)

function addVIPStatus()
	TriggerServerEvent('pxrp_vip:setVIPStatus', true)
	vip = true
end

function removeVIPStatus()
	TriggerServerEvent('pxrp_vip:setVIPStatus', false)
	vip = false
end

RegisterNetEvent('pxrp_vip:addVIPStatus')
AddEventHandler('pxrp_vip:addVIPStatus', function()
	addVIPStatus()
end)

RegisterNetEvent('pxrp_vip:removeVIPStatus')
AddEventHandler('pxrp_vip:removeVIPStatus', function()
	removeVIPStatus()
end)
