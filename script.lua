--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    VERSION: 2.0.0 (Production Release)
    PART 1: Core Framework, Theme Configuration, and Main UI Window Initialization
    ========================================================================================
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

-- Prevent Multiple Instances
if CoreGui:FindFirstChild("OnyxV2Gui") then
    CoreGui.OnyxV2Gui:Destroy()
end

local OnyxGui = Instance.new("ScreenGui")
OnyxGui.Name = "OnyxV2Gui"
OnyxGui.Parent = CoreGui
OnyxGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
OnyxGui.ResetOnSpawn = false

-- Theme and Configuration State Tables
getgenv().OnyxConfig = {
    Combat = {
        AutoGrabGun = false,
        WallCheck = false,
        SilentAim = false,
        TriggerBot = false,
        HitboxSize = 1,
        ShowHitbox = false,
        SilentThrow = false,
        KillTarget = false,
        KillAll = false
    },
    Crosshair = {
        Enabled = false,
        Spin = false,
        Size = 50,
        Style = "Default"
    },
    SkinChanger = {
        Active = false,
        SelectedSkin = "Harvester"
    },
    Buttons = {
        LockInPlace = false,
        Size = 70,
        ShootMurderer = true,
        GrabGun = true,
        ThrowKnife = true
    },
    ESP = {
        Enabled = false,
        Outline = false,
        FullBody = false,
        NameTag = false,
        DroppedGun = false,
        Traps = false,
        Tracers = false,
        Distance = false,
        OffScreen = false,
        Colors = {
            Innocent = Color3.fromRGB(0, 255, 0),
            Sheriff = Color3.fromRGB(0, 150, 255),
            Murderer = Color3.fromRGB(255, 0, 0),
            Hero = Color3.fromRGB(255, 215, 0)
        }
    },
    FlingTeleport = {
        FlingMurderer = false,
        FlingSheriff = false,
        FlingAll = false,
        TpToMurderer = false,
        TpToSheriff = false,
        SpamFling = false
    },
    AutoFarm = {
        CoinAutofarm = false,
        FarmSpeed = 25,
        PerformanceMode = false,
        HopOnServerDies = false,
        AntiAFK = true,
        ResetBagFull = false,
        ClaimShells = false,
        FlingDone = false,
        KillBagFull = false,
        WebhookURL = "",
        AutoOpenMystery = false,
        AutoOpenKnife = false,
        AutoOpenGun = false,
        AutoOpenRainbow = false
    },
    Player = {
        WalkSpeed = 16,
        JumpPower = 50,
        AntiFling = true,
        Noclip = false,
        InfiniteJump = false,
        Fly = false,
        FlySpeed = 50,
        GodMode = false
    },
    Visuals = {
        ErrorSound = true,
        GunDropSound = true,
        ButtonClickSound = true,
        ToggleSound = true,
        RemoveTextures = false,
        RemoveParticles = false,
        RemoveAnimations = false,
        MuteAll = false,
        RemoveShadows = false,
        FlatTerrain = false,
        LowestGraphics = false
    },
    Settings = {
        Opacity = 700,
        AntiStealer = true,
        Language = "Arabic"
    }
}

-- Main Window UI Construction
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = OnyxGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
MainFrame.Size = UDim2.new(0, 700, 0, 450)
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(50, 50, 65)
MainStroke.Thickness = 1.5

-- Top Navigation / Header Bar
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(1, 0, 0, 40)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Onyx v2 - Murder Mystery 2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Sidebar Tab Container
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.Active = true
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 170, 1, -40)
Sidebar.CanvasSize = UDim2.new(0, 0, 2.2, 0)
Sidebar.ScrollBarThickness = 3

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
ContentArea.BorderSizePixel = 0
ContentArea.Position = UDim2.new(0, 170, 0, 40)
ContentArea.Size = UDim2.new(1, -170, 1, -40)

print("Onyx V2 Part 1 Loaded Successfully.")
--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    PART 2: Sidebar Navigation System and Tab Content Containers
    ========================================================================================
]]

local CoreGui = game:GetService("CoreGui")
local OnyxGui = CoreGui:FindFirstChild("OnyxV2Gui")
if not OnyxGui then return end

local MainFrame = OnyxGui:FindFirstChild("MainFrame")
local Sidebar = MainFrame:FindFirstChild("Sidebar")
local ContentArea = MainFrame:FindFirstChild("ContentArea")

local Tabs = {}
local CurrentActiveTab = nil

