--[[ Fx info ]]--
fx_version  'adamant'
game  'gta5'
lua54 'yes'

--[[ Autor info ]]--
author 'NaLajcie Store | NaLajcie'
description 'Notepad'
version '2.0.0'

--[[ Manifest ]]--
client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

shared_scripts {
  'config.lua',
  '@ox_lib/init.lua'
}

files {
  'locales/*.json'
}

dependencies {
  'ox_lib',
  'ox_inventory',
}
