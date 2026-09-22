-- =========================================================
-- BURMALDA — UAV STRIKE v1.1 (Part 1/2)
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local DRONE_MODE = false
local AIRDEF_MODE = false

local espElements = {}
local tracerElements = {}
local droneESP = {}
local knownDrones = {}
local notifList = {}
local lastAimTarget = nil
local lastDangerTime = 0

local AIM_KEYWORD = "Drone"
local AIM_MAX_DISTANCE = 1000
local AIM_VISIBLE_DISTANCE = 5000
local LERP_SMOOTHNESS = 1.0
local NOTIF_MAX = 4
local DANGER_DISTANCE = 150
local DANGER_COOLDOWN = 2

-- ЗВУКИ
local function playSound(id, volume)
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = volume or 0.5
    s.Parent = SoundService
    s:Play()
    task.delay(3, function() s:Destroy() end)
end

local SOUND_ON     = "rbxassetid://6042053626"
local SOUND_OFF    = "rbxassetid://6042053626"
local SOUND_KILL   = "rbxassetid://4612383914"
local SOUND_LOCK   = "rbxassetid://6042053626"
local SOUND_DANGER = "rbxassetid://5149395730"

-- НАЗВАНИЕ + SAFE ZONE
local NameGui = Instance.new("ScreenGui")
NameGui.Name = "BURMALDA_Name"
NameGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
NameGui.ResetOnSpawn = false
NameGui.IgnoreGuiInset = true

local NameFrame = Instance.new("Frame")
NameFrame.Parent = NameGui
NameFrame.AnchorPoint = Vector2.new(1, 0)
NameFrame.Position = UDim2.new(1, -20, 0, 15)
NameFrame.Size = UDim2.new(0, 200, 0, 34)
NameFrame.BackgroundTransparency = 1

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = NameFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.AnchorPoint = Vector2.new(1, 0)
TitleLabel.Position = UDim2.new(1, -18, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 0, 34)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.Text = "BURMALDA"
TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.TextSize = 28
TitleLabel.TextXAlignment = Enum.TextXAlignment.Right
TitleLabel.TextStrokeTransparency = 0
TitleLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

local SafeDot = Instance.new("Frame")
SafeDot.Parent = NameFrame
SafeDot.AnchorPoint = Vector2.new(1, 0.5)
SafeDot.Position = UDim2.new(1, 0, 0.5, 0)
SafeDot.Size = UDim2.new(0, 12, 0, 12)
SafeDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
SafeDot.BorderSizePixel = 0

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = SafeDot

-- КНОПКИ + POINTS
local BtnGui = Instance.new("ScreenGui")
BtnGui.Name = "BURMALDA_Buttons"
BtnGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
BtnGui.ResetOnSpawn = false
BtnGui.IgnoreGuiInset = true