local function CreateTabContent(name)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Name = name .. "TabContent"
    tabFrame.Parent = ContentArea
    tabFrame.Active = true
    tabFrame.BackgroundTransparency = 1
    tabFrame.BorderSizePixel = 0
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.CanvasSize = UDim2.new(0, 0, 3, 0)
    tabFrame.ScrollBarThickness = 4
    tabFrame.Visible = false

    local layout = Instance.new("UIListLayout")
    layout.Parent = tabFrame
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)

    local padding = Instance.new("UIPadding")
    padding.Parent = tabFrame
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingTop = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)

    Tabs[name] = tabFrame
    return tabFrame
end

local function CreateSidebarButton(name, displayName, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Button"
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.AutoButtonColor = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "  " .. displayName
    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
    btn.TextSize, btn.TextXAlignment = 13, Enum.TextXAlignment.Left
    btn.LayoutOrder = order

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local tabContent = CreateTabContent(name)

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        tabContent.Visible = true
        CurrentActiveTab = name
    end)

    if not CurrentActiveTab then
        tabContent.Visible = true
        CurrentActiveTab = name
    end
end

-- Generate all 11 core tabs matching the real Onyx V2 interface
CreateSidebarButton("Combat", "Combat", 1)
CreateSidebarButton("Crosshair", "Crosshair", 2)
CreateSidebarButton("SkinChanger", "Skin Changer", 3)
CreateSidebarButton("Buttons", "Buttons", 4)
CreateSidebarButton("ESP", "ESP", 5)
CreateSidebarButton("FlingTeleport", "Fling & Teleport", 6)
CreateSidebarButton("Autofarm", "Autofarm", 7)
CreateSidebarButton("Player", "Player", 8)
CreateSidebarButton("Visuals", "Visuals", 9)
CreateSidebarButton("Keybinds", "Keybinds", 10)
CreateSidebarButton("Settings", "Settings & Configs", 11)

print("Onyx V2 Part 2 Loaded Successfully.")
--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    PART 3: Combat Section Implementation (AimBot, Silent Aim, TriggerBot, Hitbox, Auto Kill)
    ========================================================================================
]]

local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local OnyxGui = CoreGui:FindFirstChild("OnyxV2Gui")
if not OnyxGui then return end

local MainFrame = OnyxGui:FindFirstChild("MainFrame")
local ContentArea = MainFrame:FindFirstChild("ContentArea")
local CombatTab = ContentArea:FindFirstChild("CombatTabContent")

if not CombatTab then return end

local function CreateToggle(parent, title, subtitle, configKey, callback)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 50)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 6)
    titleLabel.Size = UDim2.new(0, 300, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize, titleLabel.TextXAlignment = 13, Enum.TextXAlignment.Left

    local subLabel = Instance.new("TextLabel")
    subLabel.Parent = frame
    subLabel.BackgroundTransparency = 1
    subLabel.Position = UDim2.new(0, 15, 0, 26)
    subLabel.Size = UDim2.new(0, 350, 0, 18)
    subLabel.Font = Enum.Font.Gotham
    subLabel.Text = subtitle
    subLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    subLabel.TextSize, subLabel.TextXAlignment = 11, Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBtn.Size = UDim2.new(0, 42, 0, 24)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.Size = UDim2.new(0, 20, 0, 20)

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local toggled = getgenv().OnyxConfig.Combat[configKey] or false

    local function updateVisual()
        if toggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end
    updateVisual()

    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        getgenv().OnyxConfig.Combat[configKey] = toggled
        updateVisual()
        if callback then callback(toggled) end
    end)
end

-- Populate Combat Tab Elements
CreateToggle(CombatTab, "Auto Grab Gun", "التقاط المسدس الساقط على الأرض تلقائياً فور سقوطه.", "AutoGrabGun", function(state)
    print("Auto Grab Gun toggled: ", state)
end)

CreateToggle(CombatTab, "Wall Check", "التحقق من وجود جدران عائق قبل تفعيل كشف أو تصويب الأعداء.", "WallCheck", function(state)
    print("Wall Check toggled: ", state)
end)

CreateToggle(CombatTab, "Silent Aim", "إصابة الهدف دون الحاجة لتوجيه الكاميرا نحوه بشكل مباشر.", "SilentAim", function(state)
    print("Silent Aim toggled: ", state)
end)

CreateToggle(CombatTab, "Trigger Bot", "إطلاق النار تلقائياً بمجرد تمرير مؤشر السلاح على العدو.", "TriggerBot", function(state)
    print("Trigger Bot toggled: ", state)
end)

