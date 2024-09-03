ESX = exports["es_extended"]:getSharedObject()
lib.locale()

RegisterNetEvent('nalajcie_notepad:openNotepad', function()
    local ped = PlayerPedId()
    local animDict = Config.Setting.WritingAnim.lib
    local animName = Config.Setting.WritingAnim.anim

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, Config.Setting.WritingAnim.mode, 0, false, false, false)
    
    local prop = CreateObject(GetHashKey(Config.Setting.WritingAnim.prop.object), 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, Config.Setting.WritingAnim.prop.bone), Config.Setting.WritingAnim.prop.offset.x, Config.Setting.WritingAnim.prop.offset.y, Config.Setting.WritingAnim.prop.offset.z, Config.Setting.WritingAnim.prop.rotation.x, Config.Setting.WritingAnim.prop.rotation.y, Config.Setting.WritingAnim.prop.rotation.z, true, true, false, true, 1, true)
    
    local input = lib.inputDialog(locale('createnote_title'), {
        {type = 'input', description = locale('createnote_text_description'), icon = 'edit', required = true},
        {type = 'input', description = locale('createnote_image_description'), icon = 'image'},
        {type = 'input', description = locale('createnote_password_description'), icon = 'lock'},
        {type = 'slider', label = locale('note_quantity_label'), icon = 'arrows-alt', required = true, default = 1, min = 1, max = Config.Setting.maxNoteQuantity, step = 1},
        {type = 'checkbox', label = locale('createnote_save_checkbox'), required = true},
    })

    ClearPedTasks(ped)
    DeleteObject(prop)

    if input then
        local text = input[1]
        local imageUrl = input[2]
        local password = input[3]
        local quantity = input[4]
        local saveNote = input[5]

        if imageUrl and imageUrl ~= "" and not isImageLinkAllowed(imageUrl) then
            TriggerEvent('nalajcie_notepad:Notification', 'error', locale('notifytitle'), locale('invalid_image_url_message'))
            return
        end

        if saveNote then
            TriggerServerEvent('nalajcie_notepad:newNote', text, imageUrl, password, quantity)
        end
    end
end)

RegisterNetEvent('nalajcie_notepad:openread', function(item)
    local metadata = ESX.GetPlayerData().inventory[item.slot].metadata
    local ped = PlayerPedId()
    local textRead = metadata.text or ""
    local imageUrl = metadata.imageUrl or ""
    local password = metadata.password or ""

    local animDict = Config.Setting.ReadAnim.lib
    local animName = Config.Setting.ReadAnim.anim

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, Config.Setting.ReadAnim.mode, 0, false, false, false)

    local prop = CreateObject(GetHashKey(Config.Setting.ReadAnim.prop.object), 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, Config.Setting.ReadAnim.prop.bone), Config.Setting.ReadAnim.prop.offset.x, Config.Setting.ReadAnim.prop.offset.y, Config.Setting.ReadAnim.prop.offset.z, Config.Setting.ReadAnim.prop.rotation.x, Config.Setting.ReadAnim.prop.rotation.y, Config.Setting.ReadAnim.prop.rotation.z, true, true, false, true, 1, true)

    if password and password ~= "" then
        local enteredPassword = lib.inputDialog(locale('enter_password_title'), {{type = 'input', description = locale('enter_password_description'), icon = 'lock'}})
        if not enteredPassword or enteredPassword[1] ~= password then
            ClearPedTasks(ped)
            DeleteObject(prop)
            TriggerEvent('nalajcie_notepad:Notification', 'error', locale('notifytitle'), locale('access_denied_message'))
            return
        end
    end

    local content = textRead
    if imageUrl and imageUrl ~= "" then
        content = content .. '\n![Image](' .. imageUrl .. ')'
    end

    lib.alertDialog({
        header = locale('read_note_title'),
        content = content,
        centered = true,
    })

    ClearPedTasks(ped)
    DeleteObject(prop)
end)

function isImageLinkAllowed(url)
    for _, pattern in ipairs(Config.Setting.allowedImageLinks) do
        if string.match(url, pattern) then
            return true
        end
    end
    return false
end