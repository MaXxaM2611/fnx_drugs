ESX = exports.es_extended:getSharedObject()


ESX.RegisterServerCallback("fnx-drug:request-config",function (src,cb)
    cb(_ConfigS)
end)


ESX.RegisterServerCallback("fnx-drug:request-item",function (src,cb,args)
    if type(args) == "table" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local bool = false
        if xPlayer then   
            if args.add.enable then
                if xPlayer.canCarryItem(args.add.name, args.add.count) then
                    if args.remove.enable then
                        local item = xPlayer.getInventoryItem(args.remove.name)
                        if item and item.count >= args.remove.count then    
                            bool = true
                        else
                            bool = false
                        end  
                    else
                        bool = true
                    end  
                else
                    bool = false 
                end 
            else 
                if args.remove.enable then
                    local item = xPlayer.getInventoryItem(args.remove.name)
                    if item and item.count >= args.remove.count then    
                        bool = true
                    else
                        bool = false
                    end        
                end
            end
        end
        cb(bool)   
    end
end)



ESX.RegisterServerCallback("fnx-drug:request-job-count",function (src,cb,args)
    if type(args) == "table" then
        local count = 0
        for a, b in pairs(GetPlayers()) do
            local xPlayer = ESX.GetPlayerFromId(b)
            if xPlayer then
                if args[xPlayer.job.name] ~= nil then
                    count = count + 1
                    if args[xPlayer.job.name] >= count then
                        cb(true)
                        return
                    end
                end
            end
        end
        cb(false)
    end
end)


RegisterServerEvent("fnx-drugs:function",function (index)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        if _ConfigS[index] then
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer then   
                if _ConfigS[index].require.list_item_controll.add.enable then
                    if xPlayer.canCarryItem(_ConfigS[index].require.list_item_controll.add.name, _ConfigS[index].require.list_item_controll.add.count) then
                        if _ConfigS[index].require.list_item_controll.remove.enable then
                            local item = xPlayer.getInventoryItem(_ConfigS[index].require.list_item_controll.remove.name)
                            if item and item.count >= _ConfigS[index].require.list_item_controll.remove.count then    
                                xPlayer.removeInventoryItem(_ConfigS[index].require.list_item_controll.remove.name, _ConfigS[index].require.list_item_controll.remove.count)
                                xPlayer.addInventoryItem(_ConfigS[index].require.list_item_controll.add.name, _ConfigS[index].require.list_item_controll.add.count)
                            end
                        else
                            xPlayer.addInventoryItem(_ConfigS[index].require.list_item_controll.add.name, _ConfigS[index].require.list_item_controll.add.count)        
                        end
                    else
                        xPlayer.showNotification(Lang["no_weight"])
                    end
                else
                    if _ConfigS[index].require.list_item_controll.remove.enable then
                        local item = xPlayer.getInventoryItem(_ConfigS[index].require.list_item_controll.remove.name)
                        if item and item.count >= _ConfigS[index].require.list_item_controll.remove.count then    
                            xPlayer.removeInventoryItem(_ConfigS[index].require.list_item_controll.remove.name, _ConfigS[index].require.list_item_controll.remove.count)
                        end        
                    end
                end
            end
        end
    end
end)