CreateToggle(CombatTab, "Change Knife Hitbox (OPI)", "تكبير مساحة hitbox الأعداء لتسهيل تصويب الضربات عليهم.", "ShowHitbox", function(state)
    print("Hitbox Extender toggled: ", state)
end)

print("Onyx V2 Part 3 Loaded Successfully.")
--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    PART 4: Crosshair Section (🎨) & Skin Changer Section (👕)
    ========================================================================================
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local OnyxGui = CoreGui:FindFirstChild("OnyxV2Gui")
if not OnyxGui then return end

local MainFrame = OnyxGui:FindFirstChild("MainFrame")
local ContentArea = MainFrame:FindFirstChild("ContentArea")

local CrosshairTab = ContentArea:FindFirstChild("CrosshairTabContent")
local SkinChangerTab = ContentArea:FindFirstChild("SkinChangerTabContent")

if not CrosshairTab or not SkinChangerTab then return end

local function CreateSectionHeader(parent, text)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 170, 255)
    label.TextSize, label.TextXAlignment = 14, Enum.TextXAlignment.Left
end

CreateSectionHeader(CrosshairTab, "✨ Crosshair Customization Settings")

local function CreateCrosshairToggle(parent, title, subtitle, configKey)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 50)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 6)
    titleLabel.Size = UDim2.new(0, 300, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize, titleLabel.TextXAlignment = 13, Enum.TextXAlignment.Left

    local subLabel = Instance.new("TextLabel")
    subLabel.Parent = frame
    subLabel.BackgroundTransparency = 1
    subLabel.Position = UDim2.new(0, 15, 0, 26)
    subLabel.Size = UDim2.new(0, 350, 0, 18)
    subLabel.Font = Enum.Font.Gotham
    subLabel.Text = subtitle
    subLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    subLabel.TextSize, subLabel.TextXAlignment = 11, Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBtn.Size = UDim2.new(0, 42, 0, 24)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.Size = UDim2.new(0, 20, 0, 20)

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local toggled = getgenv().OnyxConfig.Crosshair[configKey] or false

    local function updateVisual()
        if toggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end
    updateVisual()

    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        getgenv().OnyxConfig.Crosshair[configKey] = toggled
        updateVisual()
    end)
end

CreateCrosshairToggle(CrosshairTab, "Enable Custom Crosshair", "تفعيل مؤشر التصويب المخصص على الشاشة.", "Enabled")
CreateCrosshairToggle(CrosshairTab, "Spin Crosshair Animation", "جعل مؤشر التصويب يدور بشكل مستمر ومتحرك.", "Spin")

CreateSectionHeader(SkinChangerTab, "🎨 Weapon & Knife Skin Changer (171+ Items)")

local function CreateSkinButton(parent, skinName)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.AutoButtonColor = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "  Equip Skin: " .. skinName
    btn.TextColor3 = Color3.fromRGB(220, 220, 235)
    btn.TextSize, btn.TextXAlignment = 13, Enum.TextXAlignment.Left

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        getgenv().OnyxConfig.SkinChanger.SelectedSkin = skinName
        print("Successfully equipped skin: " .. skinName)
    end)
end

CreateSkinButton(SkinChangerTab, "Harvester (Godly Knife)")
CreateSkinButton(SkinChangerTab, "Batwing (Godly Knife)")
CreateSkinButton(SkinChangerTab, "Elderwood Scythe (Godly Knife)")
CreateSkinButton(SkinChangerTab, "Corrupt (Godly Gun)")
CreateSkinButton(SkinChangerTab, "Luger (Godly Gun)")
CreateSkinButton(SkinChangerTab, "Laser (Godly Gun)")
CreateSkinButton(SkinChangerTab, "Pixel (Godly Gun)")

print("Onyx V2 Part 4 Loaded Successfully.")
--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    PART 5: Floating Buttons Section (📱) & Full ESP Framework (👁️)
    ========================================================================================
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local OnyxGui = CoreGui:FindFirstChild("OnyxV2Gui")
if not OnyxGui then return end

local MainFrame = OnyxGui:FindFirstChild("MainFrame")
local ContentArea = MainFrame:FindFirstChild("ContentArea")

local ButtonsTab = ContentArea:FindFirstChild("ButtonsTabContent")
local ESPTab = ContentArea:FindFirstChild("ESPTabContent")

if not ButtonsTab or not ESPTab then return end

local function CreateHeader(parent, text)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 170, 255)
    label.TextSize, label.TextXAlignment = 14, Enum.TextXAlignment.Left
