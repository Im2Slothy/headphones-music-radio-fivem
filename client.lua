------------------------------------------------------------
-- GTA Radio Headphones - A Simple FiveM Script, Made By Slothy#0 --
------------------------------------------------------------
----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ MESS SOMETHING UP! EDIT THE CONFIG.LUA --
----------------------------------------------------------------------------------------------

local QBCore = exports['qb-core']:GetCoreObject()

currentStationName = ""

-- Event for using the headphone item
RegisterNetEvent('qb-core:useHeadphone', function()
    print("[DEBUG CLIENT] Headphone item used - Triggering headphone menu")
    -- Open the headphone menu
    TriggerEvent('qb-headphones:openMenu')
end)

-- Headphone Menu
RegisterNetEvent('qb-headphones:openMenu', function()
    print("[DEBUG] Opening headphone menu")
    local elements = {
        {
            header = "🎧 Headphone Menu",
            isMenuHeader = true
        },
        {
            header = "Turn On",
            txt = "Put on the headphones and listen to the radio",
            params = {
                event = "qb-headphones:turnOn"
            }
        },
        {
            header = "Turn Off",
            txt = "Take off the headphones",
            params = {
                event = "qb-headphones:turnOff"
            }
        },
        {
            header = "Change Radio Station",
            txt = "Select a radio station to listen to",
            params = {
                event = "qb-headphones:changeStation"
            }
        },
        {
            header = "Current Station: " .. currentStationName,
            txt = "Now Playing: " 
        },
    }

    print("[DEBUG] Elements for menu created, ready to open qb-menu")
    
    -- Open the menu using qb-menu
    exports['qb-menu']:openMenu(elements)
end)



-- Turn On Headphones
RegisterNetEvent('qb-headphones:turnOn', function()
    print("[DEBUG] Turn On option selected")
    local playerPed = PlayerPedId()

    -- Put on the headphones (example model, adjust as needed)
    SetPedPropIndex(playerPed, 0, 15, 1, true) -- Headphones on component 1 (Hats)

    -- Enable mobile radio outside the vehicle
    SetMobileRadioEnabledDuringGameplay(true)

    -- Set default radio station (adjust as needed)
    local defaultStation = Config.RadioStations[1].stationName
    SetRadioToStationName(defaultStation)
    currentStationName = Config.RadioStations[1].name
    TriggerEvent('QBCore:Notify', "Headphones on, radio playing: " .. Config.RadioStations[1].name)
end)

-- Turn Off Headphones
RegisterNetEvent('qb-headphones:turnOff', function()
    print("[DEBUG] Turn Off option selected")
    local playerPed = PlayerPedId()

    -- Remove the headphones
    ClearPedProp(playerPed, 0) -- Remove prop from component 1 (Hats)

    -- Disable the mobile radio
    SetMobileRadioEnabledDuringGameplay(false)
    currentStationName = "None"
    TriggerEvent('QBCore:Notify', "Headphones off.")
end)

-- Change Radio Station
RegisterNetEvent('qb-headphones:changeStation', function()
    print("[DEBUG] Change Station option selected")
    local elements = {}

    for _, station in ipairs(Config.RadioStations) do
        table.insert(elements, {
            header = station.name,
            txt = "Listen to " .. station.name,
            params = {
                event = "qb-headphones:setStation",
                args = station.stationName
            }
        })
    end

    print("[DEBUG] Radio stations menu created, ready to open qb-menu")
    exports['qb-menu']:openMenu(elements)
end)

-- Update current station when changing the station
RegisterNetEvent('qb-headphones:setStation', function(stationName)
    print("[DEBUG] Setting radio station to:", stationName)
    SetRadioToStationName(stationName)

    -- Find and set the current station name based on the station name
    for _, station in ipairs(Config.RadioStations) do
        if station.stationName == stationName then
            currentStationName = station.name  -- Get the name associated with the station
            break
        end
    end

    -- Notify the player and update the menu
    TriggerEvent('QBCore:Notify', "Radio station changed to: " .. currentStationName)

    -- Reopen the headphone menu to reflect the current station
    TriggerEvent('qb-headphones:openMenu')
end)