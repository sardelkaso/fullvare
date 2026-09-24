-- =========================================================
-- BURMALDA EVADE v3.5 (Part 1/2) — UI Modern
-- =========================================================

repeat task.wait() until game:IsLoaded()

-- ОБХОД ЛОКАЛИЗАЦИИ
pcall(function()
    local LS = game:GetService("LocalizationService")
    LS.RobloxLocaleId = "en-us"
    LS.SystemLocaleId = "en-us"
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ACCENT          = Color3.fromRGB(220, 30, 45)
local ACCENT_LIGHT    = Color3.fromRGB(255, 70, 80)
local ACCENT_GLOW     = Color3.fromRGB(255, 120, 130)
local BG              = Color3.fromRGB(12, 12, 16)
local BG_PANEL        = Color3.fromRGB(20, 20, 26)
local BG_SIDEBAR      = Color3.fromRGB(16, 16, 22)
local BG_BUTTON       = Color3.fromRGB(26, 26, 34)
local BG_BUTTON_HOVER = Color3.fromRGB(38, 38, 48)
local TEXT            = Color3.fromRGB(245, 245, 250)
local TEXT_DIM        = Color3.fromRGB(130, 130, 145)
local STROKE          = Color3.fromRGB(45, 45, 55)
local SHADOW          = Color3.fromRGB(0, 0, 0)

local FONT_MAIN = Enum.Font.Cartoon

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

local function noLocalize(label)
    pcall(function()
        label.AutoLocalize = false
    end)
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
TopBar.Position = UDim2.new(0.5, 0, 0, 8)
TopBar.Size = UDim2.new(0, 340, 0, 30)
TopBar.BackgroundColor3 = BG
TopBar.BackgroundTransparency = 0.1
TopBar.BorderSizePixel = 0
TopBar.AutoButtonColor = false
TopBar.Text = ""
makeCorner(TopBar, 9)
makeStroke(TopBar, ACCENT, 1, 0.2)
local topGrad = makeGradient(TopBar, Color3.fromRGB(20, 20, 28), Color3.fromRGB(12, 12, 16), 90)

local BarTitle = Instance.new("TextLabel")
BarTitle.Parent = TopBar
BarTitle.BackgroundTransparency = 1
BarTitle.Position = UDim2.new(0, 14, 0, 0)
BarTitle.Size = UDim2.new(0, 200, 1, 0)
BarTitle.Font = FONT_MAIN
BarTitle.Text = "BURMALDA EVADE"
BarTitle.TextColor3 = ACCENT_LIGHT
BarTitle.TextSize = 15
BarTitle.TextXAlignment = Enum.TextXAlignment.Left
noLocalize(BarTitle)

local BarFPS = Instance.new("TextLabel")
BarFPS.Parent = TopBar
BarFPS.BackgroundTransparency = 1
BarFPS.Position = UDim2.new(1, -155, 0, 0)
BarFPS.Size = UDim2.new(0, 70, 1, 0)
BarFPS.Font = FONT_MAIN
BarFPS.Text = "FPS: 60"
BarFPS.TextColor3 = TEXT
BarFPS.TextSize = 13
BarFPS.TextXAlignment = Enum.TextXAlignment.Right
noLocalize(BarFPS)

local BarPing = Instance.new("TextLabel")
BarPing.Parent = TopBar
BarPing.BackgroundTransparency = 1
BarPing.Position = UDim2.new(1, -80, 0, 0)
BarPing.Size = UDim2.new(0, 72, 1, 0)
BarPing.Font = FONT_MAIN
BarPing.Text = "Ping: 0"
BarPing.TextColor3 = TEXT
BarPing.TextSize = 13
BarPing.TextXAlignment = Enum.TextXAlignment.Right
noLocalize(BarPing)

-- МЕНЮ
local MenuGui = Instance.new("ScreenGui")
MenuGui.Name = "BURMALDA_Menu"
MenuGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
MenuGui.ResetOnSpawn = false
MenuGui.IgnoreGuiInset = true
MenuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MenuGui.Enabled = false

-- Blur (стекло)
local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

-- Тень под меню
local ShadowFrame = Instance.new("Frame")
ShadowFrame.Parent = MenuGui
ShadowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ShadowFrame.Position = UDim2.new(0.5, 0, 0.55, 6)
ShadowFrame.Size = UDim2.new(0, 520, 0, 340)
ShadowFrame.BackgroundColor3 = SHADOW
ShadowFrame.BackgroundTransparency = 0.6
ShadowFrame.BorderSizePixel = 0
makeCorner(ShadowFrame, 16)

local Menu = Instance.new("Frame")
Menu.Parent = MenuGui
Menu.AnchorPoint = Vector2.new(0.5, 0.5)
Menu.Position = UDim2.new(0.5, 0, 0.55, 0)
Menu.Size = UDim2.new(0, 520, 0, 340)
Menu.BackgroundColor3 = BG
Menu.BackgroundTransparency = 0.05
Menu.BorderSizePixel = 0
makeCorner(Menu, 16)
makeStroke(Menu, ACCENT, 1, 0.4)
local menuGrad = makeGradient(Menu, Color3.fromRGB(20, 20, 28), Color3.fromRGB(10, 10, 14), 135)

-- Верхняя акцентная полоска
local TopAccent = Instance.new("Frame")
TopAccent.Parent = Menu
TopAccent.Position = UDim2.new(0, 0, 0, 0)
TopAccent.Size = UDim2.new(1, 0, 0, 2)
TopAccent.BackgroundColor3 = ACCENT
TopAccent.BorderSizePixel = 0
makeGradient(TopAccent, ACCENT, ACCENT_GLOW, 0)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Parent = Menu
Sidebar.Position = UDim2.new(0, 0, 0, 2)
Sidebar.Size = UDim2.new(0, 140, 1, -2)
Sidebar.BackgroundColor3 = BG_SIDEBAR
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0

local SidebarFix = Instance.new("Frame")
SidebarFix.Parent = Sidebar
SidebarFix.AnchorPoint = Vector2.new(1, 0)
SidebarFix.Position = UDim2.new(1, 0, 0, 0)
SidebarFix.Size = UDim2.new(0, 10, 1, 0)
SidebarFix.BackgroundColor3 = BG_SIDEBAR
SidebarFix.BackgroundTransparency = 0.3
SidebarFix.BorderSizePixel = 0

local SidebarTitle = Instance.new("TextLabel")
SidebarTitle.Parent = Sidebar
SidebarTitle.BackgroundTransparency = 1
SidebarTitle.Position = UDim2.new(0, 14, 0, 16)
SidebarTitle.Size = UDim2.new(1, -28, 0, 22)
SidebarTitle.Font = FONT_MAIN
SidebarTitle.Text = "BURMALDA"
SidebarTitle.TextColor3 = ACCENT_LIGHT
SidebarTitle.TextSize = 16
SidebarTitle.TextXAlignment = Enum.TextXAlignment.Left
noLocalize(SidebarTitle)

local SidebarSub = Instance.new("TextLabel")
SidebarSub.Parent = Sidebar
SidebarSub.BackgroundTransparency = 1
SidebarSub.Position = UDim2.new(0, 14, 0, 38)
SidebarSub.Size = UDim2.new(1, -28, 0, 12)
SidebarSub.Font = FONT_MAIN
SidebarSub.Text = "EVADE · v3.5"
SidebarSub.TextColor3 = TEXT_DIM
SidebarSub.TextSize = 10
SidebarSub.TextXAlignment = Enum.TextXAlignment.Left
noLocalize(SidebarSub)

local SidebarDiv = Instance.new("Frame")
SidebarDiv.Parent = Sidebar
SidebarDiv.Position = UDim2.new(0, 14, 0, 58)
SidebarDiv.Size = UDim2.new(1, -28, 0, 1)
SidebarDiv.BackgroundColor3 = STROKE
SidebarDiv.BackgroundTransparency = 0.5
SidebarDiv.BorderSizePixel = 0

-- КОНТЕНТ
local Content = Instance.new("Frame")
Content.Parent = Menu
Content.Position = UDim2.new(0, 152, 0, 16)
Content.Size = UDim2.new(1, -166, 1, -30)
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
    layout.Padding = UDim.new(0, 5)
    layout.Parent = page

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 3)
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
    btn.Position = UDim2.new(0, 10, 0, yOffset)
    btn.Size = UDim2.new(1, -20, 0, 32)
    btn.BackgroundColor3 = BG_BUTTON
    btn.BackgroundTransparency = 0.3
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
    label.Font = FONT_MAIN
    label.Text = name
    label.TextColor3 = TEXT_DIM
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    noLocalize(label)

    local stroke = Instance.new("UIStroke")
    stroke.Color = STROKE
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    stroke.Parent = btn

    local function selectThis()
        for _, other in ipairs(categoryButtons) do
            TweenService:Create(other.Button, TweenInfo.new(0.2), {BackgroundColor3 = BG_BUTTON, BackgroundTransparency = 0.3}):Play()
            TweenService:Create(other.Bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
            TweenService:Create(other.Label, TweenInfo.new(0.2), {TextColor3 = TEXT_DIM}):Play()
            TweenService:Create(other.Stroke, TweenInfo.new(0.2), {Color = STROKE, Transparency = 0.7}):Play()
            pages[other.Name].Visible = false
        end
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = ACCENT, BackgroundTransparency = 0}):Play()
        TweenService:Create(bar, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 18)}):Play()
        TweenService:Create(label, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.2), {Color = ACCENT_LIGHT, Transparency = 0}):Play()
        pages[name].Visible = true
        activeCategory = name
    end

    btn.MouseButton1Click:Connect(selectThis)
    btn.MouseEnter:Connect(function()
        if activeCategory ~= name then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = BG_BUTTON_HOVER}):Play()
            TweenService:Create(label, TweenInfo.new(0.12), {TextColor3 = TEXT}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if activeCategory ~= name then
            TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = BG_BUTTON}):Play()
            TweenService:Create(label, TweenInfo.new(0.12), {TextColor3 = TEXT_DIM}):Play()
        end
    end)

    table.insert(categoryButtons, {Button = btn, Bar = bar, Label = label, Stroke = stroke, Name = name})
    return selectThis
