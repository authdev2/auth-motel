fx_version 'cerulean'
game 'gta5'

lua54'yes'

ox_lib 'locale'

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
  'client/*.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua',

}