local place = tostring(game.PlaceId)

local url = "https://raw.githubusercontent.com/username/repository/branch/" .. filePath

local function load(args)
    print("Checking Place: " .. place)
    print("Checking File..")

    local source = readfile(file)
    local chunk, compileError = loadstring()

    if not isfile(filePath) then
        print("File not found.")
    else
        print("File found.")
    end
end

return load()