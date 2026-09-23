-- =========================================================
-- BURMALDA EVADE v3.1 (Part 1/3) — UI
-- =========================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ACCENT          = Color3.fromRGB(200, 30, 40)
local ACCENT_LIGHT    = Color3.fromRGB(255, 60, 70)
local BG              = Color3.fromRGB(15, 15, 20)
local BG_SIDEBAR      = Color3.fromRGB(18, 18, 24)
local BG_BUTTON       = Color3.fromRGB(28, 28, 36)
local BG_BUTTON_HOVER = Color3.fromRGB(38, 38, 48)
local TEXT            = Color3.fromRGB(240, 240, 245)
local TEXT_DIM        = Color3.fromRGB(140, 140, 155)
local STROKE          = Color3.fromRGB(50, 50, 60)

local function makeCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = p
    return c
end

local function makeStroke(p, col, th, tr)
    local s = Instance.new("UIStroke")
    s.Color = col or STROKE
    s.Thickness = th or 1
    s.Transparency = tr or 0.4
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = p
    return s
end

local function makeGradient(p, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 0
    g.Parent = p
    return g
end

-- ВЕРХНЯЯ ПАНЕЛЬ
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

-- МЕНЮ
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
Menu.Size = UDim2.new(0, 660, 0, 420)
Menu.BackgroundColor3 = BG
Menu.BackgroundTransparency = 0.1
Menu.BorderSizePixel = 0
makeCorner(Menu, 14)
makeStroke(Menu, ACCENT, 1, 0.3)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Parent = Menu
Sidebar.Size = UDim2.new(0, 170, 1, 0)
Sidebar.BackgroundColor3 = BG_SIDEBAR
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
makeCorner(Sidebar, 14)

local SidebarFix = Instance.new("Frame")
SidebarFix.Parent = Sidebar
SidebarFix.AnchorPoint = Vector2.new(1, 0)
SidebarFix.Position = UDim2.new(1, 0, 0, 0)
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.BackgroundColor3 = BG_SIDEBAR
SidebarFix.BackgroundTransparency = 0.2
SidebarFix.BorderSizePixel = 0

local SidebarTitle = Instance.new("TextLabel")
SidebarTitle.Parent = Sidebar
SidebarTitle.BackgroundTransparency = 1
SidebarTitle.Position = UDim2.new(0, 16, 0, 14)
SidebarTitle.Size = UDim2.new(1, -32, 0, 24)
SidebarTitle.Font = Enum.Font.GothamBlack
SidebarTitle.Text = "BURMALDA"
SidebarTitle.TextColor3 = ACCENT_LIGHT
SidebarTitle.TextSize = 16
SidebarTitle.TextXAlignment = Enum.TextXAlignment.Left

local SidebarSub = Instance.new("TextLabel")
SidebarSub.Parent = Sidebar
SidebarSub.BackgroundTransparency = 1
SidebarSub.Position = UDim2.new(0, 16, 0, 36)
SidebarSub.Size = UDim2.new(1, -32, 0, 14)
SidebarSub.Font = Enum.Font.Gotham
SidebarSub.Text = "EVADE · v3.1"
SidebarSub.TextColor3 = TEXT_DIM
SidebarSub.TextSize = 11
SidebarSub.TextXAlignment = Enum.TextXAlignment.Left

local SidebarDiv = Instance.new("Frame")
SidebarDiv.Parent = Sidebar
SidebarDiv.Position = UDim2.new(0, 16, 0, 58)
SidebarDiv.Size = UDim2.new(1, -32, 0, 1)
SidebarDiv.BackgroundColor3 = STROKE
SidebarDiv.BackgroundTransparency = 0.3
SidebarDiv.BorderSizePixel = 0

-- КОНТЕНТ
local Content = Instance.new("Frame")
Content.Parent = Menu
Content.Position = UDim2.new(0, 185, 0, 15)
Content.Size = UDim2.new(1, -200, 1, -30)
Content.BackgroundTransparency = 1

local pages = {}
local categoryButtons = {}
local activeCategory = nil

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = ACCENT
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = page

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 4)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 6)
    padding.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)

    pages[name] = page