end

makePage("MOVEMENT")
makePage("VISUALS")
makePage("MISC")

local selectMovement = makeCategoryButton("MOVEMENT", 72)
local selectVisuals  = makeCategoryButton("VISUALS", 110)
local selectMisc     = makeCategoryButton("MISC", 148)

selectMovement()

-- TOGGLE
local toggleStates = {}

local function makeToggle(parent, label, keyName)
    local holder = Instance.new("TextButton")
    holder.Parent = parent
    holder.BackgroundColor3 = BG_BUTTON
    holder.BackgroundTransparency = 0.4
    holder.BorderSizePixel = 0
    holder.Size = UDim2.new(1, -10, 0, 34)
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
    labelText.Position = UDim2.new(0, 14, 0, 0)
    labelText.Size = UDim2.new(1, -62, 1, 0)
    labelText.Font = FONT_MAIN
    labelText.Text = label
    labelText.TextColor3 = TEXT
    labelText.TextSize = 13
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    noLocalize(labelText)

    local switchBg = Instance.new("Frame")
    switchBg.Parent = holder
    switchBg.AnchorPoint = Vector2.new(1, 0.5)
    switchBg.Position = UDim2.new(1, -14, 0.5, 0)
    switchBg.Size = UDim2.new(0, 38, 0, 20)
    switchBg.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
    switchBg.BorderSizePixel = 0
    makeCorner(switchBg, 10)

    local switchStroke = Instance.new("UIStroke")
    switchStroke.Color = STROKE
    switchStroke.Thickness = 1
    switchStroke.Transparency = 0.6
    switchStroke.Parent = switchBg

    local knob = Instance.new("Frame")
    knob.Parent = switchBg
    knob.AnchorPoint = Vector2.new(0, 0.5)
    knob.Position = UDim2.new(0, 2, 0.5, 0)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.BackgroundColor3 = Color3.fromRGB(230, 230, 240)
    knob.BorderSizePixel = 0
    makeCorner(knob, 8)

    toggleStates[keyName] = false

    local function updateVisual(state)
        local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        if state then
            TweenService:Create(switchBg, ti, {BackgroundColor3 = ACCENT}):Play()
            TweenService:Create(switchStroke, ti, {Color = ACCENT_LIGHT, Transparency = 0}):Play()
            TweenService:Create(knob, ti, {Position = UDim2.new(0, 20, 0.5, 0)}):Play()
            TweenService:Create(labelText, ti, {TextColor3 = ACCENT_LIGHT}):Play()
        else
            TweenService:Create(switchBg, ti, {BackgroundColor3 = Color3.fromRGB(38, 38, 48)}):Play()
            TweenService:Create(switchStroke, ti, {Color = STROKE, Transparency = 0.6}):Play()
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
        TweenService:Create(holder, TweenInfo.new(0.12), {BackgroundColor3 = BG_BUTTON_HOVER}):Play()
    end)
    holder.MouseLeave:Connect(function()
        TweenService:Create(holder, TweenInfo.new(0.12), {BackgroundColor3 = BG_BUTTON}):Play()
    end)
