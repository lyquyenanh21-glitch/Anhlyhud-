loadstring(game:HttpGet("https://pastefy.app/a9TcWv4X/raw"))()

-- AUTO NOCLIP (ALL GAME)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- đảm bảo lấy đúng character
local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local noclip = true

-- Noclip loop
RunService.Stepped:Connect(function()
    if noclip then
        local char = getCharacter()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Nếu chết thì tự bật lại
player.CharacterAdded:Connect(function()
    task.wait(1)
    noclip = true
end)

print("[✓] AUTO NOCLIP ENABLED")

-- ==========================================
-- AUTO RAID - ĐỔI TRÁI LẤY CHIP + GACHA + XOAY QUANH QUÁI NÉ SKILL
-- ==========================================

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("Status_UI") then
    PlayerGui["Status_UI"]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Status_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 200)
MainFrame.Position = UDim2.new(1, -330, 0.5, -100)
MainFrame.AnchorPoint = Vector2.new(0, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 255, 0)
Stroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ AUTO RAID | anhlyhud ⚡"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(0.9, 0, 0, 1)
Line.Position = UDim2.new(0.05, 0, 0, 42)
Line.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Line.BackgroundTransparency = 0.5
Line.Parent = MainFrame

local LevelText = Instance.new("TextLabel")
LevelText.Size = UDim2.new(1, -20, 0, 30)
LevelText.Position = UDim2.new(0, 10, 0, 50)
LevelText.BackgroundTransparency = 1
LevelText.Text = "📊 Level: 0"
LevelText.TextColor3 = Color3.fromRGB(255, 255, 255)
LevelText.TextSize = 14
LevelText.TextXAlignment = Enum.TextXAlignment.Left
LevelText.Font = Enum.Font.Gotham
LevelText.Parent = MainFrame

local BeliText = Instance.new("TextLabel")
BeliText.Size = UDim2.new(1, -20, 0, 30)
BeliText.Position = UDim2.new(0, 10, 0, 80)
BeliText.BackgroundTransparency = 1
BeliText.Text = "💰 Beli: 0"
BeliText.TextColor3 = Color3.fromRGB(255, 255, 255)
BeliText.TextSize = 14
BeliText.TextXAlignment = Enum.TextXAlignment.Left
BeliText.Font = Enum.Font.Gotham
BeliText.Parent = MainFrame

local FragText = Instance.new("TextLabel")
FragText.Size = UDim2.new(1, -20, 0, 30)
FragText.Position = UDim2.new(0, 10, 0, 110)
FragText.BackgroundTransparency = 1
FragText.Text = "💎 Fragments: 0"
FragText.TextColor3 = Color3.fromRGB(255, 255, 255)
FragText.TextSize = 14
FragText.TextXAlignment = Enum.TextXAlignment.Left
FragText.Font = Enum.Font.Gotham
FragText.Parent = MainFrame

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -20, 0, 30)
StatusText.Position = UDim2.new(0, 10, 0, 145)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🤖 Status: Đang khởi động..."
StatusText.TextColor3 = Color3.fromRGB(0, 255, 0)
StatusText.TextSize = 13
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = MainFrame

local OwnerText = Instance.new("TextLabel")
OwnerText.Size = UDim2.new(1, -20, 0, 20)
OwnerText.Position = UDim2.new(0, 10, 0, 175)
OwnerText.BackgroundTransparency = 1
OwnerText.Text = "👤 Owner: anhlyhud"
OwnerText.TextColor3 = Color3.fromRGB(0, 255, 0)
OwnerText.TextSize = 12
OwnerText.TextXAlignment = Enum.TextXAlignment.Left
OwnerText.Font = Enum.Font.Gotham
OwnerText.Parent = MainFrame

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local plr = game.Players.LocalPlayer
            if plr and plr.Data then
                LevelText.Text = "📊 Level: " .. (plr.Data.Level.Value or 0)
                BeliText.Text = "💰 Beli: " .. (plr.Data.Beli.Value or 0)
                FragText.Text = "💎 Fragments: " .. (plr.Data.Fragments.Value or 0)
            end
        end)
    end
end)

-- ========== HỆ THỐNG FLY + NOCLIP ==========
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