end

local function makeCategoryButton(name, yOffset)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.Position = UDim2.new(0, 12, 0, yOffset)
    btn.Size = UDim2.new(1, -24, 0, 36)
    btn.BackgroundColor3 = BG_BUTTON
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = ""
    makeCorner(btn, 8)

    local bar = Instance.new("Frame")
    bar.Parent = btn
    bar.AnchorPoint = Vector2.new(0, 0.5)
    bar.Position = UDim2.new(0, 0, 0.5, 0)
    bar.Size = UDim2.new(0, 3, 0, 0)
    bar.BackgroundColor3 = ACCENT
    bar.BorderSizePixel = 0
    makeCorner(bar, 2)

    local label = Instance.new("TextLabel")
    label.Parent = btn
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 14, 0, 0)
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.Text = name
    label.TextColor3 = TEXT_DIM
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left

    local stroke = Instance.new("UIStroke")
    stroke.Color = STROKE
    stroke.Thickness = 1
    stroke.Transparency = 0.6
    stroke.Parent = btn

    local function selectThis()
        for _, other in ipairs(categoryButtons) do
            TweenService:Create(other.Button, TweenInfo.new(0.15), {BackgroundColor3 = BG_BUTTON, BackgroundTransparency = 0.2}):Play()
            TweenService:Create(other.Bar, TweenInfo.new(0.15), {Size = UDim2.new(0, 3, 0, 0)}):Play()
            TweenService:Create(other.Label, TweenInfo.new(0.15), {TextColor3 = TEXT_DIM}):Play()
            TweenService:Create(other.Stroke, TweenInfo.new(0.15), {Color = STROKE, Transparency = 0.6}):Play()
            pages[other.Name].Visible = false
        end
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = ACCENT, BackgroundTransparency = 0}):Play()
        TweenService:Create(bar, TweenInfo.new(0.15), {Size = UDim2.new(0, 3, 0, 20)}):Play()
        TweenService:Create(label, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Color = ACCENT_LIGHT, Transparency = 0}):Play()
        pages[name].Visible = true
        activeCategory = name
    end

    btn.MouseButton1Click:Connect(selectThis)
    btn.MouseEnter:Connect(function()
        if activeCategory ~= name then
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = BG_BUTTON_HOVER}):Play()
            TweenService:Create(label, TweenInfo.new(0.1), {TextColor3 = TEXT}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if activeCategory ~= name then
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = BG_BUTTON}):Play()
            TweenService:Create(label, TweenInfo.new(0.1), {TextColor3 = TEXT_DIM}):Play()
        end
    end)

    table.insert(categoryButtons, {Button = btn, Bar = bar, Label = label, Stroke = stroke, Name = name})
    return selectThis
end

makePage("MOVEMENT")
makePage("VISUALS")
makePage("MISC")

local selectMovement = makeCategoryButton("MOVEMENT", 80)
local selectVisuals  = makeCategoryButton("VISUALS", 122)
local selectMisc     = makeCategoryButton("MISC", 164)

selectMovement()

-- TOGGLE
local toggleStates = {}

local function makeToggle(parent, label, keyName)
    local holder = Instance.new("TextButton")
    holder.Parent = parent
    holder.BackgroundColor3 = BG_BUTTON
    holder.BackgroundTransparency = 0.3
    holder.BorderSizePixel = 0
    holder.Size = UDim2.new(1, -10, 0, 36)
    holder.Text = ""
    holder.AutoButtonColor = false
    makeCorner(holder, 8)

    local holderStroke = Instance.new("UIStroke")
    holderStroke.Color = STROKE
    holderStroke.Thickness = 1
    holderStroke.Transparency = 0.6
    holderStroke.Parent = holder

    local labelText = Instance.new("TextLabel")
    labelText.Parent = holder
    labelText.BackgroundTransparency = 1
    labelText.Position = UDim2.new(0, 12, 0, 0)
    labelText.Size = UDim2.new(1, -60, 1, 0)
    labelText.Font = Enum.Font.GothamBold
    labelText.Text = label
    labelText.TextColor3 = TEXT
    labelText.TextSize = 13
    labelText.TextXAlignment = Enum.TextXAlignment.Left

    local switchBg = Instance.new("Frame")
    switchBg.Parent = holder
    switchBg.AnchorPoint = Vector2.new(1, 0.5)
    switchBg.Position = UDim2.new(1, -12, 0.5, 0)
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

    holder.MouseEnter:Connect(function()
        TweenService:Create(holder, TweenInfo.new(0.1), {BackgroundColor3 = BG_BUTTON_HOVER}):Play()
    end)
    holder.MouseLeave:Connect(function()
        TweenService:Create(holder, TweenInfo.new(0.1), {BackgroundColor3 = BG_BUTTON}):Play()
    end)
