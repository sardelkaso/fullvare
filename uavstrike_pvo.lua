-- ILP STUDIO: UAV STRIKE — ПВО Система v6.9 (Manual Fire + Player ESP + Drone Operator Menu)
-- ЧАСТЬ 1: НАСТРОЙКИ, КОНСОЛЬНЫЕ ПРИНТЫ И ИНДИКАТОРЫ В УГЛУ

print("=========================================")
print("[ПВО СИСТЕМА v6.9]: Инициализация...")
print("[ПВО СИСТЕМА v6.9]: Авто-стрельба ОТКЛЮЧЕНА (Ручной режим)")
print("[ПВО СИСТЕМА v6.9]: ESP игроков и меню ДРОН добавлены")
print("=========================================")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- НАСТРОЙКИ СКРИПТА
local AIM_KEYWORD = "Drone"
local STINGER_NAME = "Stinger-M"
local ESP_VISIBLE_DISTANCE = 5000
local AIM_MAX_DISTANCE = 1000
local LERP_SMOOTHNESS = 0.50

local AIMBOT_ACTIVE = false
local PLAYER_ESP_ACTIVE = false
local aimTarget = nil
local activeESP = {}
local playerESP = {}

local ANTI_DRONE_WEAPONS = {"Stinger-M", "Jammer", "AV-47"}

-- ЧАСТЬ 2: WATERMARK И POINTS
local WatermarkGui = Instance.new("ScreenGui")
local VersionLabel = Instance.new("TextLabel")
local PointsLabel = Instance.new("TextLabel")

WatermarkGui.Name = "AntiDroneVersionGUI_v6_9"
WatermarkGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
WatermarkGui.ResetOnSpawn = false

VersionLabel.Parent = WatermarkGui
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(1, -260, 0, 15)
VersionLabel.Size = UDim2.new(0, 250, 0, 25)
VersionLabel.Font = Enum.Font.SourceSansBold
VersionLabel.Text = "ПВО СИСТЕМА v6.9"
VersionLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
VersionLabel.TextSize = 22
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.TextStrokeTransparency = 0
VersionLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

PointsLabel.Parent = WatermarkGui
PointsLabel.BackgroundTransparency = 1
PointsLabel.Position = UDim2.new(1, -260, 0, 42)
PointsLabel.Size = UDim2.new(0, 250, 0, 30)
PointsLabel.Font = Enum.Font.SourceSansBold
PointsLabel.Text = "Points: Чтение..."
PointsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
PointsLabel.TextSize = 24
PointsLabel.TextXAlignment = Enum.TextXAlignment.Right
PointsLabel.TextStrokeTransparency = 0
PointsLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local function trackPoints()
    local leaderstats = LocalPlayer:WaitForChild("leaderstats", 15)
    if leaderstats then
        local pointsValue = leaderstats:WaitForChild("Points", 15)
        if pointsValue then
            PointsLabel.Text = "Points: " .. tostring(pointsValue.Value)
            pointsValue.Changed:Connect(function(newVal)
                PointsLabel.Text = "Points: " .. tostring(newVal)
            end)
        else PointsLabel.Text = "Points: Не найдены" end
    else PointsLabel.Text = "Leaderstats: Ошибка" end
end
task.spawn(trackPoints)
print("[ПВО v6.9]: Индикаторы очков созданы.")

-- ЧАСТЬ 3: НАДПИСЬ "УДАЧНОГО БОЯ!"
local BattleGui = Instance.new("ScreenGui")
local BattleLabel = Instance.new("TextLabel")

BattleGui.Name = "BattleGreetingGUI"
BattleGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
BattleGui.ResetOnSpawn = false

