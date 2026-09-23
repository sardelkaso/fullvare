
-- =========================================================
-- BURMALDA EVADE v2.0 (Part 1/2) — UI + Movement
-- Credits: Soldix, Emerson, EzOpenSource
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ЦВЕТА (кроваво-красный акцент)
local ACCENT       = Color3.fromRGB(200, 30, 40)
local ACCENT_LIGHT = Color3.fromRGB(255, 60, 70)
local ACCENT_DARK  = Color3.fromRGB(120, 15, 20)
local BG           = Color3.fromRGB(15, 15, 20)
local BG_PANEL     = Color3.fromRGB(22, 22, 28)
local BG_CATEGORY  = Color3.fromRGB(28, 28, 36)
local TEXT         = Color3.fromRGB(240, 240, 245)
local TEXT_DIM     = Color3.fromRGB(140, 140, 155)
local STROKE       = Color3.fromRGB(50, 50, 60)

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

local function makeGradient(p, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 0
    g.Parent = p
end

-- =========================================================
-- ВЕРХНЯЯ ПАНЕЛЬ (BURMALDA EVADE | FPS | Ping)
-- =========================================================
local TopGui = Instance.new("ScreenGui")
TopGui.Name = "BURMALDA_TopBar"
TopGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
TopGui.ResetOnSpawn = false
TopGui.IgnoreGuiInset = true
TopGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local TopBar = Instance.new("TextButton")
TopBar.Parent = TopGui
TopBar.AnchorPoint = Vector2.new(0.5, 0)
TopBar.Position = UDim2.new(0.5, 0, 0, 10)
TopBar.Size = UDim2.new(0, 380, 0, 32)
TopBar.BackgroundColor3 = BG
TopBar.BackgroundTransparency = 0.2
TopBar.BorderSizePixel = 0
TopBar.AutoButtonColor = false
TopBar.Text = ""
makeCorner(TopBar, 8)
makeStroke(TopBar, ACCENT, 1, 0.3)

local BarTitle = Instance.new("TextLabel")
BarTitle.Parent = TopBar
BarTitle.BackgroundTransparency = 1
BarTitle.Position = UDim2.new(0, 12, 0, 0)
BarTitle.Size = UDim2.new(0, 220, 1, 0)
BarTitle.Font = Enum.Font.GothamBold
BarTitle.Text = "BURMALDA EVADE"
BarTitle.TextColor3 = ACCENT_LIGHT
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
-- ГЛАВНОЕ МЕНЮ
-- =========================================================
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "BURMALDA_Menu"
MenuGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
MenuGui.ResetOnSpawn = false
MenuGui.IgnoreGuiInset = true
MenuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MenuGui.Enabled = false

local Menu = Instance.new("Frame")
Menu.Parent = MenuGui
Menu.AnchorPoint = Vector2.new(0.5, 0.5)
Menu.Position = UDim2.new(0.5, 0, 0.55, 0)
Menu.Size = UDim2.new(0, 660, 0, 400)
Menu.BackgroundColor3 = BG
Menu.BackgroundTransparency = 0.1
Menu.BorderSizePixel = 0
makeCorner(Menu, 14)
makeStroke(Menu, ACCENT, 1, 0.3)

-- Заголовок
local MenuHeader = Instance.new("Frame")
MenuHeader.Parent = Menu
MenuHeader.Size = UDim2.new(1, 0, 0, 46)
MenuHeader.BackgroundColor3 = BG_PANEL
MenuHeader.BackgroundTransparency = 0.3
MenuHeader.BorderSizePixel = 0
makeCorner(MenuHeader, 14)

local HeaderFix = Instance.new("Frame")
HeaderFix.Parent = MenuHeader
HeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
HeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
HeaderFix.BackgroundColor3 = BG_PANEL
HeaderFix.BackgroundTransparency = 0.3
HeaderFix.BorderSizePixel = 0

local AccentLine = Instance.new("Frame")
AccentLine.Parent = MenuHeader
AccentLine.Position = UDim2.new(0, 0, 1, -2)
AccentLine.Size = UDim2.new(1, 0, 0, 2)
AccentLine.BackgroundColor3 = ACCENT
AccentLine.BorderSizePixel = 0
makeGradient(AccentLine, ACCENT, ACCENT_LIGHT, 0)

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Parent = MenuHeader
MenuTitle.BackgroundTransparency = 1
MenuTitle.Position = UDim2.new(0, 18, 0, 0)
MenuTitle.Size = UDim2.new(1, -100, 1, 0)
MenuTitle.Font = Enum.Font.GothamBlack
MenuTitle.Text = "BURMALDA EVADE"
MenuTitle.TextColor3 = TEXT
MenuTitle.TextSize = 20
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left

local MenuSub = Instance.new("TextLabel")
MenuSub.Parent = MenuHeader
MenuSub.BackgroundTransparency = 1
MenuSub.AnchorPoint = Vector2.new(1, 0.5)
MenuSub.Position = UDim2.new(1, -18, 0.5, 0)
MenuSub.Size = UDim2.new(0, 100, 1, 0)
MenuSub.Font = Enum.Font.GothamBold
MenuSub.Text = "v2.0"
MenuSub.TextColor3 = ACCENT_LIGHT
MenuSub.TextSize = 13
MenuSub.TextXAlignment = Enum.TextXAlignment.Right

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = Menu
ContentFrame.Position = UDim2.new(0, 15, 0, 60)
ContentFrame.Size = UDim2.new(1, -30, 1, -75)
ContentFrame.BackgroundTransparency = 1

-- Категории
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
    catTitle.TextColor3 = ACCENT_LIGHT
    catTitle.TextSize = 14
    catTitle.TextXAlignment = Enum.TextXAlignment.Left

    return cat
end

local MovementCat = makeCategory("MOVEMENT", 0, 195)
local VisualsCat  = makeCategory("VISUALS", 210, 195)
local MiscCat     = makeCategory("MISC", 420, 195)

-- =========================================================
-- TOGGLE (Neverlose style + красный акцент)
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
    labelText.Size = UDim2.new(1, -50, 1, 0)
    labelText.Font = Enum.Font.GothamBold
    labelText.Text = label
    labelText.TextColor3 = TEXT
    labelText.TextSize = 13
    labelText.TextXAlignment = Enum.TextXAlignment.Left

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
        local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        if state then
            TweenService:Create(switchBg, ti, {BackgroundColor3 = ACCENT}):Play()
            TweenService:Create(switchStroke, ti, {Color = ACCENT_LIGHT, Transparency = 0}):Play()
            TweenService:Create(knob, ti, {Position = UDim2.new(0, 20, 0.5, 0)}):Play()
            TweenService:Create(labelText, ti, {TextColor3 = ACCENT_LIGHT}):Play()
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
end

-- MOVEMENT
makeToggle(MovementCat, "Noclip", "noclip", 38)
makeToggle(MovementCat, "Fly", "fly", 74)
makeToggle(MovementCat, "Speed (x3)", "speed", 110)
makeToggle(MovementCat, "Bhop", "bhop", 146)

-- VISUALS
makeToggle(VisualsCat, "ESP Nextbot", "esp_nextbot", 38)
makeToggle(VisualsCat, "ESP Players", "esp_players", 74)
makeToggle(VisualsCat, "ESP Downed", "esp_downed", 110)
makeToggle(VisualsCat, "Tracers Downed", "tracers_downed", 146)
makeToggle(VisualsCat, "Full Bright", "fullbright", 182)

-- MISC
makeToggle(MiscCat, "Auto Revive", "auto_revive", 38)
makeToggle(MiscCat, "Anti-AFK", "anti_afk", 74)

TopBar.MouseButton1Click:Connect(function()
    MenuGui.Enabled = not MenuGui.Enabled
end)

-- FPS / PING
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames = frames + 1
    local now = tick()
    if now - lastTime >= 1 then
        BarFPS.Text = "FPS: " .. tostring(frames)
        frames = 0
        lastTime = now
    end
    local ping = 0
    pcall(function()
        ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
    end)
    BarPing.Text = "Ping: " .. tostring(ping)
end)