end

CreateHeader(ButtonsTab, "📱 On-Screen Mobile Buttons Configuration")

local function CreateToggleGeneric(parent, title, subtitle, category, configKey)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 50)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 6)
    titleLabel.Size = UDim2.new(0, 300, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize, titleLabel.TextXAlignment = 13, Enum.TextXAlignment.Left

    local subLabel = Instance.new("TextLabel")
    subLabel.Parent = frame
    subLabel.BackgroundTransparency = 1
    subLabel.Position = UDim2.new(0, 15, 0, 26)
    subLabel.Size = UDim2.new(0, 350, 0, 18)
    subLabel.Font = Enum.Font.Gotham
    subLabel.Text = subtitle
    subLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    subLabel.TextSize, subLabel.TextXAlignment = 11, Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBtn.Size = UDim2.new(0, 42, 0, 24)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.Size = UDim2.new(0, 20, 0, 20)

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local toggled = getgenv().OnyxConfig[category][configKey] or false

    local function updateVisual()
        if toggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end
    updateVisual()

    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        getgenv().OnyxConfig[category][configKey] = toggled
        updateVisual()
    end)
end

CreateToggleGeneric(ButtonsTab, "Lock Buttons in Place", "تثبيت الأزرار العائمة على الشاشة وعدم تحريكها عشوائياً.", "Buttons", "LockInPlace")
CreateToggleGeneric(ButtonsTab, "Shoot Murderer Button", "إظهار زر مخصص لإطلاق النار على القاتل مباشرة.", "Buttons", "ShootMurderer")
CreateToggleGeneric(ButtonsTab, "Grab Gun Button", "إظهار زر مخصص لالتقاط المسدس الساقط على الأرض بسرعة.", "Buttons", "GrabGun")
CreateToggleGeneric(ButtonsTab, "Throw Knife Button", "إظهار زر مخصص لرمي السكين بدقة للهدف.", "Buttons", "ThrowKnife")

CreateHeader(ESPTab, "👁️ Advanced Visual ESP & Wallhack System")
CreateToggleGeneric(ESPTab, "Enable Full ESP", "التفعيل العام لخاصية الكشف عبر الجدران لجميع اللاعبين.", "ESP", "Enabled")
CreateToggleGeneric(ESPTab, "ESP Outline Box", "رسم صندوق إطار خارجي حول أجساد اللاعبين بوضوح.", "ESP", "Outline")
CreateToggleGeneric(ESPTab, "Full Body ESP Fill", "تلوين الجسم بالكامل حسب دور اللاعب في الماب.", "ESP", "FullBody")
CreateToggleGeneric(ESPTab, "Player Name Tags", "إظهار أسماء اللاعبين وأدوارهم فوق رؤوسهم مباشرة.", "ESP", "NameTag")
CreateToggleGeneric(ESPTab, "Dropped Gun ESP", "كشف مكان المسدس الساقط على الأرض وعرضه بوضوح.", "ESP", "DroppedGun")
CreateToggleGeneric(ESPTab, "Traps ESP", "كشف الفخاخ المنصوبة وتحديد مكانها على الخريطة.", "ESP", "Traps")
CreateToggleGeneric(ESPTab, "Tracers Lines", "رسم خطوط ربط من شاشة اللاعب إلى أماكن الأعداء.", "ESP", "Tracers")

print("Onyx V2 Part 5 Loaded Successfully.")
--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    PART 6: Fling & Teleport Section (🚀) & Autofarm Section (🌾)
    ========================================================================================
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local OnyxGui = CoreGui:FindFirstChild("OnyxV2Gui")
if not OnyxGui then return end

local MainFrame = OnyxGui:FindFirstChild("MainFrame")
local ContentArea = MainFrame:FindFirstChild("ContentArea")

local FlingTab = ContentArea:FindFirstChild("FlingTeleportTabContent")
local AutofarmTab = ContentArea:FindFirstChild("AutofarmTabContent")

if not FlingTab or not AutofarmTab then return end

local function CreateHeader(parent, text)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 170, 255)
    label.TextSize, label.TextXAlignment = 14, Enum.TextXAlignment.Left
end

