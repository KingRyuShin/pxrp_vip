# District-V / FiveM / Made by KingRyuShin
# pxrp_vip
-Ability to give a VIP status to a player if you want to enable some features to a limited part of your community.

Exemple : Give VIP status to a player that has donated a certain ammount of money to help the community so he can access a new vehicle shop.

# HOW TO INSTALL AND USE
# Simply use the VIP Callback on any part of your code that you want to block for vip users


					ESX.TriggerServerCallback('pxrp_vip:getVIPStatus', function(isVIP)
						if isVIP then
							OpenShopMenu()
						else
							ESX.ShowNotification("Your character doesn't have the VIP access, please check discord for more information.")
						end
					end, GetPlayerServerId(PlayerId()), '1')



This has been approved by Ianthanum on the official Discord of FiveM on 09/23/2019
as long as you don't make any profit and using a built-in commerce, this can help you pay for your server hosting etc.
https://imgur.com/60V51Lr

You are allowed to modify this script to your liking but must give credit, enjoy.
