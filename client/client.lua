ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_animaladn:chuanbidoiadn')
AddEventHandler('esx_animaladn:chuanbidoiadn', function()
	local dict = "mini@repair"

	RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end

	exports['progressBars']:startUI(5000, "Finding ADN")
	TaskPlayAnim(GetPlayerPed(-1), dict, "fixing_a_player", 8.0, 8.0, -1, 50, 1, false, false, false)
	Citizen.Wait(5000)
	Openvipmemu()
	ClearPedSecondaryTask(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_animaladn:giaibiendoiadn')
AddEventHandler('esx_animaladn:giaibiendoiadn', function()
	exports['progressBars']:startUI(5000, "Changing to human ADN")
	Citizen.Wait(5000)
	TriggerEvent("esx_animaladn:bienthanhnguoi")
	ClearPedSecondaryTask(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_animaladn:bienthanhnguoi')
AddEventHandler('esx_animaladn:bienthanhnguoi', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		local isMale = skin.sex == 0


		TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
			end)
		end)

	end)
end)	

function Openvipmemu()
	ESX.UI.Menu.CloseAll()
	local elems = Config.Animaladn
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'esx_vipmenu',{
        title    = '🧬 Choose ADN',
        align = 'center',
        elements = elems
    },
    function(data, menu)
	if data.current.value == 'animal_skin' then
		local modelHash = ''
		local dict = "anim@heists@narcotics@funding@gang_idle"

		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
		end

		menu.close()
		
		exports['progressBars']:startUI(5000, "Changing ADN")
		TaskPlayAnim(GetPlayerPed(-1), dict, "gang_chatting_idle01", 8.0, -8.0, -1, 0, 0, false, false, false)
		Citizen.Wait(5000)
		ClearPedSecondaryTask(GetPlayerPed(-1))

		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
			if skin.sex == 0 then
				modelHash = GetHashKey(data.current.maleModel)
			else
				modelHash = GetHashKey(data.current.femaleModel)
			end

			ESX.Streaming.RequestModel(modelHash, function()
				SetPlayerModel(PlayerId(), modelHash)
				SetModelAsNoLongerNeeded(modelHash)

				TriggerEvent('esx:restoreLoadout')
			end)
		end)

	end
	end,
	function(data, menu)
		menu.close()
	end)
end