_G.BURMALDA_TOGGLES = toggleStates
-- =========================================================
-- BURMALDA EVADE v2.0 (Part 2/2) — Функции
-- =========================================================

local toggles = _G.BURMALDA_TOGGLES or {}

-- =========================================================
-- MOVEMENT
-- =========================================================

-- NOCLIP
local noclipConn = nil
local function startNoclip()
    if noclipConn then return end
    noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
end
local function stopNoclip()
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

-- FLY (WASD + Space/Ctrl для вертикали)
local flying = false
local flyConn = nil
local function startFly()
    if flying then return end
    flying = true
    flyConn = RunService.RenderStepped:Connect(function()
        if not flying then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end

        hrp.AssemblyLinearVelocity = moveDir.Magnitude > 0 and moveDir.Unit * 60 or Vector3.zero
    end)
end
local function stopFly()
    flying = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.AssemblyLinearVelocity = Vector3.zero end
end

-- SPEED (x3 CFrame Boost — обходит детект)
local cframeSpeedConn = nil
local SPEED_MULT = 3
local function startSpeed()
    if cframeSpeedConn then return end
    cframeSpeedConn = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hum and hrp then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + moveDir * 16 * SPEED_MULT * 0.08
            end
        end
    end)
end
local function stopSpeed()
    if cframeSpeedConn then cframeSpeedConn:Disconnect() cframeSpeedConn = nil end
