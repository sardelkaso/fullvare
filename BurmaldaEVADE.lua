-- =========================================================
-- BURMALDA EVADE (Part 1/3) — UI
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- АКЦЕНТ (Neverlose голубой)
local ACCENT = Color3.fromRGB(70, 140, 255)
local ACCENT_DARK = Color3.fromRGB(40, 80, 160)
local BG = Color3.fromRGB(18, 18, 22)
local BG_PANEL = Color3.fromRGB(24, 24, 28)
local BG_CATEGORY = Color3.fromRGB(30, 30, 36)
local TEXT = Color3.fromRGB(240, 240, 245)
local TEXT_DIM = Color3.fromRGB(130, 130, 140)
local STROKE = Color3.fromRGB(50, 50, 60)

local function makeCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
end

local function makeStroke(p, col, th, tr)
    local s = Instance.new("UIStroke")
    s.Color = col or STROKE
    s.Thickness = th or 1
    s.Transparency = tr or 0.4
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
end

-- =========================================================
-- ВЕРХНЯЯ ПАНЕЛЬ (FPS | Ping | BURMALDA EVADE)
-- =========================================================
local TopGui = Instance.new("ScreenGui")
TopGui.Name = "BURMALDA_TopBar"
TopGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
TopGui.ResetOnSpawn = false
TopGui.IgnoreGuiInset = true
TopGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local TopBar = Instance.new("TextButton")
TopBar.Name = "TopBar"
TopBar.Parent = TopGui
TopBar.AnchorPoint = Vector2.new(0.5, 0)
TopBar.Position = UDim2.new(0.5, 0, 0, 10)
TopBar.Size = UDim2.new(0, 380, 0, 32)
TopBar.BackgroundColor3 = BG
TopBar.BackgroundTransparency = 0.25
TopBar.BorderSizePixel = 0
TopBar.AutoButtonColor = false
TopBar.Text = ""
makeCorner(TopBar, 8)
makeStroke(TopBar, ACCENT, 1, 0.5)

local BarTitle = Instance.new("TextLabel")
BarTitle.Parent = TopBar
BarTitle.BackgroundTransparency = 1
BarTitle.Position = UDim2.new(0, 12, 0, 0)
BarTitle.Size = UDim2.new(0, 200, 1, 0)
BarTitle.Font = Enum.Font.GothamBold
BarTitle.Text = "BURMALDA EVADE"
BarTitle.TextColor3 = ACCENT
BarTitle.TextSize = 15
BarTitle.TextXAlignment = Enum.TextXAlignment.Left

local BarFPS = Instance.new("TextLabel")
BarFPS.Parent = TopBar
BarFPS.BackgroundTransparency = 1
BarFPS.Position = UDim2.new(1, -170, 0, 0)
BarFPS.Size = UDim2.new(0, 80, 1, 0)
BarFPS.Font = Enum.Font.GothamBold
BarFPS.Text = "FPS: 60"
BarFPS.TextColor3 = TEXT
BarFPS.TextSize = 14
BarFPS.TextXAlignment = Enum.TextXAlignment.Right

local BarPing = Instance.new("TextLabel")
BarPing.Parent = TopBar
BarPing.BackgroundTransparency = 1
BarPing.Position = UDim2.new(1, -85, 0, 0)
BarPing.Size = UDim2.new(0, 75, 1, 0)
BarPing.Font = Enum.Font.GothamBold
BarPing.Text = "Ping: 0"
BarPing.TextColor3 = TEXT
BarPing.TextSize = 14
BarPing.TextXAlignment = Enum.TextXAlignment.Right

-- =========================================================
-- МЕНЮ (Neverlose style)
-- =========================================================
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "BURMALDA_Menu"
MenuGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
MenuGui.ResetOnSpawn = false
MenuGui.IgnoreGuiInset = true
MenuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MenuGui.Enabled = false

local Menu = Instance.new("Frame")
Menu.Name = "Menu"
Menu.Parent = MenuGui
Menu.AnchorPoint = Vector2.new(0.5, 0.5)
Menu.Position = UDim2.new(0.5, 0, 0.55, 0)
Menu.Size = UDim2.new(0, 620, 0, 360)
Menu.BackgroundColor3 = BG
Menu.BackgroundTransparency = 0.15
Menu.BorderSizePixel = 0
makeCorner(Menu, 14)
makeStroke(Menu, ACCENT, 1, 0.4)

