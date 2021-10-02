

ESX = exports.es_extended:getSharedObject()


local inAction      = false
local Cancel        = false
local CicloSleep    = true
local _ConfigS      = nil


--[[

    usa questo export in quei punti dove vuoi bloccare l apertuta di un menu/nui/quello che vuoi ma usi un metodo diverso dal IsControlPressed e compagnia

    ESEMPIO

    local inAction = exports["fnx_drugs"]:getinAction()
    if not inAction then
        --continua il code
    end
    
]]


exports("getinAction",function ()
    return inAction
end)


Citizen.CreateThread(function()
    while ESX == nil do Wait(10) end
    ESX.TriggerServerCallback("fnx-drug:request-config",function (result)
        _ConfigS = result
    end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    if _ConfigS == nil then
        ESX.TriggerServerCallback("fnx-drug:request-config",function (result)
            _ConfigS = result
        end)
    end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        CicloSleep = true
        while _ConfigS == nil do Wait(10) end
        for k, v in pairs(_ConfigS) do 
            for a, b in pairs(v.point) do
                local Distanza = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),b.x, b.y, b.z, true)
                if  Distanza <= v.misc.marker_config.render_distance and not inAction then
                    CicloSleep = false
                    if v.misc.marker_config.show_marker then
                        DrawMarker(v.misc.marker_config.type,b.x, b.y, b.z, 0, 0, 0, 0, 0, 0, v.misc.marker_config.scale, v.misc.marker_config.rgb, 200, true, true, true, true)
                    end
                    if Distanza <= v.misc.marker_config.interaction_distance then
                        if v.misc.marker_config.text_notify then
                            TestoDestra(v.misc.marker_config.text)
                        end
                        if IsControlJustReleased(1, 51) then
                            Function(k)
                        end
                    end
                end
            end
        end
        if CicloSleep then
            Citizen.Wait(150)
        end
    end
end)


RequestJobCounter = function (arg)
    local wait = nil
    ESX.TriggerServerCallback("fnx-drug:request-job-count",function (result)
        wait  = result
    end,arg)
    while wait == nil do Wait(10) end
    return wait
end

RequestItemControll = function (arg)
    local wait = nil
    ESX.TriggerServerCallback("fnx-drug:request-item",function (result)
        wait  = result
    end,arg)
    while wait == nil do Wait(10) end
    return wait
end




Function = function (index)
    if index and _ConfigS[index] and not inAction then
        inAction = true   
        Cancel = false 
        local _table = _ConfigS[index] 
        if _table.require.item_controll then
            local control_item = RequestItemControll(_table.require.list_item_controll)
            if not control_item then
                Notifica(Lang["item_controll"])
                inAction = false   
                return
            end                
        end
        if _table.require.job_count_controll then
                local count = RequestJobCounter(_table.require.list_job_count_controll)
            if not count then
                Notifica(Lang["job_count_controll"])
                inAction = false   
                return
            end                
        end
        if _table.require.onlyjob then
            if _table.require.whitelist_job[ESX.GetPlayerData().job.name] == nil then
                Notifica(Lang["onlyjob"])
                inAction = false   
                return
            end
        end
        if _table.require.only_at_one_time then
            local year , month , day , hour, minute , second  = GetLocalTime()		
            if (hour + _table.require.your_time_zone) >= tonumber(_table.require.whitelist_time.start.hour) and ( hour + _table.require.your_time_zone) <= tonumber(_table.require.whitelist_time.stop.hour) then else
                Notifica(Lang["only_at_one_time"])
                inAction = false   
                return
            end
        end
        if _table.misc.animation.enable then
            ESX.Streaming.RequestAnimDict(_table.misc.animation.lib, function()
                TaskPlayAnim(PlayerPedId(),_table.misc.animation.lib,_table.misc.animation.anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                Wait(50)
                local time = 0
                Citizen.CreateThread(function()
                    while inAction do
                        Citizen.Wait(0)
                        if IsControlPressed(0,177) then
                            inAction = false   
                            Cancel = true  
                            ClearPedTasks(PlayerPedId())
                            Notifica(Lang["can_i_cancel"])
                            return
                        end
                        for i = 1, #_table.misc.animation.disablekey, 1 do
                            DisableControlAction(0, _table.misc.animation.disablekey[i], true)           
                        end
                    end
                end)
                while inAction and time < _table.misc.animation.time do
                    time = time + 1
                    Wait(1000)
                end
                inAction = false   
                ClearPedTasks(PlayerPedId())
            end)
        end
        if not Cancel and not inAction then
            TriggerServerEvent("fnx-drugs:function",index)
        end
    end
end



function Notifica(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0,1)
end


function TestoDestra(msg)
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end