end

makeToggle(pages["MOVEMENT"], "Noclip", "noclip")
makeToggle(pages["MOVEMENT"], "Fly", "fly")
makeToggle(pages["MOVEMENT"], "Speed (x1.5)", "speed")
makeToggle(pages["MOVEMENT"], "Bhop", "bhop")

makeToggle(pages["VISUALS"], "ESP Nextbot", "esp_nextbot")
makeToggle(pages["VISUALS"], "ESP Players", "esp_players")
makeToggle(pages["VISUALS"], "ESP Downed", "esp_downed")
makeToggle(pages["VISUALS"], "Tracers Downed", "tracers_downed")
makeToggle(pages["VISUALS"], "Full Bright", "fullbright")

makeToggle(pages["MISC"], "Auto Revive", "auto_revive")
makeToggle(pages["MISC"], "Anti-AFK", "anti_afk")

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
-- BURMALDA EVADE v3.1 (Part 2/2) — Функции
-- =========================================================

local toggles = _G.BURMALDA_TOGGLES or {}

-- =========================================================
-- MOVEMENT
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
    if noclipConn then noclipConn:Disconnect() noclipConn = nil end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

local flyActive = false
local flyBV, flyBG, flyConn = nil, nil, nil
local function startFly()
    if flyActive then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    flyActive = true

    flyBV = Instance.new("BodyVelocity")
    flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    flyBV.Velocity = Vector3.zero
    flyBV.Parent = hrp

    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    flyBG.P = 10000
    flyBG.D = 100
    flyBG.CFrame = hrp.CFrame
    flyBG.Parent = hrp

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyActive then return end
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        if not h or not flyBV or not flyBG then return end

        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0, 1, 0) end

        flyBV.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * 55 or Vector3.zero
        flyBG.CFrame = CFrame.new(h.Position, h.Position + Camera.CFrame.LookVector)
    end)
end
local function stopFly()
    flyActive = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
end

local speedConn = nil
local SPEED_MULT = 1.5
local function startSpeed()
    if speedConn then return end
    speedConn = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hum and hrp then
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + moveDir * 16 * (SPEED_MULT - 1) * 0.08
            end
        end
    end)
end
local function stopSpeed()
    if speedConn then speedConn:Disconnect() speedConn = nil end
end

