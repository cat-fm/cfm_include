CFMInclude = CFMInclude or {}
CFMInclude.Version = "10/02/2024"

function CFMInclude.AddFile( sFileName )
  local state = string.sub( sFileName, 1, 3 )

  if state == "sv_" then
    include( sFileName )
  end

  if state == "cl_" then
    if SERVER then
      AddCSLuaFile( sFileName )
    end

    if CLIENT then
      include( sFileName )
    end
  end

  if state == "sh_" then
    if SERVER then
      AddCSLuaFile( sFileName )
      include( sFileName )
    end

    include( sFileName )
  end
end

function CFMInclude.AddDirectory( sDir, sSorting, bRecursive )
  if string.Right( sDir, 1 ) ~= "/" then sDir = sDir .. "/" end

  local files, dirs = file.Find( sDir .. "*", "LUA", sSorting )

  if #files > 0 then
    for _, fileName in ipairs( files ) do
      CFMInclude.AddFile( sDir .. fileName )
    end
  end

  if bRecursive and #dirs > 0 then
    for _, dirName in ipairs( dirs ) do
      CFMInclude.AddDirectory( sDir .. dirName, sSorting, bRecursive )
    end
  end
end