end

-- SLIDER
local sliderValues = {}

local function makeSlider(parent, label, minVal, maxVal, default, keyName)
    local holder = Instance.new("Frame")
    holder.Parent = parent
    holder.BackgroundColor3 = BG_BUTTON
    holder.BackgroundTransparency = 0.4
    holder.BorderSizePixel = 0
    holder.Size = UDim2.new(1, -10, 0, 48)
    makeCorner(holder, 8)

    local holderStroke = Instance.new("UIStroke")
    holderStroke.Color = STROKE
    holderStroke.Thickness = 1
    holderStroke.Transparency = 0.6
    holderStroke.Parent = holder

    local labelText = Instance.new("TextLabel")
    labelText.Parent = holder
    labelText.BackgroundTransparency = 1
    labelText.Position = UDim2.new(0, 14, 0, 6)
    labelText.Size = UDim2.new(1, -80, 0, 16)
    labelText.Font = FONT_MAIN
    labelText.Text = label
    labelText.TextColor3 = TEXT
    labelText.TextSize = 12
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    noLocalize(labelText)

    local valLabel = Instance.new("TextLabel")
    valLabel.Parent = holder
    valLabel.BackgroundTransparency = 1
    valLabel.AnchorPoint = Vector2.new(1, 0)
    valLabel.Position = UDim2.new(1, -14, 0, 6)
    valLabel.Size = UDim2.new(0, 60, 0, 16)
    valLabel.Font = FONT_MAIN
    valLabel.Text = tostring(default)
    valLabel.TextColor3 = ACCENT_LIGHT
    valLabel.TextSize = 12
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    noLocalize(valLabel)

    local track = Instance.new("Frame")
    track.Parent = holder
    track.Position = UDim2.new(0, 14, 1, -16)
    track.Size = UDim2.new(1, -28, 0, 5)
    track.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
    track.BorderSizePixel = 0
    makeCorner(track, 3)

    local fill = Instance.new("Frame")
    fill.Parent = track
    fill.Size = UDim2.new((default - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = ACCENT
    fill.BorderSizePixel = 0
    makeCorner(fill, 3)

    local knob = Instance.new("Frame")
    knob.Parent = track
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new((default - minVal) / (maxVal - minVal), 0, 0.5, 0)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.BackgroundColor3 = Color3.fromRGB(230, 230, 240)
    knob.BorderSizePixel = 0
    makeCorner(knob, 7)

    local trigger = Instance.new("TextButton")
    trigger.Parent = holder
    trigger.BackgroundTransparency = 1
    trigger.Text = ""
    trigger.Size = UDim2.new(1, 0, 1, 0)
    trigger.ZIndex = 5

    sliderValues[keyName] = default

    local dragging = false
    local function updateFromInput(input)
        local mouseX = input.Position.X
        local trackX = track.AbsolutePosition.X
        local trackW = track.AbsoluteSize.X
        local alpha = math.clamp((mouseX - trackX) / trackW, 0, 1)
        local val = math.floor(minVal + (maxVal - minVal) * alpha)
        sliderValues[keyName] = val
        valLabel.Text = tostring(val)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        if _G.BURMALDA_SLIDER_CALLBACK then
            _G.BURMALDA_SLIDER_CALLBACK(keyName, val)
        end
    end

    trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromInput(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromInput(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- MOVEMENT
makeSlider(pages["MOVEMENT"], "Speed Value", 16, 100, 24, "speed_value")
makeToggle(pages["MOVEMENT"], "Noclip", "noclip")
makeToggle(pages["MOVEMENT"], "Speed Boost", "speed")

-- VISUALS
makeToggle(pages["VISUALS"], "ESP Nextbot", "esp_nextbot")
makeToggle(pages["VISUALS"], "ESP Players", "esp_players")
makeToggle(pages["VISUALS"], "ESP Downed", "esp_downed")
makeToggle(pages["VISUALS"], "Tracers Downed", "tracers_downed")
makeToggle(pages["VISUALS"], "Full Bright", "fullbright")
makeToggle(pages["VISUALS"], "Remove Fog", "remfog")

-- MISC
makeToggle(pages["MISC"], "Auto Vote Map 1", "vote1")
makeToggle(pages["MISC"], "Auto Vote Map 2", "vote2")
makeToggle(pages["MISC"], "Auto Vote Map 3", "vote3")
makeToggle(pages["MISC"], "Auto Vote Map 4", "vote4")

-- Открытие/закрытие с плавной анимацией
TopBar.MouseButton1Click:Connect(function()
    MenuGui.Enabled = not MenuGui.Enabled
    if MenuGui.Enabled then
        TweenService:Create(Blur, TweenInfo.new(0.25), {Size = 14}):Play()
        Menu.Size = UDim2.new(0, 500, 0, 320)
        ShadowFrame.Size = UDim2.new(0, 500, 0, 320)
        TweenService:Create(Menu, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 340)}):Play()
        TweenService:Create(ShadowFrame, TweenInfo.new(0.25, Enum.EasingStyle.
                    -- =========================================================
-- BURMALDA EVADE v3.5 (Part 2/2) — Функции
-- =========================================================

local toggles = _G.BURMALDA_TOGGLES or {}
local sliders = _G.BURMALDA_SLIDERS or {}

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

-- SPEED BOOST (слайдер управляет значением)
local speedConn = nil
local function startSpeed()
    if speedConn then return end
    speedConn = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            local speed = sliders.speed_value or 24
            if hum.WalkSpeed ~= speed then
                hum.WalkSpeed = speed
            end
        end
    end)
end
local function stopSpeed()
    if speedConn then speedConn:Disconnect() speedConn = nil end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
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
        text.Font = Enum.Font.Cartoon
        text.TextScaled = true
        text.Text = labelText or ""
        text.TextColor3 = color
        text.TextStrokeTransparency = 0.4
        text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        text.Parent = billboard
        pcall(function() text.AutoLocalize = false end)
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

-- ТОЛЬКО НЕКСТБОТЫ (жёсткий фильтр)
local function isNextbot(obj)
    if not obj or not obj.Parent then return false end
    if not obj:IsA("Model") then return false end
    if Players:GetPlayerFromCharacter(obj) then return false end

    -- Исключаем декор по имени
    local name = obj.Name:lower()
    local excluded = {
        "door", "stairs", "ladder", "wall", "floor", "roof",
        "crate", "box", "prop", "window", "fence", "gate",
        "railing", "vent", "pipe", "pillar", "column", "tree",
        "lamp", "light", "sign", "car", "vehicle", "barrier",
        "bench", "chair", "table", "shelf", "cabinet"
    }
    for _, ex in ipairs(excluded) do
        if string.find(name, ex) then return false end
    end

    -- У некстботов ЕСТЬ Hitbox И человеческое тело (R6/R15 части)
    local hasHitbox = obj:FindFirstChild("Hitbox") ~= nil
    local hasTorso = obj:FindFirstChild("Torso") ~= nil
        or obj:FindFirstChild("UpperTorso") ~= nil
    local hasHead = obj:FindFirstChild("Head") ~= nil

    -- Некстбот должен иметь Hitbox + голову + тело
    if hasHitbox and hasHead and hasTorso then
        return true
    end

    return false
end

-- DOWNED (по атрибуту)
local function isDowned(character)
    if not character or not character.Parent then return false end
    if character:GetAttribute("Downed") == true then return true end
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
-- FULL BRIGHT + REMOVE FOG
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
end
local function disableFullBright()
    if fbBackup.Brightness then Lighting.Brightness = fbBackup.Brightness end
    if fbBackup.Ambient then Lighting.Ambient = fbBackup.Ambient end
    if fbBackup.OutdoorAmbient then Lighting.OutdoorAmbient = fbBackup.OutdoorAmbient end
    if fbBackup.GlobalShadows ~= nil then Lighting.GlobalShadows = fbBackup.GlobalShadows end
end

local fogBackup = {}
local function enableRemoveFog()
    fogBackup.FogEnd = Lighting.FogEnd
    fogBackup.FogStart = Lighting.FogStart
    Lighting.FogEnd = 1e6
    Lighting.FogStart = 999999
end
local function disableRemoveFog()
    if fogBackup.FogEnd then Lighting.FogEnd = fogBackup.FogEnd end
    if fogBackup.FogStart then Lighting.FogStart = fogBackup.FogStart end
end

-- =========================================================
-- AUTO VOTE MAP
-- =========================================================
local voteConn = nil
local currentVoteMap = nil

local function fireVote(mapNumber)
    pcall(function()
        local eventsFolder = ReplicatedStorage:FindFirstChild("Events")
        if eventsFolder then
            local playerFolder = eventsFolder:FindFirstChild("Player")
            if playerFolder then
                local voteEvent = playerFolder:FindFirstChild("Vote")
                if voteEvent and voteEvent:IsA("RemoteEvent") then
                    voteEvent:FireServer(mapNumber)
                end
            end
        end
    end)
end

local function startAutoVote(mapNumber)
    if voteConn then voteConn:Disconnect() voteConn = nil end
    currentVoteMap = mapNumber
    voteConn = RunService.Heartbeat:Connect(function()
        if currentVoteMap then
            fireVote(currentVoteMap)
        end
    end)
end

local function stopAutoVote()
    if voteConn then voteConn:Disconnect() voteConn = nil end
    currentVoteMap = nil
end

-- =========================================================
-- SLIDER CALLBACK (обновление Speed в реальном времени)
-- =========================================================
_G.BURMALDA_SLIDER_CALLBACK = function(key, val)
    if key == "speed_value" then
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and toggles.speed then
            hum.WalkSpeed = val
        end
    end
end

-- =========================================================
-- TOGGLE CALLBACK
-- =========================================================
_G.BURMALDA_TOGGLE_CALLBACK = function(key, state)
    if key == "noclip" then
        if state then startNoclip() else stopNoclip() end
    elseif key == "speed" then
        if state then startSpeed() else stopSpeed() end
    elseif key == "fullbright" then
        if state then enableFullBright() else disableFullBright() end
    elseif key == "remfog" then
        if state then enableRemoveFog() else disableRemoveFog() end
    elseif key == "vote1" then
        if state then startAutoVote(1) else stopAutoVote() end
    elseif key == "vote2" then
        if state then startAutoVote(2) else stopAutoVote() end
    elseif key == "vote3" then
        if state then startAutoVote(3) else stopAutoVote() end
    elseif key == "vote4" then
        if state then startAutoVote(4) else stopAutoVote() end
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
                if hitbox and hitbox:IsA("BasePart") then
                    hitbox.Transparency = 0.4
                end
                createESP(obj, Color3.fromRGB(220, 40, 50), obj.Name, -1)
            end
        end
    else
        for target, _ in pairs(espElements) do
            if target:IsA("Model") and isNextbot(target) then
                local hitbox = target:FindFirstChild("Hitbox")
                if hitbox and hitbox:IsA("BasePart") then
                    hitbox.Transparency = 1
                end
                removeESP(target)
            end
        end
    end

    -- ESP PLAYERS
    if toggles.esp_players then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 and not isDowned(player.Character) then
                    createESP(player.Character, Color3.fromRGB(60, 220, 100), player.Name, 1)
                end
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                if espElements[player.Character] and not isDowned(player.Character) then
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

print("[BURMALDA EVADE v3.5]: Загружено.")