-- Заголовок меню
local MenuHeader = Instance.new("Frame")
MenuHeader.Parent = Menu
MenuHeader.Size = UDim2.new(1, 0, 0, 44)
MenuHeader.BackgroundColor3 = BG_PANEL
MenuHeader.BackgroundTransparency = 0.3
MenuHeader.BorderSizePixel = 0
makeCorner(MenuHeader, 14)

local MenuHeaderFix = Instance.new("Frame")
MenuHeaderFix.Parent = MenuHeader
MenuHeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
MenuHeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
MenuHeaderFix.BackgroundColor3 = BG_PANEL
MenuHeaderFix.BackgroundTransparency = 0.3
MenuHeaderFix.BorderSizePixel = 0

local AccentLine = Instance.new("Frame")
AccentLine.Parent = MenuHeader
AccentLine.Position = UDim2.new(0, 0, 1, -2)
AccentLine.Size = UDim2.new(1, 0, 0, 2)
AccentLine.BackgroundColor3 = ACCENT
AccentLine.BorderSizePixel = 0

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Parent = MenuHeader
MenuTitle.BackgroundTransparency = 1
MenuTitle.Position = UDim2.new(0, 18, 0, 0)
MenuTitle.Size = UDim2.new(1, -36, 1, 0)
MenuTitle.Font = Enum.Font.GothamBlack
MenuTitle.Text = "BURMALDA EVADE"
MenuTitle.TextColor3 = TEXT
MenuTitle.TextSize = 20
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left

local MenuVersion = Instance.new("TextLabel")
MenuVersion.Parent = MenuHeader
MenuVersion.BackgroundTransparency = 1
MenuVersion.AnchorPoint = Vector2.new(1, 0.5)
MenuVersion.Position = UDim2.new(1, -18, 0.5, 0)
MenuVersion.Size = UDim2.new(0, 100, 1, 0)
MenuVersion.Font = Enum.Font.GothamBold
MenuVersion.Text = "v1.0"
MenuVersion.TextColor3 = ACCENT
MenuVersion.TextSize = 13
MenuVersion.TextXAlignment = Enum.TextXAlignment.Right

-- =========================================================
-- КАТЕГОРИИ
-- =========================================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = Menu
ContentFrame.Position = UDim2.new(0, 15, 0, 58)
ContentFrame.Size = UDim2.new(1, -30, 1, -73)
ContentFrame.BackgroundTransparency = 1

-- функция создания категории
local function makeCategory(title, xOffset, width)
    local cat = Instance.new("Frame")
    cat.Parent = ContentFrame
    cat.Position = UDim2.new(0, xOffset, 0, 0)
    cat.Size = UDim2.new(0, width, 1, 0)
    cat.BackgroundColor3 = BG_CATEGORY
    cat.BackgroundTransparency = 0.3
    cat.BorderSizePixel = 0
    makeCorner(cat, 10)
    makeStroke(cat, STROKE, 1, 0.5)

    local catTitle = Instance.new("TextLabel")
    catTitle.Parent = cat
    catTitle.BackgroundTransparency = 1
    catTitle.Position = UDim2.new(0, 14, 0, 8)
    catTitle.Size = UDim2.new(1, -28, 0, 22)
    catTitle.Font = Enum.Font.GothamBold
    catTitle.Text = title
    catTitle.TextColor3 = ACCENT
    catTitle.TextSize = 14
    catTitle.TextXAlignment = Enum.TextXAlignment.Left

    return cat
end

local MovementCat = makeCategory("MOVEMENT", 0, 185)
local VisualsCat = makeCategory("VISUALS", 200, 185)
local MiscCat = makeCategory("MISC", 400, 185)

-- =========================================================
-- TOGGLE (Neverlose style)
-- =========================================================
local toggleStates = {}