end

-- BHOP (StateChanged based — правильный, не вверх)
local bhopConn = nil
local function startBhop()
    if bhopConn then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    bhopConn = hum.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Landed then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end
local function stopBhop()
    if bhopConn then bhopConn:Disconnect() bhopConn = nil end
end

-- =========================================================
-- VISUALS
-- =========================================================

local espElements = {}  -- [character] = {Highlight, Billboard, Text}
local tracersDowned = {}

-- ESP создание
local function createESP(target, color, labelText, yOffset, isModel)
    if not target or not target.Parent then return end
    if espElements[target] then return end

    local hl = Instance.new("Highlight")
    hl.Name = "BURMALDA_ESP"
    hl.Adornee = target
    hl.FillColor = color
    hl.FillTransparency = 0.55
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = target

    local mainPart = target:FindFirstChild("Head")
        or target:FindFirstChild("HumanoidRootPart")
        or target:FindFirstChild("Hitbox")
        or target:FindFirstChildWhichIsA("BasePart")

    local billboard, text
    if mainPart then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "BURMALDA_ESP_Text"
        billboard.Size = UDim2.new(0, 120, 0, 30)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, yOffset or 2, 0)
        billboard.Adornee = mainPart
        billboard.Parent = mainPart

        text = Instance.new("TextLabel")
        text.Size = UDim2.new(1, 0, 1, 0)
        text.BackgroundTransparency = 1
        text.Font = Enum.Font.GothamBold
        text.TextScaled = true
        text.Text = labelText or ""
        text.TextColor3 = color
        text.TextStrokeTransparency = 0.4
        text.Parent = billboard
    end

    espElements[target] = { Highlight = hl, Billboard = billboard, Text = text, BaseColor = color, BaseText = labelText }
end

local function removeESP(target)
    local data = espElements[target]
    if data then
        if data.Highlight and data.Highlight.Parent then data.Highlight:Destroy() end
        if data.Billboard and data.Billboard.Parent then data.Billboard:Destroy() end
    end
    espElements[target] = nil
end

local function clearAllESP()
    for target, _ in pairs(espElements) do removeESP(target) end
    espElements = {}
end

-- Обновление label дистанции
RunService.Heartbeat:Connect(function()
    for target, data in pairs(espElements) do
        if data.Text and data.Billboard and data.Billboard.Parent and data.BaseText then
            local basePart = data.Billboard.Adornee
            if basePart then
                local dist = (Camera.CFrame.Position - basePart.Position).Magnitude
                data.Text.Text = data.BaseText .. " [" .. math.floor(dist) .. "m]"
            end
        end
    end
end)

-- Downed detection (по атрибуту Downed)
local function isDowned(character)
    if not character or not character.Parent then return false end
    return character:GetAttribute("Downed") == true
end

-- TRACERS (для downed)
local TracerGui = Instance.new("ScreenGui")
TracerGui.Name = "BURMALDA_Tracers"
TracerGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
TracerGui.ResetOnSpawn = false
TracerGui.IgnoreGuiInset = true
TracerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function makeTracerLine(name, color)
    local line = Instance.new("Frame")
    line.Name = name
    line.BackgroundColor3 = color or ACCENT
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0, 0.5)
    line.ZIndex = 5
    line.Parent = TracerGui
    return line
end

local function removeTracerLine(line)
    if line and line.Parent then line:Destroy() end
end

-- FULL BRIGHT
local fbBackup = {}
local function enableFullBright()
    fbBackup.Brightness = Lighting.Brightness
    fbBackup.Ambient = Lighting.Ambient
    fbBackup.OutdoorAmbient = Lighting.OutdoorAmbient
    fbBackup.GlobalShadows = Lighting.GlobalShadows
    fbBackup.FogEnd = Lighting.FogEnd
    fbBackup.FogStart = Lighting.FogStart

    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e6
    Lighting.FogStart = 999999
