ESX = exports["es_extended"]:getSharedObject()
lib.locale()

RegisterNetEvent('nalajcie_notepad:newNote', function(text, imageUrl, password, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    local description = ""

    if password and password ~= "" then
        description = locale('note_encrypted')
    elseif text and text ~= "" then
        description = locale('note_with_text')
    else
        description = locale('note_empty')
    end

    if string.len(text) > Config.Setting.maxNoteLength then
        TriggerClientEvent('nalajcie_notepad:Notification', source, 'error', locale('notifytitle'), locale('note_exceeds_length'))
        return
    end

    quantity = tonumber(quantity) or 1 

    if quantity > 0 then
        xPlayer.addInventoryItem(Config.Setting.sheetItem, quantity, {
            text = text,
            imageUrl = imageUrl,
            password = password,
            description = description
        })
    end
end)
