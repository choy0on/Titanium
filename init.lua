local place = tostring(game.PlaceId)

local url = string.format(
	"https://raw.githubusercontent.com/choy0on/Titanium/refs/heads/main/places/%s.lua", 
	place
)

local function load(args)
	print("Checking Place: " .. place)
	print("Checking File..")

	local req, source = pcall(function()
		return game:HttpGet(url)
	end)

	local chunk, compileError = loadstring(source, "@" .. url)

	if req then
		if chunk then
			local success, result = xpcall(chunk, debug.traceback)

			if not success then
				print("Failed")
			end

			return true, result
		end
	else
		print("Failed")
	end
end

return load()