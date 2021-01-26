addFiles = (dir) ->
    files, dirs = file.Find dir .. "/*", "LUA"
    return unless files

    for v in *files
        AddCSLuaFile dir .. "/" .. v if string.match v, "^.+%.lua$"

    [addFiles dir .. "/" .. v for v in *dirs]

addFiles "cfc_gm_options"

AddCSLuaFile "includes/modules/cfc_gm_options.lua"
include "cfc_gm_options/base.lua"