local function makeToggle(parent, label, keyName, yPos)
    local holder = Instance.new("TextButton")
    holder.Parent = parent
    holder.BackgroundTransparency = 1
    holder.Position = UDim2.new(0, 10, 0, yPos)
    holder.Size = UDim2.new(1, -20, 0, 32)
    holder.Text = ""
    holder.AutoButtonColor = false

    local labelText = Instance.new("TextLabel")
    labelText.Parent = holder
    labelText.BackgroundTransparency = 1
    labelText.Position = UDim2.new(0, 0, 0, 0)
    labelText.Size = UDim2.new(1, -50, 1, 0)
    labelText.Font = Enum.Font.GothamBold
    labelText.Text = label
    labelText.TextColor3 = TEXT
    labelText.TextSize = 13
    labelText.TextXAlignment = Enum.TextXAlignment.Left

    -- контейнер переключателя
    local switchBg = Instance.new("Frame")
    switchBg.Parent = holder
    switchBg.AnchorPoint = Vector2.new(1, 0.5)
    switchBg.Position = UDim2.new(1, 0, 0.5, 0)
    switchBg.Size = UDim2.new(0, 38, 0, 20)
    switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    switchBg.BorderSizePixel = 0
    makeCorner(switchBg, 10)

    local switchStroke = Instance.new("UIStroke")
    switchStroke.Color = STROKE
    switchStroke.Thickness = 1
    switchStroke.Transparency = 0.5
    switchStroke.Parent = switchBg

    local knob = Instance.new("Frame")
    knob.Parent = switchBg
    knob.AnchorPoint = Vector2.new(0, 0.5)
    knob.Position = UDim2.new(0, 2, 0.5, 0)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.BackgroundColor3 = Color3.fromRGB(220, 220, 230)
    knob.BorderSizePixel = 0
    makeCorner(knob, 8)

    toggleStates[keyName] = false

    local function updateVisual(state)
        local TweenService = game:GetService("TweenService")
        local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        if state then
            TweenService:Create(switchBg, ti, {BackgroundColor3 = ACCENT}):Play()
            TweenService:Create(switchStroke, ti, {Color = ACCENT, Transparency = 0}):Play()
            TweenService:Create(knob, ti, {Position = UDim2.new(0, 20, 0.5, 0)}):Play()
            TweenService:Create(labelText, ti, {TextColor3 = ACCENT}):Play()
        else
            TweenService:Create(switchBg, ti, {BackgroundColor3 = Color3.fromRGB(40, 40, 48)}):Play()
            TweenService:Create(switchStroke, ti, {Color = STROKE, Transparency = 0.5}):Play()
            TweenService:Create(knob, ti, {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
            TweenService:Create(labelText, ti, {TextColor3 = TEXT}):Play()
        end
    end

    holder.MouseButton1Click:Connect(function()
        toggleStates[keyName] = not toggleStates[keyName]
        updateVisual(toggleStates[keyName])
        if _G.BURMALDA_TOGGLE_CALLBACK then
            _G.BURMALDA_TOGGLE_CALLBACK(keyName, toggleStates[keyName])
        end
    end)

    return holder
end

-- MOVEMENT
makeToggle(MovementCat, "Noclip", "noclip", 38)
makeToggle(MovementCat, "Fly", "fly", 74)
makeToggle(MovementCat, "Speed (×2)", "speed", 110)
makeToggle(MovementCat, "Bhop", "bhop", 146)

-- VISUALS
makeToggle(VisualsCat, "ESP Nextbot", "esp_nextbot", 38)
makeToggle(VisualsCat, "ESP Players", "esp_players", 74)
makeToggle(VisualsCat, "ESP Downed", "esp_downed", 110)
makeToggle(VisualsCat, "Tracers Downed", "tracers_downed", 146)
makeToggle(VisualsCat, "Full Bright", "fullbright", 182)

-- MISC
makeToggle(MiscCat, "Auto Revive", "auto_revive", 38)

-- =========================================================
-- ОТКРЫТИЕ / ЗАКРЫТИЕ МЕНЮ
-- =========================================================
TopBar.MouseButton1Click:Connect(function()
    MenuGui.Enabled = not MenuGui.Enabled
end)

-- =========================================================
-- ОБНОВЛЕНИЕ FPS / PING
-- =========================================================
local fps = 0
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local now = tick()
    if now - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = now
        BarFPS.Text = "FPS: " .. tostring(fps)
    end

    local ping = 0
    pcall(function()
        ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
    end)
    BarPing.Text = "Ping: " .. tostring(ping)
end)

-- сохранить toggle-стейты в _G для других частей
_G.BURMALDA_TOGGLES = toggleStates
-- =========================================================
-- BURMALDA EVADE (Part 2/3) — Visuals
-- =========================================================

local espNextbot = {}
local espPlayers = {}
local espDowned = {}
local tracersDowned = {}

-- =========================================================
-- ОПРЕДЕЛЕНИЕ NEXTBOT'ОВ И DOWNED
-- =========================================================
local function isNextbot(obj)
    if not obj or not obj.Parent then return false end
    if not obj:IsA("Model") then return false end
    -- Nextbot'ы обычно с Humanoid + без Player
    local hum = obj:FindFirstChildWhichIsA("Humanoid")
    if not hum then return false end
    if Players:GetPlayerFromCharacter(obj) then return false end
    -- часто содержат "Nextbot" в имени, но не всегда
    return true
end

local function isDowned(character)
    if not character or not character.Parent then return false end
    local hum = character:FindFirstChildWhichIsA("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    -- Downed обычно = Humanoid.RootPart.Anchored или PlatformStand, либо спец-анимация
    -- в Evade упавший игрок лежит, у него Humanoid.Sit = true или спец-состояние
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    -- эвристика: если игрок лежит (Humanoid.Sit или PlatformStand) или низко над землёй
    if hum.Sit then return true end
    if hum.PlatformStand then return true end
    return false
end

-- =========================================================
-- ESP: подсветка
-- =========================================================
local function applyHighlight(target, color)
    local existing = target:FindFirstChild("BURMALDA_HL")
    if existing then
        existing.FillColor = color
        existing.OutlineColor = color
        return existing
    end
    local hl = Instance.new("Highlight")
    hl.Name = "BURMALDA_HL"
    hl.FillColor = color
    hl.FillTransparency = 0.55
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = target
    hl.Parent = target
    return hl
end

local function removeHighlight(target)
    local hl = target:FindFirstChild("BURMALDA_HL")
    if hl then hl:Destroy() end
end

-- =========================================================
-- ТРЕЙСЕРЫ ДО DOWNED
-- =========================================================
local TracerGui = Instance.new("ScreenGui")
TracerGui.Name = "BURMALDA_Tracers"
TracerGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
TracerGui.ResetOnSpawn = false
TracerGui.IgnoreGuiInset = true
TracerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function makeTracerLine(name)
    local line = Instance.new("Frame")
    line.Name = name
    line.BackgroundColor3 = ACCENT
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0, 0.5)
    line.ZIndex = 5
    line.Parent = TracerGui
    return line
end

local function removeTracerLine(line)
    if line and line.Parent then line:Destroy() end
end

-- =========================================================
-- FULL BRIGHT
-- =========================================================
local fullbrightWasOn = false
local fullbrightBackup = {}

local function enableFullBright()
    fullbrightBackup.ClockTime = Lighting.ClockTime
    fullbrightBackup.Brightness = Lighting.Brightness
    fullbrightBackup.Ambient = Lighting.Ambient
    fullbrightBackup.OutdoorAmbient = Lighting.OutdoorAmbient
    fullbrightBackup.GlobalShadows = Lighting.GlobalShadows
    fullbrightBackup.FogEnd = Lighting.FogEnd
    fullbrightBackup.FogStart = Lighting.FogStart

    Lighting.ClockTime = 12
    Lighting.Brightness = 3
    Lighting.Ambient = Color3.fromRGB(180, 180, 180)
    Lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.FogStart = 0

    if not Lighting:FindFirstChild("BURMALDA_FB") then
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Name = "BURMALDA_FB"
        cc.Brightness = 0.25
        cc.Contrast = 0
        cc.Saturation = 0.1
        cc.Parent = Lighting
    end
    fullbrightWasOn = true
end

local function disableFullBright()
    if not fullbrightWasOn then return end
    if fullbrightBackup.ClockTime then Lighting.ClockTime = fullbrightBackup.ClockTime end
    if fullbrightBackup.Brightness then Lighting.Brightness = fullbrightBackup.Brightness end
    if fullbrightBackup.Ambient then Lighting.Ambient = fullbrightBackup.Ambient end
    if fullbrightBackup.OutdoorAmbient then Lighting.OutdoorAmbient = fullbrightBackup.OutdoorAmbient end
    if fullbrightBackup.GlobalShadows ~= nil then Lighting.GlobalShadows = fullbrightBackup.GlobalShadows end
    if fullbrightBackup.FogEnd then Lighting.FogEnd = fullbrightBackup.FogEnd end
    if fullbrightBackup.FogStart then Lighting.FogStart = fullbrightBackup.FogStart end

    local cc = Lighting:FindFirstChild("BURMALDA_FB")
    if cc then cc:Destroy() end
    fullbrightWasOn = false
end

-- =========================================================
-- ОБРАБОТЧИК ВКЛЮЧЕНИЯ ФУНКЦИЙ
-- =========================================================
_G.BURMALDA_VISUAL_CALLBACK = function(key, state)
    if key == "fullbright" then
        if state then enableFullBright() else disableFullBright() end
    end
end

-- =========================================================
-- ЦИКЛ ОБНОВЛЕНИЯ VISUALS
-- =========================================================
local toggles = _G.BURMALDA_TOGGLES or {}

RunService.RenderStepped:Connect(function()
    -- ESP NEXTBOT
    if toggles.esp_nextbot then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if isNextbot(obj) then
                applyHighlight(obj, Color3.fromRGB(255, 40, 40))
                espNextbot[obj] = true
            end
        end
        -- чистка мёртвых
        for obj, _ in pairs(espNextbot) do
            if not obj or not obj.Parent or not isNextbot(obj) then
                if obj and obj.Parent then removeHighlight(obj) end
                espNextbot[obj] = nil
            end
        end
    else
        for obj, _ in pairs(espNextbot) do
            if obj and obj.Parent then removeHighlight(obj) end
            espNextbot[obj] = nil
        end
    end

    -- ESP PLAYERS
    if toggles.esp_players then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local char = player.Character
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health > 0 then
                    applyHighlight(char, Color3.fromRGB(0, 255, 140))
                    espPlayers[player] = true
                end
            end
        end
        for player, _ in pairs(espPlayers) do
            if not player.Parent or not player.Character then
                if player.Character then removeHighlight(player.Character) end
                espPlayers[player] = nil
            end
        end
    else
        for player, _ in pairs(espPlayers) do
            if player.Character then removeHighlight(player.Character) end
            espPlayers[player] = nil
        end
    end

    -- ESP DOWNED
    if toggles.esp_downed then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local char = player.Character
                if isDowned(char) then
                    applyHighlight(char, Color3.fromRGB(255, 200, 0))
                    espDowned[player] = true
                end
            end
        end
        for player, _ in pairs(espDowned) do
            if not player.Parent or not player.Character or not isDowned(player.Character) then
                if player.Character then removeHighlight(player.Character) end
                espDowned[player] = nil
            end
        end
    else
        for player, _ in pairs(espDowned) do
            if player.Character then removeHighlight(player.Character) end
            espDowned[player] = nil
        end
    end

    -- TRACERS DOWNED
    if toggles.tracers_downed then
        local cam = workspace.CurrentCamera
        local screenBottom = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and isDowned(player.Character) then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if not tracersDowned[player] then
                        tracersDowned[player] = makeTracerLine("Downed_" .. player.Name)
                    end
                    local line = tracersDowned[player]
                    local screenPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    if onScreen and screenPos.Z > 0 then
                        local toV = Vector2.new(screenPos.X, screenPos.Y)
                        local delta = toV - screenBottom
                        local length = delta.Magnitude
                        local angle = math.deg(math.atan2(delta.Y, delta.X))
                        line.Position = UDim2.new(0, screenBottom.X, 0, screenBottom.Y)
                        line.Size = UDim2.new(0, length, 0, 1.5)
                        line.Rotation = angle
                        line.Visible = true
                    else
                        line.Visible = false
                    end
                end
            else
                if tracersDowned[player] then
                    removeTracerLine(tracersDowned[player])
                    tracersDowned[player] = nil
                end
            end
        end

        for player, line in pairs(tracersDowned) do
            if not player.Parent then
                removeTracerLine(line)
                tracersDowned[player] = nil
            end
        end
    else
        for player, line in pairs(tracersDowned) do
            removeTracerLine(line)
        end
        tracersDowned = {}
    end
end)
-- =========================================================
-- BURMALDA EVADE (Part 3/3) — Movement + Auto Revive
-- =========================================================

local toggles = _G.BURMALDA_TOGGLES or {}

-- =========================================================
-- NOCLIP
-- =========================================================
local noclipConn = nil

local function startNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

local function stopNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- =========================================================
-- SPEED (×2)
-- =========================================================
local SPEED_MULTIPLIER = 2
local speedBackup = nil
local speedConn = nil

local function startSpeed()
    if speedConn then return end
    speedConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            if not speedBackup then
                speedBackup = hum.WalkSpeed
            end
            hum.WalkSpeed = speedBackup * SPEED_MULTIPLIER
        end
    end)