local bhopConn, bhopJumpConn = nil, nil
local function startBhop()
    if bhopConn then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    bhopConn = hum.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Landed or newState == Enum.HumanoidStateType.Running then
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)

    bhopJumpConn = UserInputService.JumpRequest:Connect(function()
        local c = LocalPlayer.Character
        local h = c and c:FindFirstChildOfClass("Humanoid")
        if h and h.FloorMaterial ~= Enum.Material.Air then
            h:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end
local function stopBhop()
    if bhopConn then bhopConn:Disconnect() bhopConn = nil end
    if bhopJumpConn then bhopJumpConn:Disconnect() bhopJumpConn = nil end
end

-- =========================================================
-- ESP
-- =========================================================
local espElements = {}
local tracersDowned = {}

local function createESP(target, color, labelText, yOffset)
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
        billboard.Size = UDim2.new(0, 140, 0, 30)
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
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        text.Parent = billboard
    end

    espElements[target] = { Highlight = hl, Billboard = billboard, Text = text, BaseText = labelText }
end

local function removeESP(target)
    local data = espElements[target]
    if data then
        if data.Highlight and data.Highlight.Parent then data.Highlight:Destroy() end
        if data.Billboard and data.Billboard.Parent then data.Billboard:Destroy() end
    end
    espElements[target] = nil
end

RunService.Heartbeat:Connect(function()
    for _, data in pairs(espElements) do
        if data.Text and data.Billboard and data.Billboard.Parent and data.BaseText then
            local basePart = data.Billboard.Adornee
            if basePart then
                local dist = (Camera.CFrame.Position - basePart.Position).Magnitude
                data.Text.Text = data.BaseText .. " [" .. math.floor(dist) .. "m]"
            end
        end
    end
end)

local function isNextbot(obj)
    if not obj or not obj.Parent then return false end
    if not obj:IsA("Model") then return false end
    if Players:GetPlayerFromCharacter(obj) then return false end
    if obj:FindFirstChild("Hitbox") then return true end
    local hum = obj:FindFirstChildWhichIsA("Humanoid")
    if hum then return true end
    return false
end

local function isDowned(character)
    if not character or not character.Parent then return false end
    if character:GetAttribute("Downed") == true then return true end
    local hum = character:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum.Sit then return true end
        if hum.PlatformStand then return true end
    end
    return false
end

local TracerGui = Instance.new("ScreenGui")
TracerGui.Name = "BURMALDA_Tracers"
TracerGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
TracerGui.ResetOnSpawn = false
TracerGui.IgnoreGuiInset = true

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

-- =========================================================
-- FULL BRIGHT
-- =========================================================
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
-- AUTO REVIVE
-- =========================================================
local autoReviveConn = nil
local reviveEvents = {}
local reviveCacheTime = 0

local function scanReviveEvents()
    reviveEvents = {}
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local n = obj.Name:lower()
            if string.find(n, "revive") or string.find(n, "respawn") or string.find(n, "setplayermode") or string.find(n, "changemode") then
                table.insert(reviveEvents, obj)
            end
        end
    end
end

local function startAutoRevive()
    if autoReviveConn then return end
    scanReviveEvents()
    reviveCacheTime = tick()
    autoReviveConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        if char:GetAttribute("Downed") == true then
            for _, ev in ipairs(reviveEvents) do
                if ev and ev.Parent then
                    pcall(function() ev:FireServer(true) end)
                end
            end
        end
        if tick() - reviveCacheTime > 30 then
            scanReviveEvents()
            reviveCacheTime = tick()
        end
    end)
end
local function stopAutoRevive()
    if autoReviveConn then autoReviveConn:Disconnect() autoReviveConn = nil end
end

-- =========================================================
-- ANTI-AFK
-- =========================================================
local antiAfkConn = nil
local function startAntiAfk()
    if antiAfkConn then return end
    antiAfkConn = LocalPlayer.Idled:Connect(function()
        pcall(function()
            VirtualUser:Button2Down(Vector2.new(0, 0), Camera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), Camera.CFrame)
        end)
    end)
end
local function stopAntiAfk()
    if antiAfkConn then antiAfkConn:Disconnect() antiAfkConn = nil end
end

-- =========================================================
-- CALLBACK
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
-- ГЛАВНЫЙ ЦИКЛ
-- =========================================================
RunService.RenderStepped:Connect(function()
    -- ESP NEXTBOT
    if toggles.esp_nextbot then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if isNextbot(obj) then
                local hitbox = obj:FindFirstChild("Hitbox")
                if hitbox then hitbox.Transparency = 0.4 end
                createESP(obj, Color3.fromRGB(220, 40, 50), obj.Name, -1)
            end
        end
    else
        for target, _ in pairs(espElements) do
            if target:IsA("Model") and isNextbot(target) then
                local hitbox = target:FindFirstChild("Hitbox")
                if hitbox then hitbox.Transparency = 1 end
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
                if espElements[player.Character] and player.Character:GetAttribute("Downed") ~= true then
                    removeESP(player.Character)
                end
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

startAntiAfk()

print("[BURMALDA EVADE v3.1]: Загружено.")