local function StartFly()
    if not flying then
        flying = true
        SetNoclip(true)
        hum.PlatformStand = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1,1,1) * 1e6
        bodyVelocity.Parent = hrp
    end
end

local function StopFly()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    flying = false
    hum.PlatformStand = false
    SetNoclip(false)
end

local function FlyTo(pos)
    if not hrp then return false end
    StartFly()
    local dist = (pos - hrp.Position).Magnitude
    if dist < 10 then
        StopFly()
        return true
    end
    local dir = (pos - hrp.Position).Unit
    local speed = math.min(flySpeed, dist)
    if dist > 500 then speed = flySpeed end
    bodyVelocity.Velocity = dir * speed
    return false
end

-- ========== HÀM HỖ TRỢ ==========
function AutoHaki()
    if not plr.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function EquipMelee()
    local sources = {plr.Backpack}
    if plr.Character then table.insert(sources, plr.Character) end
    for _, src in pairs(sources) do
        for _, t in pairs(src:GetChildren()) do
            if t:IsA("Tool") and t.ToolTip == "Melee" then
                plr.Character.Humanoid:EquipTool(t)
                return
            end
        end
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

-- ========== XOAY QUANH QUÁI ĐỂ NÉ SKILL ==========
local circleAngle = 0
local circleRadius = 18
local circleHeight = 20

local function CircleAroundMob(mobPos)
    if not mobPos then return end
    
    circleAngle = circleAngle + 0.25
    if circleAngle > 360 then circleAngle = 0 end
    
    local rad = math.rad(circleAngle)
    local x = math.cos(rad) * circleRadius
    local z = math.sin(rad) * circleRadius
    local yOffset = math.sin(circleAngle * 2) * 5
    local newPos = mobPos + Vector3.new(x, circleHeight + yOffset, z)
    
    hrp.CFrame = CFrame.new(newPos, mobPos)
end

-- ========== TỰ ĐỘNG CỘNG CHỈ SỐ (MELEE + MÁU) ==========
local function AutoStats()
    while plr.Data.Points.Value > 0 do
        if plr.Data.Points.Value > 0 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
        end
        if plr.Data.Points.Value > 0 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
        end
        task.wait(0.1)
    end
end

task.spawn(function()
    while task.wait(1) do
        pcall(AutoStats)
    end
end)

-- ========== TỰ ĐỘNG CHỌN PHE HẢI TẶC ==========
local function AutoTeam()
    pcall(function()
        if plr.Team == nil or plr.Team.Name ~= "Pirates" then
            StatusText.Text = "🤖 Status: Đang chọn phe Hải Tặc..."
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
            task.wait(1)
            StatusText.Text = "🤖 Status: Đã chọn phe Hải Tặc!"
        end
    end)
end

task.spawn(function()
    task.wait(2)
    AutoTeam()
end)

-- ========== AUTO RAID ==========
local RaidLocations = {
    [4442272183] = {  -- Sea 2
        CFrame.new(-6438.73535, 250.645355, -4501.50684),
        "RaidSummon2"
    },
    [7449423635] = {  -- Sea 3
        CFrame.new(-5017.40869, 314.844055, -2823.0127),
        "RaidSummon2"
    }
}

-- Danh sách chip có thể mua
local ChipList = {
    "Flame", "Ice", "Light", "Dark", "Magma", "Buddha", "Quake", 
    "Spider", "Rumble", "Phoenix", "Sand", "Shadow", "Venom", "Dough"
}

local selectedChip = ChipList[1]
local chipIndex = 1

-- Vị trí NPC Gacha (Cousin) theo từng sea
local GachaLocations = {
    [2753915549] = CFrame.new(1056.227, 16.400, 1550.202),  -- Sea 1
    [4442272183] = CFrame.new(-5240.896, 65.562, -6038.067), -- Sea 2
    [7449423635] = CFrame.new(-10238.297, 331.788, -9990.099) -- Sea 3
}

-- ========== CHỌN CHIP LUÂN PHIÊN ==========
local function SelectNextChip()
    selectedChip = ChipList[chipIndex]
    chipIndex = chipIndex + 1
    if chipIndex > #ChipList then
        chipIndex = 1
    end
    StatusText.Text = "🤖 Status: Chọn chip: " .. selectedChip
    return selectedChip