end

local function stopSpeed()
    if speedConn then
        speedConn:Disconnect()
        speedConn = nil
    end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if hum and speedBackup then
        hum.WalkSpeed = speedBackup
    end
    speedBackup = nil
end

-- =========================================================
-- BHOP
-- =========================================================
local bhopConn = nil

local function startBhop()
    if bhopConn then return end
    bhopConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        if hum and hum.MoveDirection.Magnitude > 0 then
            hum.Jump = true
        end
    end)
end

local function stopBhop()
    if bhopConn then
        bhopConn:Disconnect()
        bhopConn = nil
    end
end

-- =========================================================
-- FLY (Minecraft style) — активируется тумблером
-- =========================================================
local flyActive = false
local flyConn = nil
local flyGyro = nil
local flyVelocity = nil

local function startFly()
    if flyActive then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flyActive = true

    -- создаём BodyVelocity + BodyGyro
    local bv = Instance.new("BodyVelocity")
    bv.Name = "BURMALDA_FlyVelocity"
    bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bv.Velocity = Vector3.zero
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.Name = "BURMALDA_FlyGyro"
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bg.P = 10000
    bg.D = 100
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    flyVelocity = bv
    flyGyro = bg

    flyConn = RunService.RenderStepped:Connect(function()
        local char2 = LocalPlayer.Character
        local hrp2 = char2 and char2:FindFirstChild("HumanoidRootPart")
        if not hrp2 or not flyVelocity or not flyGyro then return end

        local cam = workspace.CurrentCamera
        local moveDir = Vector3.zero

        -- WASD через Humanoid.MoveDirection (мобильный джойстик сам даёт направление)
        local hum = char2:FindFirstChildWhichIsA("Humanoid")
        if hum and hum.MoveDirection.Magnitude > 0 then
            moveDir = hum.MoveDirection * 60
        end

        -- вертикаль: кнопки прыжка/приседа (на телефоне через UserInputService)
        local jumpHeld = false
        local downHeld = false

        -- проверяем состояние джойстика через HumanoidStateType (простой вариант)
        if hum then
            if hum:GetState() == Enum.HumanoidStateType.Jumping then
                jumpHeld = true
            end
            if hum:GetState() == Enum.HumanoidStateType.Freefall then
                jumpHeld = true
            end
        end

        -- для мобилы удобнее: тащим за экран — летим
        -- упрощаем: только горизонталь + фикс высота
        moveDir = moveDir + Vector3.new(0, 0, 0)

        flyVelocity.Velocity = moveDir
        flyGyro.CFrame = CFrame.new(hrp2.Position, hrp2.Position + cam.CFrame.LookVector)
    end)
