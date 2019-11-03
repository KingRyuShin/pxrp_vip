ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pxrp_vip:getVIPStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(vip)
		if vip then
			print(('pxrp_vip: %s VIP status has been reset for the player!'):format(identifier))
		end

		cb(vip)
	end)
end)

RegisterServerEvent('pxrp_vip:setVIPStatus')
AddEventHandler('pxrp_vip:setVIPStatus', function(vip)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(vip) ~= 'boolean' then
		print(('pxrp_vip: %s attempted to parse something else than a boolean to setVIPStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET vip = @vip WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@vip'] = vip
	})
end)

TriggerEvent('es:addGroupCommand', 'addvipstatus', 'superadmin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('pxrp_vip: %s added someone to vip'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(158, 35, 35, 0.4); border-radius: 3px;"><i class="fas fa-globe"></i> <b>[Système] '..GetPlayerName(tonumber(args[1]))..'</b> <i>à été ajouté dans la liste des VIP.</i></div>'
			})			
			TriggerClientEvent('pxrp_vip:addVIPStatus', tonumber(args[1]))
		end
	else
		TriggerClientEvent('pxrp_vip:addVIPStatus', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = "Add the selected player to vip", params = {{ name = 'steamid' }} })

TriggerEvent('es:addGroupCommand', 'removevipstatus', 'superadmin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('pxrp_vip: %s removed someone to vip'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('pxrp_vip:removeVIPStatus', tonumber(args[1]))
			TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(158, 35, 35, 0.4); border-radius: 3px;"><i class="fas fa-globe"></i> <b>[Système] '..GetPlayerName(tonumber(args[1]))..'</b> <i>à été retiré de la liste des VIP.</i></div>'
			})			
		end
	else
		TriggerClientEvent('pxrp_vip:removeVIPStatus', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = "remove the selected player to vip", params = {{ name = 'steamid' }} })
