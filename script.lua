-- ==========================================
-- Keyboard Simulator - Modern Hub (Sajjad)
-- Multi-Tab UI + Floating Toggle Button
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local ContentArea = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local ToggleBtn = Instance.new("ImageButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SajjadModernHubPro"

-- 1. زر الفتح والإخفاء العائم على الشاشة (Floating Toggle Logo)
ToggleBtn.Parent = ScreenGui
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0) -- دائري
ToggleCorner.Parent = ToggleBtn

local ToggleText = Instance.new("TextLabel")
ToggleText.Parent = ToggleBtn
ToggleText.Size = UDim2.new(1, 0, 1, 0)
ToggleText.Text = "⚡"
ToggleText.TextColor3 = Color3.fromRGB(0, 210, 255)
ToggleText.TextSize = 22
ToggleText.BackgroundTransparency = 1

-- 2. النافذة الرئيسية (Main Dashboard Frame)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.Position = UDim2.new(0.25, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- الشريط العلوي (Top Bar)
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

Title.Parent = TopBar
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Text = "KEYBOARD HUB v2.0"
Title.TextColor3 = Color3.fromRGB(0, 210, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- أزرار التحكم (إغلاق وتصغير)
CloseBtn.Parent = TopBar
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
CloseBtn.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

MinimizeBtn.Parent = TopBar
MinimizeBtn.Position = UDim2.new(1, -60, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Text = "─"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
MinimizeBtn.Font = Enum.Font.GothamBold

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

-- أحداث الإخفاء والفتح
local uiVisible = true
local function toggleUI()
    uiVisible = not uiVisible
    MainFrame.Visible = uiVisible
end

ToggleBtn.MouseButton1Click:Connect(toggleUI)
MinimizeBtn.MouseButton1Click:Connect(toggleUI)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 3. الشريط الجانبي (Sidebar)
Sidebar.Parent = MainFrame
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 120, 1, -35)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
Sidebar.BorderSizePixel = 0

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.Padding = UDim.new(0, 5)

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.Parent = Sidebar
SidebarPadding.PaddingTop = UDim.new(0, 8)
SidebarPadding.PaddingLeft = UDim.new(0, 8)

-- 4. منطقة المحتوى (Content Area)
ContentArea.Parent = MainFrame
ContentArea.Position = UDim2.new(0, 125, 0, 40)
ContentArea.Size = UDim2.new(1, -130, 1, -45)
ContentArea.BackgroundTransparency = 1

-- نظام التبويبات (Tabs Management)
local tabs = {}
local function createTab(name)
    local tabBtn = Instance.new("TextButton")
    local tabCorner = Instance.new("UICorner")
    
    tabBtn.Parent = Sidebar
    tabBtn.Size = UDim2.new(0, 104, 0, 32)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 11
    
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabBtn

    local page = Instance.new("ScrollingFrame")
    page.Parent = ContentArea
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.Visible = false

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Parent = page
    pageLayout.Padding = UDim.new(0, 6)

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.page.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
            t.btn.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        page.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    table.insert(tabs, {btn = tabBtn, page = page})
    return page
end

-- إنشاء التبويبات
local mainTab = createTab("⚡ Main")
local buyTab = createTab("🛒 Auto Buy")
local configTab = createTab("⚙️ Settings")

-- تفعيل التبويب الأول افتراضياً
tabs[1].page.Visible = true
tabs[1].btn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
tabs[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- دالة إضافة أزرار داخل التبويبات
local function addToggle(parentTab, text, callback)
    local btn = Instance.new("TextButton")
    local btnCorner = Instance.new("UICorner")
    
    btn.Parent = parentTab
    btn.Size = UDim2.new(0.96, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text .. " : OFF"
    
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 120)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = text .. " : ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.Text = text .. " : OFF"
        end
        task.spawn(function() callback(active) end)
    end)
end

-- ==========================================
-- 🛠️ إضافة الوظائف للتبويبات
-- ==========================================

-- تبويب Main
addToggle(mainTab, "Auto Win (Smart Walk)", function(state)
    -- كود Auto Win
end)

addToggle(mainTab, "Smart Speed (Max)", function(state)
    -- كود Smart Speed
end)

addToggle(mainTab, "Auto Collect Coins", function(state)
    -- كود الكوينز
end)

-- تبويب Auto Buy
addToggle(buyTab, "Auto Buy Trails", function(state)
    -- كود الشراء التلقائي
end)

-- تبويب Settings
addToggle(configTab, "Clean RAM Hourly", function(state)
    -- كود التفريغ
end)