end

local function stopFly()
    flyActive = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyVelocity then flyVelocity:Destroy() flyVelocity = nil end
    if flyGyro then flyGyro:Destroy() flyGyro = nil end
end

-- =========================================================
-- AUTO REVIVE
-- =========================================================
local autoReviveConn = nil

local function startAutoRevive()
    if autoReviveConn then return end
    autoReviveConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        if not hum then return end

        -- Evade: поднятие через RemoteEvent. Точное имя может меняться.
        -- Пробуем общие варианты через ReplicatedStorage.
        local rs = game:GetService("ReplicatedStorage")

        -- Ищем RemoteEvent с намёком на revive
        for _, obj in ipairs(rs:GetDescendants()) do
            if obj:IsA("RemoteEvent") and (string.find(obj.Name:lower(), "revive") or string.find(obj.Name:lower(), "heal") or string.find(obj.Name:lower(), "respawn")) then
                pcall(function()
                    obj:FireServer()
                end)
            end
        end
    end)
end

local function stopAutoRevive()
    if autoReviveConn then
        autoReviveConn:Disconnect()
        autoReviveConn = nil
    end
end

-- =========================================================
-- ОБРАБОТЧИК ПЕРЕКЛЮЧАТЕЛЕЙ
-- =========================================================
_G.BURMALDA_TOGGLE_CALLBACK = function(key, state)
    if key == "noclip" then
        if state then startNoclip() else stopNoclip() end
    elseif key == "speed" then
        if state then startSpeed() else stopSpeed() end
    elseif key == "bhop" then
        if state then startBhop() else stopBhop() end
    elseif key == "fly" then
        if state then startFly() else stopFly() end
    elseif key == "auto_revive" then
        if state then startAutoRevive() else stopAutoRevive() end
    end

    -- передаём в visual callback
    if _G.BURMALDA_VISUAL_CALLBACK then
        _G.BURMALDA_VISUAL_CALLBACK(key, state)
    end
end

-- ресет при смерти персонажа
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if toggles.noclip then startNoclip() end
    if toggles.speed then speedBackup = nil startSpeed() end
    if toggles.bhop then startBhop() end
    if toggles.fly then flyActive = false startFly() end
end)

print("[BURMALDA EVADE]: Загружено. Всё активно.")
