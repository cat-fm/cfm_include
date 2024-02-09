if SERVER then
  AddCSLuaFile( "cfm_include/sh_init.lua" )
  include( "cfm_include/sh_init.lua" )
end

if CLIENT then
  include( "cfm_include/sh_init.lua" )
end