BattleLabel.Parent = BattleGui
BattleLabel.BackgroundTransparency = 1
BattleLabel.Position = UDim2.new(0.5, -250, 0.3, -25)
BattleLabel.Size = UDim2.new(0, 500, 0, 50)
BattleLabel.Font = Enum.Font.SourceSansBold
BattleLabel.Text = "УДАЧНОГО БОЯ!"
BattleLabel.TextColor3 = Color3.fromRGB(255, 30, 30)
BattleLabel.TextSize = 45
BattleLabel.TextTransparency = 1
BattleLabel.TextStrokeTransparency = 1
BattleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local function showBattleGreeting()
    BattleLabel.TextTransparency = 0
    BattleLabel.TextStrokeTransparency = 0
    task.wait(2)
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tweenText = TweenService:Create(BattleLabel, tweenInfo, {TextTransparency = 1})
    local tweenStroke = TweenService:Create(BattleLabel, tweenInfo, {TextStrokeTransparency = 1})
    tweenText:Play()
    tweenStroke:Play()
end

-- ЧАСТЬ 4: GUI ДЛЯ КНОПОК
local FlagGui = Instance.new("ScreenGui")
FlagGui.Name = "RussianFlagPVO_GUI"
FlagGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
FlagGui.ResetOnSpawn = false

-- КНОПКА ПВО (ТРИКОЛОР)
local MainButtonFrame = Instance.new("Frame")
local WhiteStrip = Instance.new("Frame")
local BlueStrip = Instance.new("Frame")
local RedStrip = Instance.new("Frame")
local ActionButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

MainButtonFrame.Name = "MainButtonFrame"
MainButtonFrame.Parent = FlagGui
MainButtonFrame.Position = UDim2.new(1, -210, 0, 75)
MainButtonFrame.Size = UDim2.new(0, 200, 0, 42)
MainButtonFrame.BackgroundTransparency = 1
MainButtonFrame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainButtonFrame

WhiteStrip.Parent = MainButtonFrame
WhiteStrip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WhiteStrip.Size = UDim2.new(1, 0, 0.333, 0)
WhiteStrip.BorderSizePixel = 0

BlueStrip.Parent = MainButtonFrame
BlueStrip.BackgroundColor3 = Color3.fromRGB(0, 57, 166)
BlueStrip.Position = UDim2.new(0, 0, 0.333, 0)
BlueStrip.Size = UDim2.new(1, 0, 0.333, 0)
BlueStrip.BorderSizePixel = 0

RedStrip.Parent = MainButtonFrame
RedStrip.BackgroundColor3 = Color3.fromRGB(213, 43, 30)
RedStrip.Position = UDim2.new(0, 0, 0.666, 0)
RedStrip.Size = UDim2.new(1, 0, 0.334, 0)
RedStrip.BorderSizePixel = 0

ActionButton.Parent = MainButtonFrame
ActionButton.BackgroundTransparency = 1
ActionButton.Size = UDim2.new(1, 0, 1, 0)
ActionButton.Font = Enum.Font.SourceSansBold
ActionButton.Text = "[ ПВО: ОТКЛЮЧЕНО ]"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 15
ActionButton.TextStrokeTransparency = 0
ActionButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- КНОПКА PLAYER ESP (ТЁМНАЯ)
local PlayerESPButton = Instance.new("TextButton")
PlayerESPButton.Name = "PlayerESPButton"
PlayerESPButton.Parent = FlagGui
PlayerESPButton.Position = UDim2.new(1, -210, 0, 125)
PlayerESPButton.Size = UDim2.new(0, 200, 0, 42)
PlayerESPButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerESPButton.Text = "[ PLAYER ESP: OFF ]"
PlayerESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerESPButton.TextSize = 14
PlayerESPButton.Font = Enum.Font.SourceSansBold
PlayerESPButton.TextStrokeTransparency = 0
PlayerESPButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local PlayerESPUICorner = Instance.new("UICorner")
PlayerESPUICorner.CornerRadius = UDim.new(0, 10)
PlayerESPUICorner.Parent = PlayerESPButton

