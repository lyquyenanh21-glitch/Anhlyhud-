loadstring(game:HttpGet("https://pastefy.app/u7zx5IIq/raw"))()
-- ==========================================
-- AUTO FARM LEVEL - FLY QUANH QUÁI NÉ SKILL
-- ==========================================
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnhLyFarm_UI"
ScreenGui.Parent = PlayerGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "⚡"
ToggleButton.TextSize = 28
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 200)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(220, 20, 90)
TitleBar.Text = "⚡ Auto Farm Level (Fly)"
TitleBar.TextColor3 = Color3.new(1,1,1)
TitleBar.TextSize = 15
TitleBar.Parent = MainFrame

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

local function AddToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 35)
    frame.Position = UDim2.new(0, 10, 0, #Content:GetChildren() * 40 + 10)
    frame.BackgroundTransparency = 1
    frame.Parent = Content
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Text = text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 25)
    btn.Position = UDim2.new(1, -55, 0, 5)
    btn.Text = default and "ON" or "OFF"
    btn.BackgroundColor3 = default and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = frame
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
        if callback then pcall(callback, state) end
    end)
    
    return {SetState = function(_, v) state = v; btn.Text = v and "ON" or "OFF"; btn.BackgroundColor3 = v and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0); if callback then pcall(callback, v) end end}
end

local function AddWeaponDropdown()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 60)
    frame.Position = UDim2.new(0, 10, 0, #Content:GetChildren() * 40 + 10)
    frame.BackgroundTransparency = 1
    frame.Parent = Content
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = "Chọn Vũ Khí"
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, 22)
    btn.Text = "Melee"
    btn.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Parent = frame
    
    local values = {"Melee", "Sword", "Blox Fruit"}
    local selected = "Melee"
    btn.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 120, 0, #values * 25)
        menu.BackgroundColor3 = Color3.fromRGB(50,50,50)
        menu.Position = UDim2.new(0, btn.AbsolutePosition.X, 0, btn.AbsolutePosition.Y + 30)
        menu.Parent = ScreenGui
        for i, val in ipairs(values) do
            local opt = Instance.new("TextButton")
            opt.Size = UDim2.new(1, 0, 0, 25)
            opt.Text = val
            opt.BackgroundColor3 = Color3.fromRGB(80,80,80)
            opt.TextColor3 = Color3.new(1,1,1)
            opt.Parent = menu
            opt.MouseButton1Click:Connect(function()
                selected = val
                btn.Text = val
                menu:Destroy()
            end)
        end
        game:GetService("Debris"):AddItem(menu, 10)
    end)
    
    return {GetValue = function() return selected end}
end

local farmToggle = AddToggle("🔥 Auto Farm Level", false, function(v) _G.AutoLevel = v end)
local weaponDD = AddWeaponDropdown()

ToggleButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local dragging = false
local dragStart, frameStart
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        frameStart = MainFrame.Position
    end
end)
MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
    end
end)

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 200
local bodyVelocity = nil

local function SetNoclip(enable)
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not enable
        end
    end
end

local function FlyTo(pos)
    if not hrp then return false end
    if not flying then
        flying = true
        SetNoclip(true)
        hum.PlatformStand = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1,1,1) * 1e6
        bodyVelocity.Parent = hrp
    end
    local dist = (pos - hrp.Position).Magnitude
    if dist < 10 then
        if bodyVelocity then bodyVelocity.Velocity = Vector3.new(0,0,0) end
        return true
    end
    local dir = (pos - hrp.Position).Unit
    local speed = math.min(flySpeed, dist)
    if dist > 500 then speed = flySpeed end
    bodyVelocity.Velocity = dir * speed
    return false
end

local function StopFly()
    if bodyVelocity then bodyVelocity:Destroy() end
    bodyVelocity = nil
    flying = false
    hum.PlatformStand = false
    SetNoclip(false)
end

local ChooseWeapon = "Melee"
local SelectWeapon = ""
local circleAngle = 0
local circleRadius = 20
local circleHeight = 25

