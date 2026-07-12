local placeId = tostring(game.PlaceId)

local url = string.format(
	"https://raw.githubusercontent.com/choy0on/Titanium/main/places/%s.lua",
	placeId
)

local function traceback(errorMessage)
	if debug and debug.traceback then
		return debug.traceback(errorMessage)
	end

	return tostring(errorMessage)
end

local function loadPlace()
	print("Checking Place:", placeId)
	print("Checking URL:", url)

	local requestSuccess, source = pcall(function()
		return game:HttpGet(url)
	end)

	if not requestSuccess then
		warn("지원하지 않는 Place이거나 파일 요청에 실패했습니다.")
		warn(source)
		return false
	end

	local chunk, compileError = loadstring(source, "@" .. url)

	if not chunk then
		warn("컴파일 오류:")
		warn(compileError)
		return false
	end

	-- Place 파일 실행
	local chunkSuccess, exported = xpcall(chunk, traceback)

	if not chunkSuccess then
		warn("Place 파일 로드 오류:")
		warn(exported)
		return false
	end

	-- Place 파일이 함수를 반환했다면 그 함수까지 실행
	if type(exported) == "function" then
		local runSuccess, result = xpcall(exported, traceback)

		if not runSuccess then
			warn("Place 스크립트 실행 오류:")
			warn(result)
			return false
		end

		print("Place Script Loaded:", placeId)
		return true, result
	end

	print("Place Script Loaded:", placeId)
	return true, exported
end

return loadPlace()