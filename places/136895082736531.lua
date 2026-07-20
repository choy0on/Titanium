return function()
    local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/choy0on/Solaris/main/Source.lua"))()

    local Players = game:GetService("Players")
    local plr = Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    local pick = false

    local window = SolarisLib:New({
        Name = "Titanium",
        FolderToSave = "Titanium_Settings"
    })

    local mainTab = window:Tab("Main")

    local MainS = mainTab:Section("Main")

    workspace.Saws.Saws:GetChildren()[7].Use.UsePP.MaxActivationDistance = math.huge

    local function changePickaxe(boa : boolean)
        local Event = game:GetService("ReplicatedStorage").KickStone
        Event:InvokeServer(
            boa
        )

        local Event = game:GetService("ReplicatedStorage").KickStone
        local Result = table.pack(Event:InvokeServer(
            boa
        ))
    end

    local function getBricks()
        char:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(67.9050064, 9.09399891, 0.393019259, 0.999986172, -1.56038771e-09, -0.00526221981, 1.0361586e-09, 1, -9.96240104e-08, 0.00526221981, 9.9617175e-08, 0.999986172)

        if not char:FindFirstChild("Pickaxe") then
            plr.Backpack:FindFirstChild("Pickaxe", true).Parent = char
        end

        repeat
            changePickaxe(true)
            task.wait(0.1)
        until getgenv().AutoFarm == false or pick == false
    end

    local function placesAllBricks()
        local t = game:GetService("ReplicatedStorage").Place

        repeat
            local base = workspace.Floors:FindFirstChild("Base")

            print(base)

            for _,v in pairs(base.Example:GetChildren()) do
                task.spawn(function()
                    t:InvokeServer(
                        v
                    )
                end)
            end

            task.wait(0.1)
        until math.floor(plr:FindFirstChild("Bricks").Value) <= 0

        getBricks()
    end

    MainS:Toggle("Auto Farm", false, "Farm", function(t)
        if t then
            getgenv().AutoFarm = true

            local point = workspace:FindFirstChild("Stone"):FindFirstChild("Point")

            if point ~= nil then
                getBricks()
            end

            while getgenv().AutoFarm do
                task.wait()
                pcall(function()
                end)
            end
        else
            getgenv().AutoFarm = false
        end
    end)

    local Event = game:GetService("ReplicatedStorage").Message
    local Callback = getcallbackvalue(Event, "OnClientInvoke")
    Event.OnClientInvoke = function(...)
        local Args = table.pack(...)

        if getgenv().AutoFarm and Args[1] == "🎒Your backpack is full!💯" then
            if plr:FindFirstChild("Bricks").Value == plr:FindFirstChild("Limits"):GetAttribute("Backpack") then
                char:MoveTo(workspace.Floors.Base:GetPivot().Position)
            end

            pick = false
            changePickaxe(false)

            char:MoveTo(workspace.Saws.Saws:GetChildren()[7].Use.Position)

            task.wait(0.5)
            
            workspace.Saws.Saws:GetChildren()[7].Use.UsePP:InputHoldBegin()
            
            repeat 
                task.wait()
            until plr:FindFirstChild("Stones").Value == 0

            workspace.Saws.Saws:GetChildren()[7].Use.UsePP:InputHoldEnd()

            char:MoveTo(workspace.Floors.Base:GetPivot().Position)

            placesAllBricks()
        end

        local Result = table.pack(
            Callback(table.unpack(Args, 1, Args.n))
        )

        return table.unpack(Result, 1, Result.n)
    end
    return window
end