-- КНОПКА ДРОН (ФЛАГ УКРАИНЫ)
local DroneButtonFrame = Instance.new("Frame")
local DroneBlueStrip = Instance.new("Frame")
local DroneYellowStrip = Instance.new("Frame")
local DroneButton = Instance.new("TextButton")
local DroneUICorner = Instance.new("UICorner")

DroneButtonFrame.Name = "DroneButtonFrame"
DroneButtonFrame.Parent = FlagGui
DroneButtonFrame.Position = UDim2.new(1, -210, 0, 175)
DroneButtonFrame.Size = UDim2.new(0, 200, 0, 42)
DroneButtonFrame.BackgroundTransparency = 1
DroneButtonFrame.ClipsDescendants = true

DroneUICorner.CornerRadius = UDim.new(0, 10)
DroneUICorner.Parent = DroneButtonFrame

DroneBlueStrip.Parent = DroneButtonFrame
DroneBlueStrip.BackgroundColor3 = Color3.fromRGB(0, 87, 183)
DroneBlueStrip.Size = UDim2.new(1, 0, 0.5, 0)
DroneBlueStrip.BorderSizePixel = 0

DroneYellowStrip.Parent = DroneButtonFrame
DroneYellowStrip.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
DroneYellowStrip.Position = UDim2.new(0, 0, 0.5, 0)
DroneYellowStrip.Size = UDim2.new(1, 0, 0.5, 0)
DroneYellowStrip.BorderSizePixel = 0

DroneButton.Parent = DroneButtonFrame
DroneButton.BackgroundTransparency = 1
DroneButton.Size = UDim2.new(1, 0, 1, 0)
DroneButton.Font = Enum.Font.SourceSansBold
DroneButton.Text = "[ ДРОН: ВЫКЛ ]"
DroneButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DroneButton.TextSize = 15
DroneButton.TextStrokeTransparency = 0
DroneButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- ЧАСТЬ 5: ОЧИСТКА ESP
local function clearAllESP()
    for model, espElements in pairs(activeESP) do
        for _, element in pairs(espElements) do
            if element and element.Parent then element:Destroy() end
        end
    end
    activeESP = {}

    for character, espElements in pairs(playerESP) do
        for _, element in pairs(espElements) do
            if element and element.Parent then element:Destroy() end
        end
    end
    playerESP = {}
end

-- ЧАСТЬ 6: ОБРАБОТЧИКИ КНОПОК
ActionButton.MouseButton1Click:Connect(function()
    AIMBOT_ACTIVE = not AIMBOT_ACTIVE
    if AIMBOT_ACTIVE then
        ActionButton.Text = "[ ПВО: АКТИВИРОВАНО ]"
        print("[ПВО v6.9]: АКТИВАЦИЯ НАВЕДЕНИЯ")
        task.spawn(showBattleGreeting)
    else
        ActionButton.Text = "[ ПВО: ОТКЛЮЧЕНО ]"
        print("[ПВО v6.9]: НАВЕДЕНИЕ ОТКЛЮЧЕНО")
        aimTarget = nil
        for model, elements in pairs(activeESP) do
            for _, element in pairs(elements) do
                if element and element.Parent then element:Destroy() end
            end
        end
        activeESP = {}
    end
end)

PlayerESPButton.MouseButton1Click:Connect(function()
    PLAYER_ESP_ACTIVE = not PLAYER_ESP_ACTIVE
    if PLAYER_ESP_ACTIVE then
        PlayerESPButton.Text = "[ PLAYER ESP: ON ]"
        PlayerESPButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        print("[ПВО v6.9]: ESP ИГРОКОВ АКТИВИРОВАН")
    else
        PlayerESPButton.Text = "[ PLAYER ESP: OFF ]"
        PlayerESPButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        print("[ПВО v6.9]: ESP ИГРОКОВ ОТКЛЮЧЕН")
    end
end)