local function makeButton(text, yOffset)
    local btn = Instance.new("TextButton")
    btn.Parent = BtnGui
    btn.AnchorPoint = Vector2.new(1, 0)
    btn.Position = UDim2.new(1, -20, 0, yOffset)
    btn.Size = UDim2.new(0, 150, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn
    return btn
end

local DroneButton = makeButton("DRONE", 55)
local AirDefButton = makeButton("AIRDEF", 100)

local PointsLabel = Instance.new("TextLabel")
PointsLabel.Parent = BtnGui
PointsLabel.BackgroundTransparency = 1
PointsLabel.AnchorPoint = Vector2.new(1, 0)
PointsLabel.Position = UDim2.new(1, -20, 0, 148)
PointsLabel.Size = UDim2.new(0, 150, 0, 30)
PointsLabel.Font = Enum.Font.GothamBold
PointsLabel.Text = "Points: ..."
PointsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PointsLabel.TextSize = 22
PointsLabel.TextXAlignment = Enum.TextXAlignment.Right
PointsLabel.TextStrokeTransparency = 0
PointsLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

local function trackPoints()
    local leaderstats = LocalPlayer:WaitForChild("leaderstats", 20)
    if leaderstats then
        local pv = leaderstats:WaitForChild("Points", 20)
        if pv then
            PointsLabel.Text = "Points: " .. tostring(pv.Value)
            pv.Changed:Connect(function(v)
                PointsLabel.Text = "Points: " .. tostring(v)
            end)
        else PointsLabel.Text = "Points: N/A" end
    else PointsLabel.Text = "Points: N/A" end
end
task.spawn(trackPoints)

-- УВЕДОМЛЕНИЯ
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "BURMALDA_Notifs"
NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
NotifGui.ResetOnSpawn = false
NotifGui.IgnoreGuiInset = true

local NotifContainer = Instance.new("Frame")
NotifContainer.Parent = NotifGui
NotifContainer.AnchorPoint = Vector2.new(0.5, 1)
NotifContainer.Position = UDim2.new(0.5, 0, 0.92, 0)
NotifContainer.Size = UDim2.new(0, 400, 0, 300)
NotifContainer.BackgroundTransparency = 1

local function pushNotification(text, color, duration)
    duration = duration or 3

    local lbl = Instance.new("TextLabel")
    lbl.Parent = NotifContainer
    lbl.AnchorPoint = Vector2.new(0.5, 1)
    lbl.Position = UDim2.new(0.5, 0, 1, -#notifList * 30)
    lbl.Size = UDim2.new(1, 0, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 20
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

    table.insert(notifList, lbl)

    while #notifList > NOTIF_MAX do
        local old = table.remove(notifList, 1)
        if old and old.Parent then old:Destroy() end
    end

    for i, item in ipairs(notifList) do
        item.Position = UDim2.new(0.5, 0, 1, -(#notifList - i + 1) * 30)
    end

    task.delay(duration, function()
        if lbl and lbl.Parent then lbl:Destroy() end
        for i, item in ipairs(notifList) do
            if item == lbl then
                table.remove(notifList, i)
                break
            end
        end
        for i, item in ipairs(notifList) do
            item.Position = UDim2.new(0.5, 0, 1, -(#notifList - i + 1) * 30)
        end
    end)
end

-- НОЧЬ / ДЕНЬ
local function applyNight()
    Lighting.ClockTime = 0
    Lighting.Brightness = 0.8
    Lighting.Ambient = Color3.fromRGB(15, 15, 25)
    Lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 35)
end

local function applyDay()
    Lighting.ClockTime = 12
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(70, 70, 70)
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

-- ПРОВЕРКА КРЫШИ
local function isUnderRoof(character)
    local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    if not head then return true end
    local origin = head.Position + Vector3.new(0, 2, 0)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character, LocalPlayer.Character}
    local result = workspace:Raycast(origin, Vector3.new(0, 300, 0), params)
    return result ~= nil
end

-- АВТО-ВЫБОР ОРУЖИЯ
local PRIORITY_WEAPONS = {"Stinger-M", "Stinger", "Jammer", "AV-47"}

local function findToolByName(name)
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    if not backpack then return nil end

    for _, item in ipairs(backpack:GetChildren()) do
        if item:IsA("Tool") and string.find(item.Name, name) then return item end
    end
    if char then
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Tool") and string.find(item.Name, name) then return item end
        end
    end
    return nil
end

local function hasStingerEquipped()
    local char = LocalPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildWhichIsA("Tool")
    if not tool then return false end
    return string.find(tool.Name, "Stinger")
end

local function autoEquip()
    if hasStingerEquipped() then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end

    for _, weaponName in ipairs(PRIORITY_WEAPONS) do
        local tool = findToolByName(weaponName)
        if tool then
            hum:EquipTool(tool)
            return
        end
    end
end

-- ESP ИГРОКОВ
local function makeESP(player)
    if espElements[player] then return end
    local char = player.Character
    if not char then return end
    local hl = Instance.new("Highlight")
    hl.Name = "BURMALDA_ESP"
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = char
    hl.Parent = char
    espElements[player] = hl
end

local function removeESP(player)
    local hl = espElements[player]
    if hl and hl.Parent then hl:Destroy() end
    espElements[player] = nil
end

local function clearAllESP()
    for p, _ in pairs(espElements) do removeESP(p) end
end

-- TRACERS
local TracerGui = Instance.new("ScreenGui")
TracerGui.Name = "BURMALDA_Tracers"
TracerGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
TracerGui.ResetOnSpawn = false
TracerGui.IgnoreGuiInset = true

local function makeTracer(player)
    if tracerElements[player] then return end
    local line = Instance.new("Frame")
    line.Name = "Tracer_" .. player.Name
    line.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0, 0.5)
    line.ZIndex = 5
    line.Parent = TracerGui
    tracerElements[player] = line
end

local function removeTracer(player)
    local line = tracerElements[player]
    if line and line.Parent then line:Destroy() end
    tracerElements[player] = nil
end

local function clearAllTracers()
    for p, _ in pairs(tracerElements) do removeTracer(p) end
end

-- =========================================================
-- BURMALDA — UAV STRIKE v1.1 (Part 2/2)
-- =========================================================

-- ESP ДРОНОВ + AIMBOT + КИЛЛФИД
local function isDrone(obj)
    if not obj:IsA("Model") then return false end
    local n = obj.Name
    return string.find(n, AIM_KEYWORD) or string.find(n, "UAV")
end

local function getDronePart(drone)
    return drone:FindFirstChild("HumanoidRootPart")
        or drone:FindFirstChild("Body")
        or drone:FindFirstChild("MainPart")
        or drone:FindFirstChildWhichIsA("BasePart")
end

local function createDroneESP(drone, part)
    if droneESP[drone] then return end

    local hl = Instance.new("Highlight")
    hl.Name = "BURMALDA_DroneESP"
    hl.FillColor = Color3.fromRGB(255, 0, 0)
    hl.FillTransparency = 0.6
    hl.OutlineColor = Color3.fromRGB(255, 0, 0)
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = drone
    hl.Parent = drone

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BURMALDA_DroneText"
    billboard.Size = UDim2.new(0, 260, 0, 30)
    billboard.AlwaysOnTop = true
    billboard.ExtentsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = part
    billboard.Parent = part

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextStrokeTransparency = 0
    text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    text.Parent = billboard

    droneESP[drone] = { Highlight = hl, Billboard = billboard, Text = text }
end

local function removeDroneESP(drone)
    local data = droneESP[drone]
    if data then
        if data.Highlight and data.Highlight.Parent then data.Highlight:Destroy() end
        if data.Billboard and data.Billboard.Parent then data.Billboard:Destroy() end
    end
    droneESP[drone] = nil
end

local function clearAllDroneESP()
    for drone, _ in pairs(droneESP) do removeDroneESP(drone) end
end

local function processDrones()
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closest = nil
    local closestDist = AIM_MAX_DISTANCE
    local seenNow = {}

    for _, obj in pairs(workspace:GetDescendants()) do
        if isDrone(obj) then
            seenNow[obj] = true
            local part = getDronePart(obj)
            if part then
                local pos = part.Position
                if pos.Y >= 10 then
                    local distance = (pos - myRoot.Position).Magnitude

                    if distance <= AIM_VISIBLE_DISTANCE then
                        createDroneESP(obj, part)
                        local data = droneESP[obj]
                        if data and data.Text then
                            if distance <= AIM_MAX_DISTANCE then
                                data.Text.Text = string.format("✅ГОТОВ К ЗАХВАТУ %dM", math.floor(distance))
                            else
                                data.Text.Text = string.format("🛸%dM", math.floor(distance))
                            end
                        end
                    else
                        if droneESP[obj] then removeDroneESP(obj) end
                    end

                    if distance < closestDist then
                        closestDist = distance
                        closest = part
                    end
                else
                    if droneESP[obj] then removeDroneESP(obj) end
                end
            end
        end
    end

    -- КИЛЛФИД (зелёный)
    if AIRDEF_MODE then
        for drone, _ in pairs(knownDrones) do
            if not seenNow[drone] or not drone.Parent then
                pushNotification("ДРОН СБИТ +250 POINTS", Color3.fromRGB(0, 255, 140), 3)
                playSound(SOUND_KILL, 0.5)
            end
        end
    end
    knownDrones = seenNow

    for drone, _ in pairs(droneESP) do
        if not drone or not drone.Parent then removeDroneESP(drone) end
    end

    return closest
end

-- ОБРАБОТЧИКИ КНОПОК
local function turnOffAll()
    DRONE_MODE = false
    AIRDEF_MODE = false
    DroneButton.Text = "DRONE"
    AirDefButton.Text = "AIRDEF"
    clearAllESP()
    clearAllTracers()
    clearAllDroneESP()
    knownDrones = {}
end

DroneButton.MouseButton1Click:Connect(function()
    if AIRDEF_MODE then
        turnOffAll()
        pushNotification("ВСЁ ВЫКЛЮЧЕНО (КОНФЛИКТ)", Color3.fromRGB(255, 180, 0), 3)
        return
    end

    DRONE_MODE = not DRONE_MODE

    if DRONE_MODE then
        DroneButton.Text = "DRONE ✓"
        applyNight()
        pushNotification("DRONE ON", Color3.fromRGB(0, 255, 140), 3)
        playSound(SOUND_ON, 0.4)
    else
        DroneButton.Text = "DRONE"
        clearAllESP()
        clearAllTracers()
        pushNotification("DRONE OFF", Color3.fromRGB(180, 180, 180), 3)
        playSound(SOUND_OFF, 0.4)
    end
end)

AirDefButton.MouseButton1Click:Connect(function()
    if DRONE_MODE then
        turnOffAll()
        pushNotification("ВСЁ ВЫКЛЮЧЕНО (КОНФЛИКТ)", Color3.fromRGB(255, 180, 0), 3)
        return
    end

    AIRDEF_MODE = not AIRDEF_MODE

    if AIRDEF_MODE then
        AirDefButton.Text = "AIRDEF ✓"
        applyDay()
        pushNotification("AIRDEF ON", Color3.fromRGB(0, 200, 255), 3)
        playSound(SOUND_ON, 0.4)
    else
        AirDefButton.Text = "AIRDEF"
        clearAllDroneESP()
        knownDrones = {}
        pushNotification("AIRDEF OFF", Color3.fromRGB(180, 180, 180), 3)
        playSound(SOUND_OFF, 0.4)
    end
end)

-- ГЛАВНЫЙ ЦИКЛ
RunService.RenderStepped:Connect(function()
    local myChar = LocalPlayer.Character
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        if isUnderRoof(myChar) then
            SafeDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            SafeDot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    end

    if DRONE_MODE then
        if Lighting.ClockTime > 6 and Lighting.ClockTime < 18 then
            applyNight()
        end

        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if myRoot then
            local cam = workspace.CurrentCamera
            local screenBottom = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)

            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local char = player.Character
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    local hum = char:FindFirstChild("Humanoid")

                    if hrp and hum and hum.Health > 0 then
                        local underRoof = isUnderRoof(char)

                        makeESP(player)
                        local hl = espElements[player]
                        if hl then
                            if underRoof then
                                hl.FillColor = Color3.fromRGB(255, 0, 0)
                                hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                            else
                                hl.FillColor = Color3.fromRGB(0, 255, 0)
                                hl.OutlineColor = Color3.fromRGB(0, 255, 0)
                            end
                        end

                        if not underRoof then
                            makeTracer(player)
                            local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                            if onScreen and screenPos.Z > 0 then
                                local toV = Vector2.new(screenPos.X, screenPos.Y)
                                local delta = toV - screenBottom
                                local length = delta.Magnitude
                                local angle = math.deg(math.atan2(delta.Y, delta.X))
                                local line = tracerElements[player]
                                line.Position = UDim2.new(0, screenBottom.X, 0, screenBottom.Y)
                                line.Size = UDim2.new(0, length, 0, 1.5)
                                line.Rotation = angle
                                line.Visible = true
                            else
                                tracerElements[player].Visible = false
                            end
                        else
                            if tracerElements[player] then removeTracer(player) end
                        end
                    else
                        if espElements[player] then removeESP(player) end
                        if tracerElements[player] then removeTracer(player) end
                    end
                end
            end

            for player, _ in pairs(espElements) do
                if not player.Parent or not player.Character then removeESP(player) end
            end
            for player, _ in pairs(tracerElements) do
                if not player.Parent or not player.Character then removeTracer(player) end
            end
        end
    end

    if AIRDEF_MODE then
        if Lighting.ClockTime < 6 or Lighting.ClockTime > 18 then
            applyDay()
        end

        autoEquip()

        local target = processDrones()
        if target then
            local camPos = Camera.CFrame.Position
            local lookCFrame = CFrame.lookAt(camPos, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(lookCFrame, LERP_SMOOTHNESS)

            if target ~= lastAimTarget then
                local dist = (target.Position - camPos).Magnitude
                pushNotification(string.format("ЦЕЛЬ ЗАХВАЧЕНА %dM", math.floor(dist)), Color3.fromRGB(0, 255, 140), 2)
                playSound(SOUND_LOCK, 0.3)
                lastAimTarget = target
            end

            -- ОПАСНО! с кулдауном
            local now = tick()
            local distToMe = (target.Position - myChar.HumanoidRootPart.Position).Magnitude
            if distToMe < DANGER_DISTANCE and (now - lastDangerTime) > DANGER_COOLDOWN then
                pushNotification("ОПАСНО! ДРОН БЛИЗКО", Color3.fromRGB(255, 60, 60), 2)
                playSound(SOUND_DANGER, 0.4)
                lastDangerTime = now
            end
        else
            lastAimTarget = nil
        end
    end
end)

print("[BURMALDA v1.1]: Загружено. Всё активно.")