spawn(function()
    while wait() do
        if weaponDD and weaponDD.GetValue then ChooseWeapon = weaponDD.GetValue() end
        pcall(function()
            local sources = {plr.Backpack}
            if plr.Character then table.insert(sources, plr.Character) end
            for _, src in pairs(sources) do
                for _, t in pairs(src:GetChildren()) do
                    if t:IsA("Tool") then
                        if ChooseWeapon == "Blox Fruit" and t.ToolTip == "Blox Fruit" then SelectWeapon = t.Name
                        elseif ChooseWeapon == "Sword" and t.ToolTip == "Sword" then SelectWeapon = t.Name
                        elseif ChooseWeapon == "Melee" and t.ToolTip == "Melee" then SelectWeapon = t.Name end
                    end
                end
            end
        end)
    end
end)

function AutoHaki()
    if not plr.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function EquipTool(name)
    if plr.Backpack:FindFirstChild(name) then
        plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(name))
    end
end

function AttackNoCoolDown()
    local tool = plr.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("LeftClickRemote") then
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                local dir = (v.HumanoidRootPart.Position - plr.Character:GetPivot().Position).Unit
                pcall(function() tool.LeftClickRemote:FireServer(dir, 1) end)
            end
        end
    end
end

local flyAroundMob = false
local currentMobPos = nil

local function FlyAroundMob(mobPos)
    if not mobPos then return end
    currentMobPos = mobPos
    
    circleAngle = circleAngle + 0.35
    if circleAngle > 360 then circleAngle = 0 end
    
    local rad = math.rad(circleAngle)
    local x = math.cos(rad) * circleRadius
    local z = math.sin(rad) * circleRadius
    local yOffset = math.sin(circleAngle * 2) * 6
    local newPos = mobPos + Vector3.new(x, circleHeight + yOffset, z)
    
    if not flying then
        flying = true
        SetNoclip(true)
        hum.PlatformStand = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1,1,1) * 1e6
        bodyVelocity.Parent = hrp
    end
    
    local dir = (newPos - hrp.Position).Unit
    bodyVelocity.Velocity = dir * 140
end

local function StopFlyAround()
    flyAroundMob = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    flying = false
    hum.PlatformStand = false
    SetNoclip(false)
end

local Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon

function CheckLevel()
    local lvl = plr.Data.Level.Value
    
    -- SEA 1
    if lvl <= 9 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Bandit", "BanditQuest1", 1, "Bandit", CFrame.new(1060.938, 16.455, 1547.784), CFrame.new(1038.553, 41.296, 1576.509)
    elseif lvl <= 14 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Monkey", "JungleQuest", 1, "Monkey", CFrame.new(-1601.655, 36.852, 153.388), CFrame.new(-1448.144, 50.851, 63.607)
    elseif lvl <= 29 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Gorilla", "JungleQuest", 2, "Gorilla", CFrame.new(-1601.655, 36.852, 153.388), CFrame.new(-1142.648, 40.462, -515.392)
    elseif lvl <= 39 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Pirate", "BuggyQuest1", 1, "Pirate", CFrame.new(-1140.176, 4.752, 3827.405), CFrame.new(-1201.088, 40.628, 3857.596)
    elseif lvl <= 59 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Brute", "BuggyQuest1", 2, "Brute", CFrame.new(-1140.176, 4.752, 3827.405), CFrame.new(-1387.532, 24.592, 4100.957)
    elseif lvl <= 74 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Desert Bandit", "DesertQuest", 1, "Desert Bandit", CFrame.new(896.517, 6.438, 4390.149), CFrame.new(984.998, 16.109, 4417.910)
    elseif lvl <= 89 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Desert Officer", "DesertQuest", 2, "Desert Officer", CFrame.new(896.517, 6.438, 4390.149), CFrame.new(1547.151, 14.452, 4381.800)
    elseif lvl <= 99 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Snow Bandit", "SnowQuest", 1, "Snow Bandit", CFrame.new(1386.807, 87.272, -1298.357), CFrame.new(1356.302, 105.768, -1328.241)
    elseif lvl <= 119 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Snowman", "SnowQuest", 2, "Snowman", CFrame.new(1386.807, 87.272, -1298.357), CFrame.new(1218.795, 138.011, -1488.026)
    elseif lvl <= 149 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Chief Petty Officer", "MarineQuest2", 1, "Chief Petty Officer", CFrame.new(-5035.496, 28.677, 4324.184), CFrame.new(-4931.155, 65.793, 4121.839)
    elseif lvl <= 174 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Sky Bandit", "SkyQuest", 1, "Sky Bandit", CFrame.new(-4842.137, 717.695, -2623.048), CFrame.new(-4955.641, 365.463, -2908.186)
    elseif lvl <= 189 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Dark Master", "SkyQuest", 2, "Dark Master", CFrame.new(-4842.137, 717.695, -2623.048), CFrame.new(-5148.165, 439.045, -2332.961)
    elseif lvl <= 209 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Prisoner", "PrisonerQuest", 1, "Prisoner", CFrame.new(5310.605, 0.350, 474.946), CFrame.new(4937.318, 0.332, 649.574)
    elseif lvl <= 249 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Dangerous Prisoner", "PrisonerQuest", 2, "Dangerous Prisoner", CFrame.new(5310.605, 0.350, 474.946), CFrame.new(5099.662, 0.351, 1055.758)
    elseif lvl <= 274 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Toga Warrior", "ColosseumQuest", 1, "Toga Warrior", CFrame.new(-1577.789, 7.415, -2984.483), CFrame.new(-1872.516, 49.080, -2913.810)
    elseif lvl <= 299 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Gladiator", "ColosseumQuest", 2, "Gladiator", CFrame.new(-1577.789, 7.415, -2984.483), CFrame.new(-1521.374, 81.203, -3066.313)
    elseif lvl <= 324 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Military Soldier", "MagmaQuest", 1, "Military Soldier", CFrame.new(-5316.115, 12.262, 8517.003), CFrame.new(-5369.000, 61.243, 8556.492)
    elseif lvl <= 374 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Military Spy", "MagmaQuest", 2, "Military Spy", CFrame.new(-5316.115, 12.262, 8517.003), CFrame.new(-5787.002, 75.826, 8651.699)
    elseif lvl <= 399 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Fishman Warrior", "FishmanQuest", 1, "Fishman Warrior", CFrame.new(61122.652, 18.497, 1569.399), CFrame.new(60844.105, 98.462, 1298.398)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.851, 11.679, 1819.784)) end)
    elseif lvl <= 449 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Fishman Commando", "FishmanQuest", 2, "Fishman Commando", CFrame.new(61122.652, 18.497, 1569.399), CFrame.new(61738.398, 64.207, 1433.837)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.851, 11.679, 1819.784)) end)
    elseif lvl <= 474 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "God's Guard", "SkyExp1Quest", 1, "God's Guard", CFrame.new(-4721.860, 845.302, -1953.848), CFrame.new(-4628.049, 866.928, -1931.235)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.822, 872.542, -1667.556)) end)
    elseif lvl <= 524 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Shanda", "SkyExp1Quest", 2, "Shanda", CFrame.new(-7863.159, 5545.519, -378.422), CFrame.new(-7685.147, 5601.075, -441.388)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.617, 5547.141, -380.291)) end)
    elseif lvl <= 549 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Royal Squad", "SkyExp2Quest", 1, "Royal Squad", CFrame.new(-7903.382, 5635.989, -1410.923), CFrame.new(-7654.251, 5637.107, -1407.755)
    elseif lvl <= 624 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Royal Soldier", "SkyExp2Quest", 2, "Royal Soldier", CFrame.new(-7903.382, 5635.989, -1410.923), CFrame.new(-7760.410, 5679.907, -1884.811)
    elseif lvl <= 649 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Galley Pirate", "FountainQuest", 1, "Galley Pirate", CFrame.new(5258.278, 38.526, 4050.044), CFrame.new(5557.168, 152.327, 3998.775)
    elseif lvl <= 699 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Galley Captain", "FountainQuest", 2, "Galley Captain", CFrame.new(5258.278, 38.526, 4050.044), CFrame.new(5677.677, 92.786, 4966.632)
    
    -- SEA 2
    elseif lvl <= 724 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Raider", "Area1Quest", 1, "Raider", CFrame.new(-427.725, 72.996, 1835.942), CFrame.new(68.874, 93.635, 2429.675)
    elseif lvl <= 774 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Mercenary", "Area1Quest", 2, "Mercenary", CFrame.new(-427.725, 72.996, 1835.942), CFrame.new(-864.850, 122.471, 1453.150)
    elseif lvl <= 799 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Swan Pirate", "Area2Quest", 1, "Swan Pirate", CFrame.new(635.611, 73.096, 917.812), CFrame.new(1065.366, 137.640, 1324.379)
    elseif lvl <= 874 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Factory Staff", "Area2Quest", 2, "Factory Staff", CFrame.new(635.611, 73.096, 917.812), CFrame.new(533.220, 128.468, 355.626)
    elseif lvl <= 899 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Marine Lieutenant", "MarineQuest3", 1, "Marine Lieutenant", CFrame.new(-2440.993, 73.041, -3217.708), CFrame.new(-2489.262, 84.613, -3151.883)
    elseif lvl <= 949 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Marine Captain", "MarineQuest3", 2, "Marine Captain", CFrame.new(-2440.993, 73.041, -3217.708), CFrame.new(-2335.202, 79.786, -3245.867)
    elseif lvl <= 974 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Zombie", "ZombieQuest", 1, "Zombie", CFrame.new(-5494.341, 48.505, -794.590), CFrame.new(-5536.497, 101.085, -835.590)
    elseif lvl <= 999 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Vampire", "ZombieQuest", 2, "Vampire", CFrame.new(-5494.341, 48.505, -794.590), CFrame.new(-5806.109, 16.722, -1164.438)
    elseif lvl <= 1049 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Snow Trooper", "SnowMountainQuest", 1, "Snow Trooper", CFrame.new(607.059, 401.447, -5370.554), CFrame.new(535.210, 432.742, -5484.916)
    elseif lvl <= 1099 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Winter Warrior", "SnowMountainQuest", 2, "Winter Warrior", CFrame.new(607.059, 401.447, -5370.554), CFrame.new(1234.444, 456.954, -5174.130)
    elseif lvl <= 1124 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Lab Subordinate", "IceSideQuest", 1, "Lab Subordinate", CFrame.new(-6061.841, 15.926, -4902.038), CFrame.new(-5720.557, 63.309, -4784.610)
    elseif lvl <= 1174 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Horned Warrior", "IceSideQuest", 2, "Horned Warrior", CFrame.new(-6061.841, 15.926, -4902.038), CFrame.new(-6292.751, 91.181, -5502.649)
    elseif lvl <= 1199 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Magma Ninja", "FireSideQuest", 1, "Magma Ninja", CFrame.new(-5429.047, 15.977, -5297.961), CFrame.new(-5461.838, 130.363, -5836.470)
    elseif lvl <= 1249 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Lava Pirate", "FireSideQuest", 2, "Lava Pirate", CFrame.new(-5429.047, 15.977, -5297.961), CFrame.new(-5251.188, 55.164, -4774.409)
    elseif lvl <= 1274 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Ship Deckhand", "ShipQuest1", 1, "Ship Deckhand", CFrame.new(1040.292, 125.082, 32911.039), CFrame.new(921.123, 125.983, 33088.328)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.212, 126.976, 32852.832)) end)
    elseif lvl <= 1299 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Ship Engineer", "ShipQuest1", 2, "Ship Engineer", CFrame.new(1040.292, 125.082, 32911.039), CFrame.new(886.281, 40.477, 32800.832)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.212, 126.976, 32852.832)) end)
    elseif lvl <= 1324 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Ship Steward", "ShipQuest2", 1, "Ship Steward", CFrame.new(971.420, 125.082, 33245.542), CFrame.new(943.855, 129.581, 33444.367)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.212, 126.976, 32852.832)) end)
    elseif lvl <= 1349 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Ship Officer", "ShipQuest2", 2, "Ship Officer", CFrame.new(971.420, 125.082, 33245.542), CFrame.new(955.384, 181.083, 33331.890)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.212, 126.976, 32852.832)) end)
    elseif lvl <= 1374 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Arctic Warrior", "FrostQuest", 1, "Arctic Warrior", CFrame.new(5668.137, 28.202, -6484.600), CFrame.new(5935.454, 77.260, -6472.756)
        pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-6508.558, 89.034, -132.839)) end)
    elseif lvl <= 1424 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Snow Lurker", "FrostQuest", 2, "Snow Lurker", CFrame.new(5668.137, 28.202, -6484.600), CFrame.new(5628.482, 57.574, -6618.348)
    elseif lvl <= 1449 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Sea Soldier", "ForgottenQuest", 1, "Sea Soldier", CFrame.new(-3054.582, 236.872, -10147.790), CFrame.new(-3185.015, 58.789, -9663.606)
    elseif lvl <= 1499 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Water Fighter", "ForgottenQuest", 2, "Water Fighter", CFrame.new(-3054.582, 236.872, -10147.790), CFrame.new(-3262.930, 298.690, -10552.529)

    -- SEA 3
    elseif lvl <= 1524 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Pirate Millionaire", "PiratePortQuest", 1, "Pirate Millionaire", CFrame.new(-450.104, 107.681, 5950.726), CFrame.new(-193.992, 56.125, 5755.788)
    elseif lvl <= 1574 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Pistol Billionaire", "PiratePortQuest", 2, "Pistol Billionaire", CFrame.new(-450.104, 107.681, 5950.726), CFrame.new(-188.144, 84.496, 6337.041)
    elseif lvl <= 1599 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Dragon Crew Warrior", "DragonCrewQuest", 1, "Dragon Crew Warrior", CFrame.new(6735.110, 126.990, -711.097), CFrame.new(6615.233, 50.847, -978.934)
    elseif lvl <= 1624 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Dragon Crew Archer", "DragonCrewQuest", 2, "Dragon Crew Archer", CFrame.new(6735.110, 126.990, -711.097), CFrame.new(6818.589, 483.718, 512.726)
    elseif lvl <= 1649 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Hydra Enforcer", "VenomCrewQuest", 1, "Hydra Enforcer", CFrame.new(5446.879, 601.629, 749.456), CFrame.new(4547.115, 1001.602, 334.195)
    elseif lvl <= 1699 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Venomous Assailant", "VenomCrewQuest", 2, "Venomous Assailant", CFrame.new(5446.879, 601.629, 749.456), CFrame.new(4637.885, 1077.855, 882.418)
    elseif lvl <= 1724 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Marine Commodore", "MarineTreeIsland", 1, "Marine Commodore", CFrame.new(2179.988, 28.731, -6740.055), CFrame.new(2198.006, 128.710, -7109.504)
    elseif lvl <= 1774 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Marine Rear Admiral", "MarineTreeIsland", 2, "Marine Rear Admiral", CFrame.new(2179.988, 28.731, -6740.055), CFrame.new(3294.314, 385.411, -7048.634)
    elseif lvl <= 1799 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Fishman Raider", "DeepForestIsland3", 1, "Fishman Raider", CFrame.new(-10582.759, 331.788, -8757.666), CFrame.new(-10553.268, 521.384, -8176.945)
    elseif lvl <= 1824 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Fishman Captain", "DeepForestIsland3", 2, "Fishman Captain", CFrame.new(-10583.099, 331.788, -8759.463), CFrame.new(-10789.401, 427.186, -9131.442)
    elseif lvl <= 1849 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Forest Pirate", "DeepForestIsland", 1, "Forest Pirate", CFrame.new(-13232.662, 332.403, -7626.481), CFrame.new(-13489.397, 400.303, -7770.251)
    elseif lvl <= 1899 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Mythological Pirate", "DeepForestIsland", 2, "Mythological Pirate", CFrame.new(-13232.662, 332.403, -7626.481), CFrame.new(-13508.616, 582.462, -6985.303)
    elseif lvl <= 1924 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Jungle Pirate", "DeepForestIsland2", 1, "Jungle Pirate", CFrame.new(-12682.096, 390.886, -9902.124), CFrame.new(-12267.103, 459.752, -10277.200)
    elseif lvl <= 1974 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Musketeer Pirate", "DeepForestIsland2", 2, "Musketeer Pirate", CFrame.new(-12682.096, 390.886, -9902.124), CFrame.new(-13291.507, 520.473, -9904.638)
    elseif lvl <= 1999 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Reborn Skeleton", "HauntedQuest1", 1, "Reborn Skeleton", CFrame.new(-9480.807, 142.130, 5566.373), CFrame.new(-8761.771, 183.431, 6168.333)
    elseif lvl <= 2024 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Living Zombie", "HauntedQuest1", 2, "Living Zombie", CFrame.new(-9480.807, 142.130, 5566.373), CFrame.new(-10103.752, 238.565, 6179.759)
    elseif lvl <= 2049 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Demonic Soul", "HauntedQuest2", 1, "Demonic Soul", CFrame.new(-9516.993, 178.006, 6078.465), CFrame.new(-9712.031, 204.695, 6193.322)
    elseif lvl <= 2074 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Posessed Mummy", "HauntedQuest2", 2, "Posessed Mummy", CFrame.new(-9516.993, 178.006, 6078.465), CFrame.new(-9545.776, 69.619, 6339.561)
    elseif lvl <= 2099 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Peanut Scout", "NutsIslandQuest", 1, "Peanut Scout", CFrame.new(-2105.531, 37.249, -10195.508), CFrame.new(-2150.587, 122.497, -10358.994)
    elseif lvl <= 2124 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Peanut President", "NutsIslandQuest", 2, "Peanut President", CFrame.new(-2105.531, 37.249, -10195.508), CFrame.new(-2150.587, 122.497, -10358.994)
    elseif lvl <= 2149 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Ice Cream Chef", "IceCreamIslandQuest", 1, "Ice Cream Chef", CFrame.new(-819.376, 64.925, -10967.283), CFrame.new(-789.941, 209.382, -11009.980)
    elseif lvl <= 2199 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Ice Cream Commander", "IceCreamIslandQuest", 2, "Ice Cream Commander", CFrame.new(-819.376, 64.925, -10967.283), CFrame.new(-789.941, 209.382, -11009.980)
    elseif lvl <= 2224 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Cookie Crafter", "CakeQuest1", 1, "Cookie Crafter", CFrame.new(-2022.298, 36.927, -12030.976), CFrame.new(-2321.712, 36.699, -12216.787)
    elseif lvl <= 2249 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Cake Guard", "CakeQuest1", 2, "Cake Guard", CFrame.new(-2022.298, 36.927, -12030.976), CFrame.new(-1418.110, 36.671, -12255.732)
    elseif lvl <= 2274 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Baking Staff", "CakeQuest2", 1, "Baking Staff", CFrame.new(-1928.317, 37.729, -12840.626), CFrame.new(-1980.438, 36.671, -12983.841)
    elseif lvl <= 2299 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Head Baker", "CakeQuest2", 2, "Head Baker", CFrame.new(-1928.317, 37.729, -12840.626), CFrame.new(-2251.579, 52.271, -13033.396)
    elseif lvl <= 2324 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Cocoa Warrior", "ChocQuest1", 1, "Cocoa Warrior", CFrame.new(231.750, 23.900, -12200.292), CFrame.new(167.978, 26.225, -12238.874)
    elseif lvl <= 2349 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Chocolate Bar Battler", "ChocQuest1", 2, "Chocolate Bar Battler", CFrame.new(231.750, 23.900, -12200.292), CFrame.new(701.312, 25.582, -12708.214)
    elseif lvl <= 2374 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Sweet Thief", "ChocQuest2", 1, "Sweet Thief", CFrame.new(151.198, 23.890, -12774.617), CFrame.new(-140.258, 25.582, -12652.311)
    elseif lvl <= 2400 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Candy Rebel", "ChocQuest2", 2, "Candy Rebel", CFrame.new(151.198, 23.890, -12774.617), CFrame.new(47.923, 25.582, -13029.240)
    elseif lvl <= 2424 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Candy Pirate", "CandyQuest1", 1, "Candy Pirate", CFrame.new(-1149.328, 13.575, -14445.614), CFrame.new(-1437.563, 17.148, -14385.693)
    elseif lvl <= 2449 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Snow Demon", "CandyQuest1", 2, "Snow Demon", CFrame.new(-1149.328, 13.575, -14445.614), CFrame.new(-916.222, 17.148, -14638.812)
    elseif lvl <= 2474 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Isle Outlaw", "TikiQuest1", 1, "Isle Outlaw", CFrame.new(-16549.890, 55.686, -179.913), CFrame.new(-16162.819, 11.686, -96.454)
    elseif lvl <= 2499 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Island Boy", "TikiQuest1", 2, "Island Boy", CFrame.new(-16549.890, 55.686, -179.913), CFrame.new(-16357.312, 20.632, 1005.648)
    elseif lvl <= 2524 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Sun-kissed Warrior", "TikiQuest2", 1, "Sun-kissed Warrior", CFrame.new(-16541.021, 54.770, 1051.461), CFrame.new(-16357.312, 20.632, 1005.648)
    elseif lvl <= 2549 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Isle Champion", "TikiQuest2", 2, "Isle Champion", CFrame.new(-16541.021, 54.770, 1051.461), CFrame.new(-16848.941, 21.686, 1041.449)
    elseif lvl <= 2574 then
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Serpent Hunter", "TikiQuest3", 1, "Serpent Hunter", CFrame.new(-16665.191, 104.596, 1579.694), CFrame.new(-16621.414, 121.406, 1290.688)
    else
        Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon = "Skull Slayer", "TikiQuest3", 2, "Skull Slayer", CFrame.new(-16665.191, 104.596, 1579.694), CFrame.new(-16811.570, 84.625, 1542.235)
    end