end

-- ========== GACHA - RANDOM TRÁI TỪ NPC COUSIN ==========
local function DoGacha()
    StatusText.Text = "🤖 Status: Đang random trái từ NPC Gacha..."
    
    -- Kiểm tra tiền
    if plr.Data.Beli.Value < 300000 then
        StatusText.Text = "🤖 Status: Không đủ 300k Beli để gacha!"
        return false
    end
    
    -- Bay đến NPC Gacha
    local gachaPos = GachaLocations[game.PlaceId]
    if gachaPos then
        FlyTo(gachaPos.Position)
        task.wait(1)
    end
    
    -- Mua trái ngẫu nhiên
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
        StatusText.Text = "🤖 Status: Đã mua trái ngẫu nhiên thành công!"
        task.wait(2)
    end)
    
    return true
end

-- ========== KIỂM TRA ĐANG TRONG RAID ==========
local function IsInRaid()
    return game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Island 1") ~= nil
end

-- ========== LẤY DANH SÁCH TRÁI TRONG KHO ==========
local function GetFruitsFromInventory()
    local inventory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
    local fruits = {}
    for _, item in pairs(inventory) do
        if type(item) == "table" and item.Type == "Fruit" and item.Name then
            table.insert(fruits, item.Name)
        end
    end
    return fruits
end

-- ========== ĐỔI TRÁI LẤY CHIP ==========
local function ExchangeFruitForChip()
    local fruits = GetFruitsFromInventory()
    
    if #fruits == 0 then
        StatusText.Text = "🤖 Status: Không có trái trong kho, tiến hành gacha..."
        local success = DoGacha()
        if not success then
            return false
        end
        fruits = GetFruitsFromInventory()
        if #fruits == 0 then
            return false
        end
    end
    
    local fruitToExchange = fruits[1]
    StatusText.Text = "🤖 Status: Đang đổi trái " .. fruitToExchange .. " lấy chip " .. selectedChip
    
    pcall(function()
        local args = {"RaidsNpc", "Exchange", fruitToExchange, selectedChip}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        task.wait(2)
    end)
    
    if plr.Backpack:FindFirstChild("Special Microchip") or plr.Character:FindFirstChild("Special Microchip") then
        StatusText.Text = "🤖 Status: Đã đổi trái lấy chip thành công!"
        return true
    else
        StatusText.Text = "🤖 Status: Đổi thất bại, thử chip khác..."
        SelectNextChip()
        return false
    end
end

-- ========== MUA CHIP BẰNG TIỀN ==========
local function BuyChipWithMoney()
    StatusText.Text = "🤖 Status: Đang mua chip " .. selectedChip .. " bằng tiền..."
    
    if plr.Data.Beli.Value < 100000 then
        StatusText.Text = "🤖 Status: Không đủ 100k Beli để mua chip!"
        return false
    end
    
    local args = {"RaidsNpc", "Select", selectedChip}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    task.wait(2)
    
    if plr.Backpack:FindFirstChild("Special Microchip") or plr.Character:FindFirstChild("Special Microchip") then
        StatusText.Text = "🤖 Status: Đã mua chip thành công!"
        return true
    else
        StatusText.Text = "🤖 Status: Mua chip thất bại!"
        return false
    end
end

-- ========== LẤY CHIP ==========
local function GetChip()
    if plr.Backpack:FindFirstChild("Special Microchip") or plr.Character:FindFirstChild("Special Microchip") then
        StatusText.Text = "🤖 Status: Đã có chip trong túi!"
        return true
    end
    
    local success = ExchangeFruitForChip()
    
    if not success then
        StatusText.Text = "🤖 Status: Không thể đổi trái, chuyển sang mua bằng tiền..."
        success = BuyChipWithMoney()
    end
    
    return success
end

