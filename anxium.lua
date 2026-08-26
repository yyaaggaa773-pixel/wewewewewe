local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local SelectedFont = Enum.Font.GothamBold

local fenv = getfenv()
local Drawing = fenv.Drawing

LightingDefaults = {
    Ambient = Lighting.Ambient,
    ColorShift_Bottom = Lighting.ColorShift_Bottom,
    ColorShift_Top = Lighting.ColorShift_Top,
    Brightness = Lighting.Brightness,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    FogColor = Lighting.FogColor,
    Density = (Lighting:FindFirstChildOfClass("Atmosphere") and Lighting:FindFirstChildOfClass("Atmosphere").Density) or 0,
    Haze = (Lighting:FindFirstChildOfClass("Atmosphere") and Lighting:FindFirstChildOfClass("Atmosphere").Haze) or 0
}

Config = {
    EspEnabled = false,
    BoxEspEnabled = false,
    BoxFillGradientEnabled = false,
    EspBoxStyle = "Full", -- Full / Corner / Box3D
    HealthbarEspEnabled = false,
    ChamsEnabled = false,
    NameEspEnabled = false,
    DistanceEspEnabled = false,
    SkeletonEnabled = false,
    TracersEnabled = false,
    FullbrightEnabled = false,
    CrosshairEnabled = false,
    ChinaHatEnabled = false,
    FogEnabled = false,
    FootstepsEnabled = false,
    OrbitOrbsEnabled = false,
    TrailEnabled = false,
    AspectRatioEnabled = false,
    ThirdPersonEnabled = false,
    ActiveListEnabled = false,
    BindListEnabled = false,
    Keybinds = {}, -- [featureKey] = KeyCode name string

    FakeFpsEnabled = false,
    FakeFpsValue = 67,
    FakeFpsIndex = 1,

    MultiJumpEnabled = false,
    SpeedHackEnabled = false,
    NoclipEnabled = false,
    FlyEnabled = false,
    BHopEnabled = false,
    SpinEnabled = false,
    SpinSpeed = 20,
    AimEnabled = false,
    ShowFovEnabled = false,
    TargetHudEnabled = false,
    DarkModeEnabled = false,
    TriggerbotEnabled = false,
    TriggerbotDelay = 0,

    -- Silent Aim (universal, no camera tracking — redirects shots when target in FOV)
    SilentAimEnabled = false,
    SilentFovRadius = 130,
    ShowSilentFovEnabled = false,
    SilentTargetPart = "Head", -- Head / HumanoidRootPart / Random
    SilentHitChance = 100,
    SilentTeamCheck = true,
    TeamCheckerEnabled = false, -- global: ESP/aim/silent ignore teammates
    SilentVisibleCheck = false,
    SilentMethod = "Raycast", -- Raycast / FindPartOnRay / Mouse.Hit
    SilentPrediction = false,
    SilentPredictionAmount = 0.165,
    SilentStealthMode = true, -- quieter behavior on AC places
    SilentHumanize = true, -- micro-offset so hits aren't perfectly centered
    Color_SilentFov = Color3.fromRGB(255, 80, 80),

    CustomFireSoundEnabled = false,
    CustomFireSoundName = "Gun Fire",
    CustomFireSoundVolume = 1,

    TargetFlingEnabled = false,
    TargetFlingName = "",
    ClickFlingSelectEnabled = false,

    WalkSpeedValue = 32,
    FlySpeedValue = 50,
    BHopPower = 50,
    FovRadius = 150,
    AimSmoothValue = 0.18,
    FogDistanceValue = 300,
    AspectRatioValue = 1.333,
    OrbitSpeedValue = 4,
    ThirdPersonDistance = 12,

    JumpCircleSize = 5,
    JumpCircleGlow = 4,

    ChinaHatHeightOffset = 0.5,
    ChinaHatHeight = 1.7,
    ChinaHatRadius = 2.3,
    ChinaHatSegments = 24,
    ChinaHatScale = 1.0,

    CurrentColorIndex = 1,

    -- Per-visual colors (independent)
    Color_BoxEsp = Color3.fromRGB(180, 140, 255),
    Color_BoxEspFill = Color3.fromRGB(80, 40, 160), -- Full box inner gradient end
    Color_Chams = Color3.fromRGB(180, 140, 255),
    Color_NameEsp = Color3.fromRGB(180, 140, 255),
    Color_Skeleton = Color3.fromRGB(180, 140, 255),
    Color_Tracers = Color3.fromRGB(180, 140, 255),
    Color_Healthbar = Color3.fromRGB(180, 140, 255),
    Color_Crosshair = Color3.fromRGB(180, 140, 255),
    Color_ChinaHat = Color3.fromRGB(180, 140, 255),
    Color_Fog = Color3.fromRGB(180, 140, 255),
    Color_WeaponFF = Color3.fromRGB(180, 140, 255),
    Color_ForceField = Color3.fromRGB(180, 140, 255),
    Color_BulletTracer = Color3.fromRGB(255, 200, 80),
    Color_Orbit = Color3.fromRGB(180, 140, 255),
    Color_TargetHud = Color3.fromRGB(180, 140, 255),
    Color_JumpCircle = Color3.fromRGB(180, 140, 255),
    Color_Trail = Color3.fromRGB(180, 140, 255),
    Color_Aura = Color3.fromRGB(180, 140, 255),
    Color_Fov = Color3.fromRGB(180, 140, 255),

    AntiAimEnabled = false,
    AntiAimPitch = -45, -- degrees (torso/neck lean)
    AntiAimYaw = 180,   -- degrees (body yaw vs camera)

    ForceFieldEnabled = false,
    ForceFieldRainbow = false,
    WeaponForceFieldEnabled = false,
    KillFlashEnabled = false,
    KillFlashDuration = 0.85,
    Color_KillFlash = Color3.fromRGB(255, 255, 255),

    -- Hitbox expander (client-side)
    HitboxEnabled = false,
    HitboxSize = 6, -- studs (XZ expand; Y slightly less)
    HitboxShow = true, -- visualize expanded boxes
    HitboxTeamCheck = true,
    Color_Hitbox = Color3.fromRGB(255, 80, 80),

    -- Extra visuals
    SpinCrosshairEnabled = false,
    SpinCrosshairSpeed = 180,
    DamageNumbersEnabled = false,
    Color_DamageNumber = Color3.fromRGB(255, 80, 80),
    SelfChamsEnabled = false,
    Color_SelfChams = Color3.fromRGB(180, 140, 255),

    -- Universal Visuals (movement clone / arrows / death)
    CloneChamsEnabled = false,
    Color_CloneChams = Color3.fromRGB(255, 60, 60),
    CloneInterval = 1,
    CloneFadeDelay = 1.5,
    CloneFadeTime = 1.2,
    CloneTransparency = 0.25,
    CloneChamsStyle = "Chams",
    DeathChamsStyle = "Chams",
    OffscreenArrowsEnabled = false,
    Color_OffscreenArrow = Color3.fromRGB(255, 70, 70),
    ArrowSize = 32,
    ArrowDistance = 0.36,
    ArrowShowDistance = true,
    ShowArrowRadius = false,
    DeathChamsEnabled = false,
    Color_DeathChams = Color3.fromRGB(255, 170, 40),
    DeathFadeDelay = 1.5,
    DeathFadeTime = 1.5,
    DeathBurstEnabled = false,
    Color_DeathBurst = Color3.fromRGB(255, 90, 35),
    BulletTracersEnabled = false,
    BulletTracerDuration = 2,

    AuraEnabled = false,
    ClassicPinkEnabled = false,
    ClassicAngelEnabled = false,
    ParticleStarlightEnabled = false,
    ParticleAngelEnabled = false,

    -- Character animation pack (R15 Animate script)
    SelectedAnimPack = "Default",
    AnimPackIndex = 1
}


ColorPalette = {
    Color3.fromRGB(180, 140, 255),
    Color3.fromRGB(255, 120, 160),
    Color3.fromRGB(120, 200, 255),
    Color3.fromRGB(140, 255, 180),
    Color3.fromRGB(255, 200, 120),
    Color3.fromRGB(200, 160, 255),
    Color3.fromRGB(255, 80, 80),
    Color3.fromRGB(80, 180, 255),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(50, 255, 150),
    Color3.fromRGB(255, 160, 50),
    Color3.fromRGB(160, 100, 255),
}

Cache = {
    Highlights = {},
    Chams = {},
    Boxes = {},
    Healthbars = {},
    TracerLines = {},
    EspLabels = {},
    Skeletons = {},
    ActiveFootsteps = {},
    OrbitAngle = 0,
    LastFootstepPos = Vector3.zero,
    WasOnGround = true,
    JumpCircleCooldown = 0,
    FlyBodyVelocity = nil,
    FlyBodyGyro = nil,
    PlayerTrail = nil,
    TrailAtt0 = nil,
    TrailAtt1 = nil,
    SelectedTargetHighlight = nil,
    FireSoundAssets = {},
    FireSoundInstance = nil,
    FireSoundsReady = false,

    ChinaHatLines = {},
    ChinaHatTris = {},

    ForceFieldOriginals = {},
    ForceFieldConnection = nil,
    WeaponFFOriginals = {},
    WeaponFFConnections = {},
    WeaponFFCurrentTool = nil,
    WeaponFFKeepAlive = nil,
    ActiveClassicAuras = { Godly = {}, PinkAura = {}, AngelWing = {} },
    ActiveParticleAuras = { starlight = {}, angel = {} },
    LoadedParticleTemplates = {},
    AimLockTarget = nil
}

-- Keep global refs stable for RenderStep callbacks (prevents nil Config errors)
pcall(function()
    rawset(_G, "Config", Config)
    rawset(_G, "Cache", Cache)
end)

local CachedPlayerList = {}

local function RefreshPlayerCache()
    CachedPlayerList = Players:GetPlayers()
end

Players.PlayerAdded:Connect(RefreshPlayerCache)
Players.PlayerRemoving:Connect(function(p)
    RefreshPlayerCache()
    if Cache.TeamCache then Cache.TeamCache[p] = nil end
end)
RefreshPlayerCache()

local RaycastParamsFootsteps = RaycastParams.new()
RaycastParamsFootsteps.FilterType = Enum.RaycastFilterType.Exclude

local RaycastParamsTriggerbot = RaycastParams.new()
RaycastParamsTriggerbot.FilterType = Enum.RaycastFilterType.Exclude
RaycastParamsTriggerbot.IgnoreWater = true

local Theme = {
    Bg = Color3.fromRGB(28, 28, 32),
    BgSecondary = Color3.fromRGB(36, 36, 42),
    BgTertiary = Color3.fromRGB(45, 45, 52),
    Text = Color3.fromRGB(235, 235, 240),
    TextDim = Color3.fromRGB(130, 130, 140),
    Accent = Color3.fromRGB(160, 120, 255),
    ToggleOff = Color3.fromRGB(60, 60, 70),
    ToggleOn = Color3.fromRGB(160, 120, 255),
    Stroke = Color3.fromRGB(50, 50, 58)
}

ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnxiumGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

BlurEffect = Instance.new("BlurEffect")
BlurEffect.Name = "AnxiumMenuBlur"
BlurEffect.Size = 0
BlurEffect.Parent = Lighting

MakeDraggable = function(uiFrame, dragHandle)
    local dragging, dragInput, dragStart, startPos
    dragHandle = dragHandle or uiFrame
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = uiFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            uiFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

NotifContainer = Instance.new("Frame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Size = UDim2.new(0, 240, 1, -20)
NotifContainer.Position = UDim2.new(1, -255, 0, 12)
NotifContainer.BackgroundTransparency = 1
NotifContainer.Parent = ScreenGui

NotifLayout = Instance.new("UIListLayout")
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 8)
NotifLayout.Parent = NotifContainer

Notify = function(title, message, duration)
    duration = duration or 2.6
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 38)
    Card.BackgroundColor3 = Theme.BgSecondary
    Card.BackgroundTransparency = 1
    Card.BorderSizePixel = 0
    Card.ClipsDescendants = true

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.Accent
    Stroke.Thickness = 1
    Stroke.Transparency = 1
    Stroke.Parent = Card

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Card

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 3, 1, 0)
    AccentBar.BackgroundColor3 = Theme.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Card

    local AccentCorner = Instance.new("UICorner")
    AccentCorner.CornerRadius = UDim.new(0, 8)
    AccentCorner.Parent = AccentBar

    local Txt = Instance.new("TextLabel")
    Txt.Size = UDim2.new(1, -16, 1, 0)
    Txt.Position = UDim2.new(0, 12, 0, 0)
    Txt.BackgroundTransparency = 1
    Txt.Text = title .. "  ·  " .. message
    Txt.TextColor3 = Theme.Text
    Txt.TextSize = 12
    Txt.Font = SelectedFont
    Txt.TextXAlignment = Enum.TextXAlignment.Left
    Txt.TextTransparency = 1
    Txt.Parent = Card

    Card.Parent = NotifContainer

    TweenService:Create(Card, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(Txt, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    TweenService:Create(Stroke, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.4}):Play()

    task.delay(duration, function()
        if Card and Card.Parent then
            TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
            TweenService:Create(Txt, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            task.wait(0.32)
            Card:Destroy()
        end
    end)
end

-- Shared size for Active + Binds HUD (match watermark/toggle style)
local HUD_W, HUD_H = 180, 148

ActiveListFrame = Instance.new("Frame")
ActiveListFrame.Name = "ActiveFeaturesFrame"
ActiveListFrame.Size = UDim2.new(0, HUD_W, 0, HUD_H)
ActiveListFrame.Position = UDim2.new(0, 16, 0.38, -100)
ActiveListFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32) -- same as watermark / menu button
ActiveListFrame.BackgroundTransparency = 0.08
ActiveListFrame.BorderSizePixel = 0
ActiveListFrame.ClipsDescendants = true
ActiveListFrame.Visible = Config.ActiveListEnabled == true
ActiveListFrame.Parent = ScreenGui
do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = ActiveListFrame
    local st = Instance.new("UIStroke")
    st.Color = Theme.Stroke
    st.Thickness = 1
    st.Transparency = 0.5
    st.Parent = ActiveListFrame
end

-- Header = same color family as watermark (solid within frame)
ActiveHeader = Instance.new("Frame")
ActiveHeader.Name = "Header"
ActiveHeader.Size = UDim2.new(1, 0, 0, 26)
ActiveHeader.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
ActiveHeader.BackgroundTransparency = 0
ActiveHeader.BorderSizePixel = 0
ActiveHeader.Parent = ActiveListFrame

ActiveTitle = Instance.new("TextLabel")
ActiveTitle.Size = UDim2.new(1, -12, 1, 0)
ActiveTitle.Position = UDim2.new(0, 10, 0, 0)
ActiveTitle.BackgroundTransparency = 1
ActiveTitle.Text = "Active"
ActiveTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ActiveTitle.TextSize = 12
ActiveTitle.Font = SelectedFont
ActiveTitle.TextXAlignment = Enum.TextXAlignment.Left
ActiveTitle.Parent = ActiveHeader

-- Body: same panel color, more transparent (one continuous window)
ActiveContainer = Instance.new("ScrollingFrame")
ActiveContainer.Name = "ActiveContainer"
ActiveContainer.Size = UDim2.new(1, 0, 1, -26)
ActiveContainer.Position = UDim2.new(0, 0, 0, 26)
ActiveContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
ActiveContainer.BackgroundTransparency = 0.45
ActiveContainer.BorderSizePixel = 0
ActiveContainer.ScrollBarThickness = 3
ActiveContainer.ScrollBarImageColor3 = Theme.Accent
ActiveContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ActiveContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ActiveContainer.Parent = ActiveListFrame

ActiveLayout = Instance.new("UIListLayout")
ActiveLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
ActiveLayout.Padding = UDim.new(0, 1)
ActiveLayout.Parent = ActiveContainer

do
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingTop = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 4)
    pad.Parent = ActiveContainer
end

MakeDraggable(ActiveListFrame, ActiveHeader)

FeatureNamesMapping = {
    BoxEspEnabled = "2D Box ESP",
    BoxFillGradientEnabled = "Box Fill Gradient",
    HealthbarEspEnabled = "Healthbar ESP",
    ChamsEnabled = "Chams",
    NameEspEnabled = "Name ESP",
    DistanceEspEnabled = "Distance ESP",
    SkeletonEnabled = "Skeleton ESP",
    TracersEnabled = "Tracers",
    CrosshairEnabled = "Crosshair",
    FullbrightEnabled = "Fullbright",
    ChinaHatEnabled = "China Hat",
    OrbitOrbsEnabled = "Neon Orbit",
    TrailEnabled = "Motion Trail",
    FogEnabled = "Custom Fog",
    FootstepsEnabled = "Jump Circles",
    AspectRatioEnabled = "Aspect Ratio",
    ThirdPersonEnabled = "Third Person",
    AimEnabled = "Aimbot",
    ShowFovEnabled = "Show FOV",
    TargetHudEnabled = "Target HUD",
    DarkModeEnabled = "Dark Mode",
    TriggerbotEnabled = "Triggerbot",
    SilentAimEnabled = "Silent Aim",
    TeamCheckerEnabled = "Team Checker",
    ShowSilentFovEnabled = "Show Silent FOV",
    CustomFireSoundEnabled = "Hit Sounds",
    SpinEnabled = "SpinBot",
    AntiAimEnabled = "Anti-Aim",
    SpeedHackEnabled = "Speed Hack",
    MultiJumpEnabled = "Multi Jump",
    NoclipEnabled = "Noclip",
    FlyEnabled = "Fly",
    BHopEnabled = "Bunny Hop",
    TargetFlingEnabled = "Target Fling",
    ClickFlingSelectEnabled = "Click Fling Select",
    ForceFieldEnabled = "Body ForceField",
    WeaponForceFieldEnabled = "Weapon ForceField",
    KillFlashEnabled = "Kill Flash",
    SpinCrosshairEnabled = "Spin Crosshair",
    DamageNumbersEnabled = "Damage Numbers",
    SelfChamsEnabled = "Self Chams",
    CloneChamsEnabled = "Clone player",
    OffscreenArrowsEnabled = "Offscreen Arrows",
    DeathChamsEnabled = "Death player",
    DeathBurstEnabled = "Death Burst",
    HitboxEnabled = "Hitbox Expander",
    BulletTracersEnabled = "Bullet Tracers",
    AuraEnabled = "Aura",
    ClassicPinkEnabled = "Pink Aura",
    ClassicAngelEnabled = "Angel Wing",
    ParticleStarlightEnabled = "Starlight",
    ParticleAngelEnabled = "Angel",
    ActiveListEnabled = "Active Modules HUD",
    BindListEnabled = "Binds HUD",
    FakeFpsEnabled = "Fake FPS"
}

UpdateActiveList = function()
    if not Config.ActiveListEnabled then
        ActiveListFrame.Visible = false
        return
    end
    ActiveListFrame.Visible = true

    for _, child in ipairs(ActiveContainer:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end

    local activeCount = 0
    for key, name in pairs(FeatureNamesMapping) do
        if Config[key] == true then
            activeCount = activeCount + 1
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -10, 0, 16)
            lbl.BackgroundTransparency = 1
            lbl.Text = name
            lbl.TextColor3 = Color3.fromRGB(230, 230, 240)
            lbl.TextSize = 12
            lbl.Font = SelectedFont
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = ActiveContainer
        end
    end
    -- fixed size (same as Binds HUD)
    ActiveListFrame.Size = UDim2.new(0, HUD_W or 180, 0, HUD_H or 148)
end

-- ===================== KEYBINDS SYSTEM =====================
Config.Keybinds = Config.Keybinds or {}
Cache.BindToggles = Cache.BindToggles or {}
Cache.WaitingBindKey = nil -- feature key waiting for next key press
Cache.BindIgnoreUntil = 0

-- Features that can be keybound (config key -> display name)
local BindableFeatureOrder = {
    "AimEnabled", "ShowFovEnabled", "SilentAimEnabled", "ShowSilentFovEnabled",
    "TriggerbotEnabled", "TargetHudEnabled", "SpinEnabled", "AntiAimEnabled",
    "BoxEspEnabled", "HealthbarEspEnabled", "ChamsEnabled", "NameEspEnabled",
    "DistanceEspEnabled", "SkeletonEnabled", "TracersEnabled", "CrosshairEnabled", "SpinCrosshairEnabled",
    "DamageNumbersEnabled", "SelfChamsEnabled", "CloneChamsEnabled", "OffscreenArrowsEnabled", "DeathChamsEnabled", "DeathBurstEnabled",
        "FullbrightEnabled", "DarkModeEnabled", "ChinaHatEnabled", "OrbitOrbsEnabled",
    "TrailEnabled", "FogEnabled", "FootstepsEnabled", "AspectRatioEnabled",
    "ThirdPersonEnabled", "ForceFieldEnabled", "WeaponForceFieldEnabled",
    "HitboxEnabled", "BulletTracersEnabled", "AuraEnabled", "ClassicPinkEnabled",
    "ClassicAngelEnabled", "SpeedHackEnabled", "MultiJumpEnabled", "NoclipEnabled",
    "FlyEnabled", "BHopEnabled", "CustomFireSoundEnabled", "ActiveListEnabled",
    "BindListEnabled", "FakeFpsEnabled",
}

local function GetFeatureDisplayName(key)
    return FeatureNamesMapping[key] or key
end

local function RegisterBindToggle(key, fn)
    if type(key) == "string" and type(fn) == "function" then
        Cache.BindToggles[key] = fn
    end
end

local function ClearKeyFromOtherFeatures(keyName, exceptKey)
    if not Config.Keybinds then return end
    for k, v in pairs(Config.Keybinds) do
        if k ~= exceptKey and v == keyName then
            Config.Keybinds[k] = nil
        end
    end
end

local function SetFeatureKeybind(featureKey, keyName)
    if not featureKey then return end
    Config.Keybinds = Config.Keybinds or {}
    if not keyName or keyName == "" or keyName == "Unknown" then
        Config.Keybinds[featureKey] = nil
    else
        ClearKeyFromOtherFeatures(keyName, featureKey)
        Config.Keybinds[featureKey] = keyName
    end
    if UpdateBindList then UpdateBindList() end
end

local function ForceDisableFeature(featureKey)
    -- Hard cleanup so bind OFF actually stops the feature
    pcall(function()
        if featureKey == "ChamsEnabled" then
            for _, ch in pairs(Cache.Chams or {}) do
                if ch then ch.Enabled = false end
            end
            if Cache.ChamsPartFallback then
                for plr, map in pairs(Cache.ChamsPartFallback) do
                    for part, data in pairs(map) do
                        if part and part.Parent and data then
                            pcall(function()
                                part.Material = data.Material
                                part.Color = data.Color
                            end)
                        end
                    end
                end
            end
        elseif featureKey == "BoxEspEnabled" or featureKey == "BoxFillGradientEnabled" then
            for _, boxData in pairs(Cache.Boxes or {}) do
                if boxData then
                    if boxData.Outline then boxData.Outline.Visible = false end
                    if boxData.Box then boxData.Box.Visible = false end
                    if boxData.Fill then boxData.Fill.Visible = false end
                    if boxData.Gradients then
                        for _, g in pairs(boxData.Gradients) do if g then g.Visible = false end end
                    end
                    if boxData.Corners then
                        for _, ln in pairs(boxData.Corners) do if ln then ln.Visible = false end end
                    end
                end
            end
        elseif featureKey == "HealthbarEspEnabled" then
            for _, hb in pairs(Cache.Healthbars or {}) do
                if hb then
                    if hb.Bg then hb.Bg.Visible = false end
                    if hb.Fill then hb.Fill.Visible = false end
                end
            end
        elseif featureKey == "NameEspEnabled" or featureKey == "DistanceEspEnabled" then
            for _, t in pairs(Cache.EspLabels or {}) do if t then t.Visible = false end end
        elseif featureKey == "SkeletonEnabled" then
            for _, parts in pairs(Cache.Skeletons or {}) do
                if parts then for _, ln in pairs(parts) do if ln then ln.Visible = false end end end
            end
        elseif featureKey == "TracersEnabled" then
            for _, ln in pairs(Cache.TracerLines or {}) do if ln then ln.Visible = false end end
        elseif featureKey == "CrosshairEnabled" then
            if CrosshairX then CrosshairX.Visible = false end
            if CrosshairY then CrosshairY.Visible = false end
            pcall(function() UserInputService.MouseIconEnabled = true end)
        elseif featureKey == "ShowFovEnabled" then
            if FovCircle then FovCircle.Visible = false end
        elseif featureKey == "ShowSilentFovEnabled" then
            if SilentFovCircle then SilentFovCircle.Visible = false end
        elseif featureKey == "SilentAimEnabled" then
            Cache.SilentAimTarget = nil
            Cache.SilentAimPart = nil
            Cache.SilentAimPos = nil
        elseif featureKey == "AimEnabled" then
            Cache.AimLockTarget = nil

-- Dedicated AA step (games physics often resets orientation in Heartbeat)
pcall(function()
    if Cache.AnxiumAntiAimHB then Cache.AnxiumAntiAimHB:Disconnect() end
end)
Cache.AnxiumAntiAimHB = RunService.Heartbeat:Connect(function(dt)
    if Config and Config.AntiAimEnabled then
        pcall(AntiAim_Update, dt)
    end
end)

        elseif featureKey == "FullbrightEnabled" or featureKey == "DarkModeEnabled" then
            if not Config.FullbrightEnabled and not Config.DarkModeEnabled then
                Lighting.Ambient = LightingDefaults.Ambient
                Lighting.ColorShift_Bottom = LightingDefaults.ColorShift_Bottom
                Lighting.ColorShift_Top = LightingDefaults.ColorShift_Top
                Lighting.Brightness = LightingDefaults.Brightness
                Lighting.OutdoorAmbient = LightingDefaults.OutdoorAmbient
            end
        elseif featureKey == "FogEnabled" then
            local fogAtm = Lighting:FindFirstChild("AnxiumFogAtmosphere")
            if fogAtm then fogAtm:Destroy() end
            Lighting.FogStart = LightingDefaults.FogStart
            Lighting.FogEnd = LightingDefaults.FogEnd
            Lighting.FogColor = LightingDefaults.FogColor
            Cache.FogWasOn = false
        elseif featureKey == "ChinaHatEnabled" then
            for _, ln in pairs(Cache.ChinaHatLines or {}) do if ln then ln.Visible = false end end
            for _, t in pairs(Cache.ChinaHatTris or {}) do if t then t.Visible = false end end
        elseif featureKey == "OrbitOrbsEnabled" then
            if OrbitPart1 then OrbitPart1.Parent = nil end
            if OrbitPart2 then OrbitPart2.Parent = nil end
        elseif featureKey == "TrailEnabled" then
            if Cache.PlayerTrail then Cache.PlayerTrail.Enabled = false end
        elseif featureKey == "ForceFieldEnabled" then
            if ForceField_Toggle then ForceField_Toggle(false)
            elseif SetForceFieldEnabled then SetForceFieldEnabled(false) end
        elseif featureKey == "WeaponForceFieldEnabled" then
            if WeaponFF_RestoreAll then WeaponFF_RestoreAll() end
        elseif featureKey == "ThirdPersonEnabled" then
            if ThirdPerson_Disable then ThirdPerson_Disable() end
        elseif featureKey == "FlyEnabled" then
            if Cache.FlyBodyVelocity then pcall(function() Cache.FlyBodyVelocity:Destroy() end) Cache.FlyBodyVelocity = nil end
            if Cache.FlyBodyGyro then pcall(function() Cache.FlyBodyGyro:Destroy() end) Cache.FlyBodyGyro = nil end
        elseif featureKey == "ActiveListEnabled" then
            if ActiveListFrame then ActiveListFrame.Visible = false end
        elseif featureKey == "BindListEnabled" then
            if BindListFrame then BindListFrame.Visible = false end
        elseif featureKey == "FakeFpsEnabled" then
            if FakeFpsFrame then FakeFpsFrame.Visible = false end
        elseif featureKey == "TargetHudEnabled" then
            if TargetHudFrame then TargetHudFrame.Visible = false end
        end
    end)
end

local function ToggleFeatureByBind(featureKey)
    if not featureKey then return false end
    local before = Config[featureKey]
    local fn = Cache.BindToggles and Cache.BindToggles[featureKey]
    if fn then
        local ok, err = pcall(fn)
        if not ok then
            warn("[Anxium] bind toggle error:", featureKey, err)
        end
    end
    -- Guarantee flip if handler failed to change state
    if typeof(Config[featureKey]) == "boolean" and Config[featureKey] == before then
        Config[featureKey] = not before
        local ui = Cache.FeatureUI and Cache.FeatureUI[featureKey]
        if ui and ui.bg and ui.knob then
            UpdateSwitch(Config[featureKey], ui.bg, ui.knob, GetFeatureDisplayName(featureKey))
        else
            Notify("Bind", (GetFeatureDisplayName(featureKey)) .. (Config[featureKey] and " enabled" or " disabled"))
            if UpdateActiveList then UpdateActiveList() end
        end
    end
    -- When OFF — force stop visuals / aim state
    if Config[featureKey] == false then
        ForceDisableFeature(featureKey)
    end
    if UpdateBindList then UpdateBindList() end
    if UpdateActiveList then UpdateActiveList() end
    return true
end

-- Bind List HUD — same size/style as Active (watermark colors, one panel)
BindListFrame = Instance.new("Frame")
BindListFrame.Name = "BindListFrame"
BindListFrame.Size = UDim2.new(0, HUD_W, 0, HUD_H)
BindListFrame.Position = UDim2.new(0, 16, 0.38, 80)
BindListFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
BindListFrame.BackgroundTransparency = 0.08
BindListFrame.BorderSizePixel = 0
BindListFrame.ClipsDescendants = true
BindListFrame.Visible = Config.BindListEnabled == true
BindListFrame.Parent = ScreenGui
do
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = BindListFrame
    local st = Instance.new("UIStroke")
    st.Color = Theme.Stroke
    st.Thickness = 1
    st.Transparency = 0.5
    st.Parent = BindListFrame
end

BindHeader = Instance.new("Frame")
BindHeader.Name = "Header"
BindHeader.Size = UDim2.new(1, 0, 0, 26)
BindHeader.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
BindHeader.BackgroundTransparency = 0
BindHeader.BorderSizePixel = 0
BindHeader.Parent = BindListFrame

BindListTitle = Instance.new("TextLabel")
BindListTitle.Size = UDim2.new(1, -12, 1, 0)
BindListTitle.Position = UDim2.new(0, 10, 0, 0)
BindListTitle.BackgroundTransparency = 1
BindListTitle.Text = "Binds"
BindListTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
BindListTitle.TextSize = 12
BindListTitle.Font = SelectedFont
BindListTitle.TextXAlignment = Enum.TextXAlignment.Left
BindListTitle.Parent = BindHeader

BindListContainer = Instance.new("ScrollingFrame")
BindListContainer.Name = "BindListContainer"
BindListContainer.Size = UDim2.new(1, 0, 1, -26)
BindListContainer.Position = UDim2.new(0, 0, 0, 26)
BindListContainer.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
BindListContainer.BackgroundTransparency = 0.45
BindListContainer.BorderSizePixel = 0
BindListContainer.ScrollBarThickness = 3
BindListContainer.ScrollBarImageColor3 = Theme.Accent
BindListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
BindListContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
BindListContainer.Parent = BindListFrame

do
    local lay = Instance.new("UIListLayout")
    lay.HorizontalAlignment = Enum.HorizontalAlignment.Left
    lay.Padding = UDim.new(0, 1)
    lay.Parent = BindListContainer
end
do
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingTop = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 4)
    pad.Parent = BindListContainer
end

MakeDraggable(BindListFrame, BindHeader)

UpdateBindList = function()
    if not Config.BindListEnabled then
        if BindListFrame then BindListFrame.Visible = false end
        return
    end
    BindListFrame.Visible = true
    for _, child in ipairs(BindListContainer:GetChildren()) do
        if child:IsA("TextLabel") then child:Destroy() end
    end
    local count = 0
    local binds = Config.Keybinds or {}
    -- stable order
    for _, key in ipairs(BindableFeatureOrder) do
        local keyName = binds[key]
        if keyName and keyName ~= "" then
            count = count + 1
            local on = Config[key] == true
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -10, 0, 16)
            lbl.BackgroundTransparency = 1
            lbl.Text = string.format("%s [%s]", GetFeatureDisplayName(key), keyName)
            lbl.TextColor3 = on and Theme.Accent or Theme.TextDim
            lbl.TextSize = 11
            lbl.Font = SelectedFont
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = BindListContainer
        end
    end
    -- any extra binds not in order list
    for key, keyName in pairs(binds) do
        local inOrder = false
        for _, k in ipairs(BindableFeatureOrder) do
            if k == key then inOrder = true break end
        end
        if not inOrder and keyName and keyName ~= "" then
            count = count + 1
            local on = Config[key] == true
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -10, 0, 16)
            lbl.BackgroundTransparency = 1
            lbl.Text = string.format("%s [%s]", GetFeatureDisplayName(key), keyName)
            lbl.TextColor3 = on and Theme.Accent or Theme.TextDim
            lbl.TextSize = 11
            lbl.Font = SelectedFont
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = BindListContainer
        end
    end
    if count == 0 then
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -10, 0, 16)
        lbl.BackgroundTransparency = 1
        lbl.Text = "No binds set"
        lbl.TextColor3 = Theme.TextDim
        lbl.TextSize = 11
        lbl.Font = SelectedFont
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = BindListContainer
        count = 1
    end
    -- fixed size (same as Active HUD)
    BindListFrame.Size = UDim2.new(0, HUD_W or 180, 0, HUD_H or 148)
end

-- Key input: set bind OR toggle feature
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local keyCode = input.KeyCode
    if not keyCode or keyCode == Enum.KeyCode.Unknown then return end
    local keyName = keyCode.Name
    if tick() < (Cache.BindIgnoreUntil or 0) then return end

    -- Waiting for bind assignment
    if Cache.WaitingBindKey then
        local feat = Cache.WaitingBindKey
        Cache.WaitingBindKey = nil
        if keyName == "Escape" then
            Notify("Binds", "Bind cancelled")
            return
        end
        if keyName == "Backspace" or keyName == "Delete" then
            SetFeatureKeybind(feat, nil)
            Notify("Binds", GetFeatureDisplayName(feat) .. " bind cleared")
            return
        end
        SetFeatureKeybind(feat, keyName)
        Notify("Binds", GetFeatureDisplayName(feat) .. " → [" .. keyName .. "]")
        return
    end

    if gameProcessed then return end

    -- Toggle any feature bound to this key
    local binds = Config.Keybinds or {}
    for feat, kn in pairs(binds) do
        if kn == keyName then
            ToggleFeatureByBind(feat)
            break
        end
    end
end)

local function StartListeningBind(featureKey)
    if not featureKey then return end
    Cache.WaitingBindKey = featureKey
    Cache.BindIgnoreUntil = tick() + 0.2
    Notify("Binds", "Press a key for " .. GetFeatureDisplayName(featureKey) .. " (Esc cancel, Backspace clear)")
end

-- Create bind row for Settings panel
CreateBindRow = function(featureKey, layoutOrder, parentTab)
    local name = GetFeatureDisplayName(featureKey)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 32)
    Row.BackgroundColor3 = Color3.fromRGB(36, 36, 42)
    Row.BackgroundTransparency = 0.15
    Row.BorderSizePixel = 0
    Row.LayoutOrder = layoutOrder
    Row.Parent = parentTab
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local KeyLbl = Instance.new("TextLabel")
    KeyLbl.Name = "KeyLbl"
    KeyLbl.Size = UDim2.new(0, 70, 0, 22)
    KeyLbl.Position = UDim2.new(1, -150, 0.5, -11)
    KeyLbl.BackgroundColor3 = Theme.BgTertiary
    KeyLbl.BorderSizePixel = 0
    KeyLbl.Text = (Config.Keybinds and Config.Keybinds[featureKey]) and ("[" .. Config.Keybinds[featureKey] .. "]") or "[—]"
    KeyLbl.TextColor3 = Theme.TextDim
    KeyLbl.TextSize = 11
    KeyLbl.Font = SelectedFont
    KeyLbl.Parent = Row
    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(0, 5)
    kc.Parent = KeyLbl

    local SetBtn = Instance.new("TextButton")
    SetBtn.Size = UDim2.new(0, 44, 0, 22)
    SetBtn.Position = UDim2.new(1, -72, 0.5, -11)
    SetBtn.BackgroundColor3 = Theme.Accent
    SetBtn.BorderSizePixel = 0
    SetBtn.Text = "Set"
    SetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SetBtn.TextSize = 11
    SetBtn.Font = SelectedFont
    SetBtn.Parent = Row
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 5)
    sc.Parent = SetBtn

    local ClrBtn = Instance.new("TextButton")
    ClrBtn.Size = UDim2.new(0, 22, 0, 22)
    ClrBtn.Position = UDim2.new(1, -24, 0.5, -11)
    ClrBtn.BackgroundColor3 = Theme.BgTertiary
    ClrBtn.BorderSizePixel = 0
    ClrBtn.Text = "×"
    ClrBtn.TextColor3 = Theme.Text
    ClrBtn.TextSize = 14
    ClrBtn.Font = SelectedFont
    ClrBtn.Parent = Row
    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 5)
    cc.Parent = ClrBtn

    SetBtn.MouseButton1Click:Connect(function()
        StartListeningBind(featureKey)
    end)
    ClrBtn.MouseButton1Click:Connect(function()
        SetFeatureKeybind(featureKey, nil)
        KeyLbl.Text = "[—]"
        Notify("Binds", name .. " bind cleared")
    end)

    -- refresh label when binds change
    Cache.BindKeyLabels = Cache.BindKeyLabels or {}
    Cache.BindKeyLabels[featureKey] = KeyLbl
end

local function RefreshBindKeyLabels()
    if not Cache.BindKeyLabels then return end
    for key, lbl in pairs(Cache.BindKeyLabels) do
        if lbl and lbl.Parent then
            local kn = Config.Keybinds and Config.Keybinds[key]
            lbl.Text = kn and ("[" .. kn .. "]") or "[—]"
        end
    end
end

-- hook UpdateBindList to also refresh settings labels
local _oldUpdateBindList = UpdateBindList
UpdateBindList = function()
    _oldUpdateBindList()
    RefreshBindKeyLabels()
end


WatermarkFrame = Instance.new("Frame")
WatermarkFrame.Name = "WatermarkFrame"
WatermarkFrame.Size = UDim2.new(0, 248, 0, 24)
WatermarkFrame.Position = UDim2.new(0.5, -124, 0, 8)
WatermarkFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
WatermarkFrame.BackgroundTransparency = 0.08
WatermarkFrame.BorderSizePixel = 0
WatermarkFrame.Parent = ScreenGui

WatermarkStroke = Instance.new("UIStroke")
WatermarkStroke.Color = Theme.Stroke
WatermarkStroke.Thickness = 1
WatermarkStroke.Transparency = 0.5
WatermarkStroke.Parent = WatermarkFrame

WatermarkCorner = Instance.new("UICorner")
WatermarkCorner.CornerRadius = UDim.new(0, 8)
WatermarkCorner.Parent = WatermarkFrame

WatermarkLabel = Instance.new("TextLabel")
WatermarkLabel.Name = "WatermarkLabel"
WatermarkLabel.Size = UDim2.new(1, -24, 1, 0)
WatermarkLabel.Position = UDim2.new(0, 12, 0, 0)
WatermarkLabel.BackgroundTransparency = 1
WatermarkLabel.Text = "анксиум <3 | t.me/AnxiumHub"
WatermarkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WatermarkLabel.TextSize = 12
WatermarkLabel.Font = SelectedFont
WatermarkLabel.TextXAlignment = Enum.TextXAlignment.Left
WatermarkLabel.Parent = WatermarkFrame

WatermarkGrad = Instance.new("UIGradient")
WatermarkGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 140, 255)),
    ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.381, Color3.fromRGB(160, 160, 175)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 175))
})
WatermarkGrad.Parent = WatermarkLabel

-- Fake FPS (left of watermark)
local FAKE_FPS_OPTIONS = { 67, 1488, 69, 333, 1337, 666 }

FakeFpsFrame = Instance.new("Frame")
FakeFpsFrame.Name = "FakeFpsFrame"
FakeFpsFrame.Size = UDim2.new(0, 72, 0, 24)
FakeFpsFrame.Position = UDim2.new(0.5, -204, 0, 8) -- left of watermark
FakeFpsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
FakeFpsFrame.BackgroundTransparency = 0.08
FakeFpsFrame.BorderSizePixel = 0
FakeFpsFrame.Visible = false
FakeFpsFrame.Parent = ScreenGui

local FakeFpsStroke = Instance.new("UIStroke")
FakeFpsStroke.Color = Theme.Stroke
FakeFpsStroke.Thickness = 1
FakeFpsStroke.Transparency = 0.5
FakeFpsStroke.Parent = FakeFpsFrame

local FakeFpsCorner = Instance.new("UICorner")
FakeFpsCorner.CornerRadius = UDim.new(0, 8)
FakeFpsCorner.Parent = FakeFpsFrame

FakeFpsLabel = Instance.new("TextLabel")
FakeFpsLabel.Name = "FakeFpsLabel"
FakeFpsLabel.Size = UDim2.new(1, -8, 1, 0)
FakeFpsLabel.Position = UDim2.new(0, 4, 0, 0)
FakeFpsLabel.BackgroundTransparency = 1
FakeFpsLabel.Text = "fps: 67"
FakeFpsLabel.TextColor3 = Color3.fromRGB(180, 255, 160)
FakeFpsLabel.TextSize = 12
FakeFpsLabel.Font = SelectedFont
FakeFpsLabel.TextXAlignment = Enum.TextXAlignment.Center
FakeFpsLabel.Parent = FakeFpsFrame

local function UpdateFakeFpsDisplay()
    local v = Config.FakeFpsValue or 67
    if FakeFpsLabel then
        FakeFpsLabel.Text = "fps: " .. tostring(v)
    end
    if FakeFpsFrame then
        FakeFpsFrame.Visible = Config.FakeFpsEnabled == true
    end
end

FovCircle = Drawing.new("Circle")
FovCircle.Thickness = 1.5
FovCircle.NumSides = 32
FovCircle.Radius = Config.FovRadius
FovCircle.Filled = false
FovCircle.Visible = false
FovCircle.Color = Config.Color_Fov or Theme.Accent

SilentFovCircle = Drawing.new("Circle")
SilentFovCircle.Thickness = 1.5
SilentFovCircle.NumSides = 48
SilentFovCircle.Radius = Config.SilentFovRadius or 130
SilentFovCircle.Filled = false
SilentFovCircle.Visible = false
SilentFovCircle.Color = Config.Color_SilentFov or Color3.fromRGB(255, 80, 80)
SilentFovCircle.ZIndex = 2

CrosshairX = Drawing.new("Line")
CrosshairX.Thickness = 1.4
CrosshairX.Transparency = 1
CrosshairX.Visible = false
CrosshairX.Color = Config.Color_Crosshair or Theme.Accent

CrosshairY = Drawing.new("Line")
CrosshairY.Thickness = 1.4
CrosshairY.Transparency = 1
CrosshairY.Visible = false
CrosshairY.Color = Config.Color_Crosshair or Theme.Accent

-- Spin crosshair uses 4 lines
Cache.CrosshairSpinAngle = 0
Cache.CrosshairSpinLines = {}
if Drawing then
    for i = 1, 4 do
        local ln = Drawing.new("Line")
        ln.Thickness = 1.6
        ln.Transparency = 1
        ln.Visible = false
        ln.Color = Config.Color_Crosshair or Theme.Accent
        Cache.CrosshairSpinLines[i] = ln
    end
end



local function BuildHatDrawing()
    if not Drawing then return end
    for _, obj in ipairs(Cache.ChinaHatLines) do 
        pcall(function() 
            if obj.Line then obj.Line:Remove() end
            if obj.BaseLine then obj.BaseLine:Remove() end
        end) 
    end
    for _, obj in ipairs(Cache.ChinaHatTris) do pcall(function() obj:Remove() end) end
    Cache.ChinaHatLines = {}
    Cache.ChinaHatTris = {}

    for i = 1, Config.ChinaHatSegments do
        local line = Drawing.new("Line")
        line.ZIndex = 3
        line.Thickness = 1.5

        local baseLine = Drawing.new("Line")
        baseLine.ZIndex = 3
        baseLine.Thickness = 1.5

        local tri = Drawing.new("Triangle")
        tri.ZIndex = 1
        tri.Filled = true

        table.insert(Cache.ChinaHatLines, {Line = line, BaseLine = baseLine})
        table.insert(Cache.ChinaHatTris, tri)
    end
end

local function HideHatDrawing()
    for i = 1, #Cache.ChinaHatLines do
        pcall(function() 
            Cache.ChinaHatLines[i].Line.Visible = false 
            Cache.ChinaHatLines[i].BaseLine.Visible = false 
        end)
        pcall(function() Cache.ChinaHatTris[i].Visible = false end)
    end
end

if Drawing then
    BuildHatDrawing()
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.5)
        BuildHatDrawing()
    end)
end

OrbitPart1 = Instance.new("Part")
OrbitPart1.Size = Vector3.new(0.1, 0.1, 0.1)
OrbitPart1.Transparency = 1
OrbitPart1.CanCollide = false
OrbitPart1.Anchored = true

OrbAtt0_1 = Instance.new("Attachment", OrbitPart1)
OrbAtt0_1.Position = Vector3.new(0, 0.6, 0)
OrbAtt1_1 = Instance.new("Attachment", OrbitPart1)
OrbAtt1_1.Position = Vector3.new(0, -0.6, 0)

OrbTrail1 = Instance.new("Trail")
OrbTrail1.Attachment0 = OrbAtt0_1
OrbTrail1.Attachment1 = OrbAtt1_1
OrbTrail1.Lifetime = 0.28
OrbTrail1.LightEmission = 1
OrbTrail1.LightInfluence = 0
OrbTrail1.Color = ColorSequence.new(Theme.Accent)
OrbTrail1.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.05),
    NumberSequenceKeypoint.new(0.6, 0.3),
    NumberSequenceKeypoint.new(1, 1)
})
OrbTrail1.WidthScale = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.8),
    NumberSequenceKeypoint.new(1, 0.1)
})
OrbTrail1.Parent = OrbitPart1

OrbitPart2 = Instance.new("Part")
OrbitPart2.Size = Vector3.new(0.1, 0.1, 0.1)
OrbitPart2.Transparency = 1
OrbitPart2.CanCollide = false
OrbitPart2.Anchored = true

OrbAtt0_2 = Instance.new("Attachment", OrbitPart2)
OrbAtt0_2.Position = Vector3.new(0, 0.6, 0)
OrbAtt1_2 = Instance.new("Attachment", OrbitPart2)
OrbAtt1_2.Position = Vector3.new(0, -0.6, 0)

OrbTrail2 = Instance.new("Trail")
OrbTrail2.Attachment0 = OrbAtt0_2
OrbTrail2.Attachment1 = OrbAtt1_2
OrbTrail2.Lifetime = 0.28
OrbTrail2.LightEmission = 1
OrbTrail2.LightInfluence = 0
OrbTrail2.Color = ColorSequence.new(Theme.Accent)
OrbTrail2.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.05),
    NumberSequenceKeypoint.new(0.6, 0.3),
    NumberSequenceKeypoint.new(1, 1)
})
OrbTrail2.WidthScale = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.8),
    NumberSequenceKeypoint.new(1, 0.1)
})
OrbTrail2.Parent = OrbitPart2

SetupTrail = function(character)
    if not character then return end
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end

    if Cache.PlayerTrail then Cache.PlayerTrail:Destroy() end
    if Cache.TrailAtt0 then Cache.TrailAtt0:Destroy() end
    if Cache.TrailAtt1 then Cache.TrailAtt1:Destroy() end

    Cache.TrailAtt0 = Instance.new("Attachment")
    Cache.TrailAtt0.Name = "AnxiumTrailAtt0"
    Cache.TrailAtt0.Position = Vector3.new(0, 1, 0)
    Cache.TrailAtt0.Parent = hrp

    Cache.TrailAtt1 = Instance.new("Attachment")
    Cache.TrailAtt1.Name = "AnxiumTrailAtt1"
    Cache.TrailAtt1.Position = Vector3.new(0, -1, 0)
    Cache.TrailAtt1.Parent = hrp

    Cache.PlayerTrail = Instance.new("Trail")
    Cache.PlayerTrail.Name = "AnxiumTrail"
    Cache.PlayerTrail.Attachment0 = Cache.TrailAtt0
    Cache.PlayerTrail.Attachment1 = Cache.TrailAtt1
    Cache.PlayerTrail.Lifetime = 0.6
    Cache.PlayerTrail.LightEmission = 1
    Cache.PlayerTrail.LightInfluence = 0
    Cache.PlayerTrail.Color = ColorSequence.new(Config.Color_Trail or Theme.Accent)
    Cache.PlayerTrail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(1, 1)
    })
    Cache.PlayerTrail.Enabled = Config.TrailEnabled
    Cache.PlayerTrail.Parent = hrp
end

if LocalPlayer.Character then SetupTrail(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(SetupTrail)

local function ForceField_SaveOriginals(char)
    if not char or Cache.ForceFieldOriginals[char] then return end
    Cache.ForceFieldOriginals[char] = {}
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            Cache.ForceFieldOriginals[char][part] = {
                Color = part.Color,
                Material = part.Material
            }
        end
    end
end

local function ForceField_Apply(char)
    if not char then return end
    ForceField_SaveOriginals(char)
    local col = Config.Color_ForceField or Theme.Accent
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Color = col
            part.Material = Enum.Material.ForceField
        end
    end
end

local function ForceField_Restore(char)
    if not char or not Cache.ForceFieldOriginals[char] then return end
    for part, data in pairs(Cache.ForceFieldOriginals[char]) do
        if part and part.Parent and part:IsA("BasePart") then
            pcall(function()
                part.Color = data.Color
                part.Material = data.Material
            end)
        end
    end
    Cache.ForceFieldOriginals[char] = nil
end

local function ForceField_Update()
    if not Config then return end
    local char = LocalPlayer.Character
    if not char or not Config.ForceFieldEnabled then return end
    local col = Config.Color_ForceField or Theme.Accent
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Material == Enum.Material.ForceField then
            part.Color = col
        end
    end
end

local function ForceField_Toggle(enabled)
    Config.ForceFieldEnabled = enabled
    local char = LocalPlayer.Character
    if enabled then
        if char then ForceField_Apply(char) end
        if Cache.ForceFieldConnection then
            Cache.ForceFieldConnection:Disconnect()
            Cache.ForceFieldConnection = nil
        end
    else
        if Cache.ForceFieldConnection then
            Cache.ForceFieldConnection:Disconnect()
            Cache.ForceFieldConnection = nil
        end
        if char then ForceField_Restore(char) end
    end
end

-- ============================================================
-- Weapon ForceField
-- Paints equipped Tool + FPS ViewModel under Camera (most shooters)
-- ============================================================
Cache.WeaponFFPainted = Cache.WeaponFFPainted or {} -- [Instance] = original data
Cache.WeaponFFKeepAlive = nil
Cache.WeaponFFConnections = Cache.WeaponFFConnections or {}
Cache.WeaponFFCurrentTool = nil

local WEAPON_FF_SKIP_NAMES = {
    HumanoidRootPart = true, Head = true, Torso = true, ["Left Arm"] = true, ["Right Arm"] = true,
    ["Left Leg"] = true, ["Right Leg"] = true, UpperTorso = true, LowerTorso = true,
    LeftUpperArm = true, LeftLowerArm = true, LeftHand = true,
    RightUpperArm = true, RightLowerArm = true, RightHand = true,
    LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true,
    RightUpperLeg = true, RightLowerLeg = true, RightFoot = true,
    -- FPS viewmodel arms (don't paint hands/arms, only gun)
    LeftArm = true, RightArm = true, Arm = true, Arms = true,
    LArm = true, RArm = true, Left_Arm = true, Right_Arm = true,
    Hand = true, Hands = true, LeftHand = true, RightHand = true,
    Glove = true, Gloves = true, Sleeve = true, Sleeves = true,
    Character = true, Body = true, FakeCharacter = true,
}

local function WeaponFF_IsBodyPart(part)
    if not part then return true end
    local n = part.Name
    if WEAPON_FF_SKIP_NAMES[n] then return true end
    local lower = string.lower(n)
    -- skip arm/hand-like names in viewmodels
    if lower:find("arm") or lower:find("hand") or lower:find("glove") or lower:find("sleeve") then
        return true
    end
    local p = part.Parent
    if p then
        if WEAPON_FF_SKIP_NAMES[p.Name] then return true end
        local pl = string.lower(p.Name)
        if pl:find("arm") or pl:find("hand") or pl == "arms" then
            return true
        end
    end
    return false
end

local function WeaponFF_SavePart(part)
    if not part or Cache.WeaponFFPainted[part] then return end
    local data = {}
    if part:IsA("BasePart") then
        data.Color = part.Color
        data.Material = part.Material
        data.Transparency = part.Transparency
        if part:IsA("MeshPart") then
            data.TextureID = part.TextureID
        end
    elseif part:IsA("SpecialMesh") then
        data.TextureId = part.TextureId
    elseif part:IsA("Decal") or part:IsA("Texture") then
        data.Transparency = part.Transparency
    elseif part:IsA("SurfaceAppearance") then
        data.WasParent = part.Parent
        -- hide SurfaceAppearance for pure FF look
    else
        return
    end
    data.Class = part.ClassName
    Cache.WeaponFFPainted[part] = data
end

local function WeaponFF_PaintPart(part)
    if not part or not part.Parent then return end
    if WeaponFF_IsBodyPart(part) then return end
    WeaponFF_SavePart(part)
    local col = Config.Color_WeaponFF or Theme.Accent
    pcall(function()
        if part:IsA("BasePart") then
            part.Color = col
            part.Material = Enum.Material.ForceField
            if part:IsA("MeshPart") then
                part.TextureID = ""
            end
            -- FPS games often hide world gun via LocalTransparencyModifier
            if part.LocalTransparencyModifier and part.LocalTransparencyModifier >= 0.9 then
                -- don't force show hidden world model; viewmodel is separate
            end
        elseif part:IsA("SpecialMesh") then
            part.TextureId = ""
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        elseif part:IsA("SurfaceAppearance") then
            part.Parent = nil
        end
    end)
end

local function WeaponFF_PaintContainer(container)
    if not container then return end
    for _, obj in ipairs(container:GetDescendants()) do
        WeaponFF_PaintPart(obj)
    end
    for _, obj in ipairs(container:GetChildren()) do
        WeaponFF_PaintPart(obj)
    end
end

local function WeaponFF_RestorePart(part, data)
    if not part or not data then return end
    pcall(function()
        if part:IsA("BasePart") then
            if data.Color then part.Color = data.Color end
            if data.Material then part.Material = data.Material end
            if data.Transparency ~= nil then part.Transparency = data.Transparency end
            if data.TextureID ~= nil and part:IsA("MeshPart") then
                part.TextureID = data.TextureID
            end
        elseif part:IsA("SpecialMesh") then
            if data.TextureId ~= nil then part.TextureId = data.TextureId end
        elseif part:IsA("Decal") or part:IsA("Texture") then
            if data.Transparency ~= nil then part.Transparency = data.Transparency end
        elseif part:IsA("SurfaceAppearance") then
            if data.WasParent and data.WasParent.Parent then
                part.Parent = data.WasParent
            end
        end
    end)
end

local function WeaponFF_RestoreAll()
    for part, data in pairs(Cache.WeaponFFPainted) do
        if part then
            WeaponFF_RestorePart(part, data)
        end
    end
    Cache.WeaponFFPainted = {}
    Cache.WeaponFFCurrentTool = nil
end

local function WeaponFF_FindViewModels()
    -- Lightweight: only Camera + Character tools (NO workspace:GetDescendants — that lagged)
    local list = {}
    local seen = {}
    local function add(obj)
        if obj and not seen[obj] then
            seen[obj] = true
            table.insert(list, obj)
        end
    end

    local cam = workspace.CurrentCamera or Camera
    if cam then
        for _, child in ipairs(cam:GetChildren()) do
            if child:IsA("Model") or child:IsA("Folder") or child:IsA("Tool") or child:IsA("BasePart") then
                add(child)
            end
        end
    end

    local char = LocalPlayer.Character
    if char then
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") then
                add(child)
            end
        end
    end

    return list
end

local function WeaponFF_ApplyAll()
    if not Config.WeaponForceFieldEnabled then return end
    local containers = WeaponFF_FindViewModels()
    for _, c in ipairs(containers) do
        WeaponFF_PaintContainer(c)
        if c:IsA("Tool") then
            Cache.WeaponFFCurrentTool = c
        end
    end
end

local function WeaponFF_UpdateColor()
    if not Config.WeaponForceFieldEnabled then return end
    local col = Config.Color_WeaponFF or Theme.Accent
    for part, _ in pairs(Cache.WeaponFFPainted) do
        if part and part.Parent and part:IsA("BasePart") and part.Material == Enum.Material.ForceField then
            pcall(function() part.Color = col end)
        end
    end
end

local function WeaponFF_OnCharacter(char)
    if not char then return end
    if Cache.WeaponFFConnections.ChildAdded then
        pcall(function() Cache.WeaponFFConnections.ChildAdded:Disconnect() end)
    end
    if Cache.WeaponFFConnections.ChildRemoved then
        pcall(function() Cache.WeaponFFConnections.ChildRemoved:Disconnect() end)
    end
    if Cache.WeaponFFConnections.CamChild then
        pcall(function() Cache.WeaponFFConnections.CamChild:Disconnect() end)
    end

    Cache.WeaponFFConnections.ChildAdded = char.ChildAdded:Connect(function(child)
        if not Config.WeaponForceFieldEnabled then return end
        if child:IsA("Tool") then
            task.defer(function()
                if child.Parent == char and Config.WeaponForceFieldEnabled then
                    WeaponFF_PaintContainer(child)
                    Cache.WeaponFFCurrentTool = child
                end
            end)
        end
    end)

    Cache.WeaponFFConnections.ChildRemoved = char.ChildRemoved:Connect(function(child)
        if child:IsA("Tool") then
            -- restore only parts that belonged to this tool
            for part, data in pairs(Cache.WeaponFFPainted) do
                if part and part:IsDescendantOf(child) then
                    WeaponFF_RestorePart(part, data)
                    Cache.WeaponFFPainted[part] = nil
                end
            end
            if Cache.WeaponFFCurrentTool == child then
                Cache.WeaponFFCurrentTool = nil
            end
        end
    end)

    local cam = Camera or workspace.CurrentCamera
    if cam then
        Cache.WeaponFFConnections.CamChild = cam.ChildAdded:Connect(function(child)
            if Config.WeaponForceFieldEnabled then
                task.defer(function()
                    if Config.WeaponForceFieldEnabled and child.Parent == cam then
                        WeaponFF_PaintContainer(child)
                    end
                end)
            end
        end)
    end

    if Config.WeaponForceFieldEnabled then
        WeaponFF_ApplyAll()
    end
end

local function WeaponFF_Toggle(enabled)
    Config.WeaponForceFieldEnabled = enabled
    if Cache.WeaponFFKeepAlive then
        pcall(function() Cache.WeaponFFKeepAlive:Disconnect() end)
        Cache.WeaponFFKeepAlive = nil
    end
    if enabled then
        local char = LocalPlayer.Character
        if char then WeaponFF_OnCharacter(char) end
        WeaponFF_ApplyAll()
        -- aggressive keep-alive: FPS games reset materials every frame
        local acc = 0
        Cache.WeaponFFKeepAlive = RunService.RenderStepped:Connect(function(dt)
            if not Config.WeaponForceFieldEnabled then return end
            acc = acc + dt
            if acc < 0.35 then return end
            acc = 0
            WeaponFF_ApplyAll()
        end)
    else
        WeaponFF_RestoreAll()
    end
end

-- Hook character respawn for weapon FF
LocalPlayer.CharacterAdded:Connect(function(char)
    task.defer(function()
        if Config.WeaponForceFieldEnabled then
            WeaponFF_OnCharacter(char)
            WeaponFF_ApplyAll()
        end
    end)
end)
if LocalPlayer.Character and Config.WeaponForceFieldEnabled then
    task.defer(function() WeaponFF_OnCharacter(LocalPlayer.Character) end)
end



local ClassicAuraIDs = {
    Godly = "rbxassetid://16699750981",
    PinkAura = "rbxassetid://115980859615239",
    AngelWing = "rbxassetid://90022969696073"
}

local function tintAuraSubtree(root, color)
    if not root or not color then return end
    local seq = ColorSequence.new(color)
    local function tintOne(obj)
        pcall(function()
            if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                obj.Color = seq
            elseif obj:IsA("PointLight") or obj:IsA("Fire") or obj:IsA("Smoke") then
                obj.Color = color
            end
        end)
    end
    tintOne(root)
    for _, d in ipairs(root:GetDescendants()) do
        tintOne(d)
    end
end

local function ClassicAura_Disable(name)
    if Cache.ActiveClassicAuras[name] then
        for _, v in ipairs(Cache.ActiveClassicAuras[name]) do
            if v and v.Parent then
                pcall(function() v:Destroy() end)
            end
        end
        Cache.ActiveClassicAuras[name] = {}
    end
end

local function ClassicAura_Enable(char, name, color)
    if not char or not char.Parent then return end
    ClassicAura_Disable(name)

    local id = ClassicAuraIDs[name]
    if not id then return end

    local success, model = pcall(function()
        return game:GetObjects(id)[1]
    end)
    if not success or not model then return end

    local effects = {}
    for _, obj in pairs(model:GetDescendants()) do
        if not obj:IsA("BasePart") then
            pcall(function()
                local clone = obj:Clone()
                local parentName = obj.Parent and obj.Parent.Name
                local target = char:FindFirstChild(parentName) or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart")
                if target then
                    clone.Parent = target
                    if color then tintAuraSubtree(clone, color) end
                    table.insert(effects, clone)
                end
            end)
        end
    end

    pcall(function() model:Destroy() end)
    Cache.ActiveClassicAuras[name] = effects
end

local function ClassicAura_RefreshAll()
    local char = LocalPlayer.Character
    if not char then return end

    local ac = Config.Color_Aura or Theme.Accent
    if Config.AuraEnabled then ClassicAura_Enable(char, "Godly", ac) else ClassicAura_Disable("Godly") end
    if Config.ClassicPinkEnabled then ClassicAura_Enable(char, "PinkAura", ac) else ClassicAura_Disable("PinkAura") end
    if Config.ClassicAngelEnabled then ClassicAura_Enable(char, "AngelWing", ac) else ClassicAura_Disable("AngelWing") end
end

local ParticleAuraIDs = {
    starlight = "rbxassetid://134645216613107",
    angel = "rbxassetid://97658130917593"
}

local function getParticleTemplate(name)
    if Cache.LoadedParticleTemplates[name] then
        return Cache.LoadedParticleTemplates[name]
    end
    local id = ParticleAuraIDs[name]
    if not id then return nil end
    local ok, result = pcall(function()
        return game:GetObjects(id)[1]
    end)
    if ok and result then
        Cache.LoadedParticleTemplates[name] = result
        return result
    end
    return nil
end

local function mapCharacterParts(character)
    local parts = {}
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("BasePart") then
            parts[child.Name] = child
        end
    end
    return parts
end

local function setParticleEmittersEnabled(root, enabled)
    if not root then return end
    if root:IsA("ParticleEmitter") then pcall(function() root.Enabled = enabled end) end
    for _, d in ipairs(root:GetDescendants()) do
        if d:IsA("ParticleEmitter") then pcall(function() d.Enabled = enabled end) end
    end
end

local function ParticleAura_Disable(name)
    if Cache.ActiveParticleAuras[name] then
        for _, p in ipairs(Cache.ActiveParticleAuras[name]) do
            if p then pcall(function() p:Destroy() end) end
        end
        Cache.ActiveParticleAuras[name] = {}
    end
end

local function ParticleAura_Enable(char, name, color)
    if not char then return end
    ParticleAura_Disable(name)

    local auraObj = getParticleTemplate(name)
    if not auraObj then return end

    local localParts = mapCharacterParts(char)
    local cloned = auraObj:Clone()
    local created = {}

    for _, part in ipairs(cloned:GetChildren()) do
        local targetPart = localParts[part.Name]
        if targetPart then
            for _, child in ipairs(part:GetChildren()) do
                pcall(function()
                    local inst = child:Clone()
                    inst.Name = "AnxiumParticleAura"
                    inst.Parent = targetPart
                    if color then tintAuraSubtree(inst, color) end
                    table.insert(created, inst)
                end)
            end
        end
    end

    pcall(function() cloned:Destroy() end)

    for _, p in ipairs(created) do
        setParticleEmittersEnabled(p, true)
    end

    Cache.ActiveParticleAuras[name] = created
end

local function ParticleAura_RefreshAll()
    local char = LocalPlayer.Character
    if not char then return end

    local ac = Config.Color_Aura or Theme.Accent
    if Config.ParticleStarlightEnabled then ParticleAura_Enable(char, "starlight", ac) else ParticleAura_Disable("starlight") end
    if Config.ParticleAngelEnabled then ParticleAura_Enable(char, "angel", ac) else ParticleAura_Disable("angel") end
end

local function ReapplyAurasAndForceField(char)
    task.wait(0.8)
    if not char or not char.Parent then return end
    if Config.ForceFieldEnabled then ForceField_Apply(char) end
    ClassicAura_RefreshAll()
    ParticleAura_RefreshAll()
end

-- Saved zoom limits so we can restore cleanly (important for lobbies that already allow 3rd person)
Cache.ThirdPersonSavedMinZoom = nil
Cache.ThirdPersonSavedMaxZoom = nil
Cache.ThirdPersonUsingOffset = false

local function ThirdPerson_IsFirstPersonLocked()
    local ok, mode = pcall(function() return LocalPlayer.CameraMode end)
    if ok and mode == Enum.CameraMode.LockFirstPerson then
        return true
    end
    local maxZ = LocalPlayer.CameraMaxZoomDistance
    -- Game forces first person if max zoom is very small
    if typeof(maxZ) == "number" and maxZ <= 1.5 then
        return true
    end
    return false
end

local function ThirdPerson_ApplyCharacter(char)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                if part.Name ~= "HumanoidRootPart" then
                    part.LocalTransparencyModifier = 1
                end
                part.CanQuery = false
            end)
        end
    end
end

local function ThirdPerson_RestoreCharacter(char)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                part.LocalTransparencyModifier = 0
                part.CanQuery = true
            end)
        end
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function() hum.CameraOffset = Vector3.zero end)
    end
end

local function ThirdPerson_Enable()
    pcall(function()
        -- Remember original zoom so lobby / free-cam places restore correctly
        if Cache.ThirdPersonSavedMinZoom == nil then
            Cache.ThirdPersonSavedMinZoom = LocalPlayer.CameraMinZoomDistance
            Cache.ThirdPersonSavedMaxZoom = LocalPlayer.CameraMaxZoomDistance
        end

        LocalPlayer.CameraMode = Enum.CameraMode.Classic
        LocalPlayer.DevEnableMouseLock = true

        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local dist = math.clamp(Config.ThirdPersonDistance or 12, 4, 50)
        local fpLocked = ThirdPerson_IsFirstPersonLocked()
        Cache.ThirdPersonUsingOffset = fpLocked

        if Camera then
            if Camera.CameraType ~= Enum.CameraType.Custom and Camera.CameraType ~= Enum.CameraType.Track then
                Camera.CameraType = Enum.CameraType.Custom
            end
            if hum then Camera.CameraSubject = hum end
        end

        if fpLocked then
            -- FPS places: keep zoom in FP range, pull camera with CameraOffset so shots still register
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 0.5
            if hum then
                hum.CameraOffset = Vector3.new(0, math.clamp(dist * 0.12, 0.8, 3), dist * 0.85)
            end
            if char then ThirdPerson_ApplyCharacter(char) end
        else
            -- Lobby / free third-person places: normal zoom lock, no offset (keeps cursor & controls working)
            if hum then hum.CameraOffset = Vector3.zero end
            LocalPlayer.CameraMinZoomDistance = dist
            LocalPlayer.CameraMaxZoomDistance = dist
            if char then ThirdPerson_RestoreCharacter(char) end
        end
    end)
end

local function ThirdPerson_Disable()
    pcall(function()
        local minZ = Cache.ThirdPersonSavedMinZoom
        local maxZ = Cache.ThirdPersonSavedMaxZoom
        if typeof(minZ) == "number" and typeof(maxZ) == "number" then
            LocalPlayer.CameraMinZoomDistance = minZ
            LocalPlayer.CameraMaxZoomDistance = maxZ
        else
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 400
        end
        Cache.ThirdPersonSavedMinZoom = nil
        Cache.ThirdPersonSavedMaxZoom = nil
        Cache.ThirdPersonUsingOffset = false

        local char = LocalPlayer.Character
        if char then
            ThirdPerson_RestoreCharacter(char)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(ReapplyAurasAndForceField)
LocalPlayer.CharacterAdded:Connect(function(char)
    if not Config.ThirdPersonEnabled then return end
    -- Game often forces First-Person after spawn. Re-apply multiple times.
    task.spawn(function()
        for _, delay in ipairs({0.15, 0.45, 0.9, 1.5, 2.3}) do
            task.wait(delay)
            if not Config.ThirdPersonEnabled then return end
            if LocalPlayer.Character ~= char then return end
            ThirdPerson_Enable()
        end
    end)
end)
LocalPlayer.CharacterRemoving:Connect(function(char)
    if Cache.ForceFieldOriginals[char] then Cache.ForceFieldOriginals[char] = nil end
    ClassicAura_Disable("Godly")
    ClassicAura_Disable("PinkAura")
    ClassicAura_Disable("AngelWing")
    ParticleAura_Disable("starlight")
    ParticleAura_Disable("angel")
    ThirdPerson_RestoreCharacter(char)
end)

if LocalPlayer.Character then
    task.spawn(function() ReapplyAurasAndForceField(LocalPlayer.Character) end)
end

TargetHudFrame = Instance.new("Frame")
TargetHudFrame.Name = "AnxiumTargetHud"
TargetHudFrame.Size = UDim2.new(0, 240, 0, 78)
TargetHudFrame.Position = UDim2.new(0.5, 130, 0.5, 40)
TargetHudFrame.BackgroundColor3 = Theme.Bg
TargetHudFrame.BackgroundTransparency = 1
TargetHudFrame.BorderSizePixel = 0
TargetHudFrame.Visible = false
TargetHudFrame.ClipsDescendants = true
TargetHudFrame.Parent = ScreenGui

TargetHudStroke = Instance.new("UIStroke")
TargetHudStroke.Color = Config.Color_TargetHud or Theme.Accent
TargetHudStroke.Thickness = 1
TargetHudStroke.Transparency = 1
TargetHudStroke.Parent = TargetHudFrame

TargetHudCorner = Instance.new("UICorner")
TargetHudCorner.CornerRadius = UDim.new(0, 12)
TargetHudCorner.Parent = TargetHudFrame

MakeDraggable(TargetHudFrame)

TargetAvatar = Instance.new("ImageLabel")
TargetAvatar.Name = "TargetAvatar"
TargetAvatar.Size = UDim2.new(0, 54, 0, 54)
TargetAvatar.Position = UDim2.new(0, 12, 0.5, -27)
TargetAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TargetAvatar.BorderSizePixel = 0
TargetAvatar.ImageTransparency = 0
TargetAvatar.BackgroundTransparency = 0
TargetAvatar.ScaleType = Enum.ScaleType.Crop
TargetAvatar.ResampleMode = Enum.ResamplerMode.Pixelated
TargetAvatar.Image = ""
TargetAvatar.ZIndex = 5
TargetAvatar.ClipsDescendants = true
TargetAvatar.Parent = TargetHudFrame

AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 10)
AvatarCorner.Parent = TargetAvatar

-- subtle ring around avatar
local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = Config.Color_TargetHud or Theme.Accent
AvatarStroke.Thickness = 1.5
AvatarStroke.Transparency = 0.3
AvatarStroke.Parent = TargetAvatar

-- Cache for player headshot thumbnails
Cache.TargetHudThumbCache = {}
Cache.TargetHudLastUserId = nil

local function GetAvatarUrl(userId)
    userId = tonumber(userId) or userId
    -- Multiple formats — at least one works in most executors
    return {
        "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png",
        "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=150&h=150",
        "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. userId .. "&size=150x150&format=Png&isCircular=false",
    }
end

local function ApplyTargetAvatar(userId)
    if not userId then return end
    userId = tonumber(userId) or userId

    if Cache.TargetHudThumbCache[userId] then
        TargetAvatar.Image = Cache.TargetHudThumbCache[userId]
        TargetAvatar.ImageTransparency = 0
        return
    end

    -- Instant: use classic roblox headshot URL (works in ImageLabel almost everywhere)
    local urls = GetAvatarUrl(userId)
    TargetAvatar.Image = urls[1]
    TargetAvatar.ImageTransparency = 0
    Cache.TargetHudThumbCache[userId] = urls[1]

    -- Also try GetUserThumbnailAsync in background for better quality
    task.spawn(function()
        local ok, thumb = pcall(function()
            return Players:GetUserThumbnailAsync(
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size150x150
            )
        end)
        if ok and type(thumb) == "string" and #thumb > 0 then
            Cache.TargetHudThumbCache[userId] = thumb
            if Cache.TargetHudLastUserId == userId then
                TargetAvatar.Image = thumb
                TargetAvatar.ImageTransparency = 0
            end
        end
    end)
end

TargetNameLabel = Instance.new("TextLabel")
TargetNameLabel.Name = "TargetName"
TargetNameLabel.Size = UDim2.new(1, -80, 0, 20)
TargetNameLabel.Position = UDim2.new(0, 76, 0, 12)
TargetNameLabel.BackgroundTransparency = 1
TargetNameLabel.Text = "Target"
TargetNameLabel.TextColor3 = Theme.Text
TargetNameLabel.TextSize = 14
TargetNameLabel.Font = SelectedFont
TargetNameLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetNameLabel.TextTransparency = 1
TargetNameLabel.Parent = TargetHudFrame

TargetHealthBg = Instance.new("Frame")
TargetHealthBg.Name = "HealthBg"
TargetHealthBg.Size = UDim2.new(1, -88, 0, 8)
TargetHealthBg.Position = UDim2.new(0, 76, 0, 38)
TargetHealthBg.BackgroundColor3 = Theme.BgTertiary
TargetHealthBg.BorderSizePixel = 0
TargetHealthBg.BackgroundTransparency = 1
TargetHealthBg.Parent = TargetHudFrame

HealthBgCorner = Instance.new("UICorner")
HealthBgCorner.CornerRadius = UDim.new(0, 4)
HealthBgCorner.Parent = TargetHealthBg

TargetHealthFill = Instance.new("Frame")
TargetHealthFill.Name = "HealthFill"
TargetHealthFill.Size = UDim2.new(1, 0, 1, 0)
TargetHealthFill.BackgroundColor3 = Config.Color_TargetHud or Theme.Accent
            if AvatarStroke then AvatarStroke.Color = Config.Color_TargetHud or Theme.Accent end
TargetHealthFill.BorderSizePixel = 0
TargetHealthFill.BackgroundTransparency = 1
TargetHealthFill.Parent = TargetHealthBg

HealthFillCorner = Instance.new("UICorner")
HealthFillCorner.CornerRadius = UDim.new(0, 4)
HealthFillCorner.Parent = TargetHealthFill

TargetInfoLabel = Instance.new("TextLabel")
TargetInfoLabel.Name = "TargetInfo"
TargetInfoLabel.Size = UDim2.new(1, -88, 0, 16)
TargetInfoLabel.Position = UDim2.new(0, 76, 0, 52)
TargetInfoLabel.BackgroundTransparency = 1
TargetInfoLabel.Text = "100 / 100  ·  0m"
TargetInfoLabel.TextColor3 = Theme.TextDim
TargetInfoLabel.TextSize = 11
TargetInfoLabel.Font = SelectedFont
TargetInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetInfoLabel.TextTransparency = 1
TargetInfoLabel.Parent = TargetHudFrame

local TargetHudVisible = false
local TargetHudTweens = {}

local function CancelTargetHudTweens()
    for _, tw in ipairs(TargetHudTweens) do
        if tw then tw:Cancel() end
    end
    TargetHudTweens = {}
end

local function ShowTargetHud()
    if TargetHudVisible then return end
    TargetHudVisible = true
    CancelTargetHudTweens()

    TargetHudFrame.Visible = true
    TargetHudFrame.Size = UDim2.new(0, 228, 0, 72)
    TargetHudFrame.BackgroundTransparency = 1
    TargetHudStroke.Transparency = 1
    TargetAvatar.ImageTransparency = 1
    TargetNameLabel.TextTransparency = 1
    TargetInfoLabel.TextTransparency = 1
    TargetHealthBg.BackgroundTransparency = 1
    TargetHealthFill.BackgroundTransparency = 1

    local info = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    table.insert(TargetHudTweens, TweenService:Create(TargetHudFrame, info, {
        Size = UDim2.new(0, 240, 0, 78),
        BackgroundTransparency = 0.12
    }))
    table.insert(TargetHudTweens, TweenService:Create(TargetHudStroke, info, {Transparency = 0.35}))
    table.insert(TargetHudTweens, TweenService:Create(TargetAvatar, info, {ImageTransparency = 0, BackgroundTransparency = 0}))
    table.insert(TargetHudTweens, TweenService:Create(TargetNameLabel, info, {TextTransparency = 0}))
    table.insert(TargetHudTweens, TweenService:Create(TargetInfoLabel, info, {TextTransparency = 0}))
    table.insert(TargetHudTweens, TweenService:Create(TargetHealthBg, info, {BackgroundTransparency = 0}))
    table.insert(TargetHudTweens, TweenService:Create(TargetHealthFill, info, {BackgroundTransparency = 0}))

    for _, tw in ipairs(TargetHudTweens) do tw:Play() end
    -- Ensure avatar image is visible after animation
    task.delay(0.35, function()
        if TargetHudVisible then
            TargetAvatar.ImageTransparency = 0
        end
    end)
end

local function HideTargetHud()
    if not TargetHudVisible then return end
    TargetHudVisible = false
    CancelTargetHudTweens()

    local info = TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

    table.insert(TargetHudTweens, TweenService:Create(TargetHudFrame, info, {BackgroundTransparency = 1}))
    table.insert(TargetHudTweens, TweenService:Create(TargetHudStroke, info, {Transparency = 1}))
    table.insert(TargetHudTweens, TweenService:Create(TargetAvatar, info, {ImageTransparency = 1}))
    table.insert(TargetHudTweens, TweenService:Create(TargetNameLabel, info, {TextTransparency = 1}))
    table.insert(TargetHudTweens, TweenService:Create(TargetInfoLabel, info, {TextTransparency = 1}))
    table.insert(TargetHudTweens, TweenService:Create(TargetHealthBg, info, {BackgroundTransparency = 1}))
    table.insert(TargetHudTweens, TweenService:Create(TargetHealthFill, info, {BackgroundTransparency = 1}))

    for _, tw in ipairs(TargetHudTweens) do tw:Play() end

    task.delay(0.28, function()
        if not TargetHudVisible then
            TargetHudFrame.Visible = false
            TargetHudFrame.Size = UDim2.new(0, 240, 0, 78)
        end
    end)
end

ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "AnxiumToggleButton"
ToggleButton.Size = UDim2.new(0, 108, 0, 28)
ToggleButton.Position = UDim2.new(0.02, 0, 0.42, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
ToggleButton.BackgroundTransparency = 0
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "  anxium"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 12
ToggleButton.Font = SelectedFont
ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
ToggleButton.Parent = ScreenGui

ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(55, 55, 65)
ToggleStroke.Thickness = 1
ToggleStroke.Transparency = 0.2
ToggleStroke.Parent = ToggleButton

ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

MakeDraggable(ToggleButton)

MainFrame = Instance.new("Frame")
MainFrame.Name = "AnxiumMainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 420)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(48, 48, 56)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.15
MainStroke.Parent = MainFrame

MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
Header.BackgroundTransparency = 0
Header.BorderSizePixel = 0
Header.Parent = MainFrame

HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 8)
HeaderFix.Position = UDim2.new(0, 0, 1, -8)
HeaderFix.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
HeaderFix.BackgroundTransparency = 0
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "anxium"
TitleLabel.TextColor3 = Color3.fromRGB(200, 180, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = SelectedFont
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

VersionTag = Instance.new("TextLabel")
VersionTag.Size = UDim2.new(0.35, 0, 1, 0)
VersionTag.Position = UDim2.new(0.6, 0, 0, 0)
VersionTag.BackgroundTransparency = 1
VersionTag.Text = "menu"
VersionTag.TextColor3 = Theme.TextDim
VersionTag.TextSize = 11
VersionTag.Font = SelectedFont
VersionTag.TextXAlignment = Enum.TextXAlignment.Right
VersionTag.Parent = Header

MakeDraggable(MainFrame, Header)

Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
Sidebar.BackgroundTransparency = 0
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0)
SidebarCorner.Parent = Sidebar

-- SidebarFix removed (was causing thick strip between sidebar and content)
SidebarFix = nil

TabButtons = {}
TabFrames = {}
CurrentTab = "Visuals"

local function SwitchTab(tabName)
    CurrentTab = tabName
    for name, frame in pairs(TabFrames) do
        frame.Visible = (name == tabName)
    end
    for name, btn in pairs(TabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = Theme.Accent
            btn.BackgroundTransparency = 0.75
            btn.TextColor3 = Theme.Accent
        else
            btn.BackgroundColor3 = Theme.BgTertiary
            btn.BackgroundTransparency = 1
            btn.TextColor3 = Theme.TextDim
        end
    end
end

local function CreateSidebarTab(name, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -16, 0, 34)
    Btn.Position = UDim2.new(0, 8, 0, 10 + (order - 1) * 40)
    Btn.BackgroundColor3 = Theme.BgTertiary
    Btn.BackgroundTransparency = 1
    Btn.BorderSizePixel = 0
    Btn.Text = "  " .. name
    Btn.TextColor3 = Theme.TextDim
    Btn.TextSize = 13
    Btn.Font = SelectedFont
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn

    Btn.MouseButton1Click:Connect(function() SwitchTab(name) end)

    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -128, 1, -48)
    Scroll.Position = UDim2.new(0, 124, 0, 44)
    Scroll.BackgroundTransparency = 1
    Scroll.BorderSizePixel = 0
    Scroll.ScrollBarThickness = 3
    Scroll.ScrollBarImageColor3 = Theme.Accent
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.Visible = false
    Scroll.Parent = MainFrame

    local Layout = Instance.new("UIListLayout")
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.Padding = UDim.new(0, 6)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Scroll

    local Pad = Instance.new("UIPadding")
    Pad.PaddingTop = UDim.new(0, 6)
    Pad.PaddingBottom = UDim.new(0, 24)
    Pad.Parent = Scroll

    TabButtons[name] = Btn
    TabFrames[name] = Scroll
    return Scroll
end

VisualsTab = CreateSidebarTab("Visuals", 1)
CombatTab = CreateSidebarTab("Combat", 2)
MovementTab = CreateSidebarTab("Movement", 3)
TrollingTab = CreateSidebarTab("Trolling", 4)
AnimationsTab = CreateSidebarTab("Animations", 5)
ConfigsTab = CreateSidebarTab("Configs", 6)
SettingsTab = CreateSidebarTab("Settings", 7)

-- ===== HSV Color Picker (Bbot-style: SV square + Hue bar + Hex) =====
local ColorPickerFrame = nil
local ColorPickerCallback = nil
local ColorPickerPreviewBtn = nil
local ColorPickerState = {
    H = 0.75, S = 0.55, V = 1,
    DraggingSV = false, DraggingHue = false,
}

local function CloseRGBPicker()
    if ColorPickerFrame then
        ColorPickerFrame.Visible = false
    end
    ColorPickerCallback = nil
    ColorPickerPreviewBtn = nil
    ColorPickerState.DraggingSV = false
    ColorPickerState.DraggingHue = false
end

local function ColorToHex(col)
    local r = math.floor(col.R * 255 + 0.5)
    local g = math.floor(col.G * 255 + 0.5)
    local b = math.floor(col.B * 255 + 0.5)
    return string.format("#%02X%02X%02X", r, g, b)
end

local function HexToColor(str)
    if not str then return nil end
    str = tostring(str):gsub("#", ""):gsub("%s", "")
    if #str == 3 then
        str = str:sub(1,1)..str:sub(1,1)..str:sub(2,2)..str:sub(2,2)..str:sub(3,3)..str:sub(3,3)
    end
    if #str < 6 then return nil end
    local r = tonumber(str:sub(1, 2), 16)
    local g = tonumber(str:sub(3, 4), 16)
    local b = tonumber(str:sub(5, 6), 16)
    if not r or not g or not b then return nil end
    return Color3.fromRGB(r, g, b)
end

local function OpenRGBPicker(currentColor, onApply, previewBtn)
    ColorPickerCallback = onApply
    ColorPickerPreviewBtn = previewBtn

    local col0 = currentColor or Color3.fromRGB(180, 140, 255)
    local h0, s0, v0 = col0:ToHSV()
    ColorPickerState.H, ColorPickerState.S, ColorPickerState.V = h0, s0, v0
    Cache.PickerSelectedColor = col0

    if not ColorPickerFrame then
        ColorPickerFrame = Instance.new("Frame")
        ColorPickerFrame.Name = "AnxiumRGBPicker"
        ColorPickerFrame.Size = UDim2.new(0, 230, 0, 268)
        ColorPickerFrame.Position = UDim2.new(0.5, -115, 0.5, -134)
        ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
        ColorPickerFrame.BorderSizePixel = 0
        ColorPickerFrame.ZIndex = 120
        ColorPickerFrame.Parent = ScreenGui
        local pc = Instance.new("UICorner")
        pc.CornerRadius = UDim.new(0, 8)
        pc.Parent = ColorPickerFrame
        local ps = Instance.new("UIStroke")
        ps.Color = Color3.fromRGB(55, 55, 65)
        ps.Thickness = 1
        ps.Parent = ColorPickerFrame

        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Size = UDim2.new(1, -40, 0, 24)
        title.Position = UDim2.new(0, 10, 0, 4)
        title.BackgroundTransparency = 1
        title.Text = "Color Picker"
        title.TextColor3 = Color3.fromRGB(230, 230, 235)
        title.TextSize = 13
        title.Font = SelectedFont
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.ZIndex = 121
        title.Parent = ColorPickerFrame

        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 24, 0, 24)
        closeBtn.Position = UDim2.new(1, -28, 0, 4)
        closeBtn.BackgroundTransparency = 1
        closeBtn.Text = "✕"
        closeBtn.TextColor3 = Color3.fromRGB(170, 170, 180)
        closeBtn.TextSize = 14
        closeBtn.ZIndex = 121
        closeBtn.Parent = ColorPickerFrame
        closeBtn.MouseButton1Click:Connect(CloseRGBPicker)

        -- SV square (Saturation / Value)
        local satFrame = Instance.new("TextButton")
        satFrame.Name = "SatFrame"
        satFrame.Size = UDim2.new(0, 180, 0, 160)
        satFrame.Position = UDim2.new(0, 12, 0, 32)
        satFrame.BackgroundColor3 = Color3.fromHSV(0.75, 1, 1)
        satFrame.BorderSizePixel = 0
        satFrame.Text = ""
        satFrame.AutoButtonColor = false
        satFrame.ZIndex = 121
        satFrame.ClipsDescendants = true
        satFrame.Parent = ColorPickerFrame
        local satCorner = Instance.new("UICorner")
        satCorner.CornerRadius = UDim.new(0, 4)
        satCorner.Parent = satFrame

        -- White → transparent horizontal (saturation)
        local satWhite = Instance.new("Frame")
        satWhite.Name = "SatWhite"
        satWhite.Size = UDim2.new(1, 0, 1, 0)
        satWhite.BackgroundColor3 = Color3.new(1, 1, 1)
        satWhite.BorderSizePixel = 0
        satWhite.ZIndex = 122
        satWhite.Parent = satFrame
        local satWhiteGrad = Instance.new("UIGradient")
        satWhiteGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1),
        })
        satWhiteGrad.Parent = satWhite

        -- Black vertical (value)
        local satBlack = Instance.new("Frame")
        satBlack.Name = "SatBlack"
        satBlack.Size = UDim2.new(1, 0, 1, 0)
        satBlack.BackgroundColor3 = Color3.new(0, 0, 0)
        satBlack.BorderSizePixel = 0
        satBlack.ZIndex = 123
        satBlack.Parent = satFrame
        local satBlackGrad = Instance.new("UIGradient")
        satBlackGrad.Rotation = 90
        satBlackGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0),
        })
        satBlackGrad.Parent = satBlack

        -- SV cursor
        local svCursor = Instance.new("Frame")
        svCursor.Name = "SVCursor"
        svCursor.Size = UDim2.new(0, 10, 0, 10)
        svCursor.AnchorPoint = Vector2.new(0.5, 0.5)
        svCursor.BackgroundTransparency = 1
        svCursor.BorderSizePixel = 0
        svCursor.ZIndex = 125
        svCursor.Parent = satFrame
        local svStroke = Instance.new("UIStroke")
        svStroke.Color = Color3.new(1, 1, 1)
        svStroke.Thickness = 1.5
        svStroke.Parent = svCursor
        local svCorner = Instance.new("UICorner")
        svCorner.CornerRadius = UDim.new(1, 0)
        svCorner.Parent = svCursor
        local svInner = Instance.new("UIStroke")
        -- use ring only

        -- Hue bar (vertical)
        local hueFrame = Instance.new("TextButton")
        hueFrame.Name = "HueFrame"
        hueFrame.Size = UDim2.new(0, 18, 0, 160)
        hueFrame.Position = UDim2.new(0, 200, 0, 32)
        hueFrame.BackgroundColor3 = Color3.new(1, 1, 1)
        hueFrame.BorderSizePixel = 0
        hueFrame.Text = ""
        hueFrame.AutoButtonColor = false
        hueFrame.ZIndex = 121
        hueFrame.Parent = ColorPickerFrame
        local hueCorner = Instance.new("UICorner")
        hueCorner.CornerRadius = UDim.new(0, 4)
        hueCorner.Parent = hueFrame
        local hueGrad = Instance.new("UIGradient")
        hueGrad.Rotation = 90
        hueGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromHSV(0, 1, 1)),
            ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17, 1, 1)),
            ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
            ColorSequenceKeypoint.new(0.50, Color3.fromHSV(0.50, 1, 1)),
            ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67, 1, 1)),
            ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
            ColorSequenceKeypoint.new(1.00, Color3.fromHSV(1, 1, 1)),
        })
        hueGrad.Parent = hueFrame

        local hueCursor = Instance.new("Frame")
        hueCursor.Name = "HueCursor"
        hueCursor.Size = UDim2.new(1, 4, 0, 4)
        hueCursor.Position = UDim2.new(0.5, 0, 0, 0)
        hueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
        hueCursor.BackgroundColor3 = Color3.new(1, 1, 1)
        hueCursor.BorderSizePixel = 0
        hueCursor.ZIndex = 125
        hueCursor.Parent = hueFrame
        local hueCStroke = Instance.new("UIStroke")
        hueCStroke.Color = Color3.fromRGB(30, 30, 35)
        hueCStroke.Thickness = 1
        hueCStroke.Parent = hueCursor
        local hueCCorner = Instance.new("UICorner")
        hueCCorner.CornerRadius = UDim.new(0, 2)
        hueCCorner.Parent = hueCursor

        -- Preview
        local preview = Instance.new("Frame")
        preview.Name = "Preview"
        preview.Size = UDim2.new(0, 36, 0, 28)
        preview.Position = UDim2.new(0, 12, 0, 202)
        preview.BorderSizePixel = 0
        preview.ZIndex = 121
        preview.Parent = ColorPickerFrame
        local prc = Instance.new("UICorner")
        prc.CornerRadius = UDim.new(0, 5)
        prc.Parent = preview
        local prs = Instance.new("UIStroke")
        prs.Color = Color3.fromRGB(60, 60, 70)
        prs.Thickness = 1
        prs.Parent = preview

        -- Hex input
        local hexBox = Instance.new("TextBox")
        hexBox.Name = "HexBox"
        hexBox.Size = UDim2.new(0, 90, 0, 28)
        hexBox.Position = UDim2.new(0, 56, 0, 202)
        hexBox.BackgroundColor3 = Color3.fromRGB(36, 36, 42)
        hexBox.BorderSizePixel = 0
        hexBox.Text = "#B48CFF"
        hexBox.TextColor3 = Color3.fromRGB(220, 220, 230)
        hexBox.TextSize = 12
        hexBox.Font = SelectedFont
        hexBox.ClearTextOnFocus = false
        hexBox.ZIndex = 121
        hexBox.Parent = ColorPickerFrame
        local hxc = Instance.new("UICorner")
        hxc.CornerRadius = UDim.new(0, 5)
        hxc.Parent = hexBox

        -- Apply
        local apply = Instance.new("TextButton")
        apply.Name = "ApplyBtn"
        apply.Size = UDim2.new(0, 62, 0, 28)
        apply.Position = UDim2.new(1, -74, 0, 202)
        apply.BackgroundColor3 = Color3.fromRGB(160, 120, 255)
        apply.BorderSizePixel = 0
        apply.Text = "Apply"
        apply.TextColor3 = Color3.fromRGB(255, 255, 255)
        apply.TextSize = 12
        apply.Font = SelectedFont
        apply.ZIndex = 121
        apply.Parent = ColorPickerFrame
        local ac = Instance.new("UICorner")
        ac.CornerRadius = UDim.new(0, 5)
        ac.Parent = apply

        -- Live apply hint
        local hint = Instance.new("TextLabel")
        hint.Size = UDim2.new(1, -20, 0, 18)
        hint.Position = UDim2.new(0, 12, 0, 238)
        hint.BackgroundTransparency = 1
        hint.Text = "Drag on square / hue · Enter hex · Apply"
        hint.TextColor3 = Color3.fromRGB(120, 120, 130)
        hint.TextSize = 10
        hint.Font = SelectedFont
        hint.TextXAlignment = Enum.TextXAlignment.Left
        hint.ZIndex = 121
        hint.Parent = ColorPickerFrame

        local function refreshFromHSV(live)
            local h = ColorPickerState.H
            local s = ColorPickerState.S
            local v = ColorPickerState.V
            local col = Color3.fromHSV(h, s, v)
            Cache.PickerSelectedColor = col
            satFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            preview.BackgroundColor3 = col
            hexBox.Text = ColorToHex(col)
            svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
            hueCursor.Position = UDim2.new(0.5, 0, h, 0)
            if ColorPickerPreviewBtn then
                pcall(function() ColorPickerPreviewBtn.BackgroundColor3 = col end)
            end
            if live and ColorPickerCallback then
                -- optional live: only update preview button, apply on button
            end
        end
        Cache.ColorPickerRefresh = refreshFromHSV

        local function setFromColor(col)
            if not col then return end
            local h, s, v = col:ToHSV()
            ColorPickerState.H, ColorPickerState.S, ColorPickerState.V = h, s, v
            refreshFromHSV(false)
        end
        Cache.ColorPickerSetFromColor = setFromColor

        local function updateFromMouse(absPos, mode)
            if mode == "sv" then
                local ap = satFrame.AbsolutePosition
                local as = satFrame.AbsoluteSize
                if as.X <= 0 or as.Y <= 0 then return end
                local sx = math.clamp((absPos.X - ap.X) / as.X, 0, 1)
                local sy = math.clamp((absPos.Y - ap.Y) / as.Y, 0, 1)
                ColorPickerState.S = sx
                ColorPickerState.V = 1 - sy
                refreshFromHSV(true)
            elseif mode == "hue" then
                local ap = hueFrame.AbsolutePosition
                local as = hueFrame.AbsoluteSize
                if as.Y <= 0 then return end
                local hy = math.clamp((absPos.Y - ap.Y) / as.Y, 0, 1)
                ColorPickerState.H = hy
                refreshFromHSV(true)
            end
        end

        satFrame.MouseButton1Down:Connect(function()
            ColorPickerState.DraggingSV = true
            updateFromMouse(UserInputService:GetMouseLocation(), "sv")
        end)
        hueFrame.MouseButton1Down:Connect(function()
            ColorPickerState.DraggingHue = true
            updateFromMouse(UserInputService:GetMouseLocation(), "hue")
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
            if not ColorPickerFrame or not ColorPickerFrame.Visible then return end
            if ColorPickerState.DraggingSV then
                updateFromMouse(input.Position, "sv")
            elseif ColorPickerState.DraggingHue then
                updateFromMouse(input.Position, "hue")
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                ColorPickerState.DraggingSV = false
                ColorPickerState.DraggingHue = false
            end
        end)

        hexBox.FocusLost:Connect(function(enter)
            local c = HexToColor(hexBox.Text)
            if c then
                setFromColor(c)
            else
                hexBox.Text = ColorToHex(Cache.PickerSelectedColor or col0)
            end
        end)

        apply.MouseButton1Click:Connect(function()
            local col = Cache.PickerSelectedColor or Color3.fromRGB(180, 140, 255)
            if ColorPickerCallback then
                pcall(ColorPickerCallback, col)
            end
            if ColorPickerPreviewBtn then
                pcall(function() ColorPickerPreviewBtn.BackgroundColor3 = col end)
            end
            CloseRGBPicker()
        end)

        MakeDraggable(ColorPickerFrame, title)
        refreshFromHSV(false)
    end

    if Cache.ColorPickerSetFromColor then
        Cache.ColorPickerSetFromColor(col0)
    end
    ColorPickerFrame.Visible = true
end

CreateFeatureRow = function(name, layoutOrder, parentTab, colorKey)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(36, 36, 42)
    Row.BackgroundTransparency = 0.15
    Row.BorderSizePixel = 0
    Row.LayoutOrder = layoutOrder
    Row.Parent = parentTab

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.55, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    if colorKey then
        local colBtn = Instance.new("TextButton")
        colBtn.Name = "ColorBtn"
        colBtn.Size = UDim2.new(0, 22, 0, 22)
        colBtn.Position = UDim2.new(1, -82, 0.5, -11)
        colBtn.BackgroundColor3 = Config[colorKey] or Theme.Accent
        colBtn.BorderSizePixel = 0
        colBtn.Text = ""
        colBtn.Parent = Row
        local cbc = Instance.new("UICorner")
        cbc.CornerRadius = UDim.new(0, 5)
        cbc.Parent = colBtn
        local cbs = Instance.new("UIStroke")
        cbs.Color = Color3.fromRGB(70, 70, 80)
        cbs.Thickness = 1
        cbs.Parent = colBtn
        colBtn.MouseButton1Click:Connect(function()
            OpenRGBPicker(Config[colorKey] or Theme.Accent, function(col)
                Config[colorKey] = col
                colBtn.BackgroundColor3 = col
                -- live-apply without respawn
                pcall(function()
                    if colorKey == "Color_Orbit" then
                        OrbTrail1.Color = ColorSequence.new(col)
                        OrbTrail2.Color = ColorSequence.new(col)
                    elseif colorKey == "Color_TargetHud" then
                        TargetHudStroke.Color = col
                        TargetHealthFill.BackgroundColor3 = col
                        if AvatarStroke then AvatarStroke.Color = col end
                    elseif colorKey == "Color_Trail" then
                        if Cache.PlayerTrail then Cache.PlayerTrail.Color = ColorSequence.new(col) end
                    elseif colorKey == "Color_Fov" then
                        FovCircle.Color = col
                    elseif colorKey == "Color_SilentFov" then
                        if SilentFovCircle then SilentFovCircle.Color = col end
                    elseif colorKey == "Color_Aura" then
                        ClassicAura_RefreshAll()
                        if ParticleAura_RefreshAll then ParticleAura_RefreshAll() end
                    elseif colorKey == "Color_Chams" then
                        for _, ch in pairs(Cache.Chams) do
                            if ch and ch.Parent then ch.FillColor = col end
                        end
                    elseif colorKey == "Color_BoxEsp" or colorKey == "Color_BoxEspFill" then
                        for _, boxData in pairs(Cache.Boxes) do
                            if boxData then
                                local c1 = Config.Color_BoxEsp or col
                                local c2 = Config.Color_BoxEspFill or Color3.fromRGB(80, 40, 160)
                                if boxData.Box then boxData.Box.Color = c1 end
                                if boxData.Fill then boxData.Fill.Color = c1 end
                                if boxData.Outline then
                                    boxData.Outline.Color = Color3.new(
                                        math.clamp(c1.R * 0.22, 0, 1),
                                        math.clamp(c1.G * 0.22, 0, 1),
                                        math.clamp(c1.B * 0.22, 0, 1)
                                    )
                                end
                                if boxData.Corners then
                                    for _, ln in pairs(boxData.Corners) do if ln then ln.Color = c1 end end
                                end
                                if boxData.Gradients then
                                    local steps = #boxData.Gradients
                                    for i, g in ipairs(boxData.Gradients) do
                                        if g then
                                            local t = (i - 1) / math.max(steps - 1, 1)
                                            g.Color = c1:Lerp(c2, t)
                                        end
                                    end
                                end
                            end
                        end
                    elseif colorKey == "Color_ForceField" then
                        if Config.ForceFieldEnabled then ForceField_Update() end
                    elseif colorKey == "Color_WeaponFF" then
                        if Config.WeaponForceFieldEnabled then WeaponFF_UpdateColor() end
                    elseif colorKey == "Color_Crosshair" then
                        CrosshairX.Color = col
                        CrosshairY.Color = col
                    end
                end)
                Notify("Color", name .. " color set")
            end, colBtn)
        end)
    end

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Name = "SwitchBg"
    SwitchBg.Size = UDim2.new(0, 42, 0, 22)
    SwitchBg.AnchorPoint = Vector2.new(1, 0.5)
    SwitchBg.Position = UDim2.new(1, -12, 0.5, 0)
    SwitchBg.BackgroundColor3 = Theme.ToggleOff
    SwitchBg.BorderSizePixel = 0
    SwitchBg.ClipsDescendants = true
    SwitchBg.Parent = Row

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg

    -- Centered knob (AnchorPoint 0.5,0.5) so it never sits high/low
    local SwitchKnob = Instance.new("Frame")
    SwitchKnob.Name = "SwitchKnob"
    SwitchKnob.Size = UDim2.new(0, 18, 0, 18)
    SwitchKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    SwitchKnob.Position = UDim2.new(0, 11, 0.5, 0) -- OFF
    SwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchKnob.BorderSizePixel = 0
    SwitchKnob.ZIndex = 2
    SwitchKnob.Parent = SwitchBg

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = SwitchKnob

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.ZIndex = 3
    Button.Parent = SwitchBg

    return Button, SwitchBg, SwitchKnob
end

CreateSectionHeader = function(title, layoutOrder, parentTab)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 28)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel = 0
    Row.LayoutOrder = layoutOrder
    Row.Parent = parentTab

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -8, 1, 0)
    Label.Position = UDim2.new(0, 8, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Theme.Accent
    Cache.SectionLabels = Cache.SectionLabels or {}
    table.insert(Cache.SectionLabels, Label)
    Label.TextSize = 12
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row
end

UpdateSwitch = function(state, bg, knob, featureName)
    local info = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    -- Knob always centered in track (AnchorPoint 0.5, 0.5)
    pcall(function()
        if knob then
            knob.AnchorPoint = Vector2.new(0.5, 0.5)
            knob.Size = UDim2.new(0, 18, 0, 18)
        end
    end)
    if state then
        if bg then TweenService:Create(bg, info, {BackgroundColor3 = Theme.Accent}):Play() end
        if knob then
            knob.Position = UDim2.new(1, -11, 0.5, 0) -- snap Y immediately
            TweenService:Create(knob, info, {Position = UDim2.new(1, -11, 0.5, 0)}):Play()
        end
    else
        if bg then TweenService:Create(bg, info, {BackgroundColor3 = Theme.ToggleOff}):Play() end
        if knob then
            knob.Position = UDim2.new(0, 11, 0.5, 0)
            TweenService:Create(knob, info, {Position = UDim2.new(0, 11, 0.5, 0)}):Play()
        end
    end
    if featureName then
        Notify("Anxium", featureName .. (state and " enabled" or " disabled"))
    end
    if UpdateActiveList then UpdateActiveList() end
    if UpdateBindList then UpdateBindList() end
end

CreateSliderRow = function(name, minVal, maxVal, defaultVal, layoutOrder, parentTab, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 48)
    Row.BackgroundColor3 = Theme.BgSecondary
    Row.BackgroundTransparency = 0.45
    Row.BorderSizePixel = 0
    Row.LayoutOrder = layoutOrder
    Row.Parent = parentTab

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 18)
    Label.Position = UDim2.new(0, 12, 0, 6)
    Label.BackgroundTransparency = 1
    Label.Text = name .. "  " .. tostring(defaultVal)
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -24, 0, 5)
    SliderBar.Position = UDim2.new(0, 12, 1, -14)
    SliderBar.BackgroundColor3 = Theme.BgTertiary
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = Row

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = SliderBar

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    SliderFill.BackgroundColor3 = Theme.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    Cache.SliderFills = Cache.SliderFills or {}
    table.insert(Cache.SliderFills, SliderFill)

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = SliderFill

    local isDragging = false
    local function UpdateSlider(input)
        local relX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        local value = math.floor(minVal + (maxVal - minVal) * relX)
        SliderFill.Size = UDim2.new(relX, 0, 1, 0)
        Label.Text = name .. "  " .. tostring(value)
        callback(value)
    end

    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            UpdateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)

    return function(newVal)
        local relX = math.clamp((newVal - minVal) / (maxVal - minVal), 0, 1)
        SliderFill.Size = UDim2.new(relX, 0, 1, 0)
        Label.Text = name .. "  " .. tostring(newVal)
        callback(newVal)
    end
end

CreateTextBoxRow = function(name, placeholder, layoutOrder, parentTab, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 56)
    Row.BackgroundColor3 = Theme.BgSecondary
    Row.BackgroundTransparency = 0.45
    Row.BorderSizePixel = 0
    Row.LayoutOrder = layoutOrder
    Row.Parent = parentTab

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 18)
    Label.Position = UDim2.new(0, 12, 0, 6)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 12
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local TextBoxBg = Instance.new("Frame")
    TextBoxBg.Size = UDim2.new(1, -24, 0, 24)
    TextBoxBg.Position = UDim2.new(0, 12, 0, 26)
    TextBoxBg.BackgroundColor3 = Theme.BgTertiary
    TextBoxBg.BorderSizePixel = 0
    TextBoxBg.Parent = Row

    local TbCorner = Instance.new("UICorner")
    TbCorner.CornerRadius = UDim.new(0, 6)
    TbCorner.Parent = TextBoxBg

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -12, 1, 0)
    TextBox.Position = UDim2.new(0, 6, 0, 0)
    TextBox.BackgroundTransparency = 1
    TextBox.Text = ""
    TextBox.PlaceholderText = placeholder
    TextBox.PlaceholderColor3 = Theme.TextDim
    TextBox.TextColor3 = Theme.Text
    TextBox.TextSize = 12
    TextBox.Font = SelectedFont
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.Parent = TextBoxBg

    TextBox.FocusLost:Connect(function()
        callback(TextBox.Text)
    end)

    return TextBox
end

-- Player Highlight ESP removed (useless)
BoxEspBtn, BoxEspBg, BoxEspKnob = CreateFeatureRow("2D Box ESP", 1, VisualsTab, "Color_BoxEsp")
BoxFillBtn, BoxFillBg, BoxFillKnob = CreateFeatureRow("Box Fill Gradient", 1.2, VisualsTab, "Color_BoxEspFill")

-- ESP Box Style selector
do
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 36)
    Row.BackgroundColor3 = Theme.BgSecondary
    Row.BackgroundTransparency = 0.45
    Row.BorderSizePixel = 0
    Row.LayoutOrder = 2.5
    Row.Parent = VisualsTab

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Box Style"
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local StyleBtn = Instance.new("TextButton")
    StyleBtn.Size = UDim2.new(0, 110, 0, 24)
    StyleBtn.Position = UDim2.new(1, -122, 0.5, -12)
    StyleBtn.BackgroundColor3 = Theme.BgTertiary
    StyleBtn.BorderSizePixel = 0
    StyleBtn.Text = Config.EspBoxStyle or "Full"
    StyleBtn.TextColor3 = Theme.Accent
    StyleBtn.TextSize = 12
    StyleBtn.Font = SelectedFont
    StyleBtn.Parent = Row

    local SbCorner = Instance.new("UICorner")
    SbCorner.CornerRadius = UDim.new(0, 7)
    SbCorner.Parent = StyleBtn

    local styles = { "Full", "Corner" }
    local styleIdx = 1
    for i, s in ipairs(styles) do
        if s == (Config.EspBoxStyle or "Full") then styleIdx = i break end
    end
    StyleBtn.MouseButton1Click:Connect(function()
        styleIdx = styleIdx % #styles + 1
        Config.EspBoxStyle = styles[styleIdx]
        StyleBtn.Text = Config.EspBoxStyle
        Notify("ESP", "Box style: " .. Config.EspBoxStyle)
    end)
end

HealthbarEspBtn, HealthbarEspBg, HealthbarEspKnob = CreateFeatureRow("Healthbar ESP", 3, VisualsTab, "Color_Healthbar")
ChamsBtn, ChamsBg, ChamsKnob = CreateFeatureRow("Chams (Wallhack)", 4, VisualsTab, "Color_Chams")
NameEspBtn, NameEspBg, NameEspKnob = CreateFeatureRow("Name ESP", 5, VisualsTab, "Color_NameEsp")
DistEspBtn, DistEspBg, DistEspKnob = CreateFeatureRow("Distance ESP", 6, VisualsTab, "Color_NameEsp")
SkelBtn, SkelBg, SkelKnob = CreateFeatureRow("Skeleton ESP", 7, VisualsTab, "Color_Skeleton")
TracerBtn, TracerBg, TracerKnob = CreateFeatureRow("Tracers", 8, VisualsTab, "Color_Tracers")
CrossBtn, CrossBg, CrossKnob = CreateFeatureRow("Custom Crosshair", 9, VisualsTab, "Color_Crosshair")
SpinCrossBtn, SpinCrossBg, SpinCrossKnob = CreateFeatureRow("Spin Crosshair", 9.2, VisualsTab, "Color_Crosshair")
CreateSliderRow("Spin Speed", 30, 400, Config.SpinCrosshairSpeed or 180, 9.3, VisualsTab, function(val)
    Config.SpinCrosshairSpeed = val
end)
DmgNumBtn, DmgNumBg, DmgNumKnob = CreateFeatureRow("Damage Numbers", 9.7, VisualsTab, "Color_DamageNumber")
SelfChamsBtn, SelfChamsBg, SelfChamsKnob = CreateFeatureRow("Self Chams (Highlight)", 9.9, VisualsTab, "Color_SelfChams")
CloneChamsBtn, CloneChamsBg, CloneChamsKnob = CreateFeatureRow("Clone player", 9.92, VisualsTab, "Color_CloneChams")
OffscreenBtn, OffscreenBg, OffscreenKnob = CreateFeatureRow("Offscreen Arrows", 9.93, VisualsTab, "Color_OffscreenArrow")
CreateSliderRow("Arrow Radius", 10, 80, math.floor((Config.ArrowDistance or 0.36) * 100), 9.935, VisualsTab, function(val)
    Config.ArrowDistance = val / 100
end)
DeathChamsBtn, DeathChamsBg, DeathChamsKnob = CreateFeatureRow("Death player", 9.94, VisualsTab, "Color_DeathChams")

-- Style pickers: Chams / ForceField for Clone & Death
do
    local styles = { "Chams", "FF" }
    local function makeStyleRow(label, layoutOrder, getStyle, setStyle)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(0.96, 0, 0, 32)
        row.BackgroundColor3 = Theme.BgSecondary
        row.BackgroundTransparency = 0.45
        row.BorderSizePixel = 0
        row.LayoutOrder = layoutOrder
        row.Parent = VisualsTab
        local rc = Instance.new("UICorner")
        rc.CornerRadius = UDim.new(0, 8)
        rc.Parent = row
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.5, 0, 1, 0)
        lbl.Position = UDim2.new(0, 12, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Theme.Text
        lbl.TextSize = 12
        lbl.Font = SelectedFont
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 100, 0, 22)
        btn.Position = UDim2.new(1, -112, 0.5, -11)
        btn.BackgroundColor3 = Theme.BgTertiary
        btn.BorderSizePixel = 0
        btn.Text = tostring(getStyle())
        btn.TextColor3 = Theme.Text
        btn.TextSize = 11
        btn.Font = SelectedFont
        btn.Parent = row
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 6)
        bc.Parent = btn
        btn.MouseButton1Click:Connect(function()
            local cur = getStyle()
            local idx = 1
            for i, s in ipairs(styles) do
                if s == cur then idx = i break end
            end
            local nxt = styles[(idx % #styles) + 1]
            setStyle(nxt)
            btn.Text = nxt
        end)
    end
    makeStyleRow("Clone material", 9.925, function()
        return Config.CloneChamsStyle or "Chams"
    end, function(v) Config.CloneChamsStyle = v end)
    makeStyleRow("Death material", 9.945, function()
        return Config.DeathChamsStyle or "Chams"
    end, function(v) Config.DeathChamsStyle = v end)
end
DeathBurstBtn, DeathBurstBg, DeathBurstKnob = CreateFeatureRow("Death Burst", 9.95, VisualsTab, "Color_DeathBurst")
FullBtn, FullBg, FullKnob = CreateFeatureRow("Fullbright", 10, VisualsTab)
DarkModeBtn, DarkModeBg, DarkModeKnob = CreateFeatureRow("Dark Mode", 10.5, VisualsTab)

ActiveListBtn, ActiveListBg, ActiveListKnob = CreateFeatureRow("Active Modules HUD", 11, VisualsTab)
BindListBtn, BindListBg, BindListKnob = CreateFeatureRow("Binds HUD", 11.5, VisualsTab)
UpdateSwitch(Config.ActiveListEnabled, ActiveListBg, ActiveListKnob)
FakeFpsBtn, FakeFpsBg, FakeFpsKnob = CreateFeatureRow("Fake FPS", 11.2, VisualsTab)
do
    local row = Instance.new("Frame")
    row.Size = UDim2.new(0.96, 0, 0, 36)
    row.BackgroundColor3 = Theme.BgSecondary
    row.BackgroundTransparency = 0.45
    row.BorderSizePixel = 0
    row.LayoutOrder = 11.3
    row.Parent = VisualsTab
    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 9)
    rc.Parent = row
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.45, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "FPS Value"
    lbl.TextColor3 = Theme.Text
    lbl.TextSize = 12
    lbl.Font = SelectedFont
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row
    local cycle = Instance.new("TextButton")
    cycle.Size = UDim2.new(0, 90, 0, 24)
    cycle.Position = UDim2.new(1, -102, 0.5, -12)
    cycle.BackgroundColor3 = Theme.BgTertiary
    cycle.BorderSizePixel = 0
    cycle.Text = tostring(Config.FakeFpsValue or 67)
    cycle.TextColor3 = Theme.Text
    cycle.TextSize = 12
    cycle.Font = SelectedFont
    cycle.Parent = row
    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 6)
    cc.Parent = cycle
    local opts = { 67, 1488, 69, 333, 1337, 666 }
    cycle.MouseButton1Click:Connect(function()
        Config.FakeFpsIndex = (Config.FakeFpsIndex or 1) % #opts + 1
        Config.FakeFpsValue = opts[Config.FakeFpsIndex]
        cycle.Text = tostring(Config.FakeFpsValue)
        UpdateFakeFpsDisplay()
        Notify("Fake FPS", "Set to " .. tostring(Config.FakeFpsValue))
    end)
    Cache.FakeFpsCycleBtn = cycle
end

HatBtn, HatBg, HatKnob = CreateFeatureRow("China Hat (Drawing)", 12, VisualsTab, "Color_ChinaHat")

CreateSliderRow("Hat Global Scale", 5, 30, 10, 13, VisualsTab, function(val) Config.ChinaHatScale = val / 10 end)
CreateSliderRow("Hat Height Offset", 0, 20, 5, 14, VisualsTab, function(val) Config.ChinaHatHeightOffset = val / 10 end)
CreateSliderRow("Hat Height", 5, 40, 17, 15, VisualsTab, function(val) Config.ChinaHatHeight = val / 10 end)
CreateSliderRow("Hat Radius", 10, 50, 23, 16, VisualsTab, function(val) Config.ChinaHatRadius = val / 10 end)

OrbitOrbsBtn, OrbitOrbsBg, OrbitOrbsKnob = CreateFeatureRow("Neon Orbit Bands", 17, VisualsTab, "Color_Orbit")
CreateSliderRow("Orbit Speed", 1, 20, Config.OrbitSpeedValue, 18, VisualsTab, function(val) Config.OrbitSpeedValue = val end)

TrailBtn, TrailBg, TrailKnob = CreateFeatureRow("Motion Trail", 19, VisualsTab, "Color_Trail")
FogBtn, FogBg, FogKnob = CreateFeatureRow("Custom Fog", 20, VisualsTab, "Color_Fog")
CreateSliderRow("Fog Distance", 50, 2000, Config.FogDistanceValue, 21, VisualsTab, function(val) Config.FogDistanceValue = val end)

FootstepsBtn, FootstepsBg, FootstepsKnob = CreateFeatureRow("Jump Circles", 22, VisualsTab, "Color_JumpCircle")
CreateSliderRow("Circle Size", 1, 20, Config.JumpCircleSize, 23, VisualsTab, function(val) Config.JumpCircleSize = val end)
CreateSliderRow("Glow Power", 0, 10, Config.JumpCircleGlow, 24, VisualsTab, function(val) Config.JumpCircleGlow = val end)

AspectBtn, AspectBg, AspectKnob = CreateFeatureRow("Aspect Ratio", 25, VisualsTab)
CreateSliderRow("Aspect Scale (%)", 50, 200, 133, 26, VisualsTab, function(val) Config.AspectRatioValue = val / 100 end)

ThirdPersonBtn, ThirdPersonBg, ThirdPersonKnob = CreateFeatureRow("Third Person", 27, VisualsTab)
CreateSliderRow("Cam Distance", 5, 50, Config.ThirdPersonDistance, 28, VisualsTab, function(val) Config.ThirdPersonDistance = val end)

CreateSectionHeader("— ForceField —", 29, VisualsTab)
FFBtn, FFBg, FFKnob = CreateFeatureRow("Body ForceField", 30, VisualsTab, "Color_ForceField")
WeaponFFBtn, WeaponFFBg, WeaponFFKnob = CreateFeatureRow("Weapon ForceField", 31, VisualsTab, "Color_WeaponFF")
KillFlashBtn, KillFlashBg, KillFlashKnob = CreateFeatureRow("Kill Flash (Screen)", 31.6, VisualsTab, "Color_KillFlash")
CreateSliderRow("Flash Duration (x0.1s)", 2, 25, math.floor((Config.KillFlashDuration or 0.85) * 10), 31.65, VisualsTab, function(val)
    Config.KillFlashDuration = val / 10
end)
HitboxBtn, HitboxBg, HitboxKnob = CreateFeatureRow("Hitbox Expander", 31.68, CombatTab, "Color_Hitbox")
CreateSliderRow("Hitbox Size", 2, 20, Config.HitboxSize or 6, 31.69, CombatTab, function(val)
    Config.HitboxSize = val
end)
HitboxShowBtn, HitboxShowBg, HitboxShowKnob = CreateFeatureRow("Show Hitboxes", 31.695, CombatTab)
BulletTracerBtn, BulletTracerBg, BulletTracerKnob = CreateFeatureRow("Bullet Tracers", 31.7, VisualsTab, "Color_BulletTracer")

CreateSectionHeader("— Auras —", 32, VisualsTab)
AuraBtn, AuraBg, AuraKnob = CreateFeatureRow("Aura", 33, VisualsTab, "Color_Aura")
ClassicPinkBtn, ClassicPinkBg, ClassicPinkKnob = CreateFeatureRow("Pink Aura", 34, VisualsTab, "Color_Aura")
ClassicAngelBtn, ClassicAngelBg, ClassicAngelKnob = CreateFeatureRow("Angel Wing", 35, VisualsTab, "Color_Aura")
ParticleStarBtn, ParticleStarBg, ParticleStarKnob = CreateFeatureRow("Starlight", 36, VisualsTab, "Color_Aura")
ParticleAngelBtn, ParticleAngelBg, ParticleAngelKnob = CreateFeatureRow("Angel", 37, VisualsTab, "Color_Aura")

TeamCheckerBtn, TeamCheckerBg, TeamCheckerKnob = CreateFeatureRow("Team Checker", 0.5, CombatTab)
AimBtn, AimBg, AimKnob = CreateFeatureRow("Aimbot", 1, CombatTab)
ShowFovBtn, ShowFovBg, ShowFovKnob = CreateFeatureRow("Show FOV", 2, CombatTab, "Color_Fov")
CreateSliderRow("FOV Size", 30, 500, Config.FovRadius, 3, CombatTab, function(val)
    Config.FovRadius = val
    FovCircle.Radius = Config.FovRadius
end)
CreateSliderRow("Aim Smooth", 1, 100, math.floor((Config.AimSmoothValue or 0.18) * 100), 5, CombatTab, function(val)
    Config.AimSmoothValue = math.clamp(val / 100, 0.01, 1)
end)
TargetHudBtn, TargetHudBg, TargetHudKnob = CreateFeatureRow("Target HUD", 6, CombatTab, "Color_TargetHud")
SpinBtn, SpinBg, SpinKnob = CreateFeatureRow("SpinBot", 7, CombatTab)
CreateSliderRow("Spin Speed", 0, 500, Config.SpinSpeed, 8, CombatTab, function(val) 
    Config.SpinSpeed = val 
    if Config.SpinEnabled then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local spinObj = hrp:FindFirstChild("Spinning")
            if spinObj then spinObj.AngularVelocity = Vector3.new(0, val, 0) end
        end
    end
end)

AntiAimBtn, AntiAimBg, AntiAimKnob = CreateFeatureRow("Anti-Aim", 8.5, CombatTab)
CreateSliderRow("AA Pitch", -75, 75, Config.AntiAimPitch, 8.6, CombatTab, function(val)
    Config.AntiAimPitch = val
end)
CreateSliderRow("AA Yaw", -180, 180, Config.AntiAimYaw, 8.7, CombatTab, function(val)
    Config.AntiAimYaw = val
end)
do
    local modes = { "Static", "Jitter", "Spin" }
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -20, 0, 36)
    Row.BackgroundColor3 = Theme.BgSecondary
    Row.BorderSizePixel = 0
    Row.LayoutOrder = 8.75
    Row.Parent = CombatTab
    local Rc = Instance.new("UICorner")
    Rc.CornerRadius = UDim.new(0, 8)
    Rc.Parent = Row
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0.4, 0, 1, 0)
    Lbl.Position = UDim2.new(0, 12, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = "AA Mode"
    Lbl.TextColor3 = Theme.Text
    Lbl.TextSize = 13
    Lbl.Font = SelectedFont
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Row
    local ModeBtn = Instance.new("TextButton")
    ModeBtn.Size = UDim2.new(0, 120, 0, 26)
    ModeBtn.Position = UDim2.new(1, -132, 0.5, -13)
    ModeBtn.BackgroundColor3 = Theme.BgTertiary
    ModeBtn.BorderSizePixel = 0
    ModeBtn.Text = Config.AntiAimMode or "Static"
    ModeBtn.TextColor3 = Theme.Accent
    ModeBtn.TextSize = 12
    ModeBtn.Font = SelectedFont
    ModeBtn.Parent = Row
    local Mc = Instance.new("UICorner")
    Mc.CornerRadius = UDim.new(0, 7)
    Mc.Parent = ModeBtn
    local mi = 1
    for i, m in ipairs(modes) do
        if m == (Config.AntiAimMode or "Static") then mi = i break end
    end
    ModeBtn.MouseButton1Click:Connect(function()
        mi = mi % #modes + 1
        Config.AntiAimMode = modes[mi]
        ModeBtn.Text = Config.AntiAimMode
        Notify("Anti-Aim", "Mode: " .. Config.AntiAimMode)
    end)
end
CreateSliderRow("AA Jitter Range", 5, 90, Config.AntiAimJitter or 35, 8.8, CombatTab, function(val)
    Config.AntiAimJitter = val
end)
CreateSliderRow("AA Spin Speed", 90, 1440, Config.AntiAimSpinSpeed or 720, 8.85, CombatTab, function(val)
    Config.AntiAimSpinSpeed = val
end)

TriggerbotBtn, TriggerbotBg, TriggerbotKnob = CreateFeatureRow("Triggerbot", 9, CombatTab)
CreateSliderRow("Trigger Delay (ms)", 0, 200, Config.TriggerbotDelay, 10, CombatTab, function(val)
    Config.TriggerbotDelay = val
end)

CreateSectionHeader("— Silent Aim —", 10.2, CombatTab)
SilentAimBtn, SilentAimBg, SilentAimKnob = CreateFeatureRow("Silent Aim", 10.3, CombatTab)
ShowSilentFovBtn, ShowSilentFovBg, ShowSilentFovKnob = CreateFeatureRow("Show Silent FOV", 10.4, CombatTab, "Color_SilentFov")
CreateSliderRow("Silent FOV Size", 20, 500, Config.SilentFovRadius or 130, 10.5, CombatTab, function(val)
    Config.SilentFovRadius = val
    if SilentFovCircle then SilentFovCircle.Radius = val end
end)
CreateSliderRow("Silent Hit Chance %", 1, 100, Config.SilentHitChance or 100, 10.6, CombatTab, function(val)
    Config.SilentHitChance = val
end)
SilentTeamCheckBtn, SilentTeamCheckBg, SilentTeamCheckKnob = CreateFeatureRow("Silent Team Check", 10.7, CombatTab)

CreateSectionHeader("— Hit Sounds —", 11, CombatTab)
FireSoundBtn, FireSoundBg, FireSoundKnob = CreateFeatureRow("Hit Sounds", 12, CombatTab)
CreateSliderRow("Hit Volume", 0, 100, math.floor(Config.CustomFireSoundVolume * 100), 13, CombatTab, function(val)
    Config.CustomFireSoundVolume = val / 100
    if Cache.FireSoundInstance then
        Cache.FireSoundInstance.Volume = Config.CustomFireSoundVolume
    end
end)

do
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(0.96, 0, 0, 40)
    Row.BackgroundColor3 = Theme.BgSecondary
    Row.BackgroundTransparency = 0.45
    Row.BorderSizePixel = 0
    Row.LayoutOrder = 12
    Row.Parent = CombatTab

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Row

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.45, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "Sound"
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = SelectedFont
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Row

    local SoundSelectBtn = Instance.new("TextButton")
    SoundSelectBtn.Size = UDim2.new(0, 130, 0, 26)
    SoundSelectBtn.Position = UDim2.new(1, -142, 0.5, -13)
    SoundSelectBtn.BackgroundColor3 = Theme.BgTertiary
    SoundSelectBtn.BorderSizePixel = 0
    SoundSelectBtn.Text = Config.CustomFireSoundName
    SoundSelectBtn.TextColor3 = Theme.Accent
    SoundSelectBtn.TextSize = 12
    SoundSelectBtn.Font = SelectedFont
    SoundSelectBtn.Parent = Row

    local SbCorner = Instance.new("UICorner")
    SbCorner.CornerRadius = UDim.new(0, 7)
    SbCorner.Parent = SoundSelectBtn

    local soundOptions = { "Gun Fire", "Hammer Hit", "Bow Ding", "Cod Hit", "Uwu" }
    local soundIndex = 1
    SoundSelectBtn.MouseButton1Click:Connect(function()
        soundIndex = soundIndex % #soundOptions + 1
        Config.CustomFireSoundName = soundOptions[soundIndex]
        SoundSelectBtn.Text = Config.CustomFireSoundName
        Notify("Hit Sounds", "Selected: " .. Config.CustomFireSoundName)
    end)
end

SpeedBtn, SpeedBg, SpeedKnob = CreateFeatureRow("Speed Hack", 1, MovementTab)
JumpBtn, JumpBg, JumpKnob = CreateFeatureRow("Multi Jump", 2, MovementTab)
NoclipBtn, NoclipBg, NoclipKnob = CreateFeatureRow("Noclip", 3, MovementTab)
FlyBtn, FlyBg, FlyKnob = CreateFeatureRow("Fly", 4, MovementTab)
BHopBtn, BHopBg, BHopKnob = CreateFeatureRow("Bunny Hop", 5, MovementTab)
CreateSliderRow("BHop Force", 10, 150, Config.BHopPower, 6, MovementTab, function(val) Config.BHopPower = val end)


-- ===================== CHARACTER ANIMATION PACKS (from universal anims) =====================
local AnxiumAnimPacks = {
    Astronaut = {Idle=891621366, Idle2=891633237, Idle3=1047759695, Walk=891667138, Run=891636393, Jump=891627522, Climb=891609353, Fall=891617961, Swim=891639666, SwimIdle=891663592, Weight=9, Weight2=1},
    Bold = {Idle=16738333868, Idle2=16738334710, Idle3=16738335517, Walk=16738340646, Run=16738337225, Jump=16738336650, Climb=16738332169, Fall=16738333171, Swim=16738339158, SwimIdle=16738339817, Weight=9, Weight2=1},
    Borock = {Idle=3293641938, Idle2=3293642554, Idle3=3710131919, Walk=2510202577, Run=3236836670, Jump=2510197830, Climb=2510192778, Fall=2510195892, Swim=2510199791, SwimIdle=2510201162, Weight=9, Weight2=1},
    Bubbly = {Idle=910004836, Idle2=910009958, Idle3=1018536639, Walk=910034870, Run=910025107, Jump=910016857, Climb=909997997, Fall=910001910, Swim=910028158, SwimIdle=910030921, Weight=9, Weight2=1},
    Cartoony = {Idle=742637544, Idle2=742638445, Idle3=885477856, Walk=742640026, Run=742638842, Jump=742637942, Climb=742636889, Fall=742637151, Swim=742639220, SwimIdle=742639812, Weight=9, Weight2=1},
    Confident = {Idle=1069977950, Idle2=1069987858, Idle3=1116160740, Walk=1070017263, Run=1070001516, Jump=1069984524, Climb=1069946257, Fall=1069973677, Swim=1070009914, SwimIdle=1070012133, Weight=9, Weight2=1},
    Cowboy = {Idle=1014390418, Idle2=1014398616, Idle3=1159487651, Walk=1014421541, Run=1014401683, Jump=1014394726, Climb=1014380606, Fall=1014384571, Swim=1014406523, SwimIdle=1014411816, Weight=9, Weight2=1},
    Elder = {Idle=845397899, Idle2=845400520, Idle3=901160519, Walk=845403856, Run=845386501, Jump=845398858, Climb=845392038, Fall=845396048, Swim=845401742, SwimIdle=845403127, Weight=9, Weight2=1},
    Ghost = {Idle=616006778, Idle2=616008087, Idle3=616008087, Walk=616013216, Run=616013216, Jump=616008936, Climb=0, Fall=616005863, Swim=616011509, SwimIdle=616012453, Weight=9, Weight2=1},
    Knight = {Idle=657595757, Idle2=657568135, Idle3=885499184, Walk=657552124, Run=657564596, Jump=658409194, Climb=658360781, Fall=657600338, Swim=657560551, SwimIdle=657557095, Weight=9, Weight2=1},
    Levitation = {Idle=616006778, Idle2=616008087, Idle3=886862142, Walk=616013216, Run=616010382, Jump=616008936, Climb=616003713, Fall=616005863, Swim=616011509, SwimIdle=616012453, Weight=9, Weight2=1},
    Mage = {Idle=707742142, Idle2=707855907, Idle3=885508740, Walk=707897309, Run=707861613, Jump=707853694, Climb=707826056, Fall=707829716, Swim=707876443, SwimIdle=707894699, Weight=9, Weight2=1},
    Mocap = {Idle=913367814, Idle2=913373430, Walk=913402848, Run=913376220, Jump=913370268, Climb=913362637, Fall=913365531, Swim=913384386, SwimIdle=913389285, Weight=9, Weight2=1},
    Ninja = {Idle=656117400, Idle2=656118341, Idle3=886742569, Walk=656121766, Run=656118852, Jump=656117878, Climb=656114359, Fall=656115606, Swim=656119721, SwimIdle=656121397, Weight=9, Weight2=1},
    Oldschool = {Idle=5319828216, Idle2=5319831086, Idle3=5392107832, Walk=5319847204, Run=5319844329, Jump=5319841935, Climb=5319816685, Fall=5319839762, Swim=5319850266, SwimIdle=5319852613, Weight=9, Weight2=1},
    Patrol = {Idle=1149612882, Idle2=1150842221, Idle3=1159573567, Walk=1151231493, Run=1150967949, Jump=1150944216, Climb=1148811837, Fall=1148863382, Swim=1151204998, SwimIdle=1151221899, Weight=9, Weight2=1},
    Pirate = {Idle=750781874, Idle2=750782770, Idle3=885515365, Walk=750785693, Run=750783738, Jump=750782230, Climb=750779899, Fall=750780242, Swim=750784579, SwimIdle=750785176, Weight=9, Weight2=1},
    Popstar = {Idle=1212900985, Idle2=1150842221, Idle3=1239733474, Walk=1212980338, Run=1212980348, Jump=1212954642, Climb=1213044953, Fall=1212900995, Swim=1212852603, SwimIdle=1070012133, Weight=9, Weight2=1},
    Princess = {Idle=941003647, Idle2=941013098, Idle3=1159195712, Walk=941028902, Run=941015281, Jump=941008832, Climb=940996062, Fall=941000007, Swim=941018893, SwimIdle=941025398, Weight=9, Weight2=1},
    R15 = {Idle=4211217646, Idle2=4211218409, Walk=4211223236, Run=4211220381, Jump=4211219390, Climb=4211214992, Fall=4211216152, Swim=4211221314, SwimIdle=4374694239, Weight=9, Weight2=1},
    Realistic = {Idle=17172918855, Idle2=17173014241, Idle3=17173014241, Walk=11600249883, Run=11600211410, Jump=11600210487, Climb=11600205519, Fall=11600206437, Swim=11600212676, SwimIdle=11600213505, Weight=9, Weight2=1},
    Robot = {Idle=616088211, Idle2=616089559, Idle3=885531463, Walk=616095330, Run=616091570, Jump=616090535, Climb=616086039, Fall=616087089, Swim=616092998, SwimIdle=616094091, Weight=9, Weight2=1},
    Rthro = {Idle=2510196951, Idle2=2510197257, Idle3=3711062489, Walk=2510202577, Run=2510198475, Jump=2510197830, Climb=2510192778, Fall=2510195892, Swim=2510199791, SwimIdle=2510201162, Weight=9, Weight2=1},
    Sneaky = {Idle=1132473842, Idle2=1132477671, Walk=1132510133, Run=1132494274, Jump=1132489853, Climb=1132461372, Fall=1132469004, Swim=1132500520, SwimIdle=1132506407, Weight=9, Weight2=1},
    Stylish = {Idle=616136790, Idle2=616138447, Idle3=886888594, Walk=616146177, Run=616140816, Jump=616139451, Climb=616133594, Fall=616134815, Swim=616143378, SwimIdle=616144772, Weight=9, Weight2=1},
    Superhero = {Idle=616111295, Idle2=616113536, Idle3=885535855, Walk=616122287, Run=616117076, Jump=616115533, Climb=616104706, Fall=616108001, Swim=616119360, SwimIdle=616120861, Weight=9, Weight2=1},
    Toy = {Idle=782841498, Idle2=782845736, Idle3=980952228, Walk=782843345, Run=782842708, Jump=782847020, Climb=782843869, Fall=782846423, Swim=782844582, SwimIdle=782845186, Weight=9, Weight2=1},
    Udzal = {Idle=3303162274, Idle2=3303162549, Idle3=3710161342, Walk=3303162967, Run=3236836670, Jump=2510197830, Climb=2510192778, Fall=2510195892, Swim=2510199791, SwimIdle=2510201162, Weight=9, Weight2=1},
    Unboxed = {Idle=98281136301627, Idle2=138183121662404, Idle3=133117300343405, Walk=90478085024465, Run=134824450619865, Jump=121454505477205, Climb=121145883950231, Fall=94788218468396, Swim=105962919001086, SwimIdle=129126268464847, Weight=9, Weight2=1},
    Vampire = {Idle=1083445855, Idle2=1083450166, Idle3=1088037547, Walk=1083473930, Run=1083462077, Jump=1083455352, Climb=1083439238, Fall=1083443587, Swim=1083464683, SwimIdle=1083467779, Weight=9, Weight2=1},
    Werewolf = {Idle=1083195517, Idle2=1083214717, Idle3=1099492820, Walk=1083178339, Run=1083216690, Jump=1083218792, Climb=1083182000, Fall=1083189019, Swim=1083222527, SwimIdle=1083225406, Weight=9, Weight2=1},
    Zombie = {Idle=616158929, Idle2=616160636, Idle3=885545458, Walk=616168032, Run=616163682, Jump=616161997, Climb=616156119, Fall=616157476, Swim=616165109, SwimIdle=616166655, Weight=9, Weight2=1},
}

local AnxiumAnimList = {}
for name in pairs(AnxiumAnimPacks) do
    table.insert(AnxiumAnimList, name)
end
table.sort(AnxiumAnimList, function(a, b) return a:lower() < b:lower() end)
table.insert(AnxiumAnimList, 1, "Default")

local ANIM_URL = "http://www.roblox.com/asset/?id="

local function Anxium_SaveOriginalAnims()
    local char = LocalPlayer.Character
    if not char then return end
    local Animate = char:FindFirstChild("Animate")
    if not Animate then return end
    if Cache.OriginalAnims then return end
    local ok, data = pcall(function()
        local o = {}
        if Animate:FindFirstChild("idle") then
            o.Idle = Animate.idle.Animation1 and Animate.idle.Animation1.AnimationId
            o.Idle2 = Animate.idle.Animation2 and Animate.idle.Animation2.AnimationId
            if Animate.idle.Animation1 and Animate.idle.Animation1:FindFirstChild("Weight") then
                o.Weight = Animate.idle.Animation1.Weight.Value
            end
            if Animate.idle.Animation2 and Animate.idle.Animation2:FindFirstChild("Weight") then
                o.Weight2 = Animate.idle.Animation2.Weight.Value
            end
        end
        if Animate:FindFirstChild("pose") then
            local a = Animate.pose:FindFirstChildOfClass("Animation")
            if a then o.Idle3 = a.AnimationId end
        end
        local function aid(folder)
            local a = folder and folder:FindFirstChildOfClass("Animation")
            return a and a.AnimationId
        end
        o.Walk = aid(Animate:FindFirstChild("walk"))
        o.Run = aid(Animate:FindFirstChild("run"))
        o.Jump = aid(Animate:FindFirstChild("jump"))
        o.Climb = aid(Animate:FindFirstChild("climb"))
        o.Fall = aid(Animate:FindFirstChild("fall"))
        o.Swim = aid(Animate:FindFirstChild("swim"))
        o.SwimIdle = aid(Animate:FindFirstChild("swimidle"))
        return o
    end)
    if ok and data then Cache.OriginalAnims = data end
end

local function Anxium_RefreshAnims()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local Animate = char:FindFirstChild("Animate")
    if not hum or not Animate then return end
    pcall(function()
        Animate.Disabled = true
        for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
            t:Stop()
        end
        Animate.Disabled = false
        local s = hum.WalkSpeed
        hum.WalkSpeed = 0
        task.wait()
        hum.WalkSpeed = s
    end)
end

local function Anxium_SetAnimId(animObj, id)
    if not animObj or not id then return end
    local sid = tostring(id)
    if sid:find("rbxassetid://") or sid:find("http") then
        animObj.AnimationId = sid
    else
        animObj.AnimationId = ANIM_URL .. sid
    end
end

local function Anxium_PlayAnimationBody(pack)
    local char = LocalPlayer.Character
    if not char then return false end
    local Animate = char:FindFirstChild("Animate") or char:WaitForChild("Animate", 3)
    if not Animate then return false end
    Anxium_SaveOriginalAnims()

    local function applyIds(id1, id2, id3, id4, id5, id6, id7, id8, id9, id10, weight, weight2)
        pcall(function()
            if Animate:FindFirstChild("idle") then
                if Animate.idle:FindFirstChild("Animation1") then
                    Anxium_SetAnimId(Animate.idle.Animation1, id1)
                    if Animate.idle.Animation1:FindFirstChild("Weight") and weight then
                        Animate.idle.Animation1.Weight.Value = tonumber(weight) or 9
                    end
                end
                if Animate.idle:FindFirstChild("Animation2") then
                    Anxium_SetAnimId(Animate.idle.Animation2, id2)
                    if Animate.idle.Animation2:FindFirstChild("Weight") and weight2 then
                        Animate.idle.Animation2.Weight.Value = tonumber(weight2) or 1
                    end
                end
            end
            if id3 and Animate:FindFirstChild("pose") then
                local a = Animate.pose:FindFirstChildOfClass("Animation")
                if a then Anxium_SetAnimId(a, id3) end
            end
            local map = {
                walk = id4, run = id5, jump = id6, climb = id7, fall = id8,
                swim = id9, swimidle = id10,
            }
            for folderName, id in pairs(map) do
                local folder = Animate:FindFirstChild(folderName)
                if folder and id then
                    local a = folder:FindFirstChildOfClass("Animation")
                    if a then Anxium_SetAnimId(a, id) end
                end
            end
        end)
    end

    if not pack or pack == "Default" then
        local o = Cache.OriginalAnims
        if o then
            applyIds(o.Idle, o.Idle2, o.Idle3, o.Walk, o.Run, o.Jump, o.Climb, o.Fall, o.Swim, o.SwimIdle, o.Weight, o.Weight2)
        end
    else
        local p = AnxiumAnimPacks[pack]
        if not p then return false end
        applyIds(p.Idle, p.Idle2, p.Idle3, p.Walk, p.Run, p.Jump, p.Climb, p.Fall, p.Swim, p.SwimIdle, p.Weight or 9, p.Weight2 or 1)
    end
    Anxium_RefreshAnims()
    return true
end

local function Anxium_ApplySelectedPack()
    local name = Config.SelectedAnimPack or "Default"
    local ok = Anxium_PlayAnimationBody(name)
    if ok then
        Notify("Animations", "Pack: " .. tostring(name))
    else
        Notify("Animations", "Failed (need R15 Animate)")
    end
end

-- Re-apply pack after respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    task.delay(1.0, function()
        Cache.OriginalAnims = nil -- resave defaults for new character
        Anxium_SaveOriginalAnims()
        if Config.SelectedAnimPack and Config.SelectedAnimPack ~= "Default" then
            Anxium_PlayAnimationBody(Config.SelectedAnimPack)
        end
    end)
end)
if LocalPlayer.Character then
    task.defer(Anxium_SaveOriginalAnims)
end

-- UI: Animations tab — full selectable list
do
    CreateSectionHeader("— Animation Packs (R15) —", 1, AnimationsTab)

    local SelectedLbl = Instance.new("TextLabel")
    SelectedLbl.Size = UDim2.new(1, -20, 0, 22)
    SelectedLbl.BackgroundTransparency = 1
    SelectedLbl.LayoutOrder = 2
    SelectedLbl.Text = "Selected: " .. tostring(Config.SelectedAnimPack or "Default")
    SelectedLbl.TextColor3 = Theme.Accent
    SelectedLbl.TextSize = 12
    SelectedLbl.Font = SelectedFont
    SelectedLbl.TextXAlignment = Enum.TextXAlignment.Left
    SelectedLbl.Parent = AnimationsTab

    local ListFrame = Instance.new("Frame")
    ListFrame.Name = "AnimPackList"
    ListFrame.Size = UDim2.new(1, -20, 0, 320)
    ListFrame.BackgroundColor3 = Theme.BgSecondary
    ListFrame.BorderSizePixel = 0
    ListFrame.LayoutOrder = 3
    ListFrame.ClipsDescendants = true
    ListFrame.Parent = AnimationsTab
    do
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 8)
        c.Parent = ListFrame
    end

    local ListScroll = Instance.new("ScrollingFrame")
    ListScroll.Size = UDim2.new(1, -8, 1, -8)
    ListScroll.Position = UDim2.new(0, 4, 0, 4)
    ListScroll.BackgroundTransparency = 1
    ListScroll.BorderSizePixel = 0
    ListScroll.ScrollBarThickness = 4
    ListScroll.ScrollBarImageColor3 = Theme.Accent
    ListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    ListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ListScroll.Parent = ListFrame

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 4)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Parent = ListScroll

    local ListPad = Instance.new("UIPadding")
    ListPad.PaddingTop = UDim.new(0, 4)
    ListPad.PaddingBottom = UDim.new(0, 4)
    ListPad.PaddingLeft = UDim.new(0, 4)
    ListPad.PaddingRight = UDim.new(0, 4)
    ListPad.Parent = ListScroll

    Cache.AnimPackButtons = {}

    local function RefreshAnimPackHighlight()
        local cur = Config.SelectedAnimPack or "Default"
        for name, btn in pairs(Cache.AnimPackButtons) do
            if btn and btn.Parent then
                if name == cur then
                    btn.BackgroundColor3 = Theme.Accent
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                else
                    btn.BackgroundColor3 = Theme.BgTertiary
                    btn.TextColor3 = Theme.Text
                end
            end
        end
        SelectedLbl.Text = "Selected: " .. tostring(cur)
    end

    for i, packName in ipairs(AnxiumAnimList) do
        local btn = Instance.new("TextButton")
        btn.Name = "Pack_" .. packName
        btn.Size = UDim2.new(1, -4, 0, 28)
        btn.BackgroundColor3 = Theme.BgTertiary
        btn.BorderSizePixel = 0
        btn.Text = "  " .. packName
        btn.TextColor3 = Theme.Text
        btn.TextSize = 13
        btn.Font = SelectedFont
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.LayoutOrder = i
        btn.AutoButtonColor = true
        btn.Parent = ListScroll
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0, 6)
        bc.Parent = btn
        Cache.AnimPackButtons[packName] = btn
        btn.MouseButton1Click:Connect(function()
            Config.SelectedAnimPack = packName
            Config.AnimPackIndex = i
            RefreshAnimPackHighlight()
            Anxium_PlayAnimationBody(packName)
            Notify("Animations", "Pack: " .. packName)
        end)
    end
    RefreshAnimPackHighlight()

    local Hint = Instance.new("TextLabel")
    Hint.Size = UDim2.new(1, -20, 0, 28)
    Hint.BackgroundTransparency = 1
    Hint.LayoutOrder = 4
    Hint.Text = "Click a pack to apply (R15). Default = original."
    Hint.TextColor3 = Theme.TextDim
    Hint.TextSize = 11
    Hint.Font = SelectedFont
    Hint.TextXAlignment = Enum.TextXAlignment.Left
    Hint.TextWrapped = true
    Hint.Parent = AnimationsTab
end


CreateTextBoxRow("Target Player (Name / DisplayName)", "Enter name...", 1, TrollingTab, function(val)
    Config.TargetFlingName = val
    Notify("Trolling", "Target set: " .. val)
end)

ClickSelectBtn, ClickSelectBg, ClickSelectKnob = CreateFeatureRow("Click Select Target", 2, TrollingTab)
ClickSelectBtn.MouseButton1Click:Connect(function()
    Config.ClickFlingSelectEnabled = not Config.ClickFlingSelectEnabled
    UpdateSwitch(Config.ClickFlingSelectEnabled, ClickSelectBg, ClickSelectKnob, "Click Select Target")
end)

FlingBtn, FlingBg, FlingKnob = CreateFeatureRow("Target Fling", 3, TrollingTab)
OriginalFlingPos = nil

FlingBtn.MouseButton1Click:Connect(function()
    Config.TargetFlingEnabled = not Config.TargetFlingEnabled
    UpdateSwitch(Config.TargetFlingEnabled, FlingBg, FlingKnob, "Target Fling")
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if Config.TargetFlingEnabled and myHrp then
        OriginalFlingPos = myHrp.CFrame
    elseif not Config.TargetFlingEnabled and myHrp and OriginalFlingPos then
        myHrp.AssemblyAngularVelocity = Vector3.zero
        myHrp.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.1)
        myHrp.CFrame = OriginalFlingPos
        OriginalFlingPos = nil
    end
end)

-- Theme color (Settings) — same spectrum RGB picker, applies instantly to UI
ColorRow = Instance.new("Frame")
ColorRow.Size = UDim2.new(0.96, 0, 0, 44)
ColorRow.BackgroundColor3 = Color3.fromRGB(36, 36, 42)
ColorRow.BackgroundTransparency = 0.15
ColorRow.BorderSizePixel = 0
ColorRow.LayoutOrder = 1
ColorRow.Parent = SettingsTab

local ColorCorner = Instance.new("UICorner")
ColorCorner.CornerRadius = UDim.new(0, 6)
ColorCorner.Parent = ColorRow

ColorTitle = Instance.new("TextLabel")
ColorTitle.Size = UDim2.new(0.7, 0, 1, 0)
ColorTitle.Position = UDim2.new(0, 12, 0, 0)
ColorTitle.BackgroundTransparency = 1
ColorTitle.Text = "Theme Color"
ColorTitle.TextColor3 = Theme.Text
ColorTitle.TextSize = 12
ColorTitle.Font = SelectedFont
ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorTitle.Parent = ColorRow

ColorPickerBtn = Instance.new("TextButton")
ColorPickerBtn.Size = UDim2.new(0, 28, 0, 28)
ColorPickerBtn.Position = UDim2.new(1, -40, 0.5, -14)
ColorPickerBtn.BackgroundColor3 = Theme.Accent
ColorPickerBtn.BorderSizePixel = 0
ColorPickerBtn.Text = ""
ColorPickerBtn.Parent = ColorRow
local CpCorner = Instance.new("UICorner")
CpCorner.CornerRadius = UDim.new(0, 6)
CpCorner.Parent = ColorPickerBtn
local CpStroke = Instance.new("UIStroke")
CpStroke.Color = Color3.fromRGB(70, 70, 80)
CpStroke.Thickness = 1
CpStroke.Parent = ColorPickerBtn

local function ApplyAccentColor(color)
    Theme.Accent = color
    Theme.ToggleOn = color
    ColorPickerBtn.BackgroundColor3 = color

    -- Title "anxium" in menu header
    pcall(function() TitleLabel.TextColor3 = color end)
    -- Open-menu button: stroke can tint, TEXT stays white
    pcall(function()
        ToggleStroke.Color = Color3.fromRGB(55, 55, 65)
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    pcall(UpdateActiveList)
    -- Sidebar sections / tabs (active + inactive)
    pcall(function()
        if typeof(SwitchTab) == "function" and CurrentTab then
            SwitchTab(CurrentTab)
        else
            for name, btn in pairs(TabButtons) do
                if name == CurrentTab then
                    btn.BackgroundColor3 = color
                    btn.BackgroundTransparency = 0.75
                    btn.TextColor3 = color
                else
                    btn.BackgroundColor3 = Theme.BgTertiary
                    btn.BackgroundTransparency = 1
                    btn.TextColor3 = Theme.TextDim
                end
            end
        end
    end)
    -- Section headers inside tabs ("— ForceField —" etc.)
    pcall(function()
        Cache.SectionLabels = Cache.SectionLabels or {}
        for _, lbl in ipairs(Cache.SectionLabels) do
            if lbl and lbl.Parent then
                lbl.TextColor3 = color
            end
        end
    end)
    -- ON toggles immediately (don't wait for tween / full refresh side-effects)
    pcall(function()
        if RefreshAllSwitches then RefreshAllSwitches() end
    end)
    -- ALL slider fills
    pcall(function()
        Cache.SliderFills = Cache.SliderFills or {}
        for _, fill in ipairs(Cache.SliderFills) do
            if fill and fill.Parent then
                fill.BackgroundColor3 = color
            end
        end
    end)
    pcall(function()
        for _, frame in pairs(TabFrames) do
            if frame and frame:IsA("ScrollingFrame") then
                frame.ScrollBarImageColor3 = color
            end
        end
    end)
    pcall(function()
        if MainStroke then MainStroke.Color = Color3.fromRGB(48, 48, 56) end
    end)
    Notify("Theme", "Theme color applied")
end

ColorPickerBtn.MouseButton1Click:Connect(function()
    OpenRGBPicker(Theme.Accent, function(col)
        ApplyAccentColor(col)
    end, ColorPickerBtn)
end)





-- Keybinds panel in Settings
CreateSectionHeader("— Keybinds —", 40, SettingsTab)
BindListSettingsBtn, BindListSettingsBg, BindListSettingsKnob = CreateFeatureRow("Binds HUD", 41, SettingsTab)
local bindOrder = 42
local BIND_SETTINGS_KEYS = {
    "AimEnabled", "SilentAimEnabled", "TriggerbotEnabled", "ShowFovEnabled", "ShowSilentFovEnabled",
    "BoxEspEnabled", "ChamsEnabled", "NameEspEnabled", "HealthbarEspEnabled", "SkeletonEnabled",
    "TracersEnabled", "CrosshairEnabled", "FullbrightEnabled", "ChinaHatEnabled",
    "SpeedHackEnabled", "FlyEnabled", "NoclipEnabled", "BHopEnabled", "MultiJumpEnabled",
    "ForceFieldEnabled", "WeaponForceFieldEnabled", "BulletTracersEnabled",
    "SpinEnabled", "AntiAimEnabled", "TargetHudEnabled", "FogEnabled", "TrailEnabled",
    "ThirdPersonEnabled", "AspectRatioEnabled", "FootstepsEnabled",
}
for _, fk in ipairs(BIND_SETTINGS_KEYS) do
    CreateBindRow(fk, bindOrder, SettingsTab)
    bindOrder = bindOrder + 1
end
BindListSettingsBtn.MouseButton1Click:Connect(function()
    Config.BindListEnabled = not Config.BindListEnabled
    UpdateSwitch(Config.BindListEnabled, BindListSettingsBg, BindListSettingsKnob, "Binds HUD")
    if BindListBg and BindListKnob then
        pcall(function() UpdateSwitch(Config.BindListEnabled, BindListBg, BindListKnob) end)
    end
    if UpdateBindList then UpdateBindList() end
end)

-- ===== CONFIG SYSTEM (register-safe: single table) =====
local CfgIO = {
    -- Isolated folder so other hubs' configs never appear here
    Folder = "AnxiumHubConfigs",
    IndexFile = "AnxiumHubConfigs/_index.json",
    IndexFileAlt = "AnxiumHubConfigs_index.json",
    LastFile = "AnxiumHubConfigs/_last.txt",
    LastFileAlt = "AnxiumHubConfigs_last.txt",
    Marker = "__anxium_hub",
    Current = "default",
    List = {},
    Index = 1,
    NameBox = nil,
    ListFrame = nil,
    SelectBtn = nil,
    RowButtons = {},
}

local function SanitizeConfigName(name)
    name = tostring(name or ""):gsub("^%s+", ""):gsub("%s+$", "")
    name = name:gsub("[^%w%-%_ ]", "")
    if name == "" then name = "default" end
    return name
end

local function EnsureConfigFolder()
    if typeof(makefolder) == "function" then
        pcall(makefolder, CfgIO.Folder)
    end
end

local function GetConfigPath(name)
    return CfgIO.Folder .. "/" .. SanitizeConfigName(name) .. ".json"
end

local function SerializeConfig()
    local data = {
        Config = {},
        Accent = { R = Theme.Accent.R, G = Theme.Accent.G, B = Theme.Accent.B },
        CurrentColorIndex = Config.CurrentColorIndex
    }
    local function canSerializeTable(t)
        if type(t) ~= "table" then return false end
        for kk, vv in pairs(t) do
            local tk, tv = type(kk), typeof(vv)
            if tk ~= "string" and tk ~= "number" then return false end
            if tv == "table" then
                for _, vv2 in pairs(vv) do
                    local t2 = typeof(vv2)
                    if t2 ~= "string" and t2 ~= "number" and t2 ~= "boolean" then return false end
                end
            elseif tv ~= "string" and tv ~= "number" and tv ~= "boolean" then
                return false
            end
        end
        return true
    end
    for k, v in pairs(Config) do
        local t = typeof(v)
        if t == "boolean" or t == "number" or t == "string" then
            data.Config[k] = v
        elseif t == "Color3" then
            data.Config[k] = { __color = true, R = v.R, G = v.G, B = v.B }
        elseif t == "table" and canSerializeTable(v) then
            data.Config[k] = v
        end
    end
    return HttpService:JSONEncode(data)
end

local function ApplyLoadedConfig(data)
    if type(data) ~= "table" then return false end
    if type(data.Config) == "table" then
        for k, v in pairs(data.Config) do
            if Config[k] ~= nil then
                if type(v) == "table" and v.__color then
                    Config[k] = Color3.new(tonumber(v.R) or 1, tonumber(v.G) or 1, tonumber(v.B) or 1)
                else
                    local expected = typeof(Config[k])
                    local got = typeof(v)
                    if expected == got then
                        Config[k] = v
                    elseif expected == "number" then
                        local num = tonumber(v)
                        if num then Config[k] = num end
                    elseif expected == "table" and type(v) == "table" then
                        Config[k] = v
                    end
                end
            end
        end
    end
    if type(data.Accent) == "table" and data.Accent.R then
        local r = tonumber(data.Accent.R) or 0
        local g = tonumber(data.Accent.G) or 0
        local b = tonumber(data.Accent.B) or 0
        Theme.Accent = Color3.new(r, g, b)
        Theme.ToggleOn = Theme.Accent
        if ColorPickerBtn then ColorPickerBtn.BackgroundColor3 = Theme.Accent end
    end
    if typeof(data.CurrentColorIndex) == "number" then
        Config.CurrentColorIndex = data.CurrentColorIndex
    end
    return true
end

local function RefreshAllSwitches()
    local pairsList = {
        { Config.BoxEspEnabled, BoxEspBg, BoxEspKnob },
        { Config.HealthbarEspEnabled, HealthbarEspBg, HealthbarEspKnob },
        { Config.ChamsEnabled, ChamsBg, ChamsKnob },
        { Config.NameEspEnabled, NameEspBg, NameEspKnob },
        { Config.DistanceEspEnabled, DistEspBg, DistEspKnob },
        { Config.SkeletonEnabled, SkelBg, SkelKnob },
        { Config.TracersEnabled, TracerBg, TracerKnob },
        { Config.CrosshairEnabled, CrossBg, CrossKnob },
        { Config.SpinCrosshairEnabled, SpinCrossBg, SpinCrossKnob },
        { Config.DamageNumbersEnabled, DmgNumBg, DmgNumKnob },
        { Config.SelfChamsEnabled, SelfChamsBg, SelfChamsKnob },
        { Config.CloneChamsEnabled, CloneChamsBg, CloneChamsKnob },
        { Config.OffscreenArrowsEnabled, OffscreenBg, OffscreenKnob },
        { Config.DeathChamsEnabled, DeathChamsBg, DeathChamsKnob },
        { Config.DeathBurstEnabled, DeathBurstBg, DeathBurstKnob },
        { Config.FullbrightEnabled, FullBg, FullKnob },
        { Config.ActiveListEnabled, ActiveListBg, ActiveListKnob },
        { Config.FakeFpsEnabled, FakeFpsBg, FakeFpsKnob },
        { Config.ChinaHatEnabled, HatBg, HatKnob },
        { Config.OrbitOrbsEnabled, OrbitOrbsBg, OrbitOrbsKnob },
        { Config.TrailEnabled, TrailBg, TrailKnob },
        { Config.FogEnabled, FogBg, FogKnob },
        { Config.FootstepsEnabled, FootstepsBg, FootstepsKnob },
        { Config.AspectRatioEnabled, AspectBg, AspectKnob },
        { Config.ThirdPersonEnabled, ThirdPersonBg, ThirdPersonKnob },
        { Config.ForceFieldEnabled, FFBg, FFKnob },
        { Config.WeaponForceFieldEnabled, WeaponFFBg, WeaponFFKnob },
        { Config.KillFlashEnabled, KillFlashBg, KillFlashKnob },
        { Config.HitboxEnabled, HitboxBg, HitboxKnob },
        { Config.HitboxShow, HitboxShowBg, HitboxShowKnob },
        { Config.BulletTracersEnabled, BulletTracerBg, BulletTracerKnob },
        { Config.AuraEnabled, AuraBg, AuraKnob },
        { Config.ClassicPinkEnabled, ClassicPinkBg, ClassicPinkKnob },
        { Config.ClassicAngelEnabled, ClassicAngelBg, ClassicAngelKnob },
        { Config.ParticleStarlightEnabled, ParticleStarBg, ParticleStarKnob },
        { Config.ParticleAngelEnabled, ParticleAngelBg, ParticleAngelKnob },
        { Config.TeamCheckerEnabled, TeamCheckerBg, TeamCheckerKnob },
        { Config.AimEnabled, AimBg, AimKnob },
        { Config.ShowFovEnabled, ShowFovBg, ShowFovKnob },
        { Config.TargetHudEnabled, TargetHudBg, TargetHudKnob },
        { Config.DarkModeEnabled, DarkModeBg, DarkModeKnob },
        { Config.SpinEnabled, SpinBg, SpinKnob },
        { Config.AntiAimEnabled, AntiAimBg, AntiAimKnob },
        { Config.TriggerbotEnabled, TriggerbotBg, TriggerbotKnob },
        { Config.SilentAimEnabled, SilentAimBg, SilentAimKnob },
        { Config.ShowSilentFovEnabled, ShowSilentFovBg, ShowSilentFovKnob },
        { Config.SilentTeamCheck, SilentTeamCheckBg, SilentTeamCheckKnob },
        { Config.CustomFireSoundEnabled, FireSoundBg, FireSoundKnob },
        { Config.SpeedHackEnabled, SpeedBg, SpeedKnob },
        { Config.MultiJumpEnabled, JumpBg, JumpKnob },
        { Config.NoclipEnabled, NoclipBg, NoclipKnob },
        { Config.FlyEnabled, FlyBg, FlyKnob },
        { Config.BHopEnabled, BHopBg, BHopKnob },
        { Config.ClickFlingSelectEnabled, ClickSelectBg, ClickSelectKnob },
        { Config.TargetFlingEnabled, FlingBg, FlingKnob },
    }
    for _, item in ipairs(pairsList) do
        local state, bg, knob = item[1], item[2], item[3]
        if bg and knob then
            pcall(function()
                knob.AnchorPoint = Vector2.new(0, 0.5)
                if state then
                    bg.BackgroundColor3 = Theme.Accent
                    knob.Position = UDim2.new(1, -18, 0.5, 0)
                else
                    bg.BackgroundColor3 = Theme.ToggleOff
                    knob.Position = UDim2.new(0, 2, 0.5, 0)
                end
            end)
        end
    end

    -- Re-apply runtime visual state so loaded configs actually work
    pcall(function()
        for _, highlight in pairs(Cache.Highlights) do
            if highlight and highlight.Parent then
                highlight.Enabled = false
            end
        end
    end)
    pcall(function()
        for _, chams in pairs(Cache.Chams) do
            if chams and chams.Parent then
                chams.Enabled = Config.ChamsEnabled
                chams.FillColor = Config.Color_Chams or Theme.Accent
            end
        end
    end)
    pcall(function()
        if Cache.PlayerTrail then
            Cache.PlayerTrail.Enabled = Config.TrailEnabled
            Cache.PlayerTrail.Color = ColorSequence.new(Config.Color_Trail or Theme.Accent)
        end
    end)
    pcall(function()
        FovCircle.Color = Config.Color_Fov or Theme.Accent
        FovCircle.Radius = Config.FovRadius
        FovCircle.Visible = Config.ShowFovEnabled
        FovCircle.Color = Config.Color_Fov or Theme.Accent
        CrosshairX.Color = Config.Color_Crosshair or Theme.Accent
        CrosshairY.Color = Config.Color_Crosshair or Theme.Accent
    end)
    pcall(function()
        for _, boxData in pairs(Cache.Boxes) do
            if boxData then
                if boxData.Box then boxData.Box.Color = Theme.Accent end
                if boxData.Corners then
                    for _, ln in pairs(boxData.Corners) do if ln then ln.Color = Theme.Accent end end
                end
            end
        end
        for _, line in pairs(Cache.TracerLines) do
            if line then line.Color = Theme.Accent end
        end
        for _, parts in pairs(Cache.Skeletons) do
            if parts then
                for _, line in pairs(parts) do
                    if line then line.Color = Theme.Accent end
                end
            end
        end
        for _, nameText in pairs(Cache.EspLabels) do
            if nameText then nameText.Color = Config.Color_NameEsp or Theme.Accent end
        end
    end)
    pcall(function() UserInputService.MouseIconEnabled = not Config.CrosshairEnabled end)
    pcall(UpdateActiveList)
    pcall(function() ForceField_Toggle(Config.ForceFieldEnabled) end)
    pcall(ClassicAura_RefreshAll)
    pcall(ParticleAura_RefreshAll)

    -- Spinbot state
    pcall(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if Config.SpinEnabled then
            if hum then hum.AutoRotate = false end
            if hrp then
                for _, v in pairs(hrp:GetChildren()) do
                    if v.Name == "Spinning" then v:Destroy() end
                end
                local Spin = Instance.new("BodyAngularVelocity")
                Spin.Name = "Spinning"
                Spin.Parent = hrp
                Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                Spin.AngularVelocity = Vector3.new(0, Config.SpinSpeed or 20, 0)
            end
        else
            if hum then hum.AutoRotate = true end
            if hrp then
                for _, v in pairs(hrp:GetChildren()) do
                    if v.Name == "Spinning" then v:Destroy() end
                end
            end
        end
    end)

    -- Speed / third person
    pcall(function()
        if not Config.SpeedHackEnabled and LocalPlayer.Character then
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
        if Config.ThirdPersonEnabled then
            ThirdPerson_Enable()
        else
            ThirdPerson_Disable()
        end
    end)
end


-- Config FS helpers as table methods (avoid local-register blowup)
do
    local function isDeleted(content)
        if type(content) ~= "string" or #content < 2 then return true end
        return content:find('"__deleted"') ~= nil
    end

    local function fsWrite(p, c)
        if typeof(writefile) ~= "function" then return false end
        return pcall(writefile, p, c) and true or false
    end

    local function fsRead(p)
        if typeof(readfile) ~= "function" then return nil end
        local ok, c = pcall(readfile, p)
        if ok and type(c) == "string" and #c > 0 then return c end
        return nil
    end

    local function fsDelete(p)
        pcall(function() if typeof(delfile) == "function" then delfile(p) end end)
        pcall(function() if typeof(deletefile) == "function" then deletefile(p) end end)
        local gone = false
        if typeof(isfile) == "function" then
            local ok, ex = pcall(isfile, p)
            if ok and not ex then gone = true end
        end
        if not gone then fsWrite(p, '{"__deleted":true}') end
        return true
    end

    local function pathCandidates(name)
        name = SanitizeConfigName(name)
        local f = name .. ".json"
        -- Strictly only this script's folder (never workspace root)
        return {
            CfgIO.Folder .. "/" .. f,
            CfgIO.Folder .. "\\" .. f,
            "./" .. CfgIO.Folder .. "/" .. f,
        }
    end

    local function isOurs(content)
        if type(content) ~= "string" or #content < 2 then return false end
        if isDeleted(content) then return false end
        if content:find('"' .. CfgIO.Marker .. '"') then return true end
        if content:find('"Config"') and content:find('"Accent"') then return true end
        return false
    end

    local function readIndex()
        local raw = fsRead(CfgIO.IndexFile) or fsRead(CfgIO.IndexFileAlt)
        if not raw then return {} end
        local ok, data = pcall(function() return HttpService:JSONDecode(raw) end)
        if not ok or type(data) ~= "table" then return {} end
        local names, src = {}, (data.names or data)
        if type(src) ~= "table" then return {} end
        local seen = {}
        for _, n in ipairs(src) do
            if type(n) == "string" and n ~= "" and n ~= "_last" and n ~= "_index" then
                n = SanitizeConfigName(n)
                if not seen[n] then seen[n] = true table.insert(names, n) end
            end
        end
        return names
    end

    local function writeIndex(names)
        EnsureConfigFolder()
        local clean, seen = {}, {}
        for _, n in ipairs(names or {}) do
            n = SanitizeConfigName(n)
            if n ~= "" and n ~= "_last" and n ~= "_index" and not seen[n] then
                seen[n] = true
                table.insert(clean, n)
            end
        end
        table.sort(clean)
        local payload = HttpService:JSONEncode({ names = clean, version = 1 })
        fsWrite(CfgIO.IndexFile, payload)
        fsWrite(CfgIO.IndexFileAlt, payload)
        return clean
    end

    local function readConfigFile(name)
        name = SanitizeConfigName(name)
        for _, p in ipairs(pathCandidates(name)) do
            local c = fsRead(p)
            if c and isOurs(c) then return c, p end
        end
        return nil, nil
    end

    local function writeConfigFile(name, json)
        name = SanitizeConfigName(name)
        EnsureConfigFolder()
        -- stamp marker so list never confuses us with other scripts
        local stamped = json
        if type(json) == "string" and not json:find('"' .. CfgIO.Marker .. '"') then
            if json:sub(1, 1) == "{" then
                stamped = '{"' .. CfgIO.Marker .. '":true,' .. json:sub(2)
            end
        end
        for _, p in ipairs(pathCandidates(name)) do
            if fsWrite(p, stamped) then
                local body = fsRead(p)
                if body and isOurs(body) then
                    return true, p
                end
            end
        end
        return false, nil
    end

    local function deleteConfigFile(name)
        name = SanitizeConfigName(name)
        for _, p in ipairs(pathCandidates(name)) do
            fsDelete(p)
        end
        return true
    end

    local function scanListfiles()
        local found = {}
        if typeof(listfiles) ~= "function" then return found end
        -- ONLY scan this script's folder
        for _, dir in ipairs({ CfgIO.Folder, CfgIO.Folder .. "/", "./" .. CfgIO.Folder }) do
            local ok, res = pcall(listfiles, dir)
            if ok and type(res) == "table" then
                for _, fpath in ipairs(res) do
                    local s = tostring(fpath):gsub("\\", "/")
                    local base = s:match("([^/]+)$") or s
                    if base == "_last.txt" or base == "_index.json" or base:find("_index") then
                        -- skip meta
                    elseif base:match("%.json$") then
                        local name = base:match("(.+)%.json$")
                        if name and name ~= "" and name ~= "_last" and name ~= "_index" then
                            name = SanitizeConfigName(name)
                            local content = fsRead(fpath)
                            if content and isOurs(content) then
                                found[name] = true
                            end
                        end
                    end
                end
            end
        end
        return found
    end

    function CfgIO.RebuildListUI()
        local frame = CfgIO.ListFrame
        if not frame then return end
        for _, child in ipairs(frame:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        CfgIO.RowButtons = {}
        if #CfgIO.List == 0 then
            local empty = Instance.new("TextLabel")
            empty.Size = UDim2.new(1, -8, 0, 28)
            empty.BackgroundTransparency = 1
            empty.Text = "No configs yet — type a name and press Create"
            empty.TextColor3 = Theme.TextDim
            empty.TextSize = 11
            empty.Font = SelectedFont
            empty.TextXAlignment = Enum.TextXAlignment.Left
            empty.Parent = frame
            return
        end
        for i, name in ipairs(CfgIO.List) do
            local row = Instance.new("TextButton")
            row.Name = "Cfg_" .. name
            row.Size = UDim2.new(1, -8, 0, 28)
            local selected = (name == CfgIO.Current or i == CfgIO.Index)
            row.BackgroundColor3 = selected and Color3.fromRGB(55, 45, 80) or Theme.BgTertiary
            row.BackgroundTransparency = 0.15
            row.BorderSizePixel = 0
            row.Text = "  " .. name
            row.TextColor3 = (name == CfgIO.Current) and Theme.Accent or Theme.Text
            row.TextSize = 12
            row.Font = SelectedFont
            row.TextXAlignment = Enum.TextXAlignment.Left
            row.LayoutOrder = i
            row.Parent = frame
            local rc = Instance.new("UICorner")
            rc.CornerRadius = UDim.new(0, 6)
            rc.Parent = row
            CfgIO.RowButtons[name] = row
            row.MouseButton1Click:Connect(function()
                CfgIO.Index = i
                CfgIO.Current = name
                if CfgIO.NameBox then CfgIO.NameBox.Text = name end
                CfgIO.RebuildListUI()
            end)
            row.MouseButton2Click:Connect(function()
                CfgIO.Index = i
                CfgIO.Current = name
                if CfgIO.NameBox then CfgIO.NameBox.Text = name end
                CfgIO.Load()
            end)
        end
    end

    function CfgIO.RefreshList()
        EnsureConfigFolder()
        local merged, seen = {}, {}

        local function add(n)
            n = SanitizeConfigName(n)
            if n == "" or seen[n] then return end
            if select(1, readConfigFile(n)) then
                seen[n] = true
                table.insert(merged, n)
            end
        end

        for _, n in ipairs(readIndex()) do add(n) end
        for n, _ in pairs(scanListfiles()) do add(n) end

        table.sort(merged)
        for i = #CfgIO.List, 1, -1 do CfgIO.List[i] = nil end
        for _, n in ipairs(merged) do table.insert(CfgIO.List, n) end
        writeIndex(CfgIO.List)

        if CfgIO.Index < 1 then CfgIO.Index = 1 end
        if #CfgIO.List == 0 then
            CfgIO.Index = 1
        elseif CfgIO.Index > #CfgIO.List then
            CfgIO.Index = #CfgIO.List
        end
        if CfgIO.SelectBtn then
            CfgIO.SelectBtn.Text = (#CfgIO.List == 0) and "(no configs)" or CfgIO.List[CfgIO.Index]
        end
        ConfigList = CfgIO.List
        ConfigListIndex = CfgIO.Index
        CurrentConfigName = CfgIO.Current
        pcall(CfgIO.RebuildListUI)
        return CfgIO.List
    end

    function CfgIO.Remember(name)
        if not name or name == "" then return end
        EnsureConfigFolder()
        local n = SanitizeConfigName(name)
        fsWrite(CfgIO.LastFile, n)
        fsWrite(CfgIO.LastFileAlt, n)
    end

    function CfgIO.GetLast()
        local content = fsRead(CfgIO.LastFile) or fsRead(CfgIO.LastFileAlt)
        if content then
            local name = content:gsub("%s+", "")
            if name ~= "" and not name:find("{") then
                return SanitizeConfigName(name)
            end
        end
        return nil
    end

    function CfgIO.Save()
        if typeof(writefile) ~= "function" then
            Notify("Config", "writefile not available on this executor")
            return false
        end
        local rawName = ""
        if CfgIO.NameBox and type(CfgIO.NameBox.Text) == "string" then
            rawName = CfgIO.NameBox.Text
        end
        if rawName == "" and #CfgIO.List > 0 and CfgIO.List[CfgIO.Index] then
            rawName = CfgIO.List[CfgIO.Index]
        end
        if rawName == "" then rawName = CfgIO.Current or "default" end
        local name = SanitizeConfigName(rawName)
        EnsureConfigFolder()
        local okSer, json = pcall(SerializeConfig)
        if not okSer or not json or #json < 2 then
            Notify("Config", "Serialize failed")
            return false
        end
        local wrote = writeConfigFile(name, json)
        if not wrote then
            Notify("Config", "Write failed for: " .. name)
            return false
        end
        CfgIO.Current = name
        if CfgIO.NameBox then CfgIO.NameBox.Text = name end
        CfgIO.Remember(name)
        local found = false
        for _, n in ipairs(CfgIO.List) do
            if n == name then found = true break end
        end
        if not found then table.insert(CfgIO.List, name) end
        table.sort(CfgIO.List)
        for i, n in ipairs(CfgIO.List) do
            if n == name then CfgIO.Index = i break end
        end
        writeIndex(CfgIO.List)
        CfgIO.RefreshList()
        for i, n in ipairs(CfgIO.List) do
            if n == name then CfgIO.Index = i break end
        end
        Notify("Config", "Saved: " .. name)
        return true
    end

    function CfgIO.Load()
        if typeof(readfile) ~= "function" then
            Notify("Config", "readfile not available")
            return false
        end
        local name = nil
        if #CfgIO.List > 0 and CfgIO.List[CfgIO.Index] then
            name = CfgIO.List[CfgIO.Index]
        elseif CfgIO.NameBox and CfgIO.NameBox.Text ~= "" then
            name = SanitizeConfigName(CfgIO.NameBox.Text)
        elseif CfgIO.Current then
            name = SanitizeConfigName(CfgIO.Current)
        end
        if not name or name == "" then
            Notify("Config", "No config selected")
            return false
        end
        local content = select(1, readConfigFile(name))
        if not content then
            Notify("Config", "Failed to read: " .. tostring(name))
            return false
        end
        local okJson, data = pcall(function() return HttpService:JSONDecode(content) end)
        if not okJson or type(data) ~= "table" then
            Notify("Config", "Invalid JSON: " .. tostring(name))
            return false
        end
        if not ApplyLoadedConfig(data) then
            Notify("Config", "Apply failed: " .. tostring(name))
            return false
        end
        CfgIO.Current = name
        if CfgIO.NameBox then CfgIO.NameBox.Text = name end
        CfgIO.Remember(name)
        for i, n in ipairs(CfgIO.List) do
            if n == name then CfgIO.Index = i break end
        end
        pcall(function()
            if RefreshAllSwitches then RefreshAllSwitches() end
        end)
        pcall(function()
            if typeof(ApplyAccentColor) == "function" then ApplyAccentColor(Theme.Accent) end
        end)
        pcall(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and ApplyEspToPlayer then ApplyEspToPlayer(p) end
            end
        end)
        pcall(function()
            if Config.ForceFieldEnabled and ForceField_Toggle then ForceField_Toggle(true) end
            if Config.WeaponForceFieldEnabled and WeaponFF_Toggle then WeaponFF_Toggle(true) end
            if Config.TrailEnabled and LocalPlayer.Character and SetupTrail then SetupTrail(LocalPlayer.Character) end
            if ClassicAura_RefreshAll then ClassicAura_RefreshAll() end
            if ParticleAura_RefreshAll then ParticleAura_RefreshAll() end
            if FovCircle then
                FovCircle.Visible = Config.ShowFovEnabled
                FovCircle.Radius = Config.FovRadius or 150
                FovCircle.Color = Config.Color_Fov or Theme.Accent
            end
            if CrosshairX then CrosshairX.Color = Config.Color_Crosshair or Theme.Accent end
            if CrosshairY then CrosshairY.Color = Config.Color_Crosshair or Theme.Accent end
            UserInputService.MouseIconEnabled = not Config.CrosshairEnabled
            if ActiveListFrame then ActiveListFrame.Visible = Config.ActiveListEnabled == true end
            if UpdateActiveList then UpdateActiveList() end
            if UpdateFakeFpsDisplay then UpdateFakeFpsDisplay() end
            if UpdateBindList then UpdateBindList() end
            Cache.ChamsForceRefresh = true
        end)
        pcall(CfgIO.RebuildListUI)
        Notify("Config", "Loaded: " .. name)
        return true
    end

    function CfgIO.Delete()
        local name = nil
        if #CfgIO.List > 0 and CfgIO.List[CfgIO.Index] then
            name = CfgIO.List[CfgIO.Index]
        elseif CfgIO.NameBox and CfgIO.NameBox.Text ~= "" then
            name = SanitizeConfigName(CfgIO.NameBox.Text)
        end
        if not name or name == "" then
            Notify("Config", "No config to delete")
            return false
        end

        -- 1) erase file(s) from disk
        deleteConfigFile(name)

        -- 2) remove from in-memory list immediately (in-place)
        for i = #CfgIO.List, 1, -1 do
            if CfgIO.List[i] == name then
                table.remove(CfgIO.List, i)
            end
        end
        writeIndex(CfgIO.List)

        if CfgIO.Index > #CfgIO.List then
            CfgIO.Index = math.max(1, #CfgIO.List)
        end
        if CfgIO.Index < 1 then CfgIO.Index = 1 end

        local nextName = (#CfgIO.List > 0 and CfgIO.List[CfgIO.Index]) or ""
        if CfgIO.NameBox then CfgIO.NameBox.Text = nextName end
        if CfgIO.Current == name then
            CfgIO.Current = nextName ~= "" and nextName or "default"
        end

        local last = CfgIO.GetLast()
        if last == name then
            if nextName ~= "" then
                CfgIO.Remember(nextName)
            else
                fsWrite(CfgIO.LastFile, "")
                fsWrite(CfgIO.LastFileAlt, "")
            end
        end

        -- 3) redraw list RIGHT NOW (before any async refresh)
        pcall(CfgIO.RebuildListUI)

        -- 4) rescan folder only and redraw again
        CfgIO.RefreshList()
        pcall(CfgIO.RebuildListUI)

        ConfigList = CfgIO.List
        ConfigListIndex = CfgIO.Index
        CurrentConfigName = CfgIO.Current

        Notify("Config", "Deleted: " .. name)
        return true
    end

    -- Compat aliases used elsewhere
    RefreshConfigList = function() return CfgIO.RefreshList() end
    RebuildConfigListUI = function() return CfgIO.RebuildListUI() end
    SaveCurrentConfig = function() return CfgIO.Save() end
    LoadSelectedConfig = function() return CfgIO.Load() end
    DeleteSelectedConfig = function() return CfgIO.Delete() end
    IsDeletedConfigContent = isDeleted
    ReadConfigFile = readConfigFile
    WriteIndex = writeIndex
end

-- Compat globals for older references
ConfigList = CfgIO.List
ConfigListIndex = 1
CurrentConfigName = "default"
ConfigNameBox = nil
ConfigSelectBtn = nil
ConfigListFrame = nil

-- Rebuild Config UI
do
    for _, child in ipairs(ConfigsTab:GetChildren()) do
        if child:IsA("GuiObject") then
            local n = child.Name
            if n == "ConfigNameRow" or n == "ConfigSelectRow" or n == "ConfigBtnRow"
                or n == "ConfigListRow" or n == "ConfigSection" then
                pcall(function() child:Destroy() end)
            end
        end
    end
end

CreateSectionHeader("— Config —", 1, ConfigsTab)

do
    local NameRow = Instance.new("Frame")
    NameRow.Name = "ConfigNameRow"
    NameRow.Size = UDim2.new(0.96, 0, 0, 40)
    NameRow.BackgroundColor3 = Theme.BgSecondary
    NameRow.BackgroundTransparency = 0.45
    NameRow.BorderSizePixel = 0
    NameRow.LayoutOrder = 2
    NameRow.Parent = ConfigsTab
    local nc = Instance.new("UICorner")
    nc.CornerRadius = UDim.new(0, 8)
    nc.Parent = NameRow
    local nl = Instance.new("TextLabel")
    nl.Size = UDim2.new(0.4, 0, 1, 0)
    nl.Position = UDim2.new(0, 12, 0, 0)
    nl.BackgroundTransparency = 1
    nl.Text = "Name"
    nl.TextColor3 = Theme.Text
    nl.TextSize = 12
    nl.Font = SelectedFont
    nl.TextXAlignment = Enum.TextXAlignment.Left
    nl.Parent = NameRow
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 160, 0, 26)
    box.Position = UDim2.new(1, -172, 0.5, -13)
    box.BackgroundColor3 = Theme.BgTertiary
    box.BorderSizePixel = 0
    box.Text = CfgIO.Current or "default"
    box.PlaceholderText = "new config name..."
    box.TextColor3 = Theme.Text
    box.PlaceholderColor3 = Theme.TextDim
    box.TextSize = 12
    box.Font = SelectedFont
    box.ClearTextOnFocus = false
    box.Parent = NameRow
    local nbc = Instance.new("UICorner")
    nbc.CornerRadius = UDim.new(0, 6)
    nbc.Parent = box
    CfgIO.NameBox = box
    ConfigNameBox = box
end

do
    local ListRow = Instance.new("Frame")
    ListRow.Name = "ConfigListRow"
    ListRow.Size = UDim2.new(0.96, 0, 0, 168)
    ListRow.BackgroundColor3 = Theme.BgSecondary
    ListRow.BackgroundTransparency = 0.45
    ListRow.BorderSizePixel = 0
    ListRow.LayoutOrder = 3
    ListRow.ClipsDescendants = true
    ListRow.Parent = ConfigsTab
    local lc = Instance.new("UICorner")
    lc.CornerRadius = UDim.new(0, 8)
    lc.Parent = ListRow

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, -16, 0, 22)
    header.Position = UDim2.new(0, 12, 0, 4)
    header.BackgroundTransparency = 1
    header.Text = "Saved configs"
    header.TextColor3 = Theme.Text
    header.TextSize = 12
    header.Font = SelectedFont
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = ListRow

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "ConfigListScroll"
    scroll.Size = UDim2.new(1, -16, 1, -30)
    scroll.Position = UDim2.new(0, 8, 0, 26)
    scroll.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    scroll.BackgroundTransparency = 0.25
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = Theme.Accent
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = ListRow
    local lfc = Instance.new("UICorner")
    lfc.CornerRadius = UDim.new(0, 6)
    lfc.Parent = scroll
    local lay = Instance.new("UIListLayout")
    lay.Padding = UDim.new(0, 4)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    lay.Parent = scroll
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 4)
    pad.PaddingBottom = UDim.new(0, 4)
    pad.PaddingLeft = UDim.new(0, 4)
    pad.PaddingRight = UDim.new(0, 4)
    pad.Parent = scroll
    CfgIO.ListFrame = scroll
    ConfigListFrame = scroll

    local hidden = Instance.new("TextButton")
    hidden.Visible = false
    hidden.Size = UDim2.new(0, 1, 0, 1)
    hidden.Text = "(no configs)"
    hidden.Parent = ListRow
    CfgIO.SelectBtn = hidden
    ConfigSelectBtn = hidden
end

do
    local BtnRow = Instance.new("Frame")
    BtnRow.Name = "ConfigBtnRow"
    BtnRow.Size = UDim2.new(0.96, 0, 0, 40)
    BtnRow.BackgroundTransparency = 1
    BtnRow.BorderSizePixel = 0
    BtnRow.LayoutOrder = 5
    BtnRow.Parent = ConfigsTab

    local function MakeCfgBtn(text, order, color, callback)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 92, 0, 30)
        b.Position = UDim2.new(0, (order - 1) * 100, 0.5, -15)
        b.BackgroundColor3 = color
        b.BorderSizePixel = 0
        b.Text = text
        b.TextColor3 = Theme.Text
        b.TextSize = 12
        b.Font = SelectedFont
        b.Parent = BtnRow
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, 8)
        c.Parent = b
        b.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
        return b
    end

    MakeCfgBtn("Save", 1, Theme.BgSecondary, function() CfgIO.Save() end)
    MakeCfgBtn("Create", 2, Theme.BgSecondary, function()
        if CfgIO.NameBox and (not CfgIO.NameBox.Text or CfgIO.NameBox.Text == "") then
            Notify("Config", "Enter a name first")
            return
        end
        CfgIO.Save()
    end)
    MakeCfgBtn("Load", 3, Theme.BgSecondary, function() CfgIO.Load() end)
    MakeCfgBtn("Delete", 4, Color3.fromRGB(90, 40, 45), function() CfgIO.Delete() end)
end

-- Boot: only list configs — user loads manually via Load button
task.spawn(function()
    for _ = 1, 12 do
        task.wait(0.08)
        EnsureConfigFolder()
        if typeof(writefile) == "function" or typeof(readfile) == "function" then
            break
        end
    end
    EnsureConfigFolder()
    CfgIO.RefreshList()
    pcall(CfgIO.RebuildListUI)
end)

task.defer(function()
    task.wait(0.5)
    CfgIO.RefreshList()
    pcall(CfgIO.RebuildListUI)
end)



local MenuOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen
    local tweenInfo = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    if MenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 520, 0, 360)
        MainFrame.BackgroundTransparency = 1
        MainStroke.Transparency = 1
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 580, 0, 420), BackgroundTransparency = 0}):Play()
        TweenService:Create(MainStroke, tweenInfo, {Transparency = 0.4}):Play()
        TweenService:Create(BlurEffect, tweenInfo, {Size = 18}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Size = UDim2.new(0, 480, 0, 340), BackgroundTransparency = 1}):Play()
        TweenService:Create(MainStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
        TweenService:Create(BlurEffect, tweenInfo, {Size = 0}):Play()
        task.delay(0.26, function()
            if not MenuOpen then MainFrame.Visible = false end
        end)
    end
end)

SwitchTab("Visuals")
pcall(UpdateFakeFpsDisplay)

TriggerTargetHighlightAnimation = function(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local char = targetPlayer.Character

    if Cache.SelectedTargetHighlight and Cache.SelectedTargetHighlight.Parent then
        Cache.SelectedTargetHighlight:Destroy()
        Cache.SelectedTargetHighlight = nil
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "AnxiumSelectChams"
    highlight.Adornee = char
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = Theme.Accent
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 1
    highlight.Enabled = true
    highlight.Parent = char
    Cache.SelectedTargetHighlight = highlight

    local tweenIn = TweenService:Create(highlight, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        FillTransparency = 0.35,
        OutlineTransparency = 0
    })
    tweenIn:Play()

    task.delay(2.4, function()
        if highlight and highlight.Parent then
            local tweenOut = TweenService:Create(highlight, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                FillTransparency = 1,
                OutlineTransparency = 1
            })
            tweenOut:Play()
            tweenOut.Completed:Connect(function()
                if highlight and highlight.Parent then
                    highlight:Destroy()
                    if Cache.SelectedTargetHighlight == highlight then
                        Cache.SelectedTargetHighlight = nil
                    end
                end
            end)
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not Config.ClickFlingSelectEnabled or gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local closestPlayer = nil
        local shortestDist = math.huge

        for _, player in ipairs(CachedPlayerList) do
            if player ~= LocalPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if head and humanoid and humanoid.Health > 0 then
                    local screenPos, onScreen = WorldToScreen(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if dist < shortestDist and dist < 80 then
                            shortestDist = dist
                            closestPlayer = player
                        end
                    end
                end
            end
        end

        if closestPlayer then
            Config.TargetFlingName = closestPlayer.Name
            Notify("Trolling", "Selected: " .. (closestPlayer.DisplayName or closestPlayer.Name))
            TriggerTargetHighlightAnimation(closestPlayer)
        end
    end
end)

ApplyEspToPlayer = function(targetPlayer)
    if targetPlayer == LocalPlayer then return end

    local function CleanupPlayerDrawings()
        if Cache.EspLabels[targetPlayer] then
            pcall(function() Cache.EspLabels[targetPlayer]:Remove() end)
            Cache.EspLabels[targetPlayer] = nil
        end
        if Cache.Skeletons[targetPlayer] then
            for _, line in pairs(Cache.Skeletons[targetPlayer]) do
                pcall(function() if line then line:Remove() end end)
            end
            Cache.Skeletons[targetPlayer] = nil
        end
        if Cache.Boxes[targetPlayer] then
            local b = Cache.Boxes[targetPlayer]
            pcall(function() if b.Outline then b.Outline:Remove() end end)
            pcall(function() if b.Box then b.Box:Remove() end end)
            pcall(function() if b.Fill then b.Fill:Remove() end end)
            if b.Gradients then
                for _, g in pairs(b.Gradients) do pcall(function() if g then g:Remove() end end) end
            end
            if b.Corners then
                for _, ln in pairs(b.Corners) do pcall(function() ln:Remove() end) end
            end
            Cache.Boxes[targetPlayer] = nil
        end
        if Cache.Healthbars[targetPlayer] then
            pcall(function()
                if Cache.Healthbars[targetPlayer].Bg then Cache.Healthbars[targetPlayer].Bg:Remove() end
                if Cache.Healthbars[targetPlayer].Fill then Cache.Healthbars[targetPlayer].Fill:Remove() end
            end)
            Cache.Healthbars[targetPlayer] = nil
        end
    end

    local function CharacterAdded(character)
        if not character then return end
        CleanupPlayerDrawings()

        local highlight = character:FindFirstChild("AnxiumHighlight") or Instance.new("Highlight")
        highlight.Name = "AnxiumHighlight"
        highlight.Adornee = character
        highlight.FillColor = Theme.Accent
        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Enabled = false
        highlight.Parent = character
        Cache.Highlights[targetPlayer] = highlight

        -- Highlight parented to CoreGui (more reliable when games strip character children)
        local chams = Cache.Chams[targetPlayer]
        if chams and chams.Parent then
            pcall(function() chams:Destroy() end)
        end
        chams = Instance.new("Highlight")
        chams.Name = "AnxiumChams_" .. tostring(targetPlayer.UserId)
        chams.Adornee = character
        chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        chams.FillColor = Config.Color_Chams or Theme.Accent
        chams.OutlineColor = Color3.fromRGB(255, 255, 255)
        chams.FillTransparency = 0.4
        chams.OutlineTransparency = 0.2
        chams.Enabled = Config.ChamsEnabled
        -- parent to protected gui so game scripts less likely to delete
        local okParent = pcall(function()
            if gethui then chams.Parent = gethui()
            elseif syn and syn.protect_gui then chams.Parent = CoreGui
            else chams.Parent = ScreenGui end
        end)
        if not okParent then
            chams.Parent = character
        end
        Cache.Chams[targetPlayer] = chams

        -- Fallback part glow for games where Highlight is disabled (custom avatars)
        Cache.ChamsPartFallback = Cache.ChamsPartFallback or {}
        if Cache.ChamsPartFallback[targetPlayer] then
            for part, data in pairs(Cache.ChamsPartFallback[targetPlayer]) do
                if part and part.Parent and data then
                    pcall(function()
                        part.Material = data.Material
                        part.Color = data.Color
                    end)
                end
            end
        end
        Cache.ChamsPartFallback[targetPlayer] = {}
        if Config.ChamsEnabled then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Transparency < 0.95 then
                    Cache.ChamsPartFallback[targetPlayer][part] = {
                        Material = part.Material,
                        Color = part.Color,
                    }
                    pcall(function()
                        part.Material = Enum.Material.ForceField
                        part.Color = Config.Color_Chams or Theme.Accent
                    end)
                end
            end
        end

        -- Drawing-based name label (doesn't fly off when turning camera)
        if Cache.EspLabels[targetPlayer] then
            pcall(function() Cache.EspLabels[targetPlayer]:Remove() end)
            Cache.EspLabels[targetPlayer] = nil
        end
        local nameText = Drawing.new("Text")
        nameText.Size = 14
        nameText.Center = true
        nameText.Outline = true
        nameText.OutlineColor = Color3.fromRGB(0, 0, 0)
        nameText.Color = Config.Color_NameEsp or Theme.Accent
        nameText.Font = 2 -- UI
        nameText.Visible = false
        nameText.Text = ""
        Cache.EspLabels[targetPlayer] = nameText

        local skelParts = {
            Head = Drawing.new("Line"), Spine = Drawing.new("Line"), LeftArm = Drawing.new("Line"),
            RightArm = Drawing.new("Line"), LeftLeg = Drawing.new("Line"), RightLeg = Drawing.new("Line")
        }
        for _, line in pairs(skelParts) do
            line.Thickness = 1.5
            line.Transparency = 1
            line.Color = Theme.Accent
            line.Visible = false
        end
        Cache.Skeletons[targetPlayer] = skelParts

        -- Full box (square) + inner gradient fill
        local boxOutline = Drawing.new("Square")
        boxOutline.Thickness = 2.5
        boxOutline.Filled = false
        boxOutline.Color = Color3.fromRGB(20, 12, 30) -- will be set from Color_BoxEsp each frame
        boxOutline.Visible = false

        local boxLine = Drawing.new("Square")
        boxLine.Thickness = 1.4
        boxLine.Filled = false
        boxLine.Color = Config.Color_BoxEsp or Theme.Accent
        boxLine.Visible = false

        -- Soft filled base under gradient
        local boxFill = Drawing.new("Square")
        boxFill.Thickness = 1
        boxFill.Filled = true
        boxFill.Color = Config.Color_BoxEsp or Theme.Accent
        boxFill.Transparency = 0.82
        boxFill.Visible = false

        -- Gradient strips (top → bottom Color_BoxEsp → Color_BoxEspFill)
        local gradients = {}
        for i = 1, 12 do
            local g = Drawing.new("Square")
            g.Thickness = 1
            g.Filled = true
            g.Transparency = 0.72
            g.Visible = false
            gradients[i] = g
        end

        -- Corner style (8 short lines)
        local corners = {}
        for i = 1, 8 do
            local ln = Drawing.new("Line")
            ln.Thickness = 1.6
            ln.Color = Config.Color_BoxEsp or Theme.Accent
            ln.Visible = false
            corners[i] = ln
        end

        Cache.Boxes[targetPlayer] = {
            Outline = boxOutline,
            Box = boxLine,
            Fill = boxFill,
            Gradients = gradients,
            Corners = corners
        }

        local hbBg = Drawing.new("Square")
        hbBg.Thickness = 1
        hbBg.Filled = true
        hbBg.Color = Color3.fromRGB(0, 0, 0)
        hbBg.Visible = false

        local hbFill = Drawing.new("Square")
        hbFill.Thickness = 1
        hbFill.Filled = true
        hbFill.Color = Color3.fromRGB(0, 255, 0)
        hbFill.Visible = false

        Cache.Healthbars[targetPlayer] = {Bg = hbBg, Fill = hbFill}
    end

    if targetPlayer.Character then CharacterAdded(targetPlayer.Character) end
    targetPlayer.CharacterAdded:Connect(CharacterAdded)
    targetPlayer.CharacterRemoving:Connect(CleanupPlayerDrawings)
end

CreateTracer = function(targetPlayer)
    if targetPlayer == LocalPlayer then return end
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Transparency = 1
    line.Color = Theme.Accent
    line.Visible = false
    Cache.TracerLines[targetPlayer] = line
end

for _, player in ipairs(CachedPlayerList) do
    ApplyEspToPlayer(player)
    CreateTracer(player)
end

Players.PlayerAdded:Connect(function(player)
    ApplyEspToPlayer(player)
    CreateTracer(player)
end)

Players.PlayerRemoving:Connect(function(player)
    Cache.Highlights[player] = nil
    Cache.Chams[player] = nil
    if Cache.EspLabels[player] then
        pcall(function() Cache.EspLabels[player]:Remove() end)
        Cache.EspLabels[player] = nil
    end
    if Cache.TracerLines[player] then Cache.TracerLines[player]:Remove() Cache.TracerLines[player] = nil end
    if Cache.Skeletons[player] then
        for _, line in pairs(Cache.Skeletons[player]) do line:Remove() end
        Cache.Skeletons[player] = nil
    end
    if Cache.Boxes[player] then
        local b = Cache.Boxes[player]
        pcall(function() if b.Outline then b.Outline:Remove() end end)
        pcall(function() if b.Box then b.Box:Remove() end end)
        if b.Corners then
            for _, ln in pairs(b.Corners) do pcall(function() ln:Remove() end) end
        end
        Cache.Boxes[player] = nil
    end
    if Cache.Healthbars[player] then
        pcall(function()
            if Cache.Healthbars[player].Bg then Cache.Healthbars[player].Bg:Remove() end
            if Cache.Healthbars[player].Fill then Cache.Healthbars[player].Fill:Remove() end
        end)
        Cache.Healthbars[player] = nil
    end
end)


-- Anti-Aim: real desync orientation (yaw vs camera + upper-body pitch, no floor flop)
local function AntiAim_EnsureGyro(hrp)
    local g = hrp:FindFirstChild("AnxiumAAGyro")
    if g and g:IsA("BodyGyro") then return g end
    for _, c in ipairs(hrp:GetChildren()) do
        if c.Name == "AnxiumAAGyro" then pcall(function() c:Destroy() end) end
    end
    g = Instance.new("BodyGyro")
    g.Name = "AnxiumAAGyro"
    g.P = 9e4
    g.D = 2000
    g.MaxTorque = Vector3.new(0, 12e6, 0) -- yaw only — keeps upright, no tip over
    g.CFrame = hrp.CFrame
    g.Parent = hrp
    return g
end

local function AntiAim_ClearGyro()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local g = hrp:FindFirstChild("AnxiumAAGyro")
        if g then pcall(function() g:Destroy() end) end
    end
end

local function AntiAim_Update(dt)
    if not Config.AntiAimEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hrp:IsA("BasePart") then return end

    if hum then
        pcall(function()
            hum.PlatformStand = false
            hum.AutoRotate = false
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
        end)
    end

    local mode = Config.AntiAimMode or "Static"
    local yawOffDeg = Config.AntiAimYaw or 180
    local pitchDeg = math.clamp(Config.AntiAimPitch or -45, -75, 75)
    local pitch = math.rad(pitchDeg)
    dt = dt or 0.016

    -- Base yaw from camera look (true AA: body faces offset from where YOU look)
    local cam = Workspace.CurrentCamera
    local camYaw = 0
    if cam then
        local lv = cam.CFrame.LookVector
        camYaw = math.atan2(-lv.X, -lv.Z)
    end

    if mode == "Jitter" then
        local j = Config.AntiAimJitter or 35
        yawOffDeg = yawOffDeg + (math.random() * 2 - 1) * j
    elseif mode == "Spin" then
        Cache.AntiAimSpinAngle = (Cache.AntiAimSpinAngle or 0) + math.rad(Config.AntiAimSpinSpeed or 720) * dt
        yawOffDeg = math.deg(Cache.AntiAimSpinAngle)
    end

    local targetYaw = camYaw + math.rad(yawOffDeg)
    local pos = hrp.Position
    local vel = hrp.AssemblyLinearVelocity

    -- Force upright orientation every frame (physics games overwrite CFrame otherwise)
    local targetCF = CFrame.new(pos) * CFrame.Angles(0, targetYaw, 0)
    pcall(function()
        hrp.CFrame = targetCF
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        -- keep horizontal velocity, don't kill movement
        hrp.AssemblyLinearVelocity = Vector3.new(vel.X, vel.Y, vel.Z)
    end)

    -- BodyGyro backup (helps when game fights CFrame sets)
    local gyro = AntiAim_EnsureGyro(hrp)
    if gyro then
        gyro.CFrame = targetCF
        gyro.MaxTorque = Vector3.new(0, 12e6, 0)
    end

    -- Upper-body pitch lean only (Neck + Waist) — never pitch the root (that caused floor flop)
    Cache.AntiAimMotorBases = Cache.AntiAimMotorBases or {}
    for _, m in ipairs(char:GetDescendants()) do
        if m:IsA("Motor6D") then
            local n = m.Name
            if n == "Waist" or n == "Neck" then
                if not Cache.AntiAimMotorBases[m] then
                    Cache.AntiAimMotorBases[m] = m.C0
                end
                local base = Cache.AntiAimMotorBases[m]
                local amount = (n == "Neck") and (pitch * 0.9) or (pitch * 0.65)
                pcall(function()
                    m.C0 = base * CFrame.Angles(amount, 0, 0)
                end)
            end
        end
    end
end

local function AntiAim_RestoreMotors()
    if Cache.AntiAimMotorBases then
        for m, base in pairs(Cache.AntiAimMotorBases) do
            if m and m.Parent then
                pcall(function() m.C0 = base end)
            end
        end
        Cache.AntiAimMotorBases = {}
    end
    AntiAim_ClearGyro()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum.AutoRotate = true end) end
    Cache.AntiAimSpinAngle = 0
end

Cache.AimLockTarget = nil

-- Universal character resolver for custom avatars (BlockStrike etc.)
local function GetCharHumanoid(char)
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then return hum end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("Humanoid") then return d end
    end
    return nil
end

local function GetCharRoot(char)
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("HRP") or char:FindFirstChild("Root") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if hrp and hrp:IsA("BasePart") then return hrp end
    if char.PrimaryPart then return char.PrimaryPart end
    local hum = GetCharHumanoid(char)
    if hum and hum.RootPart then return hum.RootPart end
    -- largest BasePart as fallback
    local best, bestVol = nil, 0
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") and d.Transparency < 1 then
            local v = d.Size.X * d.Size.Y * d.Size.Z
            if v > bestVol then bestVol = v; best = d end
        end
    end
    return best
end

local function GetCharHead(char)
    if not char then return nil end
    local head = char:FindFirstChild("Head") or char:FindFirstChild("head") or char:FindFirstChild("Helmet")
    if head and head:IsA("BasePart") then return head end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("BasePart") then
            local n = string.lower(d.Name)
            if n == "head" or n:find("head") or n == "helmet" then return d end
        end
    end
    local root = GetCharRoot(char)
    return root
end

local function GetPlayerCharacter(player)
    if not player then return nil end
    local char = player.Character
    if char and char.Parent then return char end
    -- some games delay Character; try by name in workspace
    local byName = workspace:FindFirstChild(player.Name)
    if byName and byName:IsA("Model") and GetCharHumanoid(byName) then
        return byName
    end
    return char
end

local function IsValidAimTarget(player)
    if not player or player == LocalPlayer then return false end
    if Config.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
        return false
    end
    local char = GetPlayerCharacter(player)
    if not char then return false end
    local humanoid = GetCharHumanoid(char)
    local head = GetCharHead(char)
    if not head then return false end
    if humanoid and humanoid.Health <= 0 then return false end
    if not humanoid then
        local root = GetCharRoot(char)
        if not root then return false end
    end
    return true, head, humanoid
end

-- Screen projection that stays correct when Aspect Ratio stretches the camera
local function WorldToScreen(worldPos)
    local sp, onScreen = Camera:WorldToViewportPoint(worldPos)
    if Config.AspectRatioEnabled then
        local s = Config.AspectRatioValue
        if typeof(s) == "number" and s > 0.05 and math.abs(s - 1) > 0.001 then
            local vp = Camera.ViewportSize
            local cy = vp.Y * 0.5
            -- Inverse of YVector scale so ESP doesn't float when looking up/down
            sp = Vector3.new(sp.X, cy + (sp.Y - cy) / s, sp.Z)
        end
    end
    return sp, onScreen
end

GetClosestPlayerInFOV = function()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then
        Cache.AimLockTarget = nil
        return nil
    end

    local fovCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local fovRadius = Config.FovRadius or 150

    -- Always pick closest-to-crosshair inside FOV (easy to switch targets)
    local closestPlayer = nil
    local shortestScreenDist = math.huge

    for i = 1, #CachedPlayerList do
        local player = CachedPlayerList[i]
        local ok, head = IsValidAimTarget(player)
        if ok then
            local pos, onScreen = WorldToScreen(head.Position)
            if onScreen and pos.Z > 0 then
                local screenDist = (Vector2.new(pos.X, pos.Y) - fovCenter).Magnitude
                if screenDist <= fovRadius and screenDist < shortestScreenDist then
                    shortestScreenDist = screenDist
                    closestPlayer = player
                end
            end
        end
    end

    Cache.AimLockTarget = closestPlayer
    return closestPlayer
end

-- ===================== AIM REDIRECT (stealth) =====================
-- Low-noise silent aim: cache-only hooks, no console spam, humanized aim point,
-- multi-path install, snap fallback when hooks are unavailable.

Cache.SilentAimTarget = nil
Cache.SilentAimPart = nil
Cache.SilentAimPos = nil
Cache._saMode = "none"
Cache._saReady = false
Cache._saSnapUntil = 0

local _saParts = { "Head", "HumanoidRootPart", "UpperTorso", "Torso" }

local function _saChance(p)
    p = math.floor(tonumber(p) or 100)
    if p >= 100 then return true end
    if p <= 0 then return false end
    return math.random() <= (p / 100)
end

-- ===== Team Checker (global teammate detection for shooters) =====
Cache.TeamCache = Cache.TeamCache or {}
local TEAM_STATUS = {
    lobby = true, play = true, playing = true, spectator = true, spectate = true,
    menu = true, waiting = true, neutral = true, none = true, afk = true,
}

local function _rawIsTeammate(player)
    if not player or player == LocalPlayer then return false end

    local myTeam, theirTeam = LocalPlayer.Team, player.Team
    if myTeam and theirTeam and myTeam == theirTeam then
        local n = string.lower(tostring(myTeam.Name or ""))
        if not TEAM_STATUS[n] then
            return true
        end
    end

    if LocalPlayer.TeamColor and player.TeamColor and LocalPlayer.TeamColor == player.TeamColor then
        local cn = string.lower(tostring(LocalPlayer.TeamColor.Name or ""))
        if cn ~= "white" and cn ~= "mediumstonegrey" and cn ~= "ghostgrey" and cn ~= "black" then
            local tn = myTeam and string.lower(tostring(myTeam.Name or "")) or ""
            if not TEAM_STATUS[tn] then return true end
        end
    end

    -- Common shooter attributes / values
    local attrKeys = { "Team", "TeamName", "Faction", "Side", "TeamId", "Squad", "Party", "Alliance" }
    for _, key in ipairs(attrKeys) do
        local ok1, a = pcall(function() return LocalPlayer:GetAttribute(key) end)
        local ok2, b = pcall(function() return player:GetAttribute(key) end)
        if ok1 and ok2 and a ~= nil and b ~= nil and a == b then
            local s = string.lower(tostring(a))
            if not TEAM_STATUS[s] and a ~= "" and a ~= 0 then
                return true
            end
        end
    end

    -- Folder/value under player
    local ok, same = pcall(function()
        local myVal = LocalPlayer:FindFirstChild("Team") or LocalPlayer:FindFirstChild("TeamValue")
            or LocalPlayer:FindFirstChild("Faction")
        local theirVal = player:FindFirstChild("Team") or player:FindFirstChild("TeamValue")
            or player:FindFirstChild("Faction")
        if myVal and theirVal then
            local a = myVal:IsA("ValueBase") and myVal.Value or myVal.Name
            local b = theirVal:IsA("ValueBase") and theirVal.Value or theirVal.Name
            if a ~= nil and b ~= nil and a == b then
                local s = string.lower(tostring(a))
                if not TEAM_STATUS[s] then return true end
            end
        end
        return false
    end)
    if ok and same then return true end

    -- Character attribute
    local myChar, theirChar = LocalPlayer.Character, player.Character
    if myChar and theirChar then
        local okc, samec = pcall(function()
            local a = myChar:GetAttribute("Team") or myChar:GetAttribute("TeamName") or myChar:GetAttribute("Faction")
            local b = theirChar:GetAttribute("Team") or theirChar:GetAttribute("TeamName") or theirChar:GetAttribute("Faction")
            if a ~= nil and b ~= nil and a == b then
                local s = string.lower(tostring(a))
                if not TEAM_STATUS[s] then return true end
            end
            return false
        end)
        if okc and samec then return true end
    end

    return false
end

-- Cached teammate check (refresh ~0.35s)
IsTeammate = function(player)
    if not player or player == LocalPlayer then return false end
    local now = tick()
    local ent = Cache.TeamCache[player]
    if ent and (now - ent.t) < 0.35 then
        return ent.v
    end
    local v = _rawIsTeammate(player)
    Cache.TeamCache[player] = { t = now, v = v }
    return v
end

-- Silent-aim path: respects SilentTeamCheck OR global Team Checker
local function _saTeammate(player)
    if Config.TeamCheckerEnabled then
        return IsTeammate(player)
    end
    if not Config.SilentTeamCheck then return false end
    return IsTeammate(player)
end

-- Should combat/ESP ignore this player?
local function ShouldIgnorePlayer(player)
    if not player or player == LocalPlayer then return true end
    if Config.TeamCheckerEnabled and IsTeammate(player) then
        return true
    end
    return false
end

local function _saVisible(player, part)
    if not Config.SilentVisibleCheck then return true end
    if not part or not LocalPlayer.Character then return true end
    local origin = Camera.CFrame.Position
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { LocalPlayer.Character }
    params.IgnoreWater = true
    local result = Workspace:Raycast(origin, part.Position - origin, params)
    if not result then return true end
    return result.Instance and player.Character and result.Instance:IsDescendantOf(player.Character)
end

local function _saPart(character)
    if not character then return nil end
    local mode = Config.SilentTargetPart or "Head"
    if mode == "Random" then
        local n = _saParts[math.random(1, #_saParts)]
        local p = character:FindFirstChild(n)
        if p and p:IsA("BasePart") then return p end
    else
        local p = character:FindFirstChild(mode)
        if p and p:IsA("BasePart") then return p end
    end
    for _, n in ipairs(_saParts) do
        local p = character:FindFirstChild(n)
        if p and p:IsA("BasePart") then return p end
    end
    return GetCharHead(character) or GetCharRoot(character)
end

local function _saHumanize(pos, part)
    if not Config.SilentHumanize then return pos end
    -- small random offset inside hitbox (avoids perfect-center flags)
    local s = 0.12
    if part and part:IsA("BasePart") then
        s = math.min(0.22, math.max(0.06, math.min(part.Size.X, part.Size.Y, part.Size.Z) * 0.15))
    end
    return pos + Vector3.new(
        (math.random() - 0.5) * 2 * s,
        (math.random() - 0.5) * 1.2 * s,
        (math.random() - 0.5) * 2 * s
    )
end

local function _saRefresh()
    if not Config.SilentAimEnabled then
        Cache.SilentAimTarget = nil
        Cache.SilentAimPart = nil
        Cache.SilentAimPos = nil
        return
    end
    local mousePos = UserInputService:GetMouseLocation()
    local fov = Config.SilentFovRadius or 130
    local bestP, bestPl, bestPos, bestD = nil, nil, nil, math.huge
    for i = 1, #CachedPlayerList do
        local plr = CachedPlayerList[i]
        if plr ~= LocalPlayer and not _saTeammate(plr) then
            local ok = IsValidAimTarget(plr)
            if ok then
                local char = GetPlayerCharacter(plr)
                local part = _saPart(char)
                if part and part:IsA("BasePart") and _saVisible(plr, part) then
                    local wp = part.Position
                    if part.Name == "HumanoidRootPart" or part.Name == "Torso" or part.Name == "UpperTorso" then
                        wp = wp + Vector3.new(0, 0.35, 0)
                    end
                    if Config.SilentPrediction then
                        local vel = Vector3.zero
                        pcall(function() vel = part.AssemblyLinearVelocity or part.Velocity or Vector3.zero end)
                        wp = wp + vel * (Config.SilentPredictionAmount or 0.165)
                    end
                    local sp, onScreen = Camera:WorldToViewportPoint(wp)
                    if onScreen and sp.Z > 0 then
                        local d = (Vector2.new(sp.X, sp.Y) - mousePos).Magnitude
                        if d <= fov and d < bestD then
                            bestD, bestP, bestPl, bestPos = d, part, plr, wp
                        end
                    end
                end
            end
        end
    end
    if bestPos then bestPos = _saHumanize(bestPos, bestP) end
    Cache.SilentAimTarget = bestPl
    Cache.SilentAimPart = bestP
    Cache.SilentAimPos = bestPos
end

-- public aliases used elsewhere
local function Silent_GetClosestTarget()
    _saRefresh()
    return Cache.SilentAimPart, Cache.SilentAimTarget, Cache.SilentAimPos
end
local function Silent_CalculateChance(p) return _saChance(p) end
local function Silent_GetDirection(origin, position)
    local diff = position - origin
    if diff.Magnitude < 1e-4 then return Camera.CFrame.LookVector * 1000 end
    return diff.Unit * math.max(diff.Magnitude, 1000)
end
local function Silent_GetPredictedCFrame(part, pos)
    if pos then return CFrame.new(pos) end
    if not part then return nil end
    return part.CFrame
end

local function _saHit()
    if not Config.SilentAimEnabled then return nil, nil end
    if not _saChance(Config.SilentHitChance or 100) then return nil, nil end
    local part, pos = Cache.SilentAimPart, Cache.SilentAimPos
    if part and part.Parent and pos then return part, pos end
    _saRefresh()
    return Cache.SilentAimPart, Cache.SilentAimPos
end

local function _saWrap(fn)
    if typeof(newcclosure) == "function" then
        local ok, w = pcall(newcclosure, fn)
        if ok and w then return w end
    end
    return fn
end

local function _saCaller()
    if typeof(checkcaller) == "function" then
        local ok, r = pcall(checkcaller)
        if ok then return r end
    end
    return false
end

-- SNAP / hybrid for GunFramework (FPS Flick etc.)
-- These games often ignore Raycast hooks and read Camera.CFrame on shot.
Cache._saMouseDown = false

local function _saAimCameraAtTarget()
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) ~= "table" or not cfg.SilentAimEnabled then return false end
    pcall(_saRefresh)
    local pos = Cache and Cache.SilentAimPos
    if not pos then
        local _, p2 = _saHit()
        pos = p2 or (Cache and Cache.SilentAimPos)
    end
    if not pos then return false end
    local cam = Workspace.CurrentCamera or Camera
    if not cam then return false end
    pcall(function()
        cam.CFrame = CFrame.lookAt(cam.CFrame.Position, pos)
    end)
    return true
end

local function _saSnap()
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) ~= "table" or not cfg.SilentAimEnabled then return end
    if _saAimCameraAtTarget() then
        if Cache then
            Cache._saSnapUntil = tick() + 0.07 + math.random() * 0.02
        end
    end
end

-- expose for Triggerbot / other systems
if Cache then
    Cache._saSnap = _saSnap
    Cache._saAimCameraAtTarget = _saAimCameraAtTarget
    Cache._saRefresh = _saRefresh
end

-- Only aim camera while REAL mouse is held, or during a brief snap window (not continuous track)
local function _saShouldAimCamera()
    if type(Cache) ~= "table" then return false end
    -- short one-shot snap (triggerbot / single click)
    if tick() < (Cache._saSnapUntil or 0) then return true end
    -- continuous only if player actually holds LMB (not synthetic triggerbot flag alone)
    local realDown = false
    pcall(function()
        realDown = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
    end)
    return realDown == true
end

pcall(function()
    pcall(function() RunService:UnbindFromRenderStep("AnxiumSA") end)
    RunService:BindToRenderStep("AnxiumSA", Enum.RenderPriority.Camera.Value - 1, function()
        local cfg = rawget(_G, "Config") or Config
        if type(cfg) ~= "table" or not cfg.SilentAimEnabled then return end
        if _saShouldAimCamera() then
            _saAimCameraAtTarget()
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    Cache.VisFrame = (Cache.VisFrame or 0) + 1
    local visFrame = Cache.VisFrame
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) ~= "table" or not cfg.SilentAimEnabled then return end
    if _saShouldAimCamera() then
        _saAimCameraAtTarget()
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if type(Cache) == "table" then Cache._saMouseDown = true end
        _saSnap()
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if type(Cache) == "table" then Cache._saMouseDown = false end
    end
end)

local function _saToolSnap(char)
    if not char then return end
    local function hook(tool)
        if not tool:IsA("Tool") then return end
        tool.Activated:Connect(function()
            -- short snap only; continuous track only while real LMB held
            _saSnap()
        end)
    end
    for _, c in ipairs(char:GetChildren()) do if c:IsA("Tool") then hook(c) end end
    char.ChildAdded:Connect(function(c) if c:IsA("Tool") then task.defer(hook, c) end end)
end
if LocalPlayer.Character then task.spawn(_saToolSnap, LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(c) task.defer(_saToolSnap, c) end)

local function _saInstallMM(hmm)
    local oldNamecall
    oldNamecall = hmm(game, "__namecall", _saWrap(function(...)
        local method = (typeof(getnamecallmethod) == "function" and getnamecallmethod()) or ""
        local args = { ... }
        local self = args[1]
        local ml = string.lower(tostring(method))
        if Config.SilentAimEnabled and not _saCaller() then
            local hitPart, hitPos = _saHit()
            if hitPart and hitPos then
                if ml == "raycast" and (self == workspace or self == Workspace) and typeof(args[2]) == "Vector3" then
                    args[3] = Silent_GetDirection(args[2], hitPos)
                    return oldNamecall(unpack(args))
                end
                if (ml == "findpartonray" or ml == "findpartonraywithignorelist" or ml == "findpartonraywithwhitelist") and typeof(args[2]) == "Ray" then
                    local r = args[2]
                    args[2] = Ray.new(r.Origin, Silent_GetDirection(r.Origin, hitPos))
                    return oldNamecall(unpack(args))
                end
                if (ml == "viewportpointtoray" or ml == "screenpointtoray") and self == Camera then
                    local o = Camera.CFrame.Position
                    return Ray.new(o, Silent_GetDirection(o, hitPos))
                end
            end
        end
        return oldNamecall(...)
    end))

    local Mouse = LocalPlayer:GetMouse()
    local oldIndex
    oldIndex = hmm(game, "__index", _saWrap(function(self, index)
        if Config.SilentAimEnabled and not _saCaller() and self == Mouse then
            local hitPart, hitPos = _saHit()
            if hitPart and hitPos then
                local idx = string.lower(tostring(index or ""))
                if idx == "target" then return hitPart end
                if idx == "hit" then return Silent_GetPredictedCFrame(hitPart, hitPos) end
                if idx == "unitray" then
                    local o = Camera.CFrame.Position
                    return Ray.new(o, (hitPos - o).Unit)
                end
            end
        end
        return oldIndex(self, index)
    end))
end

local function _saInstall()
    if Cache._saReady then return end

    -- resolve hmm quietly
    local hmm = nil
    pcall(function()
        if typeof(hookmetamethod) == "function" then hmm = hookmetamethod
        elseif syn and typeof(syn.hook_metamethod) == "function" then hmm = syn.hook_metamethod
        elseif typeof(getgenv) == "function" then
            local g = getgenv()
            if g then hmm = g.hookmetamethod or g.hook_metamethod end
        end
    end)

    if hmm then
        local ok = pcall(function() _saInstallMM(hmm) end)
        if ok then
            Cache._saReady = true
            Cache._saMode = "mm"
            pcall(function()
                if typeof(hookfunction) == "function" then
                    local old = Workspace.Raycast
                    hookfunction(Workspace.Raycast, _saWrap(function(self, origin, direction, params)
                        if Config.SilentAimEnabled and not _saCaller() then
                            local _, hitPos = _saHit()
                            if hitPos and typeof(origin) == "Vector3" then
                                direction = Silent_GetDirection(origin, hitPos)
                            end
                        end
                        return old(self, origin, direction, params)
                    end))
                end
            end)
            return
        end
    end

    -- raw metatable path (quiet)
    local okRaw = pcall(function()
        if typeof(getrawmetatable) ~= "function" then error("x") end
        local mt = getrawmetatable(game)
        local oldNc, oldIdx = mt.__namecall, mt.__index
        if typeof(setreadonly) == "function" then setreadonly(mt, false) end
        local Mouse = LocalPlayer:GetMouse()
        mt.__namecall = _saWrap(function(...)
            local method = (typeof(getnamecallmethod) == "function" and getnamecallmethod()) or ""
            local args = { ... }
            local self = args[1]
            local ml = string.lower(tostring(method))
            if Config.SilentAimEnabled and not _saCaller() then
                local hitPart, hitPos = _saHit()
                if hitPart and hitPos then
                    if ml == "raycast" and (self == workspace or self == Workspace) and typeof(args[2]) == "Vector3" then
                        args[3] = Silent_GetDirection(args[2], hitPos)
                        return oldNc(unpack(args))
                    end
                    if (ml == "findpartonray" or ml == "findpartonraywithignorelist" or ml == "findpartonraywithwhitelist") and typeof(args[2]) == "Ray" then
                        local r = args[2]
                        args[2] = Ray.new(r.Origin, Silent_GetDirection(r.Origin, hitPos))
                        return oldNc(unpack(args))
                    end
                    if (ml == "viewportpointtoray" or ml == "screenpointtoray") and self == Camera then
                        local o = Camera.CFrame.Position
                        return Ray.new(o, Silent_GetDirection(o, hitPos))
                    end
                end
            end
            return oldNc(...)
        end)
        mt.__index = _saWrap(function(self, index)
            if Config.SilentAimEnabled and not _saCaller() and self == Mouse then
                local hitPart, hitPos = _saHit()
                if hitPart and hitPos then
                    local idx = string.lower(tostring(index or ""))
                    if idx == "target" then return hitPart end
                    if idx == "hit" then return Silent_GetPredictedCFrame(hitPart, hitPos) end
                    if idx == "unitray" then
                        local o = Camera.CFrame.Position
                        return Ray.new(o, (hitPos - o).Unit)
                    end
                end
            end
            return oldIdx(self, index)
        end)
        if typeof(setreadonly) == "function" then setreadonly(mt, true) end
    end)
    if okRaw then
        Cache._saReady = true
        Cache._saMode = "raw"
        return
    end

    -- hookfunction only
    local okHf = pcall(function()
        if typeof(hookfunction) ~= "function" then error("x") end
        local old = Workspace.Raycast
        hookfunction(Workspace.Raycast, _saWrap(function(self, origin, direction, params)
            if Config.SilentAimEnabled and not _saCaller() then
                local _, hitPos = _saHit()
                if hitPos and typeof(origin) == "Vector3" then
                    direction = Silent_GetDirection(origin, hitPos)
                end
            end
            return old(self, origin, direction, params)
        end))
    end)
    if okHf then
        Cache._saReady = true
        Cache._saMode = "hf"
        return
    end

    -- snap-only (safest on strict AC when hooks are monitored)
    Cache._saReady = true
    Cache._saMode = "snap"
end

-- delayed quiet install (no prints / warns)
task.spawn(function()
    task.wait(0.4 + math.random() * 0.4)
    pcall(_saInstall)
    if not Cache._saReady then
        task.wait(0.6)
        pcall(_saInstall)
        Cache._saReady = true
        if Cache._saMode == "none" then Cache._saMode = "snap" end
    end
end)

-- throttle target refresh (stealth + FPS)
local _saAcc = 0
RunService.Heartbeat:Connect(function(dt)
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) ~= "table" or not cfg.SilentAimEnabled then
        if type(Cache) == "table" then
            Cache.SilentAimTarget = nil
            Cache.SilentAimPart = nil
            Cache.SilentAimPos = nil
        end
        return
    end
    _saAcc = _saAcc + (dt or 0)
    local interval = (cfg.SilentStealthMode and 0.03) or 0.016
    if _saAcc >= interval then
        _saAcc = 0
        pcall(_saRefresh)
    end
end)

GetPartPos = function(char, partName)
    local part = char:FindFirstChild(partName)
    if part then
        local vec, on = WorldToScreen(part.Position)
        if on and vec.Z > 0.1 then return Vector2.new(vec.X, vec.Y) end
    end
    return nil
end

GetPlayerByName = function(targetName)
    if targetName == "" then return nil end
    targetName = targetName:lower()
    for _, p in ipairs(CachedPlayerList) do
        if p ~= LocalPlayer then
            if p.Name:lower():sub(1, #targetName) == targetName or p.DisplayName:lower():sub(1, #targetName) == targetName then
                return p
            end
        end
    end
    return nil
end

local TriggerbotLastShot = 0

local function Triggerbot_GetTargetUnderCrosshair()
    if not Camera then return nil end
    local myChar = LocalPlayer.Character
    if not myChar then return nil end

    RaycastParamsTriggerbot.FilterDescendantsInstances = { myChar }

    local result = Workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 1000, RaycastParamsTriggerbot)
    if not result or not result.Instance then return nil end

    local hit = result.Instance
    for _, player in ipairs(CachedPlayerList) do
        if player ~= LocalPlayer and player.Character and hit:IsDescendantOf(player.Character) then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then return player end
        end
    end
    return nil
end

-- When Silent Aim is on: trigger if enemy is inside Silent FOV (not only exact crosshair)
local function Triggerbot_GetSilentFovTarget()
    if not Config or not Config.SilentAimEnabled then return nil end
    -- prefer cached silent target (refreshed every frame)
    local t = Cache and Cache.SilentAimTarget
    if t and t ~= LocalPlayer then
        local ok = true
        pcall(function()
            local char = t.Character
            if not char then ok = false return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health <= 0 then ok = false end
        end)
        if ok then return t end
    end
    -- live refresh fallback
    if typeof(Silent_GetClosestTarget) == "function" then
        local part, plr = nil, nil
        pcall(function()
            part, plr = Silent_GetClosestTarget()
        end)
        if plr then return plr end
    end
    return nil
end

local function Triggerbot_Click()
    if typeof(mouse1press) == "function" and typeof(mouse1release) == "function" then
        mouse1press()
        task.delay(0.035, function() pcall(mouse1release) end)
        return true
    end
    if typeof(mouse1click) == "function" then
        mouse1click()
        return true
    end
    return false
end

RunService.Heartbeat:Connect(function()
    if not Config then return end

    if Config.TriggerbotEnabled then
        -- 1) classic: enemy under crosshair
        local target = Triggerbot_GetTargetUnderCrosshair()
        -- 2) silent-aim linked: enemy inside Silent FOV
        if not target then
            target = Triggerbot_GetSilentFovTarget()
        end
        if target then
            local now = tick()
            local delaySec = (Config.TriggerbotDelay or 0) / 1000
            if now - TriggerbotLastShot >= math.max(delaySec, 0.02) then
                -- brief camera snap only (does NOT enable continuous tracking)
                if Config.SilentAimEnabled and Cache and Cache.SilentAimTarget == target then
                    pcall(function()
                        local aim = Cache._saAimCameraAtTarget
                        if aim then aim() end
                    end)
                    -- very short window so gun samples camera, then release — no aimbot follow
                    Cache._saSnapUntil = tick() + 0.06
                end
                if Triggerbot_Click() then
                    TriggerbotLastShot = now
                    if Cache then
                        Cache.LastShotTime = now
                        Cache.LastShotTarget = target
                        Cache.RecentDamageTargets[target] = now
                    end
                    pcall(function()
                        if typeof(MarkRecentTarget) == "function" then MarkRecentTarget(target) end
                    end)
                end
            end
        end
    end

    if Config.TargetFlingEnabled then
        local targetPlayer = GetPlayerByName(Config.TargetFlingName)
        local myChar = LocalPlayer.Character

        if targetPlayer and targetPlayer.Character and myChar then
            local myHrp = myChar:FindFirstChild("HumanoidRootPart")
            local targetHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

            if myHrp and targetHrp then
                myHrp.AssemblyAngularVelocity = Vector3.new(0, 99999, 0)
                myHrp.AssemblyLinearVelocity = Vector3.zero
                myHrp.CFrame = targetHrp.CFrame

                for _, part in ipairs(myChar:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end

    if Config.BHopEnabled then
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if humanoid and hrp and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                if humanoid.FloorMaterial ~= Enum.Material.Air then
                    humanoid.Jump = true
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

                    if humanoid.MoveDirection.Magnitude > 0 then
                        local impulse = humanoid.MoveDirection.Unit * Config.BHopPower
                        local currentY = hrp.AssemblyLinearVelocity.Y
                        local jumpY = currentY > 0 and currentY or 35
                        hrp.AssemblyLinearVelocity = Vector3.new(impulse.X, jumpY, impulse.Z)
                    end
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    Cache.FrameN = (Cache.FrameN or 0) + 1
    local frameN = Cache.FrameN
    Camera = Workspace.CurrentCamera or Camera

    if not Config then return end
    pcall(function()
        if Cache and typeof(Cache.UpdateBulletTracers) == "function" then
            Cache.UpdateBulletTracers()
        elseif typeof(UpdateBulletTracers) == "function" then
            UpdateBulletTracers()
        end
    end)
    pcall(function()
        if Cache and typeof(Cache.UpdateKillFX) == "function" then
            Cache.UpdateKillFX()
        elseif typeof(UpdateKillFX) == "function" then
            UpdateKillFX()
        end
    end)

    local vp = Camera.ViewportSize
    local screenCenter = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHead = myChar and myChar:FindFirstChild("Head")

    local currentTarget = nil
    if Config.AimEnabled or Config.TargetHudEnabled then
        currentTarget = GetClosestPlayerInFOV()
    else
        Cache.AimLockTarget = nil
    end

    local orbitTargetHrp = nil
    if Config.TargetHudEnabled and currentTarget and currentTarget.Character then
        local targetChar = currentTarget.Character
        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
        local targetHum = targetChar:FindFirstChildOfClass("Humanoid")

        if targetHrp and targetHum and targetHum.Health > 0 then
            orbitTargetHrp = targetHrp
            ShowTargetHud()

            -- Avatar photo
            local uid = currentTarget.UserId
            if Cache.TargetHudLastUserId ~= uid then
                Cache.TargetHudLastUserId = uid
                ApplyTargetAvatar(uid)
            end
            -- Force avatar fully visible (tweens sometimes leave it transparent)
            TargetAvatar.ImageTransparency = 0
            if TargetAvatar.Image == "" or TargetAvatar.Image == nil then
                ApplyTargetAvatar(uid)
            end

            TargetNameLabel.Text = currentTarget.DisplayName or currentTarget.Name

            local hp = math.clamp(targetHum.Health, 0, targetHum.MaxHealth)
            local maxHp = math.max(targetHum.MaxHealth, 1)

            TargetHealthFill.Size = UDim2.new(hp / maxHp, 0, 1, 0)
            TargetHealthFill.BackgroundColor3 = Config.Color_TargetHud or Theme.Accent
            if AvatarStroke then AvatarStroke.Color = Config.Color_TargetHud or Theme.Accent end

            local distStuds = myHrp and (targetHrp.Position - myHrp.Position).Magnitude or 0
            TargetInfoLabel.Text = math.floor(hp) .. " / " .. math.floor(maxHp) .. "  ·  " .. math.floor(distStuds * 0.28) .. "m"
        else
            HideTargetHud()
            Cache.TargetHudLastUserId = nil
        end
    else
        HideTargetHud()
    end

    if not orbitTargetHrp and Config.OrbitOrbsEnabled then orbitTargetHrp = myHrp end

    if orbitTargetHrp then
        if not OrbitPart1.Parent then OrbitPart1.Parent = Workspace end
        if not OrbitPart2.Parent then OrbitPart2.Parent = Workspace end

        if frameN % 30 == 0 then local ocol = Config.Color_Orbit or Theme.Accent; OrbTrail1.Color = ColorSequence.new(ocol); OrbTrail2.Color = ColorSequence.new(ocol) end
        Cache.OrbitAngle = (Cache.OrbitAngle + Config.OrbitSpeedValue) % 360
        local rad = math.rad(Cache.OrbitAngle)
        local heightWave1 = math.sin(rad * 2) * 0.6
        local heightWave2 = math.cos(rad * 2) * 0.6

        local pos1 = orbitTargetHrp.Position + Vector3.new(math.cos(rad) * 3.5, heightWave1, math.sin(rad) * 3.5)
        local pos2 = orbitTargetHrp.Position + Vector3.new(math.cos(rad + math.pi) * 3.5, heightWave2, math.sin(rad + math.pi) * 3.5)

        OrbitPart1.CFrame = CFrame.new(pos1, pos1 + Vector3.new(-math.sin(rad), 0, math.cos(rad)))
        OrbitPart2.CFrame = CFrame.new(pos2, pos2 + Vector3.new(-math.sin(rad + math.pi) * 3.5, heightWave2, math.sin(rad + math.pi) * 3.5))
    else
        if OrbitPart1.Parent then OrbitPart1.Parent = nil end
        if OrbitPart2.Parent then OrbitPart2.Parent = nil end
    end

    -- ========== STABLE BOX + HEALTHBAR ESP ==========
    local needBoxDraw = Config.BoxEspEnabled or Config.HealthbarEspEnabled
    for player, boxData in pairs(Cache.Boxes) do
        pcall(function()
            local hbData = Cache.Healthbars[player]

            -- Team Checker: no ESP on teammates
            if Config.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
                if boxData then
                    if boxData.Outline then boxData.Outline.Visible = false end
                    if boxData.Box then boxData.Box.Visible = false end
                    if boxData.Fill then boxData.Fill.Visible = false end
                    if boxData.Gradients then
                        for _, g in pairs(boxData.Gradients) do if g then g.Visible = false end end
                    end
                    if boxData.Corners then
                        for _, ln in pairs(boxData.Corners) do if ln then ln.Visible = false end end
                    end
                end
                if hbData then
                    if hbData.Bg then hbData.Bg.Visible = false end
                    if hbData.Fill then hbData.Fill.Visible = false end
                end
                return
            end

            local function hideBox()
                if boxData then
                    if boxData.Outline then boxData.Outline.Visible = false end
                    if boxData.Box then boxData.Box.Visible = false end
                    if boxData.Fill then boxData.Fill.Visible = false end
                    if boxData.Gradients then
                        for _, g in pairs(boxData.Gradients) do if g then g.Visible = false end end
                    end
                    if boxData.Corners then
                        for i = 1, 8 do
                            local ln = boxData.Corners[i]
                            if ln then ln.Visible = false end
                        end
                    end
                    -- reset smoothing so next show doesn't lerp from old off-screen position
                    boxData.LastMinX = nil
                    boxData.LastMinY = nil
                    boxData.LastW = nil
                    boxData.LastH = nil
                end
                if hbData then
                    if hbData.Bg then hbData.Bg.Visible = false end
                    if hbData.Fill then hbData.Fill.Visible = false end
                end
            end

            if not needBoxDraw then
                hideBox()
                return
            end

            local char = (GetPlayerCharacter and GetPlayerCharacter(player)) or player.Character
            if not char or not boxData then hideBox() return end
            local hum = GetCharHumanoid and GetCharHumanoid(char) or char:FindFirstChildOfClass("Humanoid")
            local hrp = GetCharRoot and GetCharRoot(char) or char:FindFirstChild("HumanoidRootPart")
            local head = GetCharHead and GetCharHead(char) or char:FindFirstChild("Head")
            if not (hrp and head) then
                hideBox()
                return
            end
            if hum and hum.Health <= 0 then
                hideBox()
                return
            end

            -- ============================================================
            -- ROCK-SOLID 2D BOX (world AABB → screen)
            -- Projects fixed world-space box around HRP (no foot anim, no lookDot)
            -- Stays locked on character when rotating camera / using aimbot
            -- ============================================================
            local hrpPos = hrp.Position
            local isR15 = char:FindFirstChild("UpperTorso") ~= nil

            -- Fixed body AABB relative to HRP (ignores limb animation jitter)
            local center = hrpPos + Vector3.new(0, isR15 and 0.55 or 0.35, 0)
            local half = Vector3.new(
                isR15 and 1.35 or 1.25,
                isR15 and 3.15 or 2.95,
                isR15 and 1.35 or 1.25
            )

            local minX, maxX = math.huge, -math.huge
            local minY, maxY = math.huge, -math.huge
            local anyFront = false
            local behindCount = 0

            -- 8 corners of axis-aligned box in WORLD space
            for ox = -1, 1, 2 do
                for oy = -1, 1, 2 do
                    for oz = -1, 1, 2 do
                        local wp = center + Vector3.new(half.X * ox, half.Y * oy, half.Z * oz)
                        local sp = WorldToScreen(wp)
                        if sp.Z > 0.05 then
                            anyFront = true
                            if sp.X < minX then minX = sp.X end
                            if sp.X > maxX then maxX = sp.X end
                            if sp.Y < minY then minY = sp.Y end
                            if sp.Y > maxY then maxY = sp.Y end
                        else
                            behindCount = behindCount + 1
                        end
                    end
                end
            end

            if not anyFront then
                hideBox()
                return
            end

            -- Fallback if too few corners in front: use head + HRP-down
            if behindCount >= 6 or maxX - minX < 2 or maxY - minY < 2 then
                local topSP = WorldToScreen(head.Position + Vector3.new(0, 0.85, 0))
                local botSP = WorldToScreen(hrpPos - Vector3.new(0, isR15 and 3.0 or 2.8, 0))
                local midSP = WorldToScreen(hrpPos)
                if topSP.Z < 0.05 and botSP.Z < 0.05 then
                    hideBox()
                    return
                end
                local topY = topSP.Z > 0.05 and topSP.Y or (midSP.Y - 40)
                local botY = botSP.Z > 0.05 and botSP.Y or (midSP.Y + 40)
                if topY > botY then topY, botY = botY, topY end
                local cx = midSP.Z > 0.05 and midSP.X or ((topSP.X + botSP.X) * 0.5)
                local h = math.max(botY - topY, 8)
                local w = h * 0.55
                minX, maxX = cx - w * 0.5, cx + w * 0.5
                minY, maxY = topY, botY
            end

            local width = maxX - minX
            local height = maxY - minY
            if height < 4 or height > 3000 or width < 2 or width > 3000 then
                hideBox()
                return
            end

            -- Small padding so box doesn't clip character
            local padX = math.clamp(width * 0.06, 1, 6)
            local padY = math.clamp(height * 0.03, 1, 5)
            minX = minX - padX
            minY = minY - padY
            width = width + padX * 2
            height = height + padY * 2

            local boxPos = Vector2.new(minX, minY)
            local style = Config.EspBoxStyle or "Full"
            local col = Config.Color_BoxEsp or Theme.Accent
            if Config.BoxEspEnabled then
                if style == "Corner" and boxData.Corners then
                    if boxData.Outline then boxData.Outline.Visible = false end
                    if boxData.Box then boxData.Box.Visible = false end
                    if boxData.Fill then boxData.Fill.Visible = false end
                    if boxData.Gradients then
                        for _, g in pairs(boxData.Gradients) do if g then g.Visible = false end end
                    end

                    local cornerLen = math.clamp(math.min(width, height) * 0.22, 6, 18)
                    local x1, y1 = minX, minY
                    local x2, y2 = minX + width, minY + height
                    local c = boxData.Corners

                    c[1].From = Vector2.new(x1, y1); c[1].To = Vector2.new(x1 + cornerLen, y1); c[1].Color = col; c[1].Visible = true
                    c[2].From = Vector2.new(x1, y1); c[2].To = Vector2.new(x1, y1 + cornerLen); c[2].Color = col; c[2].Visible = true
                    c[3].From = Vector2.new(x2, y1); c[3].To = Vector2.new(x2 - cornerLen, y1); c[3].Color = col; c[3].Visible = true
                    c[4].From = Vector2.new(x2, y1); c[4].To = Vector2.new(x2, y1 + cornerLen); c[4].Color = col; c[4].Visible = true
                    c[5].From = Vector2.new(x1, y2); c[5].To = Vector2.new(x1 + cornerLen, y2); c[5].Color = col; c[5].Visible = true
                    c[6].From = Vector2.new(x1, y2); c[6].To = Vector2.new(x1, y2 - cornerLen); c[6].Color = col; c[6].Visible = true
                    c[7].From = Vector2.new(x2, y2); c[7].To = Vector2.new(x2 - cornerLen, y2); c[7].Color = col; c[7].Visible = true
                    c[8].From = Vector2.new(x2, y2); c[8].To = Vector2.new(x2, y2 - cornerLen); c[8].Color = col; c[8].Visible = true
                else
                    -- Full style: colored outline + gradient fill inside
                    if boxData.Corners then
                        for _, ln in pairs(boxData.Corners) do if ln then ln.Visible = false end end
                    end
                    local fillCol = Config.Color_BoxEspFill or Color3.fromRGB(80, 40, 160)
                    -- Outline = darkened chosen color (never pure black unless user chose black)
                    local outlineCol = Color3.new(
                        math.clamp(col.R * 0.22, 0, 1),
                        math.clamp(col.G * 0.22, 0, 1),
                        math.clamp(col.B * 0.22, 0, 1)
                    )
                    if boxData.Outline then
                        boxData.Outline.Size = Vector2.new(width, height)
                        boxData.Outline.Position = boxPos
                        boxData.Outline.Color = outlineCol
                        boxData.Outline.Thickness = 2.5
                        boxData.Outline.Visible = true
                    end
                    if boxData.Box then
                        boxData.Box.Size = Vector2.new(width, height)
                        boxData.Box.Position = boxPos
                        boxData.Box.Color = col
                        boxData.Box.Thickness = 1.4
                        boxData.Box.Visible = true
                    end
                    -- Soft base fill + gradient (only if Box Fill Gradient enabled)
                    if Config.BoxFillGradientEnabled then
                        if boxData.Fill then
                            boxData.Fill.Size = Vector2.new(width, height)
                            boxData.Fill.Position = boxPos
                            boxData.Fill.Color = col
                            boxData.Fill.Transparency = 0.85
                            boxData.Fill.Visible = true
                        end
                        if boxData.Gradients then
                            local steps = #boxData.Gradients
                            if steps < 1 then steps = 1 end
                            local stripH = height / steps
                            for i, g in ipairs(boxData.Gradients) do
                                if g then
                                    local t = (i - 1) / math.max(steps - 1, 1)
                                    local c = col:Lerp(fillCol, t)
                                    g.Size = Vector2.new(math.max(width - 2, 1), math.max(stripH + 0.5, 1))
                                    g.Position = Vector2.new(boxPos.X + 1, boxPos.Y + (i - 1) * stripH)
                                    g.Color = c
                                    g.Transparency = 0.55 + t * 0.25
                                    g.Visible = true
                                end
                            end
                        end
                    else
                        if boxData.Fill then boxData.Fill.Visible = false end
                        if boxData.Gradients then
                            for _, g in pairs(boxData.Gradients) do if g then g.Visible = false end end
                        end
                    end
                end
            else
                -- Only hide the box drawings, keep healthbar logic below
                if boxData.Outline then boxData.Outline.Visible = false end
                if boxData.Box then boxData.Box.Visible = false end
                if boxData.Fill then boxData.Fill.Visible = false end
                if boxData.Gradients then
                    for _, g in pairs(boxData.Gradients) do if g then g.Visible = false end end
                end
                if boxData.Corners then
                    for _, ln in pairs(boxData.Corners) do if ln then ln.Visible = false end end
                end
            end

            if Config.HealthbarEspEnabled and hbData and hbData.Bg and hbData.Fill then
                local barWidth = 3
                local barPos = Vector2.new(minX - barWidth - 4, minY)
                local healthPct = math.clamp(hum.Health / math.max(hum.MaxHealth, 1), 0, 1)
                local healthHeight = height * healthPct

                hbData.Bg.Size = Vector2.new(barWidth, height)
                hbData.Bg.Position = barPos
                hbData.Bg.Visible = true

                hbData.Fill.Size = Vector2.new(barWidth, healthHeight)
                hbData.Fill.Position = Vector2.new(barPos.X, barPos.Y + (height - healthHeight))
                hbData.Fill.Color = Color3.fromRGB(255, 40, 40):Lerp(Color3.fromRGB(40, 255, 80), healthPct)
                hbData.Fill.Visible = true
            elseif hbData then
                if hbData.Bg then hbData.Bg.Visible = false end
                if hbData.Fill then hbData.Fill.Visible = false end
            end
        end)
    end

    if Config.ThirdPersonEnabled then
        pcall(function()
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.DevEnableMouseLock = true
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local dist = math.clamp(Config.ThirdPersonDistance or 12, 4, 50)

            -- Re-detect every frame (Lobby ↔ Play + after respawn)
            local fpLocked = ThirdPerson_IsFirstPersonLocked()
            Cache.ThirdPersonUsingOffset = fpLocked

            if Camera and hum then
                if Camera.CameraType ~= Enum.CameraType.Custom and Camera.CameraType ~= Enum.CameraType.Track then
                    Camera.CameraType = Enum.CameraType.Custom
                end
                if Camera.CameraSubject ~= hum then
                    Camera.CameraSubject = hum
                end
            end

            if fpLocked then
                LocalPlayer.CameraMinZoomDistance = 0.5
                LocalPlayer.CameraMaxZoomDistance = 0.5
                if hum then
                    hum.CameraOffset = Vector3.new(0, math.clamp(dist * 0.12, 0.8, 3), dist * 0.85)
                end
                if char then ThirdPerson_ApplyCharacter(char) end
            else
                if hum then hum.CameraOffset = Vector3.zero end
                LocalPlayer.CameraMinZoomDistance = dist
                LocalPlayer.CameraMaxZoomDistance = dist
                if char then ThirdPerson_RestoreCharacter(char) end
            end
        end)
    end

    if Config.AimEnabled then
        -- Fresh FOV pick every frame → easy target switch (no sticky lock)
        local aimTarget = GetClosestPlayerInFOV()
        if aimTarget then
            local ok, targetHead, hum = IsValidAimTarget(aimTarget)
            if ok and targetHead then
                local smooth = math.clamp(Config.AimSmoothValue or 0.18, 0.01, 1)
                local aimPos = targetHead.Position
                local dist = (aimPos - Camera.CFrame.Position).Magnitude
                if dist < 12 then
                    local char = GetPlayerCharacter(aimTarget) or aimTarget.Character
                    local root = char and GetCharRoot(char)
                    if root then aimPos = root.Position + Vector3.new(0, 0.5, 0) end
                end
                local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, aimPos)
                if smooth >= 0.99 then
                    Camera.CFrame = targetCFrame
                else
                    -- slightly higher min lerp so switching targets feels responsive
                    local t = math.clamp(smooth, 0.08, 1)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, t)
                end
            else
                Cache.AimLockTarget = nil
            end
        else
            Cache.AimLockTarget = nil
        end
    else
        Cache.AimLockTarget = nil
    end

    if Config.AntiAimEnabled then
        pcall(function() AntiAim_Update(1/60) end)
    end

    if Config.AspectRatioEnabled and Camera then
        local cf = Camera.CFrame
        -- Use Unit axes so Y scale does not compound every frame
        local x = cf.XVector.Unit
        local y = cf.YVector.Unit
        local z = cf.ZVector.Unit
        local s = Config.AspectRatioValue or 1
        Camera.CFrame = CFrame.fromMatrix(cf.Position, x, y * s, z)
    end

    if Config.FullbrightEnabled and (frameN % 15 == 0) then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
    elseif Config.DarkModeEnabled and (frameN % 15 == 0) then
        -- Soft dark atmosphere — map stays readable
        Lighting.Brightness = 1.15
        Lighting.Ambient = Color3.fromRGB(58, 58, 75)
        Lighting.OutdoorAmbient = Color3.fromRGB(50, 52, 70)
        Lighting.ColorShift_Top = Color3.fromRGB(38, 40, 58)
        Lighting.ColorShift_Bottom = Color3.fromRGB(28, 30, 42)
    end

    if Config.FogEnabled then
        -- every frame so game cannot reset fog (was blinking when throttled)
        pcall(function()
            Lighting.FogStart = 0
            Lighting.FogEnd = math.max(Config.FogDistanceValue or 300, 20)
            Lighting.FogColor = Config.Color_Fog or Theme.Accent
            local fogAtm = Lighting:FindFirstChild("AnxiumFogAtmosphere")
            if not fogAtm then
                fogAtm = Instance.new("Atmosphere")
                fogAtm.Name = "AnxiumFogAtmosphere"
                fogAtm.Parent = Lighting
            end
            local dens = math.clamp(0.25 + (500 - math.min(Config.FogDistanceValue or 300, 500)) / 2000, 0.15, 0.55)
            if fogAtm.Density ~= dens then fogAtm.Density = dens end
            fogAtm.Haze = 2.5
            fogAtm.Color = Config.Color_Fog or Theme.Accent
            fogAtm.Decay = Config.Color_Fog or Theme.Accent
            -- only zero other atmospheres occasionally
            if frameN % 20 == 0 then
                for _, child in ipairs(Lighting:GetChildren()) do
                    if child:IsA("Atmosphere") and child.Name ~= "AnxiumFogAtmosphere" then
                        child.Density = 0
                        child.Haze = 0
                    end
                end
            end
        end)
    elseif Cache.FogWasOn then
        local fogAtm = Lighting:FindFirstChild("AnxiumFogAtmosphere")
        if fogAtm then fogAtm:Destroy() end
        pcall(function()
            Lighting.FogStart = LightingDefaults.FogStart
            Lighting.FogEnd = LightingDefaults.FogEnd
            Lighting.FogColor = LightingDefaults.FogColor
        end)
        Cache.FogWasOn = false
    end
    if Config.FogEnabled then Cache.FogWasOn = true end

    -- Chams: every frame Highlight for ALL alive players (stable, no flicker)
    if not Config.ChamsEnabled then
        for _, ch in pairs(Cache.Chams or {}) do
            if ch then ch.Enabled = false end
        end
    elseif Config.ChamsEnabled then
        local col = Config.Color_Chams or Theme.Accent
        Cache.ChamsTick = (Cache.ChamsTick or 0) + 1
        local doParts = (Cache.ChamsTick % 20 == 0) or Cache.ChamsForceRefresh
        Cache.ChamsForceRefresh = false
        local list = CachedPlayerList
        for i = 1, #list do
            local player = list[i]
            if player ~= LocalPlayer then
                local char = player.Character
                local chams = Cache.Chams[player]
                -- Team Checker: no chams on teammates
                if Config.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
                    if chams then chams.Enabled = false end
                elseif char and char.Parent then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local alive = not hum or hum.Health > 0
                    if alive then
                        if not chams or not chams.Parent then
                            chams = Instance.new("Highlight")
                            chams.Name = "AnxiumChams_" .. tostring(player.UserId)
                            chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            chams.FillTransparency = 0.35
                            chams.OutlineTransparency = 0.1
                            chams.OutlineColor = Color3.fromRGB(255, 255, 255)
                            pcall(function()
                                if gethui then
                                    chams.Parent = gethui()
                                else
                                    chams.Parent = ScreenGui
                                end
                            end)
                            if not chams.Parent then
                                chams.Parent = CoreGui
                            end
                            Cache.Chams[player] = chams
                        end
                        chams.Adornee = char
                        chams.Enabled = true
                        chams.FillColor = col
                        if doParts then
                            Cache.ChamsPartFallback = Cache.ChamsPartFallback or {}
                            local map = Cache.ChamsPartFallback[player]
                            if not map then
                                map = {}
                                Cache.ChamsPartFallback[player] = map
                            end
                            local children = char:GetChildren()
                            for j = 1, #children do
                                local part = children[j]
                                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Transparency < 0.9 then
                                    if not map[part] then
                                        map[part] = { Material = part.Material, Color = part.Color }
                                    end
                                    part.Material = Enum.Material.ForceField
                                    part.Color = col
                                end
                            end
                        end
                    elseif chams then
                        chams.Enabled = false
                    end
                elseif chams then
                    chams.Enabled = false
                end
            end
        end
    end

    if Config.FootstepsEnabled and myHrp and myChar then
        local humanoid = myChar:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local onGround = humanoid.FloorMaterial ~= Enum.Material.Air
            local now = tick()

            if Cache.WasOnGround and not onGround and myHrp.AssemblyLinearVelocity.Y > 8 and (now - Cache.JumpCircleCooldown) > 0.35 then
                Cache.JumpCircleCooldown = now
                RaycastParamsFootsteps.FilterDescendantsInstances = { myChar }

                local rayResult = Workspace:Raycast(myHrp.Position, Vector3.new(0, -10, 0), RaycastParamsFootsteps)
                local floorPos = rayResult and rayResult.Position or (myHrp.Position - Vector3.new(0, 3, 0))

                local ring = Instance.new("Part")
                ring.Size = Vector3.new(0.1, 0.1, 0.1)
                ring.CFrame = CFrame.new(floorPos + Vector3.new(0, 0.03, 0)) * CFrame.Angles(1.5708, 0, 0)
                ring.Anchored = true
                ring.CanCollide = false
                ring.CastShadow = false
                ring.Material = Enum.Material.Neon
                ring.Transparency = 0.15
                ring.Color = Config.Color_JumpCircle or Theme.Accent
                ring.Name = "AnxiumJumpCircle"

                local light = Instance.new("PointLight")
                light.Brightness = Config.JumpCircleGlow
                light.Range = math.max(5, Config.JumpCircleSize * 1.4)
                light.Color = Config.Color_JumpCircle or Theme.Accent
                light.Parent = ring

                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.FileMesh
                mesh.MeshId = "rbxassetid://3270017"
                mesh.Scale = Vector3.new(0.15, 0.15, 0.15)
                mesh.Parent = ring
                ring.Parent = Workspace

                table.insert(Cache.ActiveFootsteps, {
                    Part = ring,
                    Mesh = mesh,
                    Light = light,
                    Time = now,
                    BaseSize = Config.JumpCircleSize,
                    Life = 2.0
                })
            end

            Cache.WasOnGround = onGround
        end
    end

    for i = #Cache.ActiveFootsteps, 1, -1 do
        local data = Cache.ActiveFootsteps[i]
        local elapsed = tick() - data.Time
        local life = data.Life or 2.0
        if elapsed > life or not data.Part or not data.Part.Parent then
            if data.Part then data.Part:Destroy() end
            table.remove(Cache.ActiveFootsteps, i)
        else
            local progress = elapsed / life
            local ease = 1 - (1 - progress) * (1 - progress)
            local scale = data.BaseSize * (0.2 + ease * 1.6)
            data.Mesh.Scale = Vector3.new(scale, scale, 0.35 * (1 - progress * 0.6))
            data.Part.Transparency = 0.1 + progress * 0.9
            if data.Light then
                data.Light.Brightness = (Config.JumpCircleGlow or 4) * (1 - progress)
                data.Light.Range = math.max(2, (Config.JumpCircleSize or 5) * 1.4 * (1 - progress * 0.5))
            end
        end
    end

    if Config.ChinaHatEnabled and myHead and Drawing then
        local scale = Config.ChinaHatScale or 1.0
        local hatHeight = Config.ChinaHatHeight * scale
        local hatRadius = Config.ChinaHatRadius * scale

        local headPos = myHead.Position + Vector3.new(0, Config.ChinaHatHeightOffset, 0)
        local topPos = headPos + Vector3.new(0, hatHeight, 0)
        local step = (math.pi * 2) / Config.ChinaHatSegments

        for i = 1, Config.ChinaHatSegments do
            local a1 = (i - 1) * step
            local a2 = i * step

            local base1 = headPos + Vector3.new(math.cos(a1) * hatRadius, 0, math.sin(a1) * hatRadius)
            local base2 = headPos + Vector3.new(math.cos(a2) * hatRadius, 0, math.sin(a2) * hatRadius)

            local s1 = WorldToScreen(base1)
            local s2 = WorldToScreen(base2)
            local s3 = WorldToScreen(topPos)

            local lines = Cache.ChinaHatLines[i]
            local tri = Cache.ChinaHatTris[i]

            -- Draw as long as points are roughly in front of the camera (Z > 0)
            -- This prevents the hat from disappearing when looking at angles
            if lines and tri and s1.Z > 0 and s2.Z > 0 and s3.Z > 0 then
                pcall(function()
                    lines.Line.Visible = true
                    lines.Line.From = Vector2.new(s1.X, s1.Y)
                    lines.Line.To = Vector2.new(s3.X, s3.Y)
                    local hatCol = Config.Color_ChinaHat or Theme.Accent
                    lines.Line.Color = hatCol
                    lines.Line.Transparency = 0.75

                    lines.BaseLine.Visible = true
                    lines.BaseLine.From = Vector2.new(s1.X, s1.Y)
                    lines.BaseLine.To = Vector2.new(s2.X, s2.Y)
                    lines.BaseLine.Color = hatCol
                    lines.BaseLine.Transparency = 0.75
                end)

                pcall(function()
                    local hatCol = Config.Color_ChinaHat or Theme.Accent
                    tri.Visible = true
                    tri.PointA = Vector2.new(s1.X, s1.Y)
                    tri.PointB = Vector2.new(s2.X, s2.Y)
                    tri.PointC = Vector2.new(s3.X, s3.Y)
                    tri.Color = hatCol
                    tri.Transparency = 0.35
                end)
            else
                if lines then 
                    pcall(function() 
                        lines.Line.Visible = false 
                        lines.BaseLine.Visible = false 
                    end) 
                end
                if tri then pcall(function() tri.Visible = false end) end
            end
        end
    else
        HideHatDrawing()
    end

    if Config.CrosshairEnabled or Config.SpinCrosshairEnabled then
        if UserInputService.MouseIconEnabled then
            pcall(function() UserInputService.MouseIconEnabled = false end)
        end
        local mousePos = UserInputService:GetMouseLocation()
        local mx, my = mousePos.X, mousePos.Y
        local col = Config.Color_Crosshair or Theme.Accent
        local size = 10
        if Config.SpinCrosshairEnabled and Cache.CrosshairSpinLines then
            CrosshairX.Visible = false
            CrosshairY.Visible = false
            local speed = tonumber(Config.SpinCrosshairSpeed) or 180
            Cache.CrosshairSpinAngle = (Cache.CrosshairSpinAngle or 0) + math.rad(speed) * (1/60)
            local ang = Cache.CrosshairSpinAngle
            local gap = 4
            local len = size + 2
            for i = 1, 4 do
                local a = ang + (i - 1) * (math.pi * 0.5)
                local c, s = math.cos(a), math.sin(a)
                local ln = Cache.CrosshairSpinLines[i]
                if ln then
                    ln.Visible = true
                    ln.Color = col
                    ln.From = Vector2.new(mx + c * gap, my + s * gap)
                    ln.To = Vector2.new(mx + c * (gap + len), my + s * (gap + len))
                end
            end
        else
            if Cache.CrosshairSpinLines then
                for i = 1, 4 do
                    if Cache.CrosshairSpinLines[i] then Cache.CrosshairSpinLines[i].Visible = false end
                end
            end
            CrosshairX.Visible = true
            CrosshairY.Visible = true
            CrosshairX.Color = col
            CrosshairY.Color = col
            CrosshairX.From = Vector2.new(mx - size, my)
            CrosshairX.To = Vector2.new(mx + size, my)
            CrosshairY.From = Vector2.new(mx, my - size)
            CrosshairY.To = Vector2.new(mx, my + size)
        end
    else
        if CrosshairX.Visible then
            CrosshairX.Visible = false
            CrosshairY.Visible = false
        end
        if Cache.CrosshairSpinLines then
            for i = 1, 4 do
                if Cache.CrosshairSpinLines[i] then Cache.CrosshairSpinLines[i].Visible = false end
            end
        end
    end

    if Config.NameEspEnabled or Config.DistanceEspEnabled then
        for player, nameText in pairs(Cache.EspLabels) do
            pcall(function()
                if not nameText then return end
                if Config.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
                    nameText.Visible = false
                    return
                end
                local char = (GetPlayerCharacter and GetPlayerCharacter(player)) or player.Character
                local head = char and ((GetCharHead and GetCharHead(char)) or char:FindFirstChild("Head"))
                local hum = char and ((GetCharHumanoid and GetCharHumanoid(char)) or char:FindFirstChildOfClass("Humanoid"))
                if not head then
                    nameText.Visible = false
                    return
                end
                if hum and hum.Health <= 0 then
                    nameText.Visible = false
                    return
                end
                -- World-up offset only (stable when pitching camera)
                local sp = WorldToScreen(head.Position + Vector3.new(0, 1.35, 0))
                if sp.Z <= 0.15 then
                    nameText.Visible = false
                    return
                end
                -- Off-screen check with margin
                local vs = Camera.ViewportSize
                if sp.X < -80 or sp.X > vs.X + 80 or sp.Y < -40 or sp.Y > vs.Y + 40 then
                    nameText.Visible = false
                    return
                end
                local text
                if Config.NameEspEnabled and Config.DistanceEspEnabled and myHrp then
                    local dist = (head.Position - myHrp.Position).Magnitude
                    text = (player.DisplayName or player.Name) .. " [" .. math.floor(dist * 0.28) .. "m]"
                elseif Config.NameEspEnabled then
                    text = player.DisplayName or player.Name
                elseif myHrp then
                    local dist = (head.Position - myHrp.Position).Magnitude
                    text = "[" .. math.floor(dist * 0.28) .. "m]"
                else
                    text = ""
                end
                nameText.Text = text
                nameText.Color = Config.Color_NameEsp or Theme.Accent
                nameText.Position = Vector2.new(sp.X, sp.Y - 2)
                nameText.Visible = true
            end)
        end
    else
        for _, nameText in pairs(Cache.EspLabels) do
            if nameText then nameText.Visible = false end
        end
    end

    if Config.SkeletonEnabled then
    for player, parts in pairs(Cache.Skeletons) do
        pcall(function()
            if Config.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
                for _, line in pairs(parts) do if line then line.Visible = false end end
                return
            end
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChildOfClass("Humanoid") and char:FindFirstChildOfClass("Humanoid").Health > 0 then
                local isR15 = char:FindFirstChild("UpperTorso") ~= nil
                local head = GetPartPos(char, "Head")
                local torso = isR15 and GetPartPos(char, "UpperTorso") or GetPartPos(char, "Torso")
                local lArm = isR15 and GetPartPos(char, "LeftUpperArm") or GetPartPos(char, "Left Arm")
                local rArm = isR15 and GetPartPos(char, "RightUpperArm") or GetPartPos(char, "Right Arm")
                local lLeg = isR15 and GetPartPos(char, "LeftUpperLeg") or GetPartPos(char, "Left Leg")
                local rLeg = isR15 and GetPartPos(char, "RightUpperLeg") or GetPartPos(char, "Right Leg")
                local lowerTorso = isR15 and GetPartPos(char, "LowerTorso") or torso

                if head and torso then
                    parts.Head.Visible = true; parts.Head.From = head; parts.Head.To = torso; parts.Head.Color = Theme.Accent
                    if lArm then parts.LeftArm.Visible = true; parts.LeftArm.From = torso; parts.LeftArm.To = lArm; parts.LeftArm.Color = Theme.Accent else parts.LeftArm.Visible = false end
                    if rArm then parts.RightArm.Visible = true; parts.RightArm.From = torso; parts.RightArm.To = rArm; parts.RightArm.Color = Theme.Accent else parts.RightArm.Visible = false end
                    if lowerTorso and lLeg then parts.LeftLeg.Visible = true; parts.LeftLeg.From = lowerTorso; parts.LeftLeg.To = lLeg; parts.LeftLeg.Color = Theme.Accent else parts.LeftLeg.Visible = false end
                    if lowerTorso and rLeg then parts.RightLeg.Visible = true; parts.RightLeg.From = lowerTorso; parts.RightLeg.To = rLeg; parts.RightLeg.Color = Theme.Accent else parts.RightLeg.Visible = false end
                    if isR15 and torso and lowerTorso then parts.Spine.Visible = true; parts.Spine.From = torso; parts.Spine.To = lowerTorso; parts.Spine.Color = Theme.Accent else parts.Spine.Visible = false end
                else
                    for _, line in pairs(parts) do if line then line.Visible = false end end
                end
            else
                for _, line in pairs(parts) do if line then line.Visible = false end end
            end
        end)
    end
    else
        -- Skeleton off → hide all lines once
        for _, parts in pairs(Cache.Skeletons) do
            for _, line in pairs(parts) do if line then line.Visible = false end end
        end
    end

    FovCircle.Position = screenCenter
    FovCircle.Radius = Config.FovRadius
    FovCircle.Color = Config.Color_Fov or Theme.Accent
    FovCircle.Visible = Config.ShowFovEnabled

    -- Silent Aim FOV (follows mouse / screen center)
    if SilentFovCircle then
        local mousePos = UserInputService:GetMouseLocation()
        SilentFovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        SilentFovCircle.Radius = Config.SilentFovRadius or 130
        SilentFovCircle.Color = Config.Color_SilentFov or Color3.fromRGB(255, 80, 80)
        SilentFovCircle.Visible = Config.ShowSilentFovEnabled == true and Config.SilentAimEnabled == true
    end

    if Config.TracersEnabled then
        local bottom = Vector2.new(screenCenter.X, Camera.ViewportSize.Y)
        for player, line in pairs(Cache.TracerLines) do
            pcall(function()
                if player and Config.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
                    if line then line.Visible = false end
                    return
                end
                if player and line and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local vector, onScreen = WorldToScreen(hrp.Position)
                        if onScreen and vector.Z > 0 then
                            line.From = bottom
                            line.To = Vector2.new(vector.X, vector.Y)
                            line.Color = Theme.Accent
                            line.Visible = true
                            return
                        end
                    end
                end
                if line then line.Visible = false end
            end)
        end
    else
        for _, line in pairs(Cache.TracerLines) do if line then line.Visible = false end end
    end

    if Config.SpeedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Config.WalkSpeedValue
    end

    if Config.NoclipEnabled and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    if Config.FlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if not Cache.FlyBodyVelocity or not Cache.FlyBodyVelocity.Parent then
            Cache.FlyBodyVelocity = Instance.new("BodyVelocity")
            Cache.FlyBodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            Cache.FlyBodyVelocity.Parent = hrp
        end
        if not Cache.FlyBodyGyro or not Cache.FlyBodyGyro.Parent then
            Cache.FlyBodyGyro = Instance.new("BodyGyro")
            Cache.FlyBodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            Cache.FlyBodyGyro.P = 9e4
            Cache.FlyBodyGyro.Parent = hrp
        end
        Cache.FlyBodyGyro.CFrame = Camera.CFrame
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        Cache.FlyBodyVelocity.Velocity = moveDir * Config.FlySpeedValue
    else
        if Cache.FlyBodyVelocity then Cache.FlyBodyVelocity:Destroy() Cache.FlyBodyVelocity = nil end
        if Cache.FlyBodyGyro then Cache.FlyBodyGyro:Destroy() Cache.FlyBodyGyro = nil end
    end
end)

-- INTEGRATED SPINBOT LOGIC FROM EXTERNAL SCRIPT
local function applySpin()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp or not Config.SpinEnabled then return end
    
    for _, v in pairs(hrp:GetChildren()) do
        if v.Name == "Spinning" then v:Destroy() end
    end
    local Spin = Instance.new("BodyAngularVelocity")
    Spin.Name = "Spinning"
    Spin.Parent = hrp
    Spin.MaxTorque = Vector3.new(0, math.huge, 0)
    Spin.AngularVelocity = Vector3.new(0, Config.SpinSpeed, 0)
end

local function updateCharacterSpin()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if Config.SpinEnabled then
        hum.AutoRotate = false
        applySpin()
    else
        hum.AutoRotate = true
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v.Name == "Spinning" then v:Destroy() end
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    updateCharacterSpin()
end)

SpinBtn.MouseButton1Click:Connect(function()
    Config.SpinEnabled = not Config.SpinEnabled
    UpdateSwitch(Config.SpinEnabled, SpinBg, SpinKnob, "SpinBot")
    
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if Config.SpinEnabled then
        if hum then hum.AutoRotate = false end
        applySpin()
    else
        if hum then hum.AutoRotate = true end
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v.Name == "Spinning" then v:Destroy() end
            end
        end
    end
end)
AntiAimBtn.MouseButton1Click:Connect(function()
    Config.AntiAimEnabled = not Config.AntiAimEnabled
    UpdateSwitch(Config.AntiAimEnabled, AntiAimBg, AntiAimKnob, "Anti-Aim")
    if not Config.AntiAimEnabled then
        pcall(AntiAim_RestoreMotors)
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then pcall(function() hum.AutoRotate = true end) end
    else
        Cache.AntiAimMotorBases = {}
        Cache.AntiAimSpinAngle = 0
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then pcall(function() hum.AutoRotate = false end) end
    end
end)

-- END OF SPINBOT LOGIC

UserInputService.JumpRequest:Connect(function()
    if not Config or not LocalPlayer.Character then return end
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid and Config.MultiJumpEnabled then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

BoxEspBtn.MouseButton1Click:Connect(function()
    Config.BoxEspEnabled = not Config.BoxEspEnabled
    UpdateSwitch(Config.BoxEspEnabled, BoxEspBg, BoxEspKnob, "2D Box ESP")
end)
BoxFillBtn.MouseButton1Click:Connect(function()
    Config.BoxFillGradientEnabled = not Config.BoxFillGradientEnabled
    UpdateSwitch(Config.BoxFillGradientEnabled, BoxFillBg, BoxFillKnob, "Box Fill Gradient")
end)

HealthbarEspBtn.MouseButton1Click:Connect(function()
    Config.HealthbarEspEnabled = not Config.HealthbarEspEnabled
    UpdateSwitch(Config.HealthbarEspEnabled, HealthbarEspBg, HealthbarEspKnob, "Healthbar ESP")
end)

ChamsBtn.MouseButton1Click:Connect(function()
    Config.ChamsEnabled = not Config.ChamsEnabled
    UpdateSwitch(Config.ChamsEnabled, ChamsBg, ChamsKnob, "Chams Wallhack")
    Cache.ChamsPartFallback = Cache.ChamsPartFallback or {}
    Cache.ChamsForceRefresh = true

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            pcall(function()
                if ApplyEspToPlayer then ApplyEspToPlayer(player) end
            end)
            local char = (GetPlayerCharacter and GetPlayerCharacter(player)) or player.Character
            local chams = Cache.Chams[player]
            if Config.ChamsEnabled and char then
                if not chams or not chams.Parent then
                    chams = Instance.new("Highlight")
                    chams.Name = "AnxiumChams_" .. tostring(player.UserId)
                    chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    chams.FillTransparency = 0.4
                    chams.OutlineTransparency = 0.2
                    pcall(function()
                        if gethui then chams.Parent = gethui()
                        else chams.Parent = ScreenGui end
                    end)
                    Cache.Chams[player] = chams
                end
                chams.Adornee = char
                chams.Enabled = true
                chams.FillColor = Config.Color_Chams or Theme.Accent
                chams.OutlineColor = Color3.fromRGB(255, 255, 255)
                Cache.ChamsPartFallback[player] = Cache.ChamsPartFallback[player] or {}
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Transparency < 0.95 then
                        if not Cache.ChamsPartFallback[player][part] then
                            Cache.ChamsPartFallback[player][part] = { Material = part.Material, Color = part.Color }
                        end
                        pcall(function()
                            part.Material = Enum.Material.ForceField
                            part.Color = Config.Color_Chams or Theme.Accent
                        end)
                    end
                end
            else
                if chams then chams.Enabled = false end
                local map = Cache.ChamsPartFallback[player]
                if map then
                    for part, data in pairs(map) do
                        if part and part.Parent and data then
                            pcall(function()
                                part.Material = data.Material
                                part.Color = data.Color
                            end)
                        end
                    end
                    Cache.ChamsPartFallback[player] = {}
                end
            end
        end
    end
end)

ActiveListBtn.MouseButton1Click:Connect(function()
    Config.ActiveListEnabled = not Config.ActiveListEnabled
    UpdateSwitch(Config.ActiveListEnabled, ActiveListBg, ActiveListKnob, "Active Modules HUD")
end)
BindListBtn.MouseButton1Click:Connect(function()
    Config.BindListEnabled = not Config.BindListEnabled
    UpdateSwitch(Config.BindListEnabled, BindListBg, BindListKnob, "Binds HUD")
    if UpdateBindList then UpdateBindList() end
end)
FakeFpsBtn.MouseButton1Click:Connect(function()
    Config.FakeFpsEnabled = not Config.FakeFpsEnabled
    UpdateSwitch(Config.FakeFpsEnabled, FakeFpsBg, FakeFpsKnob, "Fake FPS")
    UpdateFakeFpsDisplay()
end)

NameEspBtn.MouseButton1Click:Connect(function() Config.NameEspEnabled = not Config.NameEspEnabled UpdateSwitch(Config.NameEspEnabled, NameEspBg, NameEspKnob, "Name ESP") end)
DistEspBtn.MouseButton1Click:Connect(function() Config.DistanceEspEnabled = not Config.DistanceEspEnabled UpdateSwitch(Config.DistanceEspEnabled, DistEspBg, DistEspKnob, "Distance ESP") end)
SkelBtn.MouseButton1Click:Connect(function() Config.SkeletonEnabled = not Config.SkeletonEnabled UpdateSwitch(Config.SkeletonEnabled, SkelBg, SkelKnob, "Skeleton ESP") end)
TracerBtn.MouseButton1Click:Connect(function() Config.TracersEnabled = not Config.TracersEnabled UpdateSwitch(Config.TracersEnabled, TracerBg, TracerKnob, "Tracers") end)
CrossBtn.MouseButton1Click:Connect(function()
    Config.CrosshairEnabled = not Config.CrosshairEnabled
    UpdateSwitch(Config.CrosshairEnabled, CrossBg, CrossKnob, "Crosshair")
    pcall(function() UserInputService.MouseIconEnabled = not Config.CrosshairEnabled end)
end)
SpinCrossBtn.MouseButton1Click:Connect(function()
    Config.SpinCrosshairEnabled = not Config.SpinCrosshairEnabled
    UpdateSwitch(Config.SpinCrosshairEnabled, SpinCrossBg, SpinCrossKnob, "Spin Crosshair")
    if Config.SpinCrosshairEnabled then
        Config.CrosshairEnabled = true
        UpdateSwitch(true, CrossBg, CrossKnob, "Crosshair")
        pcall(function() UserInputService.MouseIconEnabled = false end)
    end
end)
DmgNumBtn.MouseButton1Click:Connect(function()
    Config.DamageNumbersEnabled = not Config.DamageNumbersEnabled
    UpdateSwitch(Config.DamageNumbersEnabled, DmgNumBg, DmgNumKnob, "Damage Numbers")
end)
SelfChamsBtn.MouseButton1Click:Connect(function()
    Config.SelfChamsEnabled = not Config.SelfChamsEnabled
    UpdateSwitch(Config.SelfChamsEnabled, SelfChamsBg, SelfChamsKnob, "Self Chams")
    if not Config.SelfChamsEnabled and SelfChams_Clear then SelfChams_Clear() end
end)
CloneChamsBtn.MouseButton1Click:Connect(function()
    Config.CloneChamsEnabled = not Config.CloneChamsEnabled
    UpdateSwitch(Config.CloneChamsEnabled, CloneChamsBg, CloneChamsKnob, "Clone player")
end)
OffscreenBtn.MouseButton1Click:Connect(function()
    Config.OffscreenArrowsEnabled = not Config.OffscreenArrowsEnabled
    UpdateSwitch(Config.OffscreenArrowsEnabled, OffscreenBg, OffscreenKnob, "Offscreen Arrows")
    if not Config.OffscreenArrowsEnabled and UV_ClearArrows then UV_ClearArrows() end
end)
DeathChamsBtn.MouseButton1Click:Connect(function()
    Config.DeathChamsEnabled = not Config.DeathChamsEnabled
    UpdateSwitch(Config.DeathChamsEnabled, DeathChamsBg, DeathChamsKnob, "Death player")
end)
DeathBurstBtn.MouseButton1Click:Connect(function()
    Config.DeathBurstEnabled = not Config.DeathBurstEnabled
    UpdateSwitch(Config.DeathBurstEnabled, DeathBurstBg, DeathBurstKnob, "Death Burst")
end)

FullBtn.MouseButton1Click:Connect(function()
    Config.FullbrightEnabled = not Config.FullbrightEnabled
    UpdateSwitch(Config.FullbrightEnabled, FullBg, FullKnob, "Fullbright")
    if Config.FullbrightEnabled and Config.DarkModeEnabled then
        Config.DarkModeEnabled = false
        UpdateSwitch(false, DarkModeBg, DarkModeKnob)
    end
    if not Config.FullbrightEnabled and not Config.DarkModeEnabled then
        Lighting.Ambient = LightingDefaults.Ambient
        Lighting.ColorShift_Bottom = LightingDefaults.ColorShift_Bottom
        Lighting.ColorShift_Top = LightingDefaults.ColorShift_Top
        Lighting.Brightness = LightingDefaults.Brightness
        Lighting.OutdoorAmbient = LightingDefaults.OutdoorAmbient
    end
end)

DarkModeBtn.MouseButton1Click:Connect(function()
    Config.DarkModeEnabled = not Config.DarkModeEnabled
    UpdateSwitch(Config.DarkModeEnabled, DarkModeBg, DarkModeKnob, "Dark Mode")
    if Config.DarkModeEnabled and Config.FullbrightEnabled then
        Config.FullbrightEnabled = false
        UpdateSwitch(false, FullBg, FullKnob)
    end
    if not Config.DarkModeEnabled and not Config.FullbrightEnabled then
        Lighting.Ambient = LightingDefaults.Ambient
        Lighting.ColorShift_Bottom = LightingDefaults.ColorShift_Bottom
        Lighting.ColorShift_Top = LightingDefaults.ColorShift_Top
        Lighting.Brightness = LightingDefaults.Brightness
        Lighting.OutdoorAmbient = LightingDefaults.OutdoorAmbient
    end
end)

HatBtn.MouseButton1Click:Connect(function()
    Config.ChinaHatEnabled = not Config.ChinaHatEnabled
    UpdateSwitch(Config.ChinaHatEnabled, HatBg, HatKnob, "China Hat")
    if not Config.ChinaHatEnabled then HideHatDrawing() end
end)

OrbitOrbsBtn.MouseButton1Click:Connect(function() Config.OrbitOrbsEnabled = not Config.OrbitOrbsEnabled UpdateSwitch(Config.OrbitOrbsEnabled, OrbitOrbsBg, OrbitOrbsKnob, "Neon Orbit") end)

TrailBtn.MouseButton1Click:Connect(function()
    Config.TrailEnabled = not Config.TrailEnabled
    UpdateSwitch(Config.TrailEnabled, TrailBg, TrailKnob, "Motion Trail")
    if Cache.PlayerTrail then Cache.PlayerTrail.Enabled = Config.TrailEnabled; Cache.PlayerTrail.Color = ColorSequence.new(Config.Color_Trail or Theme.Accent) end
end)

AspectBtn.MouseButton1Click:Connect(function()
    Config.AspectRatioEnabled = not Config.AspectRatioEnabled
    UpdateSwitch(Config.AspectRatioEnabled, AspectBg, AspectKnob, "Aspect Ratio")
end)

ThirdPersonBtn.MouseButton1Click:Connect(function()
    Config.ThirdPersonEnabled = not Config.ThirdPersonEnabled
    UpdateSwitch(Config.ThirdPersonEnabled, ThirdPersonBg, ThirdPersonKnob, "Third Person")
    if Config.ThirdPersonEnabled then
        ThirdPerson_Enable()
    else
        ThirdPerson_Disable()
    end
end)

FogBtn.MouseButton1Click:Connect(function()
    Config.FogEnabled = not Config.FogEnabled
    UpdateSwitch(Config.FogEnabled, FogBg, FogKnob, "Custom Fog")
    if not Config.FogEnabled then
        local fogAtm = Lighting:FindFirstChild("AnxiumFogAtmosphere")
        if fogAtm then fogAtm:Destroy() end
        Lighting.FogStart = LightingDefaults.FogStart
        Lighting.FogEnd = LightingDefaults.FogEnd
        Lighting.FogColor = LightingDefaults.FogColor
    end
end)

FootstepsBtn.MouseButton1Click:Connect(function() Config.FootstepsEnabled = not Config.FootstepsEnabled UpdateSwitch(Config.FootstepsEnabled, FootstepsBg, FootstepsKnob, "Jump Circles") end)

AimBtn.MouseButton1Click:Connect(function()
    Config.AimEnabled = not Config.AimEnabled
    UpdateSwitch(Config.AimEnabled, AimBg, AimKnob, "Aimbot")
    if not Config.AimEnabled then Cache.AimLockTarget = nil end
end)
ShowFovBtn.MouseButton1Click:Connect(function() Config.ShowFovEnabled = not Config.ShowFovEnabled UpdateSwitch(Config.ShowFovEnabled, ShowFovBg, ShowFovKnob, "Show FOV") end)


TargetHudBtn.MouseButton1Click:Connect(function()
    Config.TargetHudEnabled = not Config.TargetHudEnabled
    UpdateSwitch(Config.TargetHudEnabled, TargetHudBg, TargetHudKnob, "Target HUD")
    if not Config.TargetHudEnabled then HideTargetHud() end
end)

TriggerbotBtn.MouseButton1Click:Connect(function()
    Config.TriggerbotEnabled = not Config.TriggerbotEnabled
    UpdateSwitch(Config.TriggerbotEnabled, TriggerbotBg, TriggerbotKnob, "Triggerbot")
end)

SilentAimBtn.MouseButton1Click:Connect(function()
    Config.SilentAimEnabled = not Config.SilentAimEnabled
    UpdateSwitch(Config.SilentAimEnabled, SilentAimBg, SilentAimKnob, "Silent Aim")
    if not Config.SilentAimEnabled then
        Cache.SilentAimTarget = nil
        if SilentFovCircle then SilentFovCircle.Visible = false end
    end
end)
ShowSilentFovBtn.MouseButton1Click:Connect(function()
    Config.ShowSilentFovEnabled = not Config.ShowSilentFovEnabled
    UpdateSwitch(Config.ShowSilentFovEnabled, ShowSilentFovBg, ShowSilentFovKnob, "Show Silent FOV")
end)
SilentTeamCheckBtn.MouseButton1Click:Connect(function()
    Config.SilentTeamCheck = not Config.SilentTeamCheck
    UpdateSwitch(Config.SilentTeamCheck, SilentTeamCheckBg, SilentTeamCheckKnob, "Silent Team Check")
end)
TeamCheckerBtn.MouseButton1Click:Connect(function()
    Config.TeamCheckerEnabled = not Config.TeamCheckerEnabled
    UpdateSwitch(Config.TeamCheckerEnabled, TeamCheckerBg, TeamCheckerKnob, "Team Checker")
    Cache.TeamCache = {}
end)

JumpBtn.MouseButton1Click:Connect(function() Config.MultiJumpEnabled = not Config.MultiJumpEnabled UpdateSwitch(Config.MultiJumpEnabled, JumpBg, JumpKnob, "Multi Jump") end)
SpeedBtn.MouseButton1Click:Connect(function()
    Config.SpeedHackEnabled = not Config.SpeedHackEnabled
    UpdateSwitch(Config.SpeedHackEnabled, SpeedBg, SpeedKnob, "Speed Hack")
    if not Config.SpeedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end)
NoclipBtn.MouseButton1Click:Connect(function() Config.NoclipEnabled = not Config.NoclipEnabled UpdateSwitch(Config.NoclipEnabled, NoclipBg, NoclipKnob, "Noclip") end)
FlyBtn.MouseButton1Click:Connect(function() Config.FlyEnabled = not Config.FlyEnabled UpdateSwitch(Config.FlyEnabled, FlyBg, FlyKnob, "Fly") end)
BHopBtn.MouseButton1Click:Connect(function() Config.BHopEnabled = not Config.BHopEnabled UpdateSwitch(Config.BHopEnabled, BHopBg, BHopKnob, "Bunny Hop") end)

-- old theme cycle removed (use Settings RGB picker)

FFBtn.MouseButton1Click:Connect(function()
    local newState = not Config.ForceFieldEnabled
    ForceField_Toggle(newState)
    UpdateSwitch(newState, FFBg, FFKnob, "ForceField")
end)

WeaponFFBtn.MouseButton1Click:Connect(function()
    local newState = not Config.WeaponForceFieldEnabled
    WeaponFF_Toggle(newState)
    UpdateSwitch(newState, WeaponFFBg, WeaponFFKnob, "Weapon ForceField")
end)
KillFlashBtn.MouseButton1Click:Connect(function()
    Config.KillFlashEnabled = not Config.KillFlashEnabled
    UpdateSwitch(Config.KillFlashEnabled, KillFlashBg, KillFlashKnob, "Kill Flash")
end)
HitboxBtn.MouseButton1Click:Connect(function()
    Config.HitboxEnabled = not Config.HitboxEnabled
    UpdateSwitch(Config.HitboxEnabled, HitboxBg, HitboxKnob, "Hitbox Expander")
    if not Config.HitboxEnabled and Hitbox_ClearAll then Hitbox_ClearAll() end
end)
HitboxShowBtn.MouseButton1Click:Connect(function()
    Config.HitboxShow = not Config.HitboxShow
    UpdateSwitch(Config.HitboxShow, HitboxShowBg, HitboxShowKnob, "Show Hitboxes")
end)
BulletTracerBtn.MouseButton1Click:Connect(function()
    Config.BulletTracersEnabled = not Config.BulletTracersEnabled
    UpdateSwitch(Config.BulletTracersEnabled, BulletTracerBg, BulletTracerKnob, "Bullet Tracers")
end)

AuraBtn.MouseButton1Click:Connect(function()
    Config.AuraEnabled = not Config.AuraEnabled
    UpdateSwitch(Config.AuraEnabled, AuraBg, AuraKnob, "Aura")
    ClassicAura_RefreshAll()
end)

ClassicPinkBtn.MouseButton1Click:Connect(function()
    Config.ClassicPinkEnabled = not Config.ClassicPinkEnabled
    UpdateSwitch(Config.ClassicPinkEnabled, ClassicPinkBg, ClassicPinkKnob, "Pink Aura")
    ClassicAura_RefreshAll()
end)

ClassicAngelBtn.MouseButton1Click:Connect(function()
    Config.ClassicAngelEnabled = not Config.ClassicAngelEnabled
    UpdateSwitch(Config.ClassicAngelEnabled, ClassicAngelBg, ClassicAngelKnob, "Angel Wing")
    ClassicAura_RefreshAll()
end)

ParticleStarBtn.MouseButton1Click:Connect(function()
    Config.ParticleStarlightEnabled = not Config.ParticleStarlightEnabled
    UpdateSwitch(Config.ParticleStarlightEnabled, ParticleStarBg, ParticleStarKnob, "Starlight")
    ParticleAura_RefreshAll()
end)

ParticleAngelBtn.MouseButton1Click:Connect(function()
    Config.ParticleAngelEnabled = not Config.ParticleAngelEnabled
    UpdateSwitch(Config.ParticleAngelEnabled, ParticleAngelBg, ParticleAngelKnob, "Angel")
    ParticleAura_RefreshAll()
end)

FireSoundBtn.MouseButton1Click:Connect(function()
    Config.CustomFireSoundEnabled = not Config.CustomFireSoundEnabled
    UpdateSwitch(Config.CustomFireSoundEnabled, FireSoundBg, FireSoundKnob, "Hit Sounds")
    if Config.CustomFireSoundEnabled and not Cache.FireSoundsReady then
        Notify("Hit Sounds", "Sounds still loading...")
    end
end)

local FIRE_SOUND_FILES = {
    ["Gun Fire"] = {
        url = "https://raw.githubusercontent.com/AnxiumClient/sounnds/main/wp_gun_fire-02.ogg",
        file = "Anxium_wp_gun_fire-02.ogg"
    },
    ["Hammer Hit"] = {
        url = "https://raw.githubusercontent.com/AnxiumClient/sounnds/main/wp_hammer_hit-01.ogg",
        file = "Anxium_wp_hammer_hit-01.ogg"
    },
    ["Bow Ding"] = {
        url = "https://raw.githubusercontent.com/AnxiumClient/sounnds/main/bow%20ding.wav",
        file = "Anxium_bow_ding.wav"
    },
    ["Cod Hit"] = {
        url = "https://raw.githubusercontent.com/AnxiumClient/sounnds/main/cod_hit.ogg",
        file = "Anxium_cod_hit.ogg"
    },
    ["Uwu"] = {
        url = "https://raw.githubusercontent.com/AnxiumClient/sounnds/main/uwu.mp3",
        file = "Anxium_uwu.mp3"
    }
}

local function PlayHitSounds()
    if not Config.CustomFireSoundEnabled or not Cache.FireSoundsReady then return end
    local key = Config.CustomFireSoundName or "Gun Fire"
    local assetId = Cache.FireSoundAssets[key]
    if not assetId then return end

    if Cache.FireSoundInstance then
        pcall(function()
            Cache.FireSoundInstance:Stop()
            Cache.FireSoundInstance:Destroy()
        end)
        Cache.FireSoundInstance = nil
    end

    local sound = Instance.new("Sound")
    sound.Name = "AnxiumHitSound"
    sound.SoundId = assetId
    sound.Volume = Config.CustomFireSoundVolume or 1
    sound.PlaybackSpeed = 1
    sound.Parent = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:FindFirstChild("PlayerScripts") or Workspace
    Cache.FireSoundInstance = sound

    pcall(function() sound:Play() end)

    sound.Ended:Connect(function()
        if Cache.FireSoundInstance == sound then Cache.FireSoundInstance = nil end
        pcall(function() sound:Destroy() end)
    end)
end

Cache.BulletTracers = Cache.BulletTracers or {}

local function SpawnBulletTracer(fromPos, toPos)
    if not Config.BulletTracersEnabled then return end
    if not fromPos or not toPos then return end
    local col = Config.Color_BulletTracer or Theme.Accent
    local duration = 2
    local dist = (toPos - fromPos).Magnitude
    if dist < 0.5 then return end

    -- Invisible anchors fixed in the world
    local a0 = Instance.new("Part")
    a0.Name = "AnxiumTracerA"
    a0.Size = Vector3.new(0.05, 0.05, 0.05)
    a0.Transparency = 1
    a0.Anchored = true
    a0.CanCollide = false
    a0.CanQuery = false
    a0.CanTouch = false
    a0.CastShadow = false
    a0.CFrame = CFrame.new(fromPos)
    a0.Parent = Workspace

    local a1 = Instance.new("Part")
    a1.Name = "AnxiumTracerB"
    a1.Size = Vector3.new(0.05, 0.05, 0.05)
    a1.Transparency = 1
    a1.Anchored = true
    a1.CanCollide = false
    a1.CanQuery = false
    a1.CanTouch = false
    a1.CastShadow = false
    a1.CFrame = CFrame.new(toPos)
    a1.Parent = Workspace

    local att0 = Instance.new("Attachment")
    att0.Parent = a0
    local att1 = Instance.new("Attachment")
    att1.Parent = a1

    local beam = Instance.new("Beam")
    beam.Attachment0 = att0
    beam.Attachment1 = att1
    beam.Color = ColorSequence.new(col)
    beam.Width0 = 0.18
    beam.Width1 = 0.06
    beam.FaceCamera = true
    beam.LightEmission = 1
    beam.LightInfluence = 0
    beam.TextureSpeed = 0
    beam.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.05),
        NumberSequenceKeypoint.new(1, 0.35),
    })
    beam.Segments = 12
    beam.Parent = a0

    table.insert(Cache.BulletTracers, {
        A0 = a0, A1 = a1, Beam = beam,
        From = fromPos, To = toPos,
        Start = tick(), Duration = duration, Color = col,
    })
    while #Cache.BulletTracers > 35 do
        local old = table.remove(Cache.BulletTracers, 1)
        if old then
            pcall(function() if old.Beam then old.Beam:Destroy() end end)
            pcall(function() if old.A0 then old.A0:Destroy() end end)
            pcall(function() if old.A1 then old.A1:Destroy() end end)
        end
    end
end

local function GetTracerOrigin()
    local cam = Workspace.CurrentCamera or Camera
    local myChar = LocalPlayer.Character
    if myChar then
        local tool = myChar:FindFirstChildOfClass("Tool")
        if tool then
            local handle = tool:FindFirstChild("Handle") or tool:FindFirstChild("Barrel") or tool:FindFirstChildWhichIsA("BasePart")
            if handle and handle:IsA("BasePart") then
                return handle.Position + handle.CFrame.LookVector * 0.5
            end
        end
        if cam then
            for _, d in ipairs(cam:GetChildren()) do
                if d:IsA("Model") or d:IsA("Folder") then
                    local h = d:FindFirstChild("Handle", true) or d:FindFirstChildWhichIsA("BasePart", true)
                    if h and h:IsA("BasePart") then
                        return h.Position
                    end
                end
            end
        end
        local head = myChar:FindFirstChild("Head")
        if head then
            return head.Position + (cam and cam.CFrame.LookVector or head.CFrame.LookVector) * 1
        end
    end
    if cam then
        return cam.CFrame.Position + cam.CFrame.LookVector * 2
    end
    return nil
end

local function FireBulletTracer()
    if not Config.BulletTracersEnabled then return end
    local cam = Workspace.CurrentCamera or Camera
    if not cam then return end
    local now = tick()
    if now - (Cache.LastTracerTime or 0) < 0.12 then return end
    Cache.LastTracerTime = now

    local origin = GetTracerOrigin() or (cam.CFrame.Position + cam.CFrame.LookVector * 1.5)
    -- Prefer silent-aim target hit if available (looks like real bullet path)
    local hitPos
    if Cache.SilentAimPos and Config.SilentAimEnabled then
        hitPos = Cache.SilentAimPos
    else
        local dir = cam.CFrame.LookVector * 1000
        local myChar = LocalPlayer.Character
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        local filter = {}
        if myChar then table.insert(filter, myChar) end
        params.FilterDescendantsInstances = filter
        params.IgnoreWater = true
        local result = Workspace:Raycast(origin, dir, params)
        hitPos = result and result.Position or (origin + cam.CFrame.LookVector * 400)
    end
    SpawnBulletTracer(origin, hitPos)
end

local function UpdateBulletTracers()
    if not Cache.BulletTracers or #Cache.BulletTracers == 0 then return end
    local now = tick()
    local i = 1
    while i <= #Cache.BulletTracers do
        local e = Cache.BulletTracers[i]
        local age = now - (e.Start or now)
        local dur = 2
        if age >= dur then
            pcall(function() if e.Beam then e.Beam:Destroy() end end)
            pcall(function() if e.A0 then e.A0:Destroy() end end)
            pcall(function() if e.A1 then e.A1:Destroy() end end)
            table.remove(Cache.BulletTracers, i)
        else
            -- smooth fade over 2s (world beam stays fixed on map)
            local t = math.clamp(age / dur, 0, 1)
            local fade = t * t * (3 - 2 * t) -- smoothstep 0→1
            if e.Beam and e.Beam.Parent then
                local t0 = 0.05 + fade * 0.95
                local t1 = 0.25 + fade * 0.75
                e.Beam.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, t0),
                    NumberSequenceKeypoint.new(1, t1),
                })
                e.Beam.Width0 = 0.18 * (1 - fade * 0.85)
                e.Beam.Width1 = 0.06 * (1 - fade * 0.85)
            end
            i = i + 1
        end
    end
end
Cache.UpdateBulletTracers = UpdateBulletTracers

if not Cache._fxHeartbeat then
    Cache._fxHeartbeat = true
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if Cache and Cache.UpdateBulletTracers then Cache.UpdateBulletTracers() end
            if Cache and Cache.UpdateKillFX then Cache.UpdateKillFX() end
        end)
    end)
end

-- Auto-fire tracers while holding M1 (SMG / auto guns)
Cache.TracerMouseDown = false
UserInputService.InputBegan:Connect(function(input, gp)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Cache.TracerMouseDown = true
        if Config.BulletTracersEnabled then
            FireBulletTracer()
        end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Cache.TracerMouseDown = false
    end
end)
RunService.Heartbeat:Connect(function()
    if Config.BulletTracersEnabled and Cache.TracerMouseDown then
        FireBulletTracer()
    end
end)

-- ===== Kill Sound: play on YOUR kills (manual + aim + trigger), once per death =====
Cache.KillHooked = Cache.KillHooked or {}
Cache.KillHumConnections = Cache.KillHumConnections or {}
Cache.LastKillSoundTime = 0
Cache.KillSoundPlayedFor = {} -- [Player] = tick
Cache.KillHandledHum = {} -- [Humanoid] = true after we finished handling
Cache.RecentDamageTargets = {} -- [Player] = tick last time we likely hit them

local function MarkRecentTarget(player)
    if player and player ~= LocalPlayer then
        Cache.RecentDamageTargets[player] = tick()
        Cache.LastShotTarget = player
        Cache.LastShotTime = tick()
    end
end

local function CaptureCrosshairTarget()
    local t = Cache.AimLockTarget
    if not t and typeof(Triggerbot_GetTargetUnderCrosshair) == "function" then
        pcall(function() t = Triggerbot_GetTargetUnderCrosshair() end)
    end
    if not t and Camera then
        local myChar = LocalPlayer.Character
        if myChar then
            pcall(function()
                RaycastParamsTriggerbot.FilterDescendantsInstances = { myChar }
                local result = Workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 1200, RaycastParamsTriggerbot)
                if result and result.Instance then
                    for _, player in ipairs(CachedPlayerList) do
                        if player ~= LocalPlayer and player.Character and result.Instance:IsDescendantOf(player.Character) then
                            t = player
                            break
                        end
                    end
                end
            end)
        end
    end
    if t then MarkRecentTarget(t) end
    return t
end

local function IsLocalPlayerKiller(humanoid)
    if not humanoid then return false, false end
    local tagNames = { "creator", "Creator", "killer", "Killer", "LastHit", "Attacker", "attacker", "DamageTag", "creatorTag" }
    local hadEnemyTag = false
    local hadAnyTag = false
    for _, name in ipairs(tagNames) do
        local tag = humanoid:FindFirstChild(name)
        if not tag then
            -- sometimes under a folder
            for _, ch in ipairs(humanoid:GetChildren()) do
                if string.lower(ch.Name) == string.lower(name) then
                    tag = ch
                    break
                end
            end
        end
        if tag then
            hadAnyTag = true
            local val = nil
            if tag:IsA("ObjectValue") then
                val = tag.Value
            elseif tag:IsA("StringValue") then
                val = tag.Value
            elseif tag:IsA("IntValue") or tag:IsA("NumberValue") then
                val = tag.Value
            end
            -- LocalPlayer / name / userid
            if val == LocalPlayer or val == LocalPlayer.Name or val == LocalPlayer.UserId then
                return true, false
            end
            if typeof(val) == "Instance" then
                if val:IsA("Player") then
                    if val == LocalPlayer then return true, false end
                    hadEnemyTag = true
                elseif val:IsA("Model") then
                    -- creator sometimes points at character model
                    if val == LocalPlayer.Character then return true, false end
                    local plr = Players:GetPlayerFromCharacter(val)
                    if plr == LocalPlayer then return true, false end
                    if plr and plr ~= LocalPlayer then hadEnemyTag = true end
                end
            end
        end
    end
    return false, hadEnemyTag
end

local function TryPlayKillSound(victimPlayer)
    if not Config.CustomFireSoundEnabled then return end
    if not victimPlayer or victimPlayer == LocalPlayer then return end
    local now = tick()
    if now - (Cache.LastKillSoundTime or 0) < 0.35 then return end
    local lastFor = Cache.KillSoundPlayedFor[victimPlayer]
    if lastFor and (now - lastFor) < 2.5 then return end
    Cache.LastKillSoundTime = now
    Cache.KillSoundPlayedFor[victimPlayer] = now
    pcall(PlayHitSounds)
end







-- ============================================================
-- EXTRA VISUALS (optimized): Self Chams + Damage Numbers
-- ============================================================

Cache.SelfChamsHL = nil
Cache.SelfChamsOriginals = nil
Cache.LastKnownHP = Cache.LastKnownHP or {}
Cache.ExtraVisFolder = nil

local function GetCfg()
    local c = rawget(_G, "Config")
    if type(c) == "table" then return c end
    if type(Config) == "table" then return Config end
    return nil
end

local function GetCache()
    local c = rawget(_G, "Cache")
    if type(c) == "table" then return c end
    if type(Cache) == "table" then return Cache end
    return nil
end

local function EnsureVisFolder()
    local cache = GetCache()
    if not cache then return Workspace end
    if cache.ExtraVisFolder and cache.ExtraVisFolder.Parent then
        return cache.ExtraVisFolder
    end
    local f = Instance.new("Folder")
    f.Name = "AnxiumExtraVisuals"
    f.Parent = Workspace
    cache.ExtraVisFolder = f
    return f
end

function SelfChams_Clear()
    local cache = GetCache()
    if not cache then return end
    if cache.SelfChamsOriginals then
        for part, data in pairs(cache.SelfChamsOriginals) do
            pcall(function()
                if part and part.Parent then
                    part.Material = data.mat
                    part.Color = data.color
                    part.Transparency = data.trans
                end
            end)
        end
        cache.SelfChamsOriginals = nil
    end
    if cache.SelfChamsHL then
        pcall(function() cache.SelfChamsHL:Destroy() end)
        cache.SelfChamsHL = nil
    end
end

local function SelfChams_Update()
    -- Self Chams = Highlight only (NOT ForceField material — that is Body ForceField)
    local cfg = GetCfg()
    local cache = GetCache()
    if not cfg or not cache then return end
    if not cfg.SelfChamsEnabled then
        SelfChams_Clear()
        return
    end
    local char = LocalPlayer.Character
    if not char then SelfChams_Clear() return end
    local col = cfg.Color_SelfChams or Color3.fromRGB(180, 140, 255)

    -- Restore any leftover material edits from older versions
    if cache.SelfChamsOriginals then
        for part, data in pairs(cache.SelfChamsOriginals) do
            pcall(function()
                if part and part.Parent then
                    part.Material = data.mat
                    part.Color = data.color
                    part.Transparency = data.trans
                end
            end)
        end
        cache.SelfChamsOriginals = nil
    end

    if not cache.SelfChamsHL or cache.SelfChamsHL.Parent == nil then
        pcall(function() if cache.SelfChamsHL then cache.SelfChamsHL:Destroy() end end)
        local hl = Instance.new("Highlight")
        hl.Name = "AnxiumSelfChams"
        hl.Adornee = char
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0.15
        hl.FillColor = col
        hl.OutlineColor = col
        hl.Parent = char
        cache.SelfChamsHL = hl
    else
        cache.SelfChamsHL.Adornee = char
        cache.SelfChamsHL.FillColor = col
        cache.SelfChamsHL.OutlineColor = col
    end
end

local function SpawnDamageNumber(worldPos, amount)
    local cfg = GetCfg()
    if not cfg or not cfg.DamageNumbersEnabled or not worldPos then return end
    local col = cfg.Color_DamageNumber or Color3.fromRGB(255, 80, 80)
    local holder = Instance.new("Part")
    holder.Anchored = true
    holder.CanCollide = false
    holder.Transparency = 1
    holder.Size = Vector3.new(0.1, 0.1, 0.1)
    holder.CFrame = CFrame.new(worldPos + Vector3.new(0, 1.2, 0))
    holder.Parent = EnsureVisFolder()
    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 80, 0, 40)
    bill.AlwaysOnTop = true
    bill.Adornee = holder
    bill.Parent = holder
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 18
    lbl.TextColor3 = col
    lbl.TextStrokeTransparency = 0.4
    lbl.Text = tostring(math.floor(amount + 0.5))
    lbl.Parent = bill
    local startT, base = tick(), holder.Position
    task.spawn(function()
        while tick() - startT < 0.75 do
            local t = (tick() - startT) / 0.75
            holder.CFrame = CFrame.new(base + Vector3.new(0, t * 2, 0))
            lbl.TextTransparency = t * 0.9
            task.wait()
        end
        pcall(function() holder:Destroy() end)
    end)
end

local function HookPlayerDamageVisuals(player)
    if player == LocalPlayer then return end
    local function hook(char)
        local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 4)
        if not hum then return end
        local cache = GetCache()
        if cache then cache.LastKnownHP[player] = hum.Health end
        hum.HealthChanged:Connect(function(hp)
            local cache2 = GetCache()
            local cfg = GetCfg()
            if not cache2 or not cfg or not cfg.DamageNumbersEnabled then return end
            local prev = cache2.LastKnownHP[player] or hp
            cache2.LastKnownHP[player] = hp
            if hp >= prev then return end
            local dmg = prev - hp
            if dmg < 0.5 then return end
            local now = tick()
            local recent = cache2.RecentDamageTargets and cache2.RecentDamageTargets[player]
            local aimed = cache2.AimLockTarget == player or cache2.SilentAimTarget == player
            local shot = (now - (cache2.LastShotTime or 0)) < 1.5
            if not ((recent and (now - recent) < 3) or (aimed and shot) or shot) then return end
            local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
            if hrp then SpawnDamageNumber(hrp.Position, dmg) end
            if cache2.RecentDamageTargets then cache2.RecentDamageTargets[player] = now end
        end)
    end
    if player.Character then task.spawn(hook, player.Character) end
    player.CharacterAdded:Connect(function(c)
        task.delay(0.25, function() if player.Character == c then hook(c) end end)
    end)
end

for _, p in ipairs(Players:GetPlayers()) do task.spawn(HookPlayerDamageVisuals, p) end
Players.PlayerAdded:Connect(HookPlayerDamageVisuals)
Players.PlayerRemoving:Connect(function(p)
    local cache = GetCache()
    if cache then cache.LastKnownHP[p] = nil end
end)

-- Lightweight visual tick (~10 Hz self-chams only when needed)
Cache.ExtraVisAccum = 0
pcall(function()
    rawset(_G, "Config", Config)
    rawset(_G, "Cache", Cache)
end)
pcall(function() RunService:UnbindFromRenderStep("AnxiumExtraVisuals") end)
RunService:BindToRenderStep("AnxiumExtraVisuals", Enum.RenderPriority.Camera.Value + 5, function(dt)
    local cfg = GetCfg()
    local cache = GetCache()
    if not cfg or not cache then return end
    if not cfg.SelfChamsEnabled then
        if cache.SelfChamsOriginals or cache.SelfChamsHL then
            pcall(SelfChams_Clear)
        end
        return
    end
    cache.ExtraVisAccum = (cache.ExtraVisAccum or 0) + (dt or 0.016)
    if cache.ExtraVisAccum < 0.1 then return end
    cache.ExtraVisAccum = 0
    pcall(SelfChams_Update)
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.delay(0.4, function() SelfChams_Clear() end)
end)

-- ============================================================
-- UNIVERSAL VISUALS (from pack) — Clone Chams / Offscreen Arrows /
-- Death Chams / Death Burst  |  colors via Config palette
-- ============================================================

local Debris = game:GetService("Debris")

Cache.UV_Arrows = Cache.UV_Arrows or {}
Cache.UV_DeathConns = Cache.UV_DeathConns or {}

local function UV_GetColor(key, fallback)
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) == "table" and cfg[key] then return cfg[key] end
    return fallback
end

-- Chams snapshot (style: "Chams" = Neon+Highlight | "ForceField" = FF material)
local function UV_CreateChamsClone(character, color, fadeDelay, fadeTime, transparency, style)
    -- Clone keeps full Chams/FF look until the very moment it is destroyed.
    if not character or not character.Parent then return end

    local materialMode = style or "Chams"
    if materialMode == "ForceField" then materialMode = "FF" end

    local fillT = 0.35
    if materialMode == "Chams" then
        fillT = math.clamp(tonumber(transparency) or 0.35, 0, 0.9)
    elseif materialMode == "FF" then
        fillT = 0.5
    end

    local oldArchivable = character.Archivable
    character.Archivable = true
    local success, clone = pcall(function()
        return character:Clone()
    end)
    character.Archivable = oldArchivable
    if not success or not clone then return end
    clone.Name = "AnxiumVisualPlayerClone"

    -- Remove things that fight materials / textures
    pcall(function()
        local hum = clone:FindFirstChildOfClass("Humanoid")
        if hum then
            local anim = hum:FindFirstChildOfClass("Animator")
            if anim then anim:Destroy() end
            hum:Destroy()
        end
    end)
    for _, object in ipairs(clone:GetDescendants()) do
        local cn = object.ClassName
        if cn == "Script" or cn == "LocalScript" or cn == "Shirt" or cn == "Pants"
            or cn == "ShirtGraphic" or cn == "BodyColors" or cn == "CharacterMesh"
            or cn == "SurfaceAppearance" or cn == "WrapLayer" or cn == "WrapTarget"
            or cn == "ParticleEmitter" or cn == "Trail" or cn == "Beam"
            or cn == "Smoke" or cn == "Fire" or cn == "Sparkles" then
            pcall(function() object:Destroy() end)
        end
    end

    local function lockVisual()
        if not clone or not clone.Parent then return end
        for _, object in ipairs(clone:GetDescendants()) do
            if object:IsA("BasePart") then
                pcall(function()
                    object.Anchored = true
                    object.CanCollide = false
                    object.CanTouch = false
                    object.CanQuery = false
                    object.CastShadow = false
                    object.Massless = true
                    if object:IsA("MeshPart") then object.TextureID = "" end
                    for _, ch in ipairs(object:GetChildren()) do
                        if ch:IsA("SpecialMesh") then
                            ch.TextureId = ""
                        elseif ch:IsA("Decal") or ch:IsA("Texture") then
                            ch.Transparency = 1
                        elseif ch:IsA("SurfaceAppearance") then
                            ch:Destroy()
                        end
                    end
                    if object.Name == "HumanoidRootPart" then
                        object.Transparency = 1
                    else
                        if materialMode == "FF" then
                            object.Material = Enum.Material.ForceField
                            object.Color = color
                            object.Transparency = 0
                            object.Reflectance = 0
                        else
                            -- Chams: solid mesh under highlight
                            object.Transparency = 0
                        end
                    end
                end)
            elseif object:IsA("Decal") or object:IsA("Texture") then
                pcall(function() object.Transparency = 1 end)
            end
        end
    end

    lockVisual()
    clone.Parent = Workspace
    lockVisual()

    -- Remove any old highlights, create one locked highlight
    for _, h in ipairs(clone:GetChildren()) do
        if h:IsA("Highlight") then pcall(function() h:Destroy() end) end
    end
    local highlight = Instance.new("Highlight")
    highlight.Name = "AnxiumCloneChams"
    highlight.Adornee = clone
    highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = fillT
    highlight.OutlineTransparency = 0
    highlight.Enabled = true
    highlight.Parent = clone

    -- Heartbeat lock: material + highlight stay full strength until destroy
    local alive = true
    local lockConn
    lockConn = RunService.Heartbeat:Connect(function()
        if not alive or not clone or not clone.Parent then
            alive = false
            if lockConn then pcall(function() lockConn:Disconnect() end) end
            return
        end
        lockVisual()
        if highlight and highlight.Parent then
            highlight.Adornee = clone
            highlight.Enabled = true
            highlight.FillColor = color
            highlight.OutlineColor = color
            highlight.FillTransparency = fillT
            highlight.OutlineTransparency = 0
        elseif clone.Parent then
            -- re-create if something destroyed it
            highlight = Instance.new("Highlight")
            highlight.Name = "AnxiumCloneChams"
            highlight.Adornee = clone
            highlight.DepthMode = Enum.HighlightDepthMode.Occluded
            highlight.FillColor = color
            highlight.OutlineColor = color
            highlight.FillTransparency = fillT
            highlight.OutlineTransparency = 0
            highlight.Enabled = true
            highlight.Parent = clone
        end
    end)

    -- Lifetime: visible solid for (delay + fadeTime), then DESTROY instantly
    -- No transparency tween — that was dropping FF/chams early.
    local lifetime = math.max(0.15, (tonumber(fadeDelay) or 1.5) + (tonumber(fadeTime) or 1.2))
    task.delay(lifetime, function()
        alive = false
        if lockConn then pcall(function() lockConn:Disconnect() end) end
        if clone and clone.Parent then
            pcall(function() clone:Destroy() end)
        end
    end)
end

-- Movement Clone player loop (idle sleep when disabled)
task.spawn(function()
    while true do
        local cfg = rawget(_G, "Config") or Config
        if type(cfg) ~= "table" or not cfg.CloneChamsEnabled then
            task.wait(0.75)
        else
            local interval = tonumber(cfg.CloneInterval) or 1
            task.wait(math.clamp(interval, 0.25, 5))
            cfg = rawget(_G, "Config") or Config
            if type(cfg) == "table" and cfg.CloneChamsEnabled then
                local col = cfg.Color_CloneChams or Color3.fromRGB(255, 60, 60)
                local fadeD = cfg.CloneFadeDelay or 1.5
                local fadeT = cfg.CloneFadeTime or 1.2
                local trans = cfg.CloneTransparency or 0.35
                local style = cfg.CloneChamsStyle or "Chams"
                if style == "ForceField" then style = "FF" end
                local list = CachedPlayerList
                if not list or #list == 0 then list = Players:GetPlayers() end
                for i = 1, #list do
                    local player = list[i]
                    if player and player ~= LocalPlayer then
                        if not (cfg.TeamCheckerEnabled and IsTeammate and IsTeammate(player)) then
                            local character = player.Character
                            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                            local root = character and character:FindFirstChild("HumanoidRootPart")
                            if humanoid and root and humanoid.Health > 0 and humanoid.MoveDirection.Magnitude > 0.05 then
                                pcall(UV_CreateChamsClone, character, col, fadeD, fadeT, trans, style)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Offscreen Arrows (GUI ▲ — works without Drawing API)
function UV_ClearArrows()
    for plr, data in pairs(Cache.UV_Arrows or {}) do
        pcall(function() if data.Holder then data.Holder:Destroy() end end)
    end
    Cache.UV_Arrows = {}
    if Cache.UV_RadiusRing then
        Cache.UV_RadiusRing.Visible = false
    end
end

local function UV_CreateArrow(player)
    if Cache.UV_Arrows[player] then return Cache.UV_Arrows[player] end
    local cfg = rawget(_G, "Config") or Config
    local size = (type(cfg) == "table" and tonumber(cfg.ArrowSize)) or 28

    local holder = Instance.new("Frame")
    holder.Name = "AnxiumArrow_" .. player.Name
    holder.Size = UDim2.fromOffset(size, size)
    holder.AnchorPoint = Vector2.new(0.5, 0.5)
    holder.BackgroundTransparency = 1
    holder.BorderSizePixel = 0
    holder.Visible = false
    holder.ZIndex = 60
    holder.Parent = ScreenGui

    -- Triangle arrow via rotated Frame + UICorner tricks won't work well;
    -- use TextLabel triangle (reliable) + outline
    local arrow = Instance.new("TextLabel")
    arrow.Name = "Arrow"
    arrow.Size = UDim2.fromScale(1, 1)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▲"
    arrow.TextScaled = true
    arrow.Font = Enum.Font.GothamBlack
    arrow.TextColor3 = Color3.fromRGB(255, 70, 70)
    arrow.TextStrokeTransparency = 0.3
    arrow.TextStrokeColor3 = Color3.new(0, 0, 0)
    arrow.ZIndex = 61
    arrow.Parent = holder

    local distance = Instance.new("TextLabel")
    distance.Name = "Dist"
    distance.Size = UDim2.fromOffset(90, 16)
    distance.Position = UDim2.new(0.5, -45, 1, 2)
    distance.BackgroundTransparency = 1
    distance.TextColor3 = Color3.fromRGB(255, 255, 255)
    distance.Font = Enum.Font.GothamBold
    distance.TextSize = 11
    distance.TextStrokeTransparency = 0.4
    distance.ZIndex = 61
    distance.Parent = holder

    Cache.UV_Arrows[player] = { Holder = holder, Arrow = arrow, Distance = distance }
    return Cache.UV_Arrows[player]
end

Players.PlayerRemoving:Connect(function(player)
    if Cache.UV_Arrows and Cache.UV_Arrows[player] then
        pcall(function() Cache.UV_Arrows[player].Holder:Destroy() end)
        Cache.UV_Arrows[player] = nil
    end
end)

-- Radius ring (center) — editable via Arrow Radius slider
Cache.UV_RadiusRing = Cache.UV_RadiusRing or nil
local function UV_EnsureRadiusRing()
    if Cache.UV_RadiusRing and Cache.UV_RadiusRing.Parent then
        return Cache.UV_RadiusRing
    end
    local ring = Instance.new("Frame")
    ring.Name = "AnxiumArrowRadius"
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.BackgroundTransparency = 1
    ring.BorderSizePixel = 0
    ring.ZIndex = 40
    ring.Visible = false
    ring.Parent = ScreenGui
    local stroke = Instance.new("UIStroke")
    stroke.Name = "Stroke"
    stroke.Thickness = 1.5
    stroke.Transparency = 0.35
    stroke.Color = Color3.fromRGB(255, 70, 70)
    stroke.Parent = ring
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = ring
    Cache.UV_RadiusRing = ring
    return ring
end

Cache._arrowInsetY = 0
Cache._arrowInsetT = 0
RunService.RenderStepped:Connect(function(dt)
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) ~= "table" then return end
    local camera = Workspace.CurrentCamera
    if not camera then return end

    if Cache.UV_RadiusRing then
        Cache.UV_RadiusRing.Visible = false
    end

    if not cfg.OffscreenArrowsEnabled then
        -- only hide once when turning off
        if Cache._arrowsWereOn then
            for _, data in pairs(Cache.UV_Arrows or {}) do
                if data.Holder and data.Holder.Visible then data.Holder.Visible = false end
            end
            Cache._arrowsWereOn = false
        end
        return
    end
    Cache._arrowsWereOn = true

    -- refresh GuiInset at most ~2 Hz
    Cache._arrowInsetT = (Cache._arrowInsetT or 0) + (dt or 0.016)
    if Cache._arrowInsetT >= 0.5 then
        Cache._arrowInsetT = 0
        pcall(function()
            Cache._arrowInsetY = game:GetService("GuiService"):GetGuiInset().Y
        end)
    end
    local insetY = Cache._arrowInsetY or 0

    local viewport = camera.ViewportSize
    -- True visual center of the game viewport, mapped into ScreenGui space
    local center = Vector2.new(viewport.X * 0.5, viewport.Y * 0.5 - insetY)
    local col = cfg.Color_OffscreenArrow or Color3.fromRGB(255, 70, 70)
    local radius = math.min(viewport.X, viewport.Y) * (cfg.ArrowDistance or 0.36)
    local arrowSize = cfg.ArrowSize or 28
    local showDist = cfg.ArrowShowDistance ~= false

    local list = CachedPlayerList
    if not list or #list == 0 then list = Players:GetPlayers() end

    for i = 1, #list do
        local player = list[i]
        if player and player ~= LocalPlayer then
            local data = UV_CreateArrow(player)
            if cfg.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then
                data.Holder.Visible = false
            else
                local character = player.Character
                local root = character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso") or character.PrimaryPart)
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if not root or not humanoid or humanoid.Health <= 0 then
                    data.Holder.Visible = false
                else
                    local position, visible = camera:WorldToViewportPoint(root.Position)
                    local onScreen = visible
                        and position.X >= 0 and position.X <= viewport.X
                        and position.Y >= 0 and position.Y <= viewport.Y
                        and position.Z > 0
                    if onScreen then
                        data.Holder.Visible = false
                    else
                        local vpCenter = Vector2.new(viewport.X * 0.5, viewport.Y * 0.5)
                        local direction = Vector2.new(position.X - vpCenter.X, position.Y - vpCenter.Y)
                        if position.Z < 0 then
                            direction = -direction
                        end
                        if direction.Magnitude < 1e-4 then
                            data.Holder.Visible = false
                        else
                            direction = direction.Unit
                            -- direction from true viewport center; place arrow in ScreenGui coords
                            local vpCenter = Vector2.new(viewport.X * 0.5, viewport.Y * 0.5)
                            local finalVp = vpCenter + direction * radius
                            local guiX = finalVp.X
                            local guiY = finalVp.Y - insetY
                            data.Holder.Size = UDim2.fromOffset(arrowSize, arrowSize)
                            data.Holder.Position = UDim2.fromOffset(guiX, guiY)
                            -- Point tip of ▲ toward off-screen target
                            data.Holder.Rotation = math.deg(math.atan2(direction.Y, direction.X)) + 90
                            data.Arrow.TextColor3 = col
                            data.Arrow.Text = "▲"
                            data.Arrow.Visible = true
                            if showDist then
                                local dist = math.floor((camera.CFrame.Position - root.Position).Magnitude)
                                data.Distance.Text = dist .. "m"
                                data.Distance.Visible = true
                            else
                                data.Distance.Visible = false
                            end
                            data.Holder.Visible = true
                        end
                    end
                end
            end
        end
    end
end)

-- Death Burst particles
local function UV_CreateDeathBurst(position)
    local cfg = rawget(_G, "Config") or Config
    if type(cfg) ~= "table" or not cfg.DeathBurstEnabled then return end
    if not position then return end

    local part = Instance.new("Part")
    part.Name = "AnxiumDeathBurst"
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.CanTouch = false
    part.CanQuery = false
    part.Transparency = 1
    part.Parent = Workspace

    local attachment = Instance.new("Attachment")
    attachment.Parent = part

    local burstCol = cfg.Color_DeathBurst or Color3.fromRGB(255, 90, 35)

    local function makeEmitter(count, speed, size, lifetime)
        local emitter = Instance.new("ParticleEmitter")
        emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
        emitter.Color = ColorSequence.new(burstCol, Color3.new(1, 1, 1))
        emitter.LightEmission = 1
        emitter.Brightness = 5
        emitter.Lifetime = NumberRange.new(lifetime * 0.7, lifetime)
        emitter.Speed = NumberRange.new(speed * 0.7, speed)
        emitter.SpreadAngle = Vector2.new(360, 360)
        emitter.Rate = 0
        emitter.Drag = 2
        emitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, size),
            NumberSequenceKeypoint.new(0.35, size * 0.8),
            NumberSequenceKeypoint.new(1, 0),
        })
        emitter.Parent = attachment
        emitter:Emit(count)
        task.delay(lifetime + 0.2, function()
            if emitter then pcall(function() emitter:Destroy() end) end
        end)
    end

    makeEmitter(80, 22, 0.55, 0.8)
    makeEmitter(110, 35, 0.28, 0.55)
    makeEmitter(35, 12, 0.8, 1.2)
    task.delay(0.12, function()
        if part and part.Parent then
            makeEmitter(45, 25, 0.4, 0.7)
        end
    end)
    Debris:AddItem(part, 2)
end

-- Death Chams + Burst hooks
local function UV_SetupDeath(player)
    if player == LocalPlayer then return end
    local function setupCharacter(character)
        local humanoid = character:WaitForChild("Humanoid", 10)
        if not humanoid then return end
        -- Capture last pose as soon as health hits 0 (more reliable than Died alone)
        local function doDeathFX()
            local cfg = rawget(_G, "Config") or Config
            if type(cfg) ~= "table" then return end
            if cfg.TeamCheckerEnabled and IsTeammate and IsTeammate(player) then return end
            local root = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
            local position = root and root.Position or character:GetPivot().Position
            if cfg.DeathChamsEnabled then
                -- Snapshot NOW while character still in last alive pose
                local dStyle = cfg.DeathChamsStyle or "Chams"
                if dStyle == "ForceField" then dStyle = "FF" end
                pcall(UV_CreateChamsClone,
                    character,
                    cfg.Color_DeathChams or Color3.fromRGB(255, 170, 40),
                    cfg.DeathFadeDelay or 1.5,
                    cfg.DeathFadeTime or 1.5,
                    cfg.CloneTransparency or 0.3,
                    dStyle
                )
            end
            if cfg.DeathBurstEnabled then
                pcall(UV_CreateDeathBurst, position)
            end
        end
        local fired = false
        local function fireOnce()
            if fired then return end
            fired = true
            doDeathFX()
        end
        local connHealth = humanoid.HealthChanged:Connect(function(hp)
            if hp <= 0 then fireOnce() end
        end)
        local conn = humanoid.Died:Connect(function()
            fireOnce()
        end)
        Cache.UV_DeathConns[player] = Cache.UV_DeathConns[player] or {}
        table.insert(Cache.UV_DeathConns[player], connHealth)
        table.insert(Cache.UV_DeathConns[player], conn)
    end
    if player.Character then task.spawn(setupCharacter, player.Character) end
    player.CharacterAdded:Connect(function(char)
        task.defer(function() setupCharacter(char) end)
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(UV_SetupDeath, player)
end
Players.PlayerAdded:Connect(UV_SetupDeath)
Players.PlayerRemoving:Connect(function(player)
    if Cache.UV_DeathConns and Cache.UV_DeathConns[player] then
        for _, c in ipairs(Cache.UV_DeathConns[player]) do
            pcall(function() c:Disconnect() end)
        end
        Cache.UV_DeathConns[player] = nil
    end
end)

-- ===== Kill Flash (fullscreen) =====
Cache.KillFlashFrame = nil
Cache.KillFlashToken = 0

local function EnsureKillFlashFrame()
    if Cache.KillFlashFrame and Cache.KillFlashFrame.Parent then
        return Cache.KillFlashFrame
    end
    local f = Instance.new("Frame")
    f.Name = "AnxiumKillFlash"
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundColor3 = Config.Color_KillFlash or Color3.fromRGB(255, 255, 255)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 1000
    f.Visible = false
    f.Parent = ScreenGui
    Cache.KillFlashFrame = f
    return f
end

local function TriggerKillFlash(color)
    if not Config or not Config.KillFlashEnabled then return end
    local f = EnsureKillFlashFrame()
    local col = color or Config.Color_KillFlash or Color3.fromRGB(255, 255, 255)
    local dur = math.clamp(tonumber(Config.KillFlashDuration) or 0.85, 0.15, 3)
    Cache.KillFlashToken = (Cache.KillFlashToken or 0) + 1
    local token = Cache.KillFlashToken
    f.BackgroundColor3 = col
    f.BackgroundTransparency = 0.15
    f.Visible = true
    task.spawn(function()
        task.wait(0.06)
        if token ~= Cache.KillFlashToken then return end
        local tw = TweenService:Create(f, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        tw:Play()
        tw.Completed:Wait()
        if token == Cache.KillFlashToken then
            f.Visible = false
            f.BackgroundTransparency = 1
        end
    end)
end


-- ===== Hitbox Expander (client-side size + visual) =====
Cache.HitboxData = Cache.HitboxData or {} -- [player] = { parts = {part=origSize}, adorns = {} }

local HITBOX_PARTS = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso", "Torso"}

function Hitbox_ClearPlayer(player)
    local data = Cache.HitboxData[player]
    if not data then return end
    if data.parts then
        for part, orig in pairs(data.parts) do
            pcall(function()
                if part and part.Parent then
                    part.Size = orig
                    part.CanCollide = data.collide[part] ~= false
                    part.Transparency = data.trans[part] or part.Transparency
                    part.Material = data.mat[part] or part.Material
                    part.Color = data.color[part] or part.Color
                end
            end)
        end
    end
    if data.adorns then
        for _, a in ipairs(data.adorns) do
            pcall(function() a:Destroy() end)
        end
    end
    Cache.HitboxData[player] = nil
end

function Hitbox_ClearAll()
    for plr in pairs(Cache.HitboxData or {}) do
        Hitbox_ClearPlayer(plr)
    end
    Cache.HitboxData = {}
end

local function Hitbox_ShouldSkip(player)
    if not player or player == LocalPlayer then return true end
    if Config.TeamCheckerEnabled or Config.HitboxTeamCheck then
        if IsTeammate and IsTeammate(player) then return true end
    end
    return false
end

local function Hitbox_ApplyPlayer(player)
    if Hitbox_ShouldSkip(player) then
        Hitbox_ClearPlayer(player)
        return
    end
    local char = player.Character
    if not char then
        Hitbox_ClearPlayer(player)
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then
        Hitbox_ClearPlayer(player)
        return
    end

    local size = math.clamp(tonumber(Config.HitboxSize) or 6, 1, 30)
    local col = Config.Color_Hitbox or Color3.fromRGB(255, 80, 80)
    local show = Config.HitboxShow == true

    local data = Cache.HitboxData[player]
    if not data then
        data = { parts = {}, collide = {}, trans = {}, mat = {}, color = {}, adorns = {} }
        Cache.HitboxData[player] = data
    end

    for _, name in ipairs(HITBOX_PARTS) do
        local part = char:FindFirstChild(name)
        if part and part:IsA("BasePart") then
            if not data.parts[part] then
                data.parts[part] = part.Size
                data.collide[part] = part.CanCollide
                data.trans[part] = part.Transparency
                data.mat[part] = part.Material
                data.color[part] = part.Color
            end
            local orig = data.parts[part]
            -- Expand mainly XZ for body, keep some height
            local yMul = (name == "Head") and 1.0 or 0.55
            local newSize = Vector3.new(
                math.max(orig.X, size),
                math.max(orig.Y, size * yMul),
                math.max(orig.Z, size)
            )
            pcall(function()
                part.Size = newSize
                part.CanCollide = false -- don't push physics weirdly
                if show then
                    part.Transparency = 0.55
                    part.Material = Enum.Material.ForceField
                    part.Color = col
                else
                    part.Transparency = data.trans[part] or 0
                    part.Material = data.mat[part] or Enum.Material.Plastic
                    part.Color = data.color[part] or part.Color
                end
            end)
        end
    end
end

-- Heartbeat update (throttled)
Cache.HitboxLastTick = 0
RunService.Heartbeat:Connect(function()
    if not Config.HitboxEnabled then
        if next(Cache.HitboxData or {}) then
            Hitbox_ClearAll()
        end
        return
    end
    local now = tick()
    if now - (Cache.HitboxLastTick or 0) < 0.12 then return end
    Cache.HitboxLastTick = now
    for _, player in ipairs(CachedPlayerList) do
        if player ~= LocalPlayer then
            pcall(Hitbox_ApplyPlayer, player)
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    Hitbox_ClearPlayer(p)
end)

local function OnVictimDied(victimPlayer, humanoid)
    if not victimPlayer or victimPlayer == LocalPlayer then return end
    if not humanoid then return end
    if Cache.KillHandledHum[humanoid] then return end
    Cache.KillHandledHum[humanoid] = true

    local function onMyKill()
        TryPlayKillSound(victimPlayer)
        pcall(function()
            if Config.KillFlashEnabled then
                TriggerKillFlash(Config.Color_KillFlash)
            end
        end)
    end

    local now0 = tick()
    local recentShot0 = (now0 - (Cache.LastShotTime or 0)) < 4.0
    local recentHit0 = Cache.RecentDamageTargets[victimPlayer] and (now0 - Cache.RecentDamageTargets[victimPlayer]) < 4.0
    local wasTarget = Cache.LastShotTarget == victimPlayer
        or Cache.AimLockTarget == victimPlayer
        or Cache.SilentAimTarget == victimPlayer
        or recentHit0

    if (recentShot0 and wasTarget) or recentHit0 then
        onMyKill()
        return
    end

    task.delay(0.2, function()
        local isKiller, enemyTag = IsLocalPlayerKiller(humanoid)
        if isKiller then
            onMyKill()
            return
        end
        if enemyTag then return end
        local now = tick()
        if (now - (Cache.LastShotTime or 0)) < 4.0 then
            onMyKill()
        end
    end)
end

local function UnhookHumanoid(hum)
    local list = Cache.KillHumConnections[hum]
    if list then
        for _, c in ipairs(list) do
            pcall(function() c:Disconnect() end)
        end
        Cache.KillHumConnections[hum] = nil
    end
end

local function HookPlayerForKillSound(player)
    if player == LocalPlayer then return end
    if Cache.KillHooked[player] then return end
    Cache.KillHooked[player] = true

    local function hookChar(char)
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
        if not hum then return end

        UnhookHumanoid(hum)
        Cache.KillHandledHum[hum] = nil

        local conns = {}
        conns[#conns + 1] = hum.Died:Connect(function()
            OnVictimDied(player, hum)
        end)

        local lastHp = hum.Health
        conns[#conns + 1] = hum.HealthChanged:Connect(function(hp)
            if lastHp > 0 and hp <= 0 then
                OnVictimDied(player, hum)
            end
            lastHp = hp
        end)

        conns[#conns + 1] = char.AncestryChanged:Connect(function(_, parent)
            if parent == nil then
                UnhookHumanoid(hum)
            end
        end)

        Cache.KillHumConnections[hum] = conns
    end

    if player.Character then
        task.spawn(hookChar, player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        task.delay(0.25, function()
            if player.Character == char then
                hookChar(char)
            end
        end)
    end)
end

-- Track shots without requiring triggerbot (mouse + tool activated)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Cache.LastShotTime = tick()
        CaptureCrosshairTarget()
        -- tracer is spawned by the dedicated tracer InputBegan (avoid double)
    end
end)

-- Tool.Activated works even when gameProcessed swallows mouse input
local function HookLocalTools(char)
    if not char then return end
    local function onTool(tool)
        if not tool:IsA("Tool") then return end
        tool.Activated:Connect(function()
            Cache.LastShotTime = tick()
            CaptureCrosshairTarget()
            FireBulletTracer()
        end)
    end
    for _, ch in ipairs(char:GetChildren()) do
        if ch:IsA("Tool") then onTool(ch) end
    end
    char.ChildAdded:Connect(function(ch)
        if ch:IsA("Tool") then
            task.defer(function() onTool(ch) end)
        end
    end)
end
if LocalPlayer.Character then task.spawn(HookLocalTools, LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(char)
    task.defer(function() HookLocalTools(char) end)
end)

for _, p in ipairs(Players:GetPlayers()) do
    task.spawn(HookPlayerForKillSound, p)
end
Players.PlayerAdded:Connect(HookPlayerForKillSound)
Players.PlayerRemoving:Connect(function(p)
    Cache.KillHooked[p] = nil
    Cache.KillSoundPlayedFor[p] = nil
    Cache.RecentDamageTargets[p] = nil
    if Cache.LastShotTarget == p then Cache.LastShotTarget = nil end
end)

task.spawn(function()
    local hasWrite = typeof(writefile) == "function"
    local hasGetCustom = typeof(getcustomasset) == "function"

    if not hasWrite or not hasGetCustom then return end

    local hasIsfile = typeof(isfile) == "function"
    local loaded = 0
    local downloaded = 0

    for name, data in pairs(FIRE_SOUND_FILES) do
        local alreadyOnDisk = false
        if hasIsfile then
            pcall(function() alreadyOnDisk = isfile(data.file) end)
        end

        if alreadyOnDisk then
            local okAsset, asset = pcall(function() return getcustomasset(data.file) end)
            if okAsset and asset then
                Cache.FireSoundAssets[name] = asset
                loaded = loaded + 1
            end
        else
            local okHttp, body = pcall(function() return game:HttpGet(data.url) end)
            if okHttp and body and #body > 0 then
                if pcall(writefile, data.file, body) then
                    local okAsset, asset = pcall(function() return getcustomasset(data.file) end)
                    if okAsset and asset then
                        Cache.FireSoundAssets[name] = asset
                        loaded = loaded + 1
                        downloaded = downloaded + 1
                    end
                end
            end
        end
    end

    if loaded > 0 then
        Cache.FireSoundsReady = true
    end
end)


-- Register keybind toggles (mirrors menu buttons)
local function _reg(key, fn)
    if Cache and Cache.BindToggles then Cache.BindToggles[key] = fn end
end
-- Map common UI for bind fallback updates
pcall(function()
    Cache.FeatureUI = Cache.FeatureUI or {}
    local map = {
        AimEnabled = { AimBg, AimKnob },
        SilentAimEnabled = { SilentAimBg, SilentAimKnob },
        TriggerbotEnabled = { TriggerbotBg, TriggerbotKnob },
        BoxEspEnabled = { BoxEspBg, BoxEspKnob },
        BoxFillGradientEnabled = { BoxFillBg, BoxFillKnob },
        ChamsEnabled = { ChamsBg, ChamsKnob },
        NameEspEnabled = { NameEspBg, NameEspKnob },
        HealthbarEspEnabled = { HealthbarEspBg, HealthbarEspKnob },
        FullbrightEnabled = { FullBg, FullKnob },
        TeamCheckerEnabled = { TeamCheckerBg, TeamCheckerKnob },
        ThirdPersonEnabled = { ThirdPersonBg, ThirdPersonKnob },
        ForceFieldEnabled = { FFBg, FFKnob },
        BulletTracersEnabled = { BulletTracerBg, BulletTracerKnob },
        HitboxEnabled = { HitboxBg, HitboxKnob },
        SpeedHackEnabled = { SpeedBg, SpeedKnob },
        FlyEnabled = { FlyBg, FlyKnob },
        NoclipEnabled = { NoclipBg, NoclipKnob },
        BHopEnabled = { BHopBg, BHopKnob },
        CrosshairEnabled = { CrossBg, CrossKnob },
        ShowFovEnabled = { ShowFovBg, ShowFovKnob },
        ShowSilentFovEnabled = { ShowSilentFovBg, ShowSilentFovKnob },
        SpinEnabled = { SpinBg, SpinKnob },
        AntiAimEnabled = { AntiAimBg, AntiAimKnob },
        TargetHudEnabled = { TargetHudBg, TargetHudKnob },
        FogEnabled = { FogBg, FogKnob },
        TrailEnabled = { TrailBg, TrailKnob },
        ChinaHatEnabled = { HatBg, HatKnob },
        OrbitOrbsEnabled = { OrbitOrbsBg, OrbitOrbsKnob },
        SkeletonEnabled = { SkelBg, SkelKnob },
        TracersEnabled = { TracerBg, TracerKnob },
        DistanceEspEnabled = { DistEspBg, DistEspKnob },
        MultiJumpEnabled = { JumpBg, JumpKnob },
        WeaponForceFieldEnabled = { WeaponFFBg, WeaponFFKnob },
        ActiveListEnabled = { ActiveListBg, ActiveListKnob },
        BindListEnabled = { BindListBg, BindListKnob },
        FakeFpsEnabled = { FakeFpsBg, FakeFpsKnob },
        CustomFireSoundEnabled = { FireSoundBg, FireSoundKnob },
        AspectRatioEnabled = { AspectBg, AspectKnob },
        FootstepsEnabled = { FootstepsBg, FootstepsKnob },
        DarkModeEnabled = { DarkModeBg, DarkModeKnob },
        AuraEnabled = { AuraBg, AuraKnob },
    }
    for k, v in pairs(map) do
        if v[1] and v[2] then
            Cache.FeatureUI[k] = { bg = v[1], knob = v[2] }
        end
    end
end)
pcall(function()
    _reg("TeamCheckerEnabled", function()
        Config.TeamCheckerEnabled = not Config.TeamCheckerEnabled
        UpdateSwitch(Config.TeamCheckerEnabled, TeamCheckerBg, TeamCheckerKnob, "Team Checker")
        Cache.TeamCache = {}
    end)
    _reg("AimEnabled", function()
        Config.AimEnabled = not Config.AimEnabled
        UpdateSwitch(Config.AimEnabled, AimBg, AimKnob, "Aimbot")
    end)
    _reg("ShowFovEnabled", function()
        Config.ShowFovEnabled = not Config.ShowFovEnabled
        UpdateSwitch(Config.ShowFovEnabled, ShowFovBg, ShowFovKnob, "Show FOV")
    end)
    _reg("SilentAimEnabled", function()
        Config.SilentAimEnabled = not Config.SilentAimEnabled
        UpdateSwitch(Config.SilentAimEnabled, SilentAimBg, SilentAimKnob, "Silent Aim")
        if not Config.SilentAimEnabled then
            Cache.SilentAimTarget = nil
            Cache.SilentAimPart = nil
            Cache.SilentAimPos = nil
        end
    end)
    _reg("ShowSilentFovEnabled", function()
        Config.ShowSilentFovEnabled = not Config.ShowSilentFovEnabled
        UpdateSwitch(Config.ShowSilentFovEnabled, ShowSilentFovBg, ShowSilentFovKnob, "Show Silent FOV")
    end)
    _reg("TriggerbotEnabled", function()
        Config.TriggerbotEnabled = not Config.TriggerbotEnabled
        UpdateSwitch(Config.TriggerbotEnabled, TriggerbotBg, TriggerbotKnob, "Triggerbot")
    end)
    _reg("TargetHudEnabled", function()
        Config.TargetHudEnabled = not Config.TargetHudEnabled
        UpdateSwitch(Config.TargetHudEnabled, TargetHudBg, TargetHudKnob, "Target HUD")
    end)
    _reg("SpinEnabled", function()
        Config.SpinEnabled = not Config.SpinEnabled
        UpdateSwitch(Config.SpinEnabled, SpinBg, SpinKnob, "SpinBot")
    end)
    _reg("AntiAimEnabled", function()
        Config.AntiAimEnabled = not Config.AntiAimEnabled
        UpdateSwitch(Config.AntiAimEnabled, AntiAimBg, AntiAimKnob, "Anti-Aim")
        if not Config.AntiAimEnabled then
            pcall(AntiAim_RestoreMotors)
        else
            Cache.AntiAimMotorBases = {}
            Cache.AntiAimSpinAngle = 0
        end
    end)
    _reg("BoxEspEnabled", function()
        Config.BoxEspEnabled = not Config.BoxEspEnabled
        UpdateSwitch(Config.BoxEspEnabled, BoxEspBg, BoxEspKnob, "2D Box ESP")
    end)
    _reg("BoxFillGradientEnabled", function()
        Config.BoxFillGradientEnabled = not Config.BoxFillGradientEnabled
        UpdateSwitch(Config.BoxFillGradientEnabled, BoxFillBg, BoxFillKnob, "Box Fill Gradient")
    end)
    _reg("HealthbarEspEnabled", function()
        Config.HealthbarEspEnabled = not Config.HealthbarEspEnabled
        UpdateSwitch(Config.HealthbarEspEnabled, HealthbarEspBg, HealthbarEspKnob, "Healthbar ESP")
    end)
    _reg("ChamsEnabled", function()
        Config.ChamsEnabled = not Config.ChamsEnabled
        UpdateSwitch(Config.ChamsEnabled, ChamsBg, ChamsKnob, "Chams")
    end)
    _reg("NameEspEnabled", function()
        Config.NameEspEnabled = not Config.NameEspEnabled
        UpdateSwitch(Config.NameEspEnabled, NameEspBg, NameEspKnob, "Name ESP")
    end)
    _reg("DistanceEspEnabled", function()
        Config.DistanceEspEnabled = not Config.DistanceEspEnabled
        UpdateSwitch(Config.DistanceEspEnabled, DistEspBg, DistEspKnob, "Distance ESP")
    end)
    _reg("SkeletonEnabled", function()
        Config.SkeletonEnabled = not Config.SkeletonEnabled
        UpdateSwitch(Config.SkeletonEnabled, SkelBg, SkelKnob, "Skeleton ESP")
    end)
    _reg("TracersEnabled", function()
        Config.TracersEnabled = not Config.TracersEnabled
        UpdateSwitch(Config.TracersEnabled, TracerBg, TracerKnob, "Tracers")
    end)
    _reg("CrosshairEnabled", function()
        Config.CrosshairEnabled = not Config.CrosshairEnabled
        UpdateSwitch(Config.CrosshairEnabled, CrossBg, CrossKnob, "Crosshair")
        pcall(function() UserInputService.MouseIconEnabled = not Config.CrosshairEnabled end)
    end)
    _reg("SpinCrosshairEnabled", function()
        Config.SpinCrosshairEnabled = not Config.SpinCrosshairEnabled
        UpdateSwitch(Config.SpinCrosshairEnabled, SpinCrossBg, SpinCrossKnob, "Spin Crosshair")
    end)
    _reg("DamageNumbersEnabled", function()
        Config.DamageNumbersEnabled = not Config.DamageNumbersEnabled
        UpdateSwitch(Config.DamageNumbersEnabled, DmgNumBg, DmgNumKnob, "Damage Numbers")
    end)
    _reg("SelfChamsEnabled", function()
        Config.SelfChamsEnabled = not Config.SelfChamsEnabled
        UpdateSwitch(Config.SelfChamsEnabled, SelfChamsBg, SelfChamsKnob, "Self Chams")
    end)
    _reg("CloneChamsEnabled", function()
        Config.CloneChamsEnabled = not Config.CloneChamsEnabled
        UpdateSwitch(Config.CloneChamsEnabled, CloneChamsBg, CloneChamsKnob, "Clone player")
    end)
    _reg("OffscreenArrowsEnabled", function()
        Config.OffscreenArrowsEnabled = not Config.OffscreenArrowsEnabled
        UpdateSwitch(Config.OffscreenArrowsEnabled, OffscreenBg, OffscreenKnob, "Offscreen Arrows")
        if not Config.OffscreenArrowsEnabled and UV_ClearArrows then UV_ClearArrows() end
    end)
    _reg("DeathChamsEnabled", function()
        Config.DeathChamsEnabled = not Config.DeathChamsEnabled
        UpdateSwitch(Config.DeathChamsEnabled, DeathChamsBg, DeathChamsKnob, "Death player")
    end)
    _reg("DeathBurstEnabled", function()
        Config.DeathBurstEnabled = not Config.DeathBurstEnabled
        UpdateSwitch(Config.DeathBurstEnabled, DeathBurstBg, DeathBurstKnob, "Death Burst")
    end)
    _reg("FullbrightEnabled", function()
        Config.FullbrightEnabled = not Config.FullbrightEnabled
        UpdateSwitch(Config.FullbrightEnabled, FullBg, FullKnob, "Fullbright")
    end)
    _reg("DarkModeEnabled", function()
        Config.DarkModeEnabled = not Config.DarkModeEnabled
        UpdateSwitch(Config.DarkModeEnabled, DarkModeBg, DarkModeKnob, "Dark Mode")
    end)
    _reg("ChinaHatEnabled", function()
        Config.ChinaHatEnabled = not Config.ChinaHatEnabled
        UpdateSwitch(Config.ChinaHatEnabled, HatBg, HatKnob, "China Hat")
    end)
    _reg("OrbitOrbsEnabled", function()
        Config.OrbitOrbsEnabled = not Config.OrbitOrbsEnabled
        UpdateSwitch(Config.OrbitOrbsEnabled, OrbitOrbsBg, OrbitOrbsKnob, "Neon Orbit")
    end)
    _reg("TrailEnabled", function()
        Config.TrailEnabled = not Config.TrailEnabled
        UpdateSwitch(Config.TrailEnabled, TrailBg, TrailKnob, "Motion Trail")
    end)
    _reg("FogEnabled", function()
        Config.FogEnabled = not Config.FogEnabled
        UpdateSwitch(Config.FogEnabled, FogBg, FogKnob, "Custom Fog")
    end)
    _reg("FootstepsEnabled", function()
        Config.FootstepsEnabled = not Config.FootstepsEnabled
        UpdateSwitch(Config.FootstepsEnabled, FootstepsBg, FootstepsKnob, "Jump Circles")
    end)
    _reg("AspectRatioEnabled", function()
        Config.AspectRatioEnabled = not Config.AspectRatioEnabled
        UpdateSwitch(Config.AspectRatioEnabled, AspectBg, AspectKnob, "Aspect Ratio")
    end)
    _reg("ThirdPersonEnabled", function()
        Config.ThirdPersonEnabled = not Config.ThirdPersonEnabled
        UpdateSwitch(Config.ThirdPersonEnabled, ThirdPersonBg, ThirdPersonKnob, "Third Person")
        pcall(function()
            if Config.ThirdPersonEnabled then
                if ThirdPerson_Enable then ThirdPerson_Enable() end
            else
                if ThirdPerson_Disable then ThirdPerson_Disable() end
            end
        end)
    end)
    _reg("ForceFieldEnabled", function()
        Config.ForceFieldEnabled = not Config.ForceFieldEnabled
        UpdateSwitch(Config.ForceFieldEnabled, FFBg, FFKnob, "Body ForceField")
        pcall(function()
            if SetForceFieldEnabled then SetForceFieldEnabled(Config.ForceFieldEnabled)
            elseif ApplyForceField then ApplyForceField(Config.ForceFieldEnabled) end
        end)
    end)
    _reg("WeaponForceFieldEnabled", function()
        Config.WeaponForceFieldEnabled = not Config.WeaponForceFieldEnabled
        UpdateSwitch(Config.WeaponForceFieldEnabled, WeaponFFBg, WeaponFFKnob, "Weapon ForceField")
    end)
    _reg("KillFlashEnabled", function()
        Config.KillFlashEnabled = not Config.KillFlashEnabled
        UpdateSwitch(Config.KillFlashEnabled, KillFlashBg, KillFlashKnob, "Kill Flash")
    end)
    _reg("HitboxEnabled", function()
        Config.HitboxEnabled = not Config.HitboxEnabled
        UpdateSwitch(Config.HitboxEnabled, HitboxBg, HitboxKnob, "Hitbox Expander")
        if not Config.HitboxEnabled and Hitbox_ClearAll then Hitbox_ClearAll() end
    end)
    _reg("BulletTracersEnabled", function()
        Config.BulletTracersEnabled = not Config.BulletTracersEnabled
        UpdateSwitch(Config.BulletTracersEnabled, BulletTracerBg, BulletTracerKnob, "Bullet Tracers")
    end)
    _reg("AuraEnabled", function()
        Config.AuraEnabled = not Config.AuraEnabled
        UpdateSwitch(Config.AuraEnabled, AuraBg, AuraKnob, "Aura")
    end)
    _reg("ClassicPinkEnabled", function()
        Config.ClassicPinkEnabled = not Config.ClassicPinkEnabled
        UpdateSwitch(Config.ClassicPinkEnabled, ClassicPinkBg, ClassicPinkKnob, "Pink Aura")
    end)
    _reg("ClassicAngelEnabled", function()
        Config.ClassicAngelEnabled = not Config.ClassicAngelEnabled
        UpdateSwitch(Config.ClassicAngelEnabled, ClassicAngelBg, ClassicAngelKnob, "Angel Wing")
    end)
    _reg("SpeedHackEnabled", function()
        Config.SpeedHackEnabled = not Config.SpeedHackEnabled
        UpdateSwitch(Config.SpeedHackEnabled, SpeedBg, SpeedKnob, "Speed Hack")
    end)
    _reg("MultiJumpEnabled", function()
        Config.MultiJumpEnabled = not Config.MultiJumpEnabled
        UpdateSwitch(Config.MultiJumpEnabled, JumpBg, JumpKnob, "Multi Jump")
    end)
    _reg("NoclipEnabled", function()
        Config.NoclipEnabled = not Config.NoclipEnabled
        UpdateSwitch(Config.NoclipEnabled, NoclipBg, NoclipKnob, "Noclip")
    end)
    _reg("FlyEnabled", function()
        Config.FlyEnabled = not Config.FlyEnabled
        UpdateSwitch(Config.FlyEnabled, FlyBg, FlyKnob, "Fly")
    end)
    _reg("BHopEnabled", function()
        Config.BHopEnabled = not Config.BHopEnabled
        UpdateSwitch(Config.BHopEnabled, BHopBg, BHopKnob, "Bunny Hop")
    end)
    _reg("CustomFireSoundEnabled", function()
        Config.CustomFireSoundEnabled = not Config.CustomFireSoundEnabled
        UpdateSwitch(Config.CustomFireSoundEnabled, FireSoundBg, FireSoundKnob, "Hit Sounds")
    end)
    _reg("ActiveListEnabled", function()
        Config.ActiveListEnabled = not Config.ActiveListEnabled
        UpdateSwitch(Config.ActiveListEnabled, ActiveListBg, ActiveListKnob, "Active Modules HUD")
    end)
    _reg("BindListEnabled", function()
        Config.BindListEnabled = not Config.BindListEnabled
        if BindListBg then UpdateSwitch(Config.BindListEnabled, BindListBg, BindListKnob, "Binds HUD") end
        if UpdateBindList then UpdateBindList() end
    end)
    _reg("FakeFpsEnabled", function()
        Config.FakeFpsEnabled = not Config.FakeFpsEnabled
        UpdateSwitch(Config.FakeFpsEnabled, FakeFpsBg, FakeFpsKnob, "Fake FPS")
        if UpdateFakeFpsDisplay then UpdateFakeFpsDisplay() end
    end)
end)
if UpdateBindList then UpdateBindList() end


print("Anxium loaded")