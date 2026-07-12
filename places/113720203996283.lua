return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    local RarityIcons = {
        ["Hacker"] = "🦕",
        ["Exclusive"] = "💎",
        ["Secret"] = "👑",
        ["Godly"] = "✨",
    }

    local window = SolarisLib:New({
        Name = "Titanium",
        FolderToSave = "Titanium_Settings"
    })

    local mainTab = window:Tab("Main")

    local MainS = mainTab:Section("Main")

    MainS:Toggle("Auto Farm", false, "Farm", function(t)
        if t then
            getgenv().AutoFarm = true
            while getgenv().AutoFarm do
                task.wait()
                pcall(function()
                    local cars = {}

                    for i,v in pairs(workspace:FindFirstChild("SpawnedCars"):GetChildren()) do
                        table.insert(cars, v)
                    end

                    for i,v in pairs(cars) do
                        
                    end
                end)
            end
        else
            getgenv().AutoFarm = false
        end

    end)

    MainS:Toggle("Auto Collects", false, "AutoCollectCoins", function(t)
        if t then
            getgenv().AutoCollectCoins = true
            while getgenv().AutoCollectCoins do
                task.wait()
                pcall(function()
                    for i,v in pairs(workspace:FindFirstChild("Coins"):GetChildren()) do
                        if v:IsA("MeshPart") then
                            v.CFrame = char.HumanoidRootPart.CFrame
                        end
                    end
                end)
            end
        else
            getgenv().AutoCollectCoins = false
        end

    end)

    MainS:Toggle("Remove All Obstacles (Include Humps)", false, "RemoveAllObstacles", function(t)
        if t then
            getgenv().RemoveAllObstacles = true
            while getgenv().RemoveAllObstacles do
                task.wait()
                pcall(function()
                    for i,v in pairs(workspace:FindFirstChild("Obstacles"):GetDescendants()) do
                        if v:IsA("Model") then
                            v:Destroy()
                        end
                    end

                    for i,v in pairs(workspace:FindFirstChild("Stages"):GetDescendants()) do
                        if v.Name == "OBSTACLES" then
                            v:Destroy()
                        end

                        if v.Name == "Humps" then
                            v:Destroy()
                        end
                    end
                end)
            end
        else
            getgenv().RemoveAllObstacles = false
        end

    end)

    local CarSection = mainTab:Section("Cars")

    local carLabelList = {}

    pcall(function()
		if workspace:FindFirstChild("SpawnedCars") then
			workspace:FindFirstChild("SpawnedCars").ChildAdded:Connect(function(car)
				local nameEffect = car:WaitForChild("nameEffect", 10)
				local nameLabel = nameEffect:WaitForChild("PartName", 10).NameLabel
				local rarityName = nameEffect:WaitForChild("Rarity", 10).Text
				local rarityIcon = RarityIcons[rarityName]
				local cost = nameEffect.Cost
				local carText

				if rarityIcon then
					carText = string.format(
						"%s | %s %s | %s",
						nameLabel.Text,
						rarityIcon,
						rarityName,
						cost.Text
					)
				else
					carText = string.format(
						"%s | %s | %s",
						nameLabel.Text,
						rarityName,
						cost.Text
					)
				end

				local butn = CarSection:Button(carText, function()
					char:MoveTo(car.WorldPivot.Position)
				end)

				carLabelList[car] = butn
			end)

			workspace:FindFirstChild("SpawnedCars").ChildRemoved:Connect(function(car)
				carLabelList[car]:Destroy()
			end)
		end
	end)

    return window
end