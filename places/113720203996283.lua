return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local window = SolarisLib:New({
        Name = "Titanium",
        FolderToSave = "Titanium_Settings"
    })

    local mainTab = window:Tab("Main")
    local mainSection = mainTab:Section("Now Cars")

    local dropdown = mainSection:Dropdown("Dropdown", {"a","b","c","d","e"},"","Dropdown", function(t)
        
    end)

    pcall(function()
        while task.wait(1) do
            
            local carList = {}

            for i,v in pairs(workspace:FindFirstChild("SpawnedCars"):GetChildren()) do
                if v:FindFirstChild("nameEffect") then
                    table.insert(carList, v:FindFirstChild("nameEffect"):FindFirstChild("PartName"):findFirstChild("NameLabel").Text .. " / " .. v:FindFirstChild("nameEffect"):findFirstChild("Cost").Text)
                end
            end

            dropdown:Refresh(carList, true)
        end
    end)

    return window
end