end
local function disableFullBright()
    if fbBackup.Brightness then Lighting.Brightness = fbBackup.Brightness end
    if fbBackup.Ambient then Lighting.Ambient = fbBackup.Ambient end
    if fbBackup.OutdoorAmbient then Lighting.OutdoorAmbient = fbBackup.OutdoorAmbient end
    if fbBackup.GlobalShadows ~= nil then Lighting.GlobalShadows = fbBackup.GlobalShadows end
    if fbBackup.FogEnd then Lighting.FogEnd = fbBackup.FogEnd end
    if fbBackup.FogStart then Lighting.FogStart = fbBackup.FogStart end
end

-- =========================================================
-- MISC
-- =========================================================

-- AUTO REVIVE (реальный, через SetPlayerMode)
local autoReviveConn = nil
local function startAutoRevive()
    if autoReviveConn then return end
    autoReviveConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char and char:GetAttribute("Downed") == true then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.SetPlayerMode:FireServer(true)
            end)
        end
    end)
end
local function stopAutoRevive()
    if autoReviveConn then autoReviveConn:Disconnect() autoReviveConn = nil end
end

-- ANTI-AFK
local antiAfkConn = nil
local function startAntiAfk()
    if antiAfkConn then return end
    antiAfkConn = LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0, 0), Camera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Camera.CFrame)
    end)
end
local function stopAntiAfk()
    if antiAfkConn then antiAfkConn:Disconnect() antiAfkConn = nil end
end

-- =========================================================
-- ОБРАБОТЧИК ПЕРЕКЛЮЧАТЕЛЕЙ
-- =========================================================
_G.BURMALDA_TOGGLE_CALLBACK = function(key, state)
    if key == "noclip" then
        if state then startNoclip() else stopNoclip() end
    elseif key == "fly" then
        if state then startFly() else stopFly() end
    elseif key == "speed" then
        if state then startSpeed() else stopSpeed() end
    elseif key == "bhop" then
        if state then startBhop() else stopBhop() end
    elseif key == "fullbright" then
        if state then enableFullBright() else disableFullBright() end
    elseif key == "auto_revive" then
        if state then startAutoRevive() else stopAutoRevive() end
    elseif key == "anti_afk" then
        if state then startAntiAfk() else stopAntiAfk() end
    end
end

-- =========================================================
-- ГЛАВНЫЙ ЦИКЛ (ESP + Tracers)
-- =========================================================
RunService.RenderStepped:Connect(function()
    -- ESP NEXTOBOT
    if toggles.esp_nextbot then
        local botsFolder = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
        if botsFolder then
            for _, bot in ipairs(botsFolder:GetChildren()) do
                if bot:IsA("Model") and bot:FindFirstChild("Hitbox") then
                    bot.Hitbox.Transparency = 0.5
                    createESP(bot, Color3.fromRGB(220, 40, 50), bot.Name, -2)
                end
            end
        end
    else
        -- чистка некстботов
        for target, _ in pairs(espElements) do
            if target:IsA("Model") and target:FindFirstChild("Hitbox") then
                target.Hitbox.Transparency = 1
                removeESP(target)
            end
        end
    end

    -- ESP PLAYERS
    if toggles.esp_players then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    createESP(player.Character, Color3.fromRGB(60, 220, 100), player.Name, 1)
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if espElements[player.Character] then removeESP(player.Character) end
            end
        end
    end

    -- ESP DOWNED
    if toggles.esp_downed then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if isDowned(player.Character) then
                    createESP(player.Character, Color3.fromRGB(255, 200, 0), "DOWNED " .. player.Name, 1)
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and isDowned(player.Character) then
                if espElements[player.Character] then removeESP(player.Character) end
            end
        end
    end

    -- TRACERS DOWNED
    if toggles.tracers_downed then
        local screenBottom = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and isDowned(player.Character) then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Head")
                if hrp then
                    if not tracersDowned[player] then
                        tracersDowned[player] = makeTracerLine("Downed_" .. player.Name, Color3.fromRGB(255, 200, 0))
                    end
                    local line = tracersDowned[player]
                    local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
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
    else
        for player, line in pairs(tracersDowned) do
            removeTracerLine(line)
        end
        tracersDowned = {}
    end
end)

-- Автозапуск Anti-AFK при старте
startAntiAfk()

print("[BURMALDA EVADE v2.0]: Загружено. Красный акцент, всё активно.")
