return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local window = SolarisLib:New({
        Name = "내 GUI",
        FolderToSave = "SolarisSettings"
    })

    local mainTab = window:Tab("메인")
    local mainSection = mainTab:Section("기능")

    mainSection:Button("테스트 버튼", function()
        print("버튼을 눌렀습니다.")
    end)

    mainSection:Toggle(
        "기능 활성화",
        false,
        "FeatureToggle",
        function(enabled)
            print("토글 상태:", enabled)
        end
    )

    mainSection:Slider(
        "속도",
        0,
        100,
        25,
        1,
        "SpeedSlider",
        function(value)
            print("속도:", value)
        end
    )

    mainSection:Dropdown(
        "항목 선택",
        {"첫 번째", "두 번째", "세 번째"},
        "첫 번째",
        "ItemDropdown",
        function(selected)
            print("선택:", selected)
        end
    )

    mainSection:Textbox("글자 입력", true, function(text)
        print("입력:", text)
    end)

    mainSection:Bind(
        "단축키",
        Enum.KeyCode.F,
        false,
        "TestBind",
        function()
            print("F 키가 눌렸습니다.")
        end
    )

    mainSection:Label("SolarisLib 정상 로드")
end