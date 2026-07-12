return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()

    local window = SolarisLib:New({
        Name = "Titanium",
        FolderToSave = "Titanium_Settings"
    })

    local mainTab = window:Tab("Main")

    local FarmSection = mainTab:Section("Farm")

    FarmSection:Toggle("Auto Farm", false, "Farm", function(t)
        if t then
            getgenv().AutoFarm = true
            while getgenv().AutoFarm do
                task.wait()
                pcall(function()
                    char:Goto()
                end)
            end
        else
            getgenv().AutoFarm = false
        end
        
    end)

    local CarSection = mainTab:Section("Cars")

    local carLabelList = {}

    pcall(function()
        if workspace:FindFirstChild("SpawnedCars") then
            while task.wait(1) do
                for i,v in pairs(workspace:FindFirstChild("SpawnedCars"):GetChildren()) do
                    if v:FindFirstChild("nameEffect") then
                        if carLabelList[i] then
                            carLabelList[i]:Set(v.nameEffect.PartName.NameLabel.Text .. " | " .. v.nameEffect.Rarity.Text .. " | " .. v.nameEffect.Cost.Text)
                        else
                            local newLabel = CarSection:Label(v.nameEffect.PartName.NameLabel.Text .. " | " .. v.nameEffect.Rarity.Text .. " | " .. v.nameEffect.Cost.Text)
                            table.insert(carLabelList, newLabel)
                        end
                    end
                end
            end
        end
    end)

    return window
end