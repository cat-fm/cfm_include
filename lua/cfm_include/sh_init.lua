CFM = CFM or {}
CFM.Include = CFM.Include or {}

function CFM.Include.AddDirectory( sDir, sPath, sSorting, bRecursive )
  local files, dirs = file.Find( sDir, sPath, sSorting )

  local _dir = string.Explode( "/", sDir )
  sDir = table.remove( _dir, #_dir - 1 )

  if #files > 0 then
    for _, fileName in ipairs( files ) do
      if string.sub( fileName, #fileName - 3, #fileName ) ~= "lua" then goto nope end

      local state = string.sub( fileName, 1, 3 )

      if state == "sv_" then
        include( sDir .. fileName )
      end

      if state == "cl_" then
        if SERVER then
          AddCSLuaFile( sDir .. fileName )
        end

        if CLIENT then
          include( sDir .. fileName )
        end
      end

      if state == "sh_" then
        if SERVER then
          AddCSLuaFile( sDir .. fileName )
          include( sDir .. fileName )
        end

        include( sDir .. fileName )
      end

      ::nope::
    end
  end

  if bRecursive and #dirs > 0 then
    for _, dirName in ipairs( dirs ) do
      CFM.Include.AddDirectory( sDir .. dirName, sPath )
    end
  end
end