local placeId = tostring(game.PlaceId)

local url = string.format(
	"https://raw.githubusercontent.com/choy0on/Titanium/main/places/%s.lua",
	placeId
)

local function loadPlace()
	print("Checking Place:", placeId)
	print("Checking URL:", url)

	-- 파일 다운로드
	local requestSuccess, source = pcall(function()
		return game:HttpGet(url)
	end)

	if not requestSuccess then
		warn("Place 파일을 찾지 못했습니다:", placeId)
		warn("요청 오류:", source)
		return false
	end

	if type(source) ~= "string" or source == "" then
		warn("가져온 파일 내용이 비어 있습니다.")
		return false
	end

	-- Lua 코드 컴파일
	local chunk, compileError = loadstring(source)

	if not chunk then
		warn("컴파일 오류:", compileError)
		return false
	end

	-- 코드 실행
	local runSuccess, result = xpcall(
		chunk,
		function(errorMessage)
			if debug and debug.traceback then
				return debug.traceback(errorMessage)
			end

			return tostring(errorMessage)
		end
	)

	if not runSuccess then
		warn("Place 스크립트 실행 오류:")
		warn(result)
		return false
	end

	print("Place Script Loaded:", placeId)
	return true, result
end

return loadPlace()