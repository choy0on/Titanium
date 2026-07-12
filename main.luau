local place = tostring(game.PlaceId)
local filePath = place .. ".lua"

local function load(args)
    print("Checking Place: " .. place)
    print("Checking File..")

    if not isfile(filePath) then
        print("File not found.")
    else
        print("File found.")
    end
end

return load()