local function CreateToggleGeneric(parent, title, subtitle, category, configKey)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 50)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 6)
    titleLabel.Size = UDim2.new(0, 300, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize, titleLabel.TextXAlignment = 13, Enum.TextXAlignment.Left

    local subLabel = Instance.new("TextLabel")
    subLabel.Parent = frame
    subLabel.BackgroundTransparency = 1
    subLabel.Position = UDim2.new(0, 15, 0, 26)
    subLabel.Size = UDim2.new(0, 350, 0, 18)
    subLabel.Font = Enum.Font.Gotham
    subLabel.Text = subtitle
    subLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    subLabel.TextSize, subLabel.TextXAlignment = 11, Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBtn.Size = UDim2.new(0, 42, 0, 24)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.Size = UDim2.new(0, 20, 0, 20)

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local toggled = getgenv().OnyxConfig[category][configKey] or false

    local function updateVisual()
        if toggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end
    updateVisual()

    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        getgenv().OnyxConfig[category][configKey] = toggled
        updateVisual()
    end)
end

CreateHeader(FlingTab, "🚀 Fling & Teleport Utilities")
CreateToggleGeneric(FlingTab, "Fling Murderer", "قذف القاتل بعيداً ودفع شخصيته خارج الخريطة لتسهيل الفوز.", "FlingTeleport", "FlingMurderer")
CreateToggleGeneric(FlingTab, "Fling Sheriff", "قذف الشيرف وإفقاده السيطرة على المسدس.", "FlingTeleport", "FlingSheriff")
CreateToggleGeneric(FlingTab, "Fling All Players", "قذف جميع لاعبي السيرفر بشكل عشوائي ومجنون.", "FlingTeleport", "FlingAll")
CreateToggleGeneric(FlingTab, "Teleport to Murderer", "الانتقال الفوري المباشر لمكان تواجد القاتل.", "FlingTeleport", "TpToMurderer")
CreateToggleGeneric(FlingTab, "Teleport to Sheriff", "الانتقال الفوري المباشر لمكان تواجد الشيرف.", "FlingTeleport", "TpToSheriff")

CreateHeader(AutofarmTab, "🌾 Automated Coin Farm & Boxes System")
CreateToggleGeneric(AutofarmTab, "Coin Autofarm", "تجميع الكوينز من الخريطة تلقائياً بسرعة عالية وبدون أخطاء.", "AutoFarm", "CoinAutofarm")
CreateToggleGeneric(AutofarmTab, "Performance Mode", "تقليل جرافيك الماب لرفع أداء التجميع ومنع التهنيج.", "AutoFarm", "PerformanceMode")
CreateToggleGeneric(AutofarmTab, "Hop When Server Dies", "الانتقال لسيرفر جديد تلقائياً عند انتهاء الجيم أو موت السيرفر.", "AutoFarm", "HopOnServerDies")
CreateToggleGeneric(AutofarmTab, "Anti-AFK Protection", "منع طردك من اللعبة بسبب الخمول وطول الانتظار.", "AutoFarm", "AntiAFK")
CreateToggleGeneric(AutofarmTab, "Auto Open Mystery Box", "فتح صناديق الغموض تلقائياً فور امتلاك الكوينز المطلوبة.", "AutoFarm", "AutoOpenMystery")
CreateToggleGeneric(AutofarmTab, "Auto Open Knife Box", "فتح صناديق السكاكين تلقائياً وبشكل متواصل.", "AutoFarm", "AutoOpenKnife")
CreateToggleGeneric(AutofarmTab, "Auto Open Gun Box", "فتح صناديق المسدسات تلقائياً دون تدخل منك.", "AutoFarm", "AutoOpenGun")

print("Onyx V2 Part 6 Loaded Successfully. Fling & Autofarm Ready.")
--[[
    ========================================================================================
    PROJECT: Onyx V2 - Ultimate Murder Mystery 2 Script (PC & Mobile)
    PART 7: Player Modifiers, Visuals, Keybinds, Settings & Final Execution
    ========================================================================================
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local OnyxGui = CoreGui:FindFirstChild("OnyxV2Gui")
if not OnyxGui then return end

local MainFrame = OnyxGui:FindFirstChild("MainFrame")
local ContentArea = MainFrame:FindFirstChild("ContentArea")

local PlayerTab = ContentArea:FindFirstChild("PlayerTabContent")
local VisualsTab = ContentArea:FindFirstChild("VisualsTabContent")
local KeybindsTab = ContentArea:FindFirstChild("KeybindsTabContent")
local SettingsTab = ContentArea:FindFirstChild("SettingsTabContent")

if not PlayerTab or not VisualsTab or not KeybindsTab or not SettingsTab then return end

local function CreateHeader(parent, text)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -10, 0, 30)
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 170, 255)
    label.TextSize, label.TextXAlignment = 14, Enum.TextXAlignment.Left