-- ========== BẮT ĐẦU RAID ==========
local function StartRaid()
    StatusText.Text = "🤖 Status: Đang bay đến chỗ kích hoạt raid..."
    
    local raidPos = nil
    local buttonPath = nil
    
    -- Xác định vị trí và đường dẫn nút theo từng sea
    if game.PlaceId == 4442272183 then  -- Sea 2
        raidPos = CFrame.new(-6438.73535, 250.645355, -4501.50684)
        buttonPath = {"Map", "RaidSummon2", "Button", "ClickDetector"}
    elseif game.PlaceId == 7449423635 then  -- Sea 3
        raidPos = CFrame.new(-5017.40869, 314.844055, -2823.0127)
        buttonPath = {"Map", "RaidSummon2", "Button", "ClickDetector"}
    else
        StatusText.Text = "🤖 Status: Sea này không có raid!"
        return false
    end
    
    -- BAY ĐẾN VỊ TRÍ
    FlyTo(raidPos.Position)
    
    -- Đợi đến gần (cách dưới 15m)
    repeat
        task.wait(0.3)
        if not hrp then return false end
        local dist = (hrp.Position - raidPos.Position).Magnitude
        StatusText.Text = "🤖 Status: Bay đến raid... còn " .. math.floor(dist) .. "m"
    until (hrp.Position - raidPos.Position).Magnitude < 15
    
    StatusText.Text = "🤖 Status: Đã đến nơi, tìm nút kích hoạt..."
    task.wait(0.5)
    
    -- TÌM VÀ CLICK NÚT
    local clicked = false
    
    -- Cách 1: Dùng đường dẫn cố định
    local detector = workspace
    for _, path in ipairs(buttonPath) do
        detector = detector:FindFirstChild(path)
        if not detector then break end
    end
    
    if detector and detector:IsA("ClickDetector") then
        fireclickdetector(detector)
        clicked = true
    end
    
    -- Cách 2: Nếu không thấy, quét tất cả ClickDetector trong khu vực
    if not clicked then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ClickDetector") and obj.Parent then
                local btnPos = obj.Parent:FindFirstChild("Position") or obj.Parent:FindFirstChild("CFrame")
                if btnPos then
                    local pos = btnPos:IsA("CFrame") and btnPos.Position or btnPos.Value
                    if pos and (pos - raidPos.Position).Magnitude < 50 then
                        fireclickdetector(obj)
                        clicked = true
                        break
                    end
                end
            end
        end
    end
    
    -- Cách 3: Gọi remote trực tiếp
    if not clicked then
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Start")
            clicked = true
        end)
    end
    
    if clicked then
        StatusText.Text = "🤖 Status: Đã kích hoạt raid thành công!"
        task.wait(3)
        return true
    else
        StatusText.Text = "🤖 Status: Không tìm thấy nút kích hoạt!"
        return false
    end
end

-- ========== LẤY ĐẢO HIỆN TẠI ==========
local function GetCurrentIsland()
    local locations = game:GetService("Workspace")._WorldOrigin.Locations
    for i = 1, 5 do
        local island = locations:FindFirstChild("Island " .. i)
        if island and (hrp.Position - island.Position).Magnitude < 500 then
            return island, i
        end
    end
    return nil, nil
end

-- ========== DI CHUYỂN ĐẾN ĐẢO TIẾP THEO ==========
local function TeleportToNextIsland()
    local locations = game:GetService("Workspace")._WorldOrigin.Locations
    for i = 1, 5 do
        local island = locations:FindFirstChild("Island " .. i)
        if island and (hrp.Position - island.Position).Magnitude > 500 then
            StatusText.Text = "🤖 Status: Đang di chuyển đến đảo " .. i
            FlyTo(island.Position)
            task.wait(2)
            return true
        end
    end
    return false
end

-- ========== ĐÁNH QUÁI TRONG RAID ==========
local function KillRaidMobs()
    while IsInRaid() do
        local killed = false
        
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if v.Name ~= "Island" and not v:GetAttribute("IsBoat") then
                    killed = true
                    repeat
                        task.wait()
                        AutoHaki()
                        EquipMelee()
                        AttackNoCoolDown()
                        CircleAroundMob(v.HumanoidRootPart.Position)
                        pcall(function()
                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                            v.HumanoidRootPart.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.Humanoid.JumpPower = 0
                        end)
                    until not v.Parent or v.Humanoid.Health <= 0
                end
            end
        end
        
        if not killed then
            local _, islandNum = GetCurrentIsland()
            if islandNum and islandNum < 5 then
                TeleportToNextIsland()
            else
                StatusText.Text = "🤖 Status: Đợi đảo tiếp theo..."
                task.wait(3)
            end
        end
    end
