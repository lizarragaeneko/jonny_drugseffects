ESX = nil
local IsAlreadyDrug = false
local DrugLevel = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

AddEventHandler('esx_status:loaded', function(status)

  TriggerEvent('esx_status:registerStatus', 'drug', 0, '#9ec617', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end, function(status)
      status.remove(1500)
    end)

	Citizen.CreateThread(function()
		while true do

			Wait(1000)

			TriggerEvent('esx_status:getStatus', 'drug', function(status)

		if status.val > 0 then
          local start = true

          if IsAlreadyDrug then
            start = false
          end

          local level = 0

          if status.val <= 999999 then
            level = 0
          else
            overdose()
          end

          if level ~= DrugLevel then
          end

          IsAlreadyDrug = true
          DrugLevel = level
		end

		if status.val == 0 then
          
          if IsAlreadyDrug then
            Normal()
          end

          IsAlreadyDrug = false
          DrugLevel     = -1
		end
			end)
		end
	end)
end)

--When effects ends go back to normal
function Normal()

  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
			
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    --ResetPedMovementClipset(playerPed, 0) <- it might cause the push of the vehicles
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)
end

--In case too much drugs dies of overdose set everything back
function overdose()

  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
	
    SetEntityHealth(playerPed, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)
end

--Drugs Effects

--Marijuana
RegisterNetEvent('jonny_drugseffects:onMarijuana')
AddEventHandler('jonny_drugseffects:onMarijuana', function()
  local playerPed = GetPlayerPed(-1)

    RequestAnimSet("move_m@hipster@a") 
    while not HasAnimSetLoaded("move_m@hipster@a") do
      Citizen.Wait(0)
    end    
      local startTime = GetGameTimer()
    local delay = 70000 -- ms
      local display = true
      TriggerEvent('jonny_drugseffects:display', true)

    while display do
      Citizen.Wait(1)
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
        local display = false
        TriggerEvent('jonny_drugseffects:display', false)
      end
    end
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
    SetPedIsDrug(playerPed, true)

    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.3)

    Wait(300000)

    SetRunSprintMultiplierForPlayer(player, 1.0)		
end)

--Opium
RegisterNetEvent('jonny_drugseffects:onOpium')
AddEventHandler('jonny_drugseffects:onOpium', function()
  local playerPed = GetPlayerPed(-1)
  
        RequestAnimSet("move_m@drunk@moderatedrunk") 
    while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    SetPedIsDrug(playerPed, true)
      local startTime = GetGameTimer()
    local delay = 70000 -- ms
     local display = true
      TriggerEvent('jonny_drugseffects:display', true)

    while display do
      Citizen.Wait(1)
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
        display = false
        TriggerEvent('jonny_drugseffects:display', false)
      end
    end
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)

    Wait(520000)

    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
 end)

--Meth
RegisterNetEvent('jonny_drugseffects:onMeth')
AddEventHandler('jonny_drugseffects:onMeth', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_injured_generic") 
    while not HasAnimSetLoaded("move_injured_generic") do
      Citizen.Wait(0)
    end    
      local startTime = GetGameTimer()
    local delay = 70000 -- ms
     local display = true
            TriggerEvent('jonny_drugseffects:display', true)

    while display do
      Citizen.Wait(1)
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
        display = false
        TriggerEvent('jonny_drugseffects:display', false)
      end
    end

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_injured_generic", true)
    SetPedIsDrug(playerPed, true)

   --Efects
    local player = PlayerId()  
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
    SetEntityHealth(playerPed, newHealth)
end)

--Coke
RegisterNetEvent('jonny_drugseffects:onCoke')
AddEventHandler('jonny_drugseffects:onCoke', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(0)
    end    
      local startTime = GetGameTimer()
    local delay = 70000 -- ms
      local display = true
      TriggerEvent('jonny_drugseffects:display', true)

    while display do
      Citizen.Wait(1)
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
        display = false
        TriggerEvent('jonny_drugseffects:display', false)
      end
    end

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrug(playerPed, true)

    --Efects
    local player = PlayerId()
    AddArmourToPed(playerPed, 100)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    SetEntityHealth(playerPed, newHealth)
end)
RegisterNetEvent('jonny_drugseffects:display')
AddEventHandler('jonny_drugseffects:display', function(value)
  SendNUIMessage({
    type = "logo",
    display = value
  })
end)

function ShowInfo(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end