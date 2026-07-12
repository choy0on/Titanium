return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local window = SolarisLib:New({
        Name = "Titanium",
        FolderToSave = "Titanium_Settings"
    })

    local mainTab = window:Tab("Main")
    local mainSection = mainTab:Section("Cars")

    local carLabelList = {}

    pcall(function()
        if workspace:FindFirstChild("SpawnedCars") then
            while task.wait(1) do
                for i,v in pairs(workspace:FindFirstChild("SpawnedCars"):GetChildren()) do
                    if v:FindFirstChild("nameEffect") then
                        if carLabelList[i] then
                            carLabelList[i]:Set(v.nameEffect.PartName.NameLabel.Text .. "|" .. v.nameEffect.Rarity.Text .. " | " .. v.nameEffect.Cost.Text)
                        else
                            local newLabel = mainSection:Label(v.nameEffect.PartName.NameLabel.Text .. "|" .. v.nameEffect.Rarity.Text .. " | " .. v.nameEffect.Cost.Text)
                            table.insert(carLabelList, newLabel)
                        end
                    end
                end
            end
        end
    end)

    return window
end