end

-- ========== VÒNG LẶP RAID CHÍNH (LOGIC MẠNH) ==========
spawn(function()
    local failedAttempts = 0
    local lastRaidCheck = 0
    local stuckCounter = 0
    local lastPosition = nil
    
    while task.wait(0.5) do  -- Giảm xuống 0.5s để phản ứng nhanh hơn
        pcall(function()
            -- KIỂM TRA CHARACTER CÒN SỐNG
            if not hrp or not hrp.Parent then
                StatusText.Text = "🤖 Status: Đang chờ hồi sinh..."
                task.wait(2)
                char = plr.Character
                if not char then return end
                hrp = char:FindFirstChild("HumanoidRootPart")
                hum = char:FindFirstChild("Humanoid")
                if not hrp or not hum then return end
                flying = false
                bodyVelocity = nil
                return
            end
            
            -- PHÁT HIỆN BỊ KẸT (không di chuyển được)
            local currentPos = hrp.Position
            if lastPosition then
                local distance = (currentPos - lastPosition).Magnitude
                if distance < 1 and flying then
                    stuckCounter = stuckCounter + 1
                    if stuckCounter > 10 then  -- Kẹt quá 5 giây
                        StatusText.Text = "🤖 Status: Phát hiện kẹt, đang xử lý..."
                        StopFly()
                        task.wait(1)
                        stuckCounter = 0
                    end
                else
                    stuckCounter = 0
                end
            end
            lastPosition = currentPos
            
            -- KIỂM TRA RAID CHÍNH XÁC HƠN (có xử lý lỗi)
            local inRaid = false
            local locations = nil
            pcall(function()
                locations = workspace._WorldOrigin and workspace._WorldOrigin:FindFirstChild("Locations")
            end)
            
            local hasIsland = locations and locations:FindFirstChild("Island 1") ~= nil
            
            -- Kiểm tra có quái không (tối ưu hơn)
            local hasEnemies = false
            local enemyCount = 0
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    hasEnemies = true
                    enemyCount = enemyCount + 1
                    if enemyCount > 3 then break end
                end
            end
            
            inRaid = hasIsland or (hasEnemies and enemyCount > 0)
            
            -- TỰ ĐỘNG BẬT HAKI NẾU CHƯA CÓ
            if char and not char:FindFirstChild("HasBuso") then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                end)
            end
            
            if inRaid then
                -- ĐANG TRONG RAID
                failedAttempts = 0
                lastRaidCheck = tick()
                StatusText.Text = "🤖 Status: Đang raid... (quái: " .. enemyCount .. ")"
                KillRaidMobs()
            else
                -- KHÔNG TRONG RAID
                -- Reset nếu đang bị kẹt trạng thái fly
                if flying then
                    StopFly()
                end
                
                -- KIỂM TRA XEM CÓ CHIP KHÔNG
                local hasChip = false
                if plr.Backpack then
                    hasChip = plr.Backpack:FindFirstChild("Special Microchip") ~= nil
                end
                if not hasChip and char then
                    hasChip = char:FindFirstChild("Special Microchip") ~= nil
                end
                
                if not hasChip then
                    -- LẤY CHIP
                    StatusText.Text = "🤖 Status: Đang lấy chip..."
                    local success = GetChip()
                    
                    if not success then
                        failedAttempts = failedAttempts + 1
                        local waitTime = math.min(5, failedAttempts)  -- Tăng dần thời gian chờ
                        StatusText.Text = "🤖 Status: Lỗi lấy chip (" .. failedAttempts .. "), thử lại sau " .. waitTime .. "s"
                        task.wait(waitTime)
                        
                        if failedAttempts >= 5 then
                            StatusText.Text = "🤖 Status: Lỗi liên tục, chờ 30s rồi thử lại..."
                            task.wait(30)
                            failedAttempts = 0
                        end
                    else
                        failedAttempts = 0
                        StatusText.Text = "🤖 Status: Đã có chip, bắt đầu raid..."
                        task.wait(1)
                    end
                else
                    -- CÓ CHIP RỒI, BẮT ĐẦU RAID
                    failedAttempts = 0
                    StatusText.Text = "🤖 Status: Có chip, đang bắt đầu raid..."
                    StartRaid()
                end
            end
        end)
    end
