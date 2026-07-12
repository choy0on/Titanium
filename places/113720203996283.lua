return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local window = SolarisLib:New({
        Name = "Titanium",
        FolderToSave = "Titanium_Settings"
    })

    local mainTab = window:Tab("Main")
    local mainSection = mainTab:Section("Now Cars")

    local carLabelList = {}

    pcall(function()
        if workspace:FindFirstChild("SpawnedCars") then
            while task.wait(1) do
                print(carLabelList)
                for i,v in pairs(workspace:FindFirstChild("SpawnedCars"):GetChildren()) do
                    if v:FindFirstChild("nameEffect") then
                        if carLabelList[i] then
                            carLabelList[i]:Set(v.nameEffect.PartName.NameLabel.Text)
                        else
                            local newLabel = mainSection:Label(v.nameEffect.PartName.NameLabel.Text)
                            table.insert(carLabelList, newLabel)
                        end
                    end
                end
            end
        end
    end)

    return window
end