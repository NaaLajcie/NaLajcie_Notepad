Config = {}

Config.Setting = {
    sheetItem = 'notepad_sheet',
    maxNoteQuantity = 5,  -- Maximum number of copies of notes
    maxNoteLength = 10,  -- Maximum note length
    allowedImageLinks = {  -- Image links allowed
        "^https://imgur.com/",
        "^https://cdn.discordapp.com/",
    },
    imageDimensions = {  -- Maximum image dimensions
        maxWidth = 1920,
        maxHeight = 1080,
    },
    WritingAnim = {      -- Animation of writing a note
        lib = "missheistdockssetup1clipboard@base",
        anim = "base",
        mode = 49,
        prop = {
            bone = 18905, 
            object = "prop_notepad_01", 
            offset = {x = 0.1, y = 0.02, z = 0.05}, 
            rotation = {x = 10.0, y = 0.0, z = 0.0}
        }
    },
    ReadAnim = {  -- Animation of reading a note
        lib = "missheistdockssetup1clipboard@base",
        anim = "base",
        mode = 49,
        prop = {
            bone = 18905, 
            object = "prop_notepad_01", 
            offset = {x = 0.1, y = 0.02, z = 0.05}, 
            rotation = {x = 10.0, y = 0.0, z = 0.0}
        }
    }
}

RegisterNetEvent('nalajcie_notepad:Notification')
AddEventHandler('nalajcie_notepad:Notification', function(type, title, text)
    if type == "error" then
        lib.notify({
            title = title,
            description = text,
            type = "error",
            position = 'center-right',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'flag',
            iconColor = '#C53030',
            iconAnimation = 'bounce'
        })
    elseif type == "success" then
        lib.notify({
            title = title,
            description = text,
            type = "success",
            position = 'center-right',
            style = {
                backgroundColor = '#141517',
                color = '#909296'
            },
            icon = 'flag',
            iconColor = '#30c537',
            iconAnimation = 'bounce'
        })
    end
end)