end)

-- ========== TỰ ĐỘNG HEAL ==========
local function AutoHeal()
    pcall(function()
        -- Kiểm tra nếu có trái Phoenix hoặc các trái hồi máu
        local fruit = plr.Character:FindFirstChild("Fruit")
        if fruit and fruit.Name == "Phoenix" then
            local health = hum.Health
            local maxHealth = hum.MaxHealth
            if health < maxHealth * 0.7 then  -- Nếu máu dưới 70%
                local healRemote = fruit:FindFirstChild("HealRemote")
                if healRemote then
                    healRemote:FireServer()
                    StatusText.Text = "?? Status: Đang hồi máu..."
                    task.wait(2)
                end
            end
        end
    end)
end

-- Chèn AutoHeal vào KillRaidMobs
local oldKillRaidMobs = KillRaidMobs
KillRaidMobs = function()
    while IsInRaid() and hrp and hrp.Parent do
        AutoHeal()  -- Thêm heal tự động
        local killed = false
        
        for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                if v.Name ~= "Island" and not v:GetAttribute("IsBoat") then
                    killed = true
                    repeat
                        task.wait(0.1)  -- Giảm tốc độ loop
                        if not hrp or not hrp.Parent then break end
                        AutoHaki()
                        EquipMelee()
                        AttackNoCoolDown()
                        if v and v.Parent and v.HumanoidRootPart then
                            CircleAroundMob(v.HumanoidRootPart.Position)
                        end
                        pcall(function()
                            if v and v.HumanoidRootPart then
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                v.HumanoidRootPart.CanCollide = false
                            end
                            if v and v.Humanoid then
                                v.Humanoid.WalkSpeed = 0
                                v.Humanoid.JumpPower = 0
                            end
                        end)
                    until not v or not v.Parent or not v.Humanoid or v.Humanoid.Health <= 0
                end
            end
        end
        
        if not killed then
            local _, islandNum = GetCurrentIsland()
            if islandNum and islandNum < 5 then
                TeleportToNextIsland()
            else
                StatusText.Text = "🤖 Status: Đợi đảo tiếp theo..."
                task.wait(3)
            end
        end
    end
end

-- ========== CHỐNG LAG & TỐI ƯU ==========
-- Giới hạn số lượng quái xử lý cùng lúc
local function GetNearestEnemy()
    local nearest = nil
    local nearestDist = 500
    local hrpPos = hrp and hrp.Position
    
    if not hrpPos then return nil end
    
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local dist = (v.HumanoidRootPart.Position - hrpPos).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = v
            end
        end
    end
    
    return nearest
end

-- Ghi đè AttackNoCoolDown để chỉ tấn công quái gần nhất
local oldAttack = AttackNoCoolDown
AttackNoCoolDown = function()
    local tool = plr.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("LeftClickRemote") then
        local target = GetNearestEnemy()
        if target and target.HumanoidRootPart then
            local dir = (target.HumanoidRootPart.Position - plr.Character:GetPivot().Position).Unit
            pcall(function() 
                tool.LeftClickRemote:FireServer(dir, 1) 
            end)
        end
    end
end

print("✅ LOGIC MẠNH ĐÃ ĐƯỢC THÊM VÀO!")

-- ========== ANTI AFK ==========
plr.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait()
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- ========== RESET KHI RESPAWN ==========
plr.CharacterAdded:Connect(function(newChar)
    char = newChar
    hrp = char:WaitForChild("HumanoidRootPart")
    hum = char:WaitForChild("Humanoid")
    flying = false
    bodyVelocity = nil
end)

print("✅ AUTO RAID - GACHA + ĐỔI TRÁI LẤY CHIP + XOAY QUANH QUÁI NÉ SKILL - ĐÃ SẴN SÀNG! | anhlyhud")
