-- ILP STUDIO: UAV STRIKE — ПВО Система v6.7 (Manual Fire Edition)
-- ЧАСТЬ 1: НАСТРОЙКИ, КОНСОЛЬНЫЕ ПРИНТЫ И ИНДИКАТОРЫ В УГЛУ

print("=========================================")
print("[ПВО СИСТЕМА v6.7]: Инициализация...")
print("[ПВО СИСТЕМА v6.7]: Авто-стрельба ОТКЛЮЧЕНА (Ручной режим)")
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
local LERP_SMOOTHNESS = 0.50      -- Высокая скорость для удержания строго внутри круга

local AIMBOT_ACTIVE = false
local aimTarget = nil
local activeESP = {}

-- СОЗДАНИЕ WATERMARK И POINTS В УГЛУ ЭКРАНА
local WatermarkGui = Instance.new("ScreenGui")
local VersionLabel = Instance.new("TextLabel")
local PointsLabel = Instance.new("TextLabel")

WatermarkGui.Name = "AntiDroneVersionGUI_v6_7"
WatermarkGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
WatermarkGui.ResetOnSpawn = false

-- Название "ПВО СИСТЕМА v6.7"
VersionLabel.Parent = WatermarkGui
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(1, -260, 0, 15) 
VersionLabel.Size = UDim2.new(0, 250, 0, 25)
VersionLabel.Font = Enum.Font.SourceSansBold
VersionLabel.Text = "ПВО СИСТЕМА v6.7"
VersionLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
VersionLabel.TextSize = 22
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.TextStrokeTransparency = 0
VersionLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Счетчик очков под ПВО
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
print("[ПВО v6.7]: Индикаторы очков созданы.")
-- ЧАСТЬ 2: КНОПКА «ПВО» В СТИЛЕ ФЛАГА РОССИИ И МОДУЛЬ 3D ESP

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

-- СОЗДАНИЕ КНОПКИ ТРИКОЛОР СТРОГО ПОД POINTS
local FlagGui = Instance.new("ScreenGui")
local MainButtonFrame = Instance.new("Frame")
local WhiteStrip = Instance.new("Frame")
local BlueStrip = Instance.new("Frame")
local RedStrip = Instance.new("Frame")
local ActionButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

FlagGui.Name = "RussianFlagPVO_GUI"
FlagGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
FlagGui.ResetOnSpawn = false

MainButtonFrame.Name = "MainButtonFrame"
MainButtonFrame.Parent = FlagGui
MainButtonFrame.Position = UDim2.new(1, -210, 0, 75)
MainButtonFrame.Size = UDim2.new(0, 200, 0, 42)
MainButtonFrame.BackgroundTransparency = 1
MainButtonFrame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainButtonFrame

-- Белая полоса
WhiteStrip.Parent = MainButtonFrame
WhiteStrip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WhiteStrip.Size = UDim2.new(1, 0, 0.333, 0)
WhiteStrip.BorderSizePixel = 0

-- Синяя полоса
BlueStrip.Parent = MainButtonFrame
BlueStrip.BackgroundColor3 = Color3.fromRGB(0, 57, 166)
BlueStrip.Position = UDim2.new(0, 0, 0.333, 0)
BlueStrip.Size = UDim2.new(1, 0, 0.333, 0)
BlueStrip.BorderSizePixel = 0

-- Красная полоса
RedStrip.Parent = MainButtonFrame
RedStrip.BackgroundColor3 = Color3.fromRGB(213, 43, 30)
RedStrip.Position = UDim2.new(0, 0, 0.666, 0)
RedStrip.Size = UDim2.new(1, 0, 0.334, 0)
RedStrip.BorderSizePixel = 0

-- Прозрачная кнопка поверх флага
ActionButton.Parent = MainButtonFrame
ActionButton.BackgroundTransparency = 1
ActionButton.Size = UDim2.new(1, 0, 1, 0)
ActionButton.Font = Enum.Font.SourceSansBold
ActionButton.Text = "[ ПВО: ОТКЛЮЧЕНО ]"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 15
ActionButton.TextStrokeTransparency = 0
ActionButton.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local function clearAllESP()
    for model, espElements in pairs(activeESP) do
        for _, element in pairs(espElements) do
            if element and element.Parent then element:Destroy() end
        end
    end
    activeESP = {}
end

ActionButton.MouseButton1Click:Connect(function()
    AIMBOT_ACTIVE = not AIMBOT_ACTIVE
    if AIMBOT_ACTIVE then
        ActionButton.Text = "[ ПВО: АКТИВИРОВАНО ]"
        print("[ПВО v6.7]: АКТИВАЦИЯ НАВЕДЕНИЯ")
        task.spawn(showBattleGreeting)
    else
        ActionButton.Text = "[ ПВО: ОТКЛЮЧЕНО ]"
        print("[ПВО v6.7]: НАВЕДЕНИЕ ОТКЛЮЧЕНО")
        aimTarget = nil
        clearAllESP()
    end
end)

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
-- ЧАСТЬ 3: АЛГОРИТМ ИГНОРИРОВАНИЯ МЕТАЛЛОЛОМА И ЧИСТАЯ НАВОДКА КАМЕРЫ (РУЧНОЙ ОГОНЬ)

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
                -- Фильтрация уничтоженных дронов
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

-- ЦИКЛ СИНХРОНИЗАЦИИ ПВО (СТРЕЛЬБА УБРАНА)
RunService.RenderStepped:Connect(function()
    if AIMBOT_ACTIVE then
        aimTarget = processDronesAndGetClosest()
        
        -- Наводит строго в центр, если дрон найден и в руках Stinger-M
        if aimTarget and isHoldingStinger() and LocalPlayer.Character then
            local targetPos = aimTarget.Position
            local lookCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
            
            -- Камера плавно, но быстро центрирует дрон прямо в прицельный круг игры
            Camera.CFrame = Camera.CFrame:Lerp(lookCFrame, LERP_SMOOTHNESS)
        end
    else
        clearAllESP()
    end
end)

print("=========================================")
print("[ПВО СИСТЕМА v6.7]: Сборка завершена. Стреляйте вручную!")
print("=========================================")
