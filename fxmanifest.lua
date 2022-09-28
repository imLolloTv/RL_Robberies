fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
author '! Lollo#0363'

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua', 
}

shared_scripts {
    'config.lua',
    '@es_extended/imports.lua',
}

dependecies {
    'es_extended',
    'rprogress', -- Need for Minigame and Timer
    'gridsystem', -- Need for markers
}