DroneButton.MouseButton1Click:Connect(function()
    PLAYER_ESP_ACTIVE = not PLAYER_ESP_ACTIVE
    if PLAYER_ESP_ACTIVE then
        DroneButton.Text = "[ ДРОН: ВКЛ ]"
        print("[ПВО v6.9]: ESP ДЛЯ ОПЕРАТОРА ДРОНА АКТИВИРОВАН")
    else
        DroneButton.Text = "[ ДРОН: ВЫКЛ ]"
        print("[ПВО v6.9]: ESP ДЛЯ ОПЕРАТОРА ДРОНА ОТКЛЮЧЕН")
    end
end)

-- ЧАСТЬ 7: ESP ДЛЯ ДРОНОВ
local function createESP(model)
    if activeESP[model] then return end
    local espElements = {}

    local highlight = Instance.new("Highlight")
    highlight.Name = "DroneESPBox"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.75
    highlight.OutlineColor = Color3.fromRGB(255, 50, 50)
    highlight.Adornee = model
    highlight.Parent = model
    table.insert(espElements, highlight)

    local mainPart = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    if mainPart then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "DroneESPTextGui"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.ExtentsOffset = Vector3.new(0, 4, 0)
        billboard.Adornee = mainPart
        billboard.Parent = mainPart

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 15
        textLabel.TextColor3 = Color3.fromRGB(255, 230, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Parent = billboard

        table.insert(espElements, billboard)
        table.insert(espElements, textLabel)
    end
    activeESP[model] = espElements
end

-- ЧАСТЬ 8: ESP ДЛЯ ИГРОКОВ
local function createPlayerESP(character)
    if playerESP[character] then return end
    local espElements = {}

    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerESPBox"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.75
    highlight.OutlineColor = Color3.fromRGB(255, 50, 50)
    highlight.Adornee = character
    highlight.Parent = character
    table.insert(espElements, highlight)

    local mainPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart")
    if mainPart then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "PlayerESPTextGui"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.ExtentsOffset = Vector3.new(0, 4, 0)
        billboard.Adornee = mainPart
        billboard.Parent = mainPart

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextSize = 15
        textLabel.TextColor3 = Color3.fromRGB(255, 230, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Parent = billboard

        table.insert(espElements, billboard)
        table.insert(espElements, textLabel)
    end
    playerESP[character] = espElements
end

-- ЧАСТЬ 9: АЛГОРИТМ ДРОНОВ И НАВОДКА
local function processDronesAndGetClosest()
    local closestPart = nil
    local shortestDistance = AIM_MAX_DISTANCE
    local character = LocalPlayer.Character
    local myRoot = character and character:FindFirstChild("HumanoidRootPart")

    if not myRoot then return nil end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and (string.find(obj.Name, AIM_KEYWORD) or string.find(obj.Name, "UAV")) then
            local targetPart = obj:FindFirstChild("HumanoidRootPart")
                or obj:FindFirstChild("Body")
                or obj:FindFirstChild("MainPart")
                or obj:FindFirstChildWhichIsA("BasePart")

            if targetPart then
                local isDropped = targetPart.Position.Y < 25 or (targetPart.AssemblyLinearVelocity.Magnitude < 2 and targetPart.Position.Y < 40)

                if not isDropped then
                    local distance = (targetPart.Position - myRoot.Position).Magnitude

                    if AIMBOT_ACTIVE and distance <= ESP_VISIBLE_DISTANCE then
                        createESP(obj)

                        if activeESP[obj] then
                            local hl = obj:FindFirstChild("DroneESPBox")
                            if hl and hl:IsA("Highlight") then
                                if distance <= AIM_MAX_DISTANCE then
                                    hl.OutlineColor = Color3.fromRGB(0, 255, 0)
                                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                                else
                                    hl.OutlineColor = Color3.fromRGB(255, 50, 50)
                                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                                end
                            end

                            for _, el in pairs(activeESP[obj]) do
                                if el:IsA("TextLabel") then
                                    if distance <= AIM_MAX_DISTANCE then
                                        el.Text = string.format("🎯 [%d m] ГОТОВ К ЗАХВАТУ", math.floor(distance))
                                        el.TextColor3 = Color3.fromRGB(0, 255, 0)
                                    else
                                        el.Text = string.format("🛸 [%d m]", math.floor(distance))
                                        el.TextColor3 = Color3.fromRGB(255, 230, 0)
                                    end
                                end
                            end
                        end
                    end

                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPart = targetPart
                    end
                else
                    if activeESP[obj] then
                        for _, element in pairs(activeESP[obj]) do
                            if element and element.Parent then element:Destroy() end
                        end
                        activeESP[obj] = nil
                    end
                end
            end
        end
    end

    for model, _ in pairs(activeESP) do
        if not model or not model.Parent then activeESP[model] = nil end
    end
    return closestPart
end

local function isHoldingStinger()
    local character = LocalPlayer.Character
    if character and character:FindFirstChildWhichIsA("Tool") then
        local tool = character:FindFirstChildWhichIsA("Tool")
        return string.find(tool.Name, "Stinger") or tool.Name == STINGER_NAME
    end
    return false
end

-- ЧАСТЬ 10: ESP ИГРОКОВ С ОРУЖИЕМ ПРОТИВ ДРОНОВ
local function getPlayerWeapon(player)
    local character = player.Character
    if not character then return nil end

    local tool = character:FindFirstChildWhichIsA("Tool")
    if tool then
        for _, weaponName in ipairs(ANTI_DRONE_WEAPONS) do
            if string.find(tool.Name, weaponName) then
                return weaponName
            end
        end
    end
    return nil
end

local function processPlayersESP()
    if not PLAYER_ESP_ACTIVE then
        for character, elements in pairs(playerESP) do
            for _, element in pairs(elements) do
                if element and element.Parent then element:Destroy() end
            end
        end
        playerESP = {}
        return
    end

    local myCharacter = LocalPlayer.Character
    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")

            if humanoid and rootPart and humanoid.Health > 0 then
                local distance = (rootPart.Position - myRoot.Position).Magnitude
                local weapon = getPlayerWeapon(player)

                if weapon then
                    createPlayerESP(character)

                    if playerESP[character] then
                        local hl = character:FindFirstChild("PlayerESPBox")
                        if hl and hl:IsA("Highlight") then
                            if weapon == "Stinger-M" then
                                hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                                hl.FillColor = Color3.fromRGB(255, 0, 0)
                            elseif weapon == "Jammer" then
                                hl.OutlineColor = Color3.fromRGB(255, 165, 0)
                                hl.FillColor = Color3.fromRGB(255, 165, 0)
                            elseif weapon == "AV-47" then
                                hl.OutlineColor = Color3.fromRGB(255, 255, 0)
                                hl.FillColor = Color3.fromRGB(255, 255, 0)
                            end
                        end

                        for _, el in pairs(playerESP[character]) do
                            if el:IsA("TextLabel") then
                                el.Text = string.format("👤 %s | %s | [%d m] | HP: %d",
                                    player.Name, weapon, math.floor(distance), math.floor(humanoid.Health))
                                el.TextColor3 = Color3.fromRGB(255, 50, 50)
                            end
                        end
                    end
                end
            end
        end
    end

    for character, elements in pairs(playerESP) do
        if not character or not character.Parent or not character:FindFirstChild("Humanoid") or character.Humanoid.Health <= 0 then
            for _, element in pairs(elements) do
                if element and element.Parent then element:Destroy() end
            end
            playerESP[character] = nil
        end
    end
end

-- ЧАСТЬ 11: ЦИКЛ СИНХРОНИЗАЦИИ
RunService.RenderStepped:Connect(function()
    if AIMBOT_ACTIVE