end

spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel()
                if not Ms or not CFrameQ then return end
                
                local questVisible = false
                local QuestTitle = ""
                pcall(function()
                    questVisible = plr.PlayerGui.Main.Quest.Visible
                    if questVisible then
                        QuestTitle = plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    end
                end)
                
                if questVisible and QuestTitle ~= "" and not string.find(QuestTitle, NameMon) then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    StopFlyAround()
                    return
                end
                
                if not questVisible then
                    local arrived = FlyTo(CFrameQ.Position)
                    if arrived then
                        StopFlyAround()
                        task.wait(0.3)
                        if (CFrameQ.Position - hrp.Position).Magnitude <= 25 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                            task.wait(0.3)
                        end
                    end
                    return
                end
                
                if questVisible and string.find(QuestTitle, NameMon) then
                    if game.Workspace.Enemies:FindFirstChild(Ms) then
                        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == Ms and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    AttackNoCoolDown()
                                    
                                    -- Bay quanh quái liên tục để né skill
                                    FlyAroundMob(v.HumanoidRootPart.Position)
                                    
                                    pcall(function()
                                        v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Humanoid.JumpPower = 0
                                    end)
                                until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0
                            end
                        end
                        StopFlyAround()
                    else
                        FlyTo(CFrameMon.Position)
                    end
                end
            end)
        else
            StopFlyAround()
        end
    end
end)

plr.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait()
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

plr.CharacterAdded:Connect(function(newChar)
    char = newChar
    hrp = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")
    flying = false
    flyAroundMob = false
    bodyVelocity = nil
end)

print("✅ Auto Farm Level - Bay quanh quái né skill + NoClip - Đã sẵn sàng!")