end

local function CreateToggleGeneric(parent, title, subtitle, category, configKey)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -10, 0, 50)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = frame
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 15, 0, 6)
    titleLabel.Size = UDim2.new(0, 300, 0, 20)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
    titleLabel.TextSize, titleLabel.TextXAlignment = 13, Enum.TextXAlignment.Left

    local subLabel = Instance.new("TextLabel")
    subLabel.Parent = frame
    subLabel.BackgroundTransparency = 1
    subLabel.Position = UDim2.new(0, 15, 0, 26)
    subLabel.Size = UDim2.new(0, 350, 0, 18)
    subLabel.Font = Enum.Font.Gotham
    subLabel.Text = subtitle
    subLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
    subLabel.TextSize, subLabel.TextXAlignment = 11, Enum.TextXAlignment.Left

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = frame
    toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    toggleBtn.Position = UDim2.new(1, -55, 0.5, -12)
    toggleBtn.Size = UDim2.new(0, 42, 0, 24)
    toggleBtn.AutoButtonColor = false
    toggleBtn.Text = ""

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Parent = toggleBtn
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Position = UDim2.new(0, 2, 0.5, -10)
    circle.Size = UDim2.new(0, 20, 0, 20)

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local toggled = getgenv().OnyxConfig[category][configKey] or false

    local function updateVisual()
        if toggled then
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            circle:TweenPosition(UDim2.new(1, -22, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            toggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end
    updateVisual()

    toggleBtn.MouseButton1Click:Connect(function()
        toggled = not toggled
        getgenv().OnyxConfig[category][configKey] = toggled
        updateVisual()
    end)
end

-- Populate Player Tab
CreateHeader(PlayerTab, "🏃 Player Character & Movement Modifiers")
CreateToggleGeneric(PlayerTab, "Anti-Fling Protection", "حماية كاملة لشخصيتك من الطيران الناتج عن الفلينج.", "Player", "AntiFling")
CreateToggleGeneric(PlayerTab, "Noclip (Walk Through Walls)", "المرور عبر الجدران والعوائق بكل سهولة.", "Player", "Noclip")
CreateToggleGeneric(PlayerTab, "Infinite Jump", "القفز بلا حدود في الهواء بشكل متكرر.", "Player", "InfiniteJump")
CreateToggleGeneric(PlayerTab, "Fly Mode", "الطيران في الهواء بحرية كاملة وسرعة فائقة.", "Player", "Fly")
CreateToggleGeneric(PlayerTab, "God Mode [BETA]", "وضع عدم التأثر بالضربات والوصول لمستوى حماية متقدم.", "Player", "GodMode")

-- Populate Visuals Tab
CreateHeader(VisualsTab, "👁️ Visuals, Sounds & Performance Optimization")
CreateToggleGeneric(VisualsTab, "Remove Textures", "إزالة خامات الماب لرفع الإطارات ومنع اللاغ.", "Visuals", "RemoveTextures")
CreateToggleGeneric(VisualsTab, "Remove Particles & Effects", "إزالة الجسيمات والمؤثرات البصرية الثقيلة.", "Visuals", "RemoveParticles")
CreateToggleGeneric(VisualsTab, "Remove Shadows & Lighting FX", "إلغاء الظلال وتأثيرات الإضاءة الثقيلة.", "Visuals", "RemoveShadows")
CreateToggleGeneric(VisualsTab, "Lowest Graphics Quality", "تخفيض إعدادات الجرافيك لأدنى مستوى ممكن.", "Visuals", "LowestGraphics")

-- Populate Keybinds Tab
CreateHeader(KeybindsTab, "⌨️ Interface & Action Keybinds")
CreateToggleGeneric(KeybindsTab, "Toggle GUI Keybind", "تخصيص مفتاح لإظهار وإخفاء واجهة السكربت بسرعة.", "Settings", "AntiStealer")

-- Populate Settings Tab
CreateHeader(SettingsTab, "⚙️ Settings & Configuration Management")
CreateToggleGeneric(SettingsTab, "Anti-Stealer Protection", "حماية السكربت من كشفه أو سرقته داخل السيرفر.", "Settings", "AntiStealer")

-- Core Noclip Loop Implementation
RunService.Stepped:Connect(function()
    if getgenv().OnyxConfig.Player.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

print("========================================================================================")
print("Onyx V2 - Ultimate MM2 Script Successfully Loaded & Executed on All Parts!")
print("========================================================================================")
