local QBCore = exports['qb-core']:GetCoreObject()
local MinDistance = 1.5
local ClosestTire = nil

local BONES = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}

local function RemoveTire()
	local p = promise.new()
	QBCore.Functions.TriggerCallback("tire:CheckItem", function(r)
		p:resolve(r)
	end)
	return Citizen.Await(p)
end

RegisterNetEvent('Tire:Handler', function(removing)	
    if removing == nil then
        removing = false
    end
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local vehicle = GetClosestVehicle(coords, 3.0, 0, 127)
	local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
	
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}

	if vehicle ~= nil and vehicle ~= 0 then					
		SetVehicleModKit(vehicle, 0)
		for a = 1, #BONES do
			local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, BONES[a]))
            local distance = #(coords - bonePos)
			local vehpos = GetEntityCoords(vehicle)
			local wheeltype = GetVehicleWheelType(vehicle)	
			local wheelindex = GetVehicleMod(vehicle, 23)
	
			if distance <= MinDistance and not IsPedInAnyVehicle(ped) then
				ClosestTire = {bone = BONES[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[BONES[a]]}
			end
		end

        local Label = "Removing Tire"
        local Time = 10000
        if not removing then
            Label = "Replacing Tire"
            Time = 15000
        end

        TaskTurnPedToFaceCoord(ped, ClosestTire.bonePos.x, ClosestTire.bonePos.y, ClosestTire.bonePos.z, 0)
        QBCore.Functions.Progressbar("TireHandler", Label, Time, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 01,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            if removing then
                SetVehicleTyreBurst(vehicle, ClosestTire.tireIndex, true, 1000)					
                Wait(3000)
                TriggerServerEvent('Tires:GiveTire')
                TriggerServerEvent('qb-customs:server:updateVehicle', vehProps)
            else 
                if RemoveTire() then 
                    SetVehicleTyreFixed(vehicle, ClosestTire.tireIndex)					
                    Wait(3000)
                    TriggerServerEvent('qb-customs:server:updateVehicle', vehProps)
                end		
            end
        end, function() -- Cancel
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)							
        end)
	end
end)