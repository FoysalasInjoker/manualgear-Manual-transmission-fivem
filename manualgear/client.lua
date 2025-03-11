-- Define initial gear state
gear = 1
maxGear = 6  -- Maximum number of gears
minGear = 0  -- Reverse gear
neutralGear = -1  -- Neutral gear
manualGearEnabled = true -- Toggle for manual gear system

-- Define key bindings for shifting gears
RegisterCommand("shift_up", function()
    if manualGearEnabled and gear < maxGear then
        gear = gear + 1
        ShowGearChangeNotification()
    elseif manualGearEnabled and gear == neutralGear then
        gear = minGear
        ShowGearChangeNotification()
    end
end, false)
RegisterKeyMapping("shift_up", "Shift Up Gear", "keyboard", "E")

RegisterCommand("shift_down", function()
    if manualGearEnabled then
        if gear > 1 then
            gear = gear - 1
        elseif gear == 1 then
            gear = -1 -- Shift to Neutral first
        elseif gear == -1 then
            gear = 0 -- Shift to Reverse
        end
        ShowGearChangeNotification()
    end
end, false)

RegisterKeyMapping("shift_down", "Shift Down Gear", "keyboard", "Q")

-- Command to toggle manual gear system
RegisterCommand("toggle_manual_gears", function()
    manualGearEnabled = not manualGearEnabled
    local status = manualGearEnabled and "enabled" or "disabled"
    ShowNotification("Manual gears " .. status)
end, false)
RegisterKeyMapping("toggle_manual_gears", "Toggle Manual Gears", "keyboard", "G")

-- Function to show gear change notification
function ShowGearChangeNotification()
    local gearLabel = gear
    if gear == -1 then
        gearLabel = "N"
    elseif gear == 0 then
        gearLabel = "R"
    end

    exports['ox_lib']:notify({
        title = "Gear Change",
        description = "Current Gear: " .. gearLabel,
        type = "info",
        position = "bottom",
        duration = 1500
    })
end


-- Function to show status notification
function ShowNotification(msg)
    lib.notify({
        title = "Gear System",
        description = msg,
        type = "info",
        position = "bottom",
        duration = 2000
    })
end

-- Function to set vehicle speed based on gear
function SetVehicleSpeedByGear(vehicle)
    if not manualGearEnabled then return end
    
    local maxSpeeds = {-15, 0, 15, 30, 50, 80, 110, 150} -- Reverse, Neutral, 1-6
    local rpmMultiplier = {0.3, 0.0, 0.3, 0.5, 0.7, 0.85, 1.0, 1.2} -- RPM scaling

    local currentSpeed = GetEntitySpeed(vehicle)

    -- ⛔ Prevent movement in Neutral (N)
    if gear == -1 then 
        SetVehicleForwardSpeed(vehicle, 0.0) 
        SetVehicleEngineOn(vehicle, true, true, false) -- Keep engine on but no power
        SetVehicleCurrentRpm(vehicle, 0.0)
        return
    end

    -- ✅ Allow Reverse (R) to function properly
    if gear == 0 then
        local reverseSpeedLimit = maxSpeeds[1] / 2.236936 -- Convert mph to GTA speed units
        if currentSpeed > reverseSpeedLimit then
            SetVehicleForwardSpeed(vehicle, reverseSpeedLimit)
        end
        SetVehicleCurrentRpm(vehicle, rpmMultiplier[1]) -- Set proper RPM for Reverse
        return
    end

    -- 🚗 Forward Gears (1-6)
    if gear >= 1 and gear <= #maxSpeeds then
        local speedLimit = maxSpeeds[gear + 2] / 2.236936
        if currentSpeed > speedLimit then
            SetVehicleForwardSpeed(vehicle, speedLimit)
        end
        local currentRPM = GetVehicleCurrentRpm(vehicle)
        SetVehicleCurrentRpm(vehicle, rpmMultiplier[gear + 2] * currentRPM)
    end
end



-- Continuously adjust vehicle based on gear
CreateThread(function()
    while true do
        Wait(100)
        if manualGearEnabled then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                SetVehicleSpeedByGear(vehicle)
            end
        end
    end
end)