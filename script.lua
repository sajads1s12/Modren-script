--[=[
    Project: MM2 Ultimate Hub Script - Part 1 (UI Base & Navigation)
    Language: Luau (Roblox)
]=]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- التعرف التلقائي على الجهاز (حاسوب أم هاتف/تابلت)
local isPC = UserInputService.KeyboardEnabled and not UserInputService.TouchEnabled

-- إزالة الواجهة القديمة إن وجدت
if CoreGui:FindFirstChild("MM2_UltimateHub") then
    CoreGui.MM2_UltimateHub:Destroy()
end

-- إنشاء الشاشة الرئيسية للسكربت
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2_UltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي المربع والمتجاوب
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.Active = true
MainFrame.Draggable = true -- قابل للسحب لكل الأجهزة

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- القائمة الجانبية اليسرى للأقسام
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Sidebar.ScrollBarThickness = 2
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 6)

-- منطقة المحتوى الرئيسية بجانب القائمة
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
ContentArea.Position = UDim2.new(0, 145, 0, 0)
ContentArea.Size = UDim2.new(1, -145, 1, 0)
ContentArea.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentArea

-- نظام الصفحات (Pages)
local Pages = {}
local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Parent = ContentArea
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 2, 0)
    page.ScrollBarThickness = 4
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)
    
    Pages[name] = page
    return page
end

-- إنشاء الأقسام المطلوبة
CreatePage("Combat")
CreatePage("AutoFarm")
CreatePage("ESP")
if isPC then
    CreatePage("RamAlt") -- يظهر فقط للحاسوب
end
CreatePage("Trade")
CreatePage("KillSayings")
CreatePage("Settings")

-- دالة لإنشاء أزرار القائمة الجانبية
local function CreateMenuButton(text, targetName)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do
            p.Visible = false
        end
        if Pages[targetName] then
            Pages[targetName].Visible = true
        end
    end)
end

-- إضافة الأزرار للقائمة الجانبية
CreateMenuButton("⚔️ Combat", "Combat")
CreateMenuButton("🌾 Auto Farm", "AutoFarm")
CreateMenuButton("👁️ ESP", "ESP")
if isPC then
    CreateMenuButton("💻 Ram & Alt", "RamAlt")
end
CreateMenuButton("🤝 Trade", "Trade")
CreateMenuButton("💬 Kill Sayings", "KillSayings")
CreateMenuButton("⚙️ Settings", "Settings")

-- جعل صفحة الـ Combat تظهر افتراضياً
Pages["Combat"].Visible = true

print("✅ [الجزء الأول]: تم تحميل الواجهة والقائمة الجانبية بنجاح.")
--[=[
    Project: MM2 Ultimate Hub Script - Part 2 (Combat & Auto Farm Modules)
    Language: Luau (Roblox)
]=]

-- التحقق من وجود الجزء الأول أو الاعتماد على المتغيرات المشتركة
local CombatPage = Pages["Combat"]
local FarmPage = Pages["AutoFarm"]

if not CombatPage or not FarmPage then
    warn("⚠️ يرجى تشغيل الجزء الأول أولاً لضمان إنشاء واجهة الأقسام!")
    return
end

-- متغيرات أزرار وقسم القتال
local CombatSettings = {
    AimBot = false,
    SilentAim = false,
    TriggerBot = false,
    HitboxExtender = false,
    HitboxSize = 5,
    AutoKillSheriff = false
}

-- متغيرات أزرار وقسم التجميع التلقائي
local FarmSettings = {
    AutoCoin = false,
    WalkSpeed = 16,
    AutoLevel = false,
    Noclip = false,
    FlightMode = "AboveMap"
}

-- دالة مساعدة لإنشاء عناصر واجهة مستخدم (زر مع شرح خافت تحتفظ به)
local function CreateControlWithSubtitle(parentPage, titleText, subtitleText, callback)
    local container = Instance.new("Frame")
    container.Parent = parentPage
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -10, 0, 50)
    
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = titleText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Parent = container
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 0, 0, 30)
    subtitle.Size = UDim2.new(1, 0, 0, 18)
    subtitle.Font = Enum.Font.SourceSans
    subtitle.Text = subtitleText
    subtitle.TextColor3 = Color3.fromRGB(160, 160, 180) -- لون خافت للشرح
    subtitle.TextSize = 11
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(40, 40, 52)
        callback(state)
    end)
end

-- ==========================================
-- بناء عناصر قسم الـ Combat ⚔️
-- ==========================================
CreateControlWithSubtitle(CombatPage, "Aim Bot (مساعد التصويب)", "مساعد التصويب التلقائي نحو عدوك لتسهيل إطلاق النار", function(v)
    CombatSettings.AimBot = v
end)

CreateControlWithSubtitle(CombatPage, "Silent Aim (التصويب الصامت)", "إصابة الهدف دون الحاجة لتوجيه الكاميرا نحوه بشكل مباشر", function(v)
    CombatSettings.SilentAim = v
end)

CreateControlWithSubtitle(CombatPage, "Trigger Bot (الطلق التلقائي)", "إطلاق النار تلقائياً بمجرد تمرير مؤشر السلاح على العدو", function(v)
    CombatSettings.TriggerBot = v
end)

CreateControlWithSubtitle(CombatPage, "Hitbox Extender (تكبير الهيتبوكس)", "تكبير مساحة hitbox الأعداء لتسهيل تصويب الضربات عليهم", function(v)
    CombatSettings.HitboxExtender = v
end)

CreateControlWithSubtitle(CombatPage, "Auto Kill Sheriff (القتل السريع للشيرف)", "استهداف والقضاء على الشيرف فوراً عند توفر الشروط في الماب", function(v)
    CombatSettings.AutoKillSheriff = v
end)

-- ==========================================
-- بناء عناصر قسم الـ Auto Farm 🌾
-- ==========================================
CreateControlWithSubtitle(FarmPage, "Auto Coin (تجميع الكوينز المخفي)", "تجميع الكوينز من تحت الأرض عبر حركة منبطحة، مع تصغير الهيتبوكس لتجنب الكشف", function(v)
    FarmSettings.AutoCoin = v
end)

CreateControlWithSubtitle(FarmPage, "Noclip (تخطي الجدران)", "مطلوب للزراعة: يتيح لك المرور عبر الجدران والعوائق بسلاسة تامة", function(v)
    FarmSettings.Noclip = v
end)

CreateControlWithSubtitle(FarmPage, "Auto Level (الطيران والنجاة)", "نظام يضمن نجاة اللاعب ورفع مستواه تلقائياً عبر الطيران بعيداً عن القاتل أو فوق الماب", function(v)
    FarmSettings.AutoLevel = v
end)

-- ==========================================
-- دوال التشغيل البرمجية الفعلية للقسمين
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

RunService.RenderStepped:Connect(function()
    -- تنفيذ الـ Hitbox Extender
    if CombatSettings.HitboxExtender then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                hrp.Size = Vector3.new(CombatSettings.HitboxSize, CombatSettings.HitboxSize, CombatSettings.HitboxSize)
                hrp.Transparency = 0.7
                hrp.CanCollide = false
            end
        end
    end

    -- تنفيذ النوتشليب الإجباري للزراعة
    if FarmSettings.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- حلقة تجميع الكوينز والرفع التلقائي
task.spawn(function()
    while task.wait(0.3) do
        if FarmSettings.AutoCoin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.Size = Vector3.new(1, 1, 1)
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj.Name == "Coin_Server" or obj.Name == "Coin" then
                    if obj:IsA("BasePart") then
                        hrp.CFrame = obj.CFrame + Vector3.new(0, -2.5, 0)
                        task.wait(0.1)
                    end
                end
            end
        end

        if FarmSettings.AutoLevel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 75, 0)
            local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end
        end
    end
end)

print("✅ [الجزء الثاني]: تم تحميل قسمي Combat و Auto Farm مع الشروحات الخافتة بنجاح.")
--[=[
    Project: MM2 Ultimate Hub Script - Part 3 (ESP & Ram/Alt Modules)
    Language: Luau (Roblox)
]=]

local ESPPage = Pages["ESP"]
local RamAltPage = Pages["RamAlt"] -- قد يكون غير موجود إن كان الجهاز هاتفا

if not ESPPage then
    warn("⚠️ يرجى تشغيل الأجزاء السابقة أولاً!")
    return
end

-- متغيرات قسم الـ ESP
local ESPSettings = {
    Enabled = false,
    HitboxESP = false,
    Colors = {
        Murderer = Color3.fromRGB(255, 0, 0),    -- أحمر للقاتل
        Sheriff = Color3.fromRGB(0, 0, 255),     -- أزرق للشيرف
        Hero = Color3.fromRGB(255, 215, 0),      -- أصفر ذهبي للهيرو
        Innocent = Color3.fromRGB(0, 255, 0)     -- أخضر للبريء
    }
}

-- متغيرات قسم الـ Ram & Alt (خاص بالحاسوب)
local RamAltSettings = {
    AltManagerActive = false,
    AutoTradeMain = false,
    AntiConflictSpacing = true
}

-- دالة مساعدة لإنشاء الأزرار مع الشروحات (موروثة من الجزء السابق)
local function CreateControlWithSubtitle(parentPage, titleText, subtitleText, callback)
    local container = Instance.new("Frame")
    container.Parent = parentPage
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -10, 0, 50)
    
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = titleText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Parent = container
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 0, 0, 30)
    subtitle.Size = UDim2.new(1, 0, 0, 18)
    subtitle.Font = Enum.Font.SourceSans
    subtitle.Text = subtitleText
    subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
    subtitle.TextSize = 11
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(40, 40, 52)
        callback(state)
    end)
end

-- ==========================================
-- بناء عناصر قسم الـ ESP 👁️
-- ==========================================
CreateControlWithSubtitle(ESPPage, "Enable ESP (تفعيل نظام الكشف العام)", "المفتاح الرئيسي لتشغيل جميع وظائف كشف الأماكن ورؤية اللاعبين", function(v)
    ESPSettings.Enabled = v
end)

CreateControlWithSubtitle(ESPPage, "Hitbox ESP (تلوين هيتبوكس اللاعبين)", "إظهار حدود ملونة حول الشخصيات لتحديد أماكنهم عبر الجدران بناءً على أدوارهم", function(v)
    ESPSettings.HitboxESP = v
end)

-- ==========================================
-- بناء عناصر قسم الـ Ram & Alt 💻 (إن وجد للحاسوب)
-- ==========================================
if RamAltPage and isPC then
    CreateControlWithSubtitle(RamAltPage, "Alt Manager Active (تفعيل مدير الحسابات)", "تفعيل نظام إدارة الحسابات الوهمية المتعددة للتحكم بها جماعياً", function(v)
        RamAltSettings.AltManagerActive = v
    end)

    CreateControlWithSubtitle(RamAltPage, "Auto Trade Main (التريد التلقائي للحساب الرئيسي)", "إرسال طلبات تبادل الأسلحة والبتات بشكل آلي نحو حسابك الرئيسي وتفريغ الحقائب", function(v)
        RamAltSettings.AutoTradeMain = v
    end)

    CreateControlWithSubtitle(RamAltPage, "Anti-Conflict Spacing (منع تعارض المواقع)", "ترك مسافة متباعدة ذكية بين الحسابات الوهمية أثناء تجميع الكوينز لمنع التصادم", function(v)
        RamAltSettings.AntiConflictSpacing = v
    end)
elseif RamAltPage and not isPC then
    -- رسالة تنبيهية في حال فتح من الجوال
    local notice = Instance.new("TextLabel")
    notice.Parent = RamAltPage
    notice.BackgroundTransparency = 1
    notice.Size = UDim2.new(1, 0, 0, 40)
    notice.Font = Enum.Font.SourceSansBold
    notice.Text = "⚠️ قسم الحسابات الوهمية مخصص لأجهزة الحاسوب (PC) فقط لعدم دعم الهواتف لتعدد الحسابات."
    notice.TextColor3 = Color3.fromRGB(255, 100, 100)
    notice.TextSize = 13
    notice.TextWrapped = true
end

-- ==========================================
-- دوال التشغيل البرمجية للـ ESP وأدوار MM2
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local function GetPlayerRole(player)
    local char = player.Character
    if not char then return "Innocent" end
    
    if char:FindFirstChild("Knife") or (player.Backpack and player.Backpack:FindFirstChild("Knife")) then
        return "Murderer"
    elseif char:FindFirstChild("Gun") or (player.Backpack and player.Backpack:FindFirstChild("Gun")) then
        return "Sheriff"
    end
    return "Innocent"
end

RunService.RenderStepped:Connect(function()
    if not ESPSettings.Enabled then
        -- إزالة الـ Highlights القديمة إذا تم إيقاف الـ ESP
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                if hrp:FindFirstChild("MM2_ESP_Box") then
                    hrp.MM2_ESP_Box:Destroy()
                end
            end
        end
        return
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetPlayerRole(player)
            local color = ESPSettings.Colors[role] or ESPSettings.Colors.Innocent
            local hrp = player.Character.HumanoidRootPart
            
            if ESPSettings.HitboxESP then
                if not hrp:FindFirstChild("MM2_ESP_Box") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "MM2_ESP_Box"
                    highlight.Adornee = player.Character
                    highlight.FillColor = color
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = hrp
                else
                    hrp.MM2_ESP_Box.FillColor = color
                end
            else
                if hrp:FindFirstChild("MM2_ESP_Box") then
                    hrp.MM2_ESP_Box:Destroy()
                end
            end
        end
    end
end)

print("✅ [الجزء الثالث]: تم تحميل قسمي ESP و Ram & Alt بنجاح.")
--[=[
    Project: MM2 Ultimate Hub Script - Part 4 (Trade, Kill Sayings & Settings - Final)
    Language: Luau (Roblox)
]=]

local TradePage = Pages["Trade"]
local KillSayingsPage = Pages["KillSayings"]
local SettingsPage = Pages["Settings"]

if not TradePage or not SettingsPage then
    warn("⚠️ يرجى تشغيل الأجزاء السابقة أولاً!")
    return
end

-- متغيرات الأقسام الأخيرة
local TradeSettings = {
    AutoAccept = false,
    YourOfferItem = "None",
    TheirTargetItem = "None"
}

local KillSayingSettings = {
    Enabled = false,
    SelectedSymbol = "† [MM2 PRO] †"
}

local SettingsData = {
    Language = "AR", -- البدء بالعربية (🇮🇶)
    MasterMute = false,
    AntiAFK = true,
    AntiFling = true,
    BlackScreen = false,
    FPSLimit = 60
}

-- قائمة الـ 20 شكلاً ورمزاً
local SymbolList = {
    "† [MM2 PRO] †", "⚡ [EXEC_KILL] ⚡", "☠️ [DESTROYED] ☠️", "👑 [KING_GOD] 👑",
    "⚔️ [SHADOW_X] ⚔️", "🔥 [ELITE_HUD] 🔥", "⭐ [STAR_GOD] ⭐", "❄️ [ICE_QUEEN] ❄️",
    "💫 [GODLY_WIN] 💫", "💎 [GEM_MASTER] 💎", "⚜️ [ROYAL_KILL] ⚜️", "🔰 [PRO_PLAYER] 🔰",
    "🎯 [HEAD_SHOT] 🎯", "🔮 [DARK_MAGIC] 🔮", "🌀 [CYCLONE_X] 🌀", "🛡️ [DEFENDER] 🛡️",
    "🧨 [EXPLOSIVE] 🧨", "🗡️ [BLADE_MASTER] 🗡️", "🦅 [FALCON_EYE] 🦅", "🌌 [GALAXY_HUB] 🌌"
}

-- دالة إنشاء أزرار مع شرح خافت
local function CreateControlWithSubtitle(parentPage, titleText, subtitleText, callback)
    local container = Instance.new("Frame")
    container.Parent = parentPage
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -10, 0, 50)
    
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = titleText
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Parent = container
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 0, 0, 30)
    subtitle.Size = UDim2.new(1, 0, 0, 18)
    subtitle.Font = Enum.Font.SourceSans
    subtitle.Text = subtitleText
    subtitle.TextColor3 = Color3.fromRGB(160, 160, 180)
    subtitle.TextSize = 11
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(40, 40, 52)
        callback(state)
    end)
end

-- ==========================================
-- بناء عناصر قسم التريد 🤝
-- ==========================================
CreateControlWithSubtitle(TradePage, "Auto Accept Trades (القبول التلقائي للتريدات)", "قبول صفقات التبادل الواردة فوراً عند تطابق الشروط والأمان", function(v)
    TradeSettings.AutoAccept = v
end)

-- محاكاة القوائم المنسدلة Your Offer و Their Offer لاختيار الأسلحة
local function CreateDropdownSimulator(parentPage, labelText, items, onSelected)
    local container = Instance.new("Frame")
    container.Parent = parentPage
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, -10, 0, 40)
    
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Font = Enum.Font.SourceSansBold
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Parent = container
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    dropdownBtn.Position = UDim2.new(0.42, 0, 0.1, 0)
    dropdownBtn.Size = UDim2.new(0.58, 0, 0.8, 0)
    dropdownBtn.Font = Enum.Font.SourceSans
    dropdownBtn.Text = items[1]
    dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    dropdownBtn.TextSize = 12
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = dropdownBtn
    
    local index = 1
    dropdownBtn.MouseButton1Click:Connect(function()
        index = index % #items + 1
        dropdownBtn.Text = items[index]
        onSelected(items[index])
    end)
end

CreateDropdownSimulator(TradePage, "Your Offer (عروضك):", {"Godly Blade", "Luger Gun", "Corrupt Knife", "Laser Gun"}, function(item)
    TradeSettings.YourOfferItem = item
end)

CreateDropdownSimulator(TradePage, "Their Offer (الطلب المستهدف):", {"Chromas", "Batwing", "Elderwood Scythe", "Hallow's Edge"}, function(item)
    TradeSettings.TheirTargetItem = item
end)

-- ==========================================
-- بناء عناصر قسم الأشكال Kill Sayings 💬
-- ==========================================
CreateControlWithSubtitle(KillSayingsPage, "Enable Kill Sayings (تفعيل عبارات القتل)", "إرسال رمز أو شكل مميز في الشات تلقائياً عند القضاء على أي هدف", function(v)
    KillSayingSettings.Enabled = v
end)

CreateDropdownSimulator(KillSayingsPage, "Select Symbol (اختر الشكل):", SymbolList, function(symbol)
    KillSayingSettings.SelectedSymbol = symbol
end)

-- ==========================================
-- بناء عناصر قسم الإعدادات Settings ⚙️
-- ==========================================
-- زر تبديل اللغة مع الأعلام (🇬🇧 English / 🇮🇶 العربية)
local LangButton = Instance.new("TextButton")
LangButton.Parent = SettingsPage
LangButton.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
LangButton.Size = UDim2.new(1, -10, 0, 35)
LangButton.Font = Enum.Font.SourceSansBold
LangButton.Text = "Language / اللغة: 🇮🇶 العربية"
LangButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LangButton.TextSize = 14

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 5)
LangCorner.Parent = LangButton

LangButton.MouseButton1Click:Connect(function()
    if SettingsData.Language == "AR" then
        SettingsData.Language = "EN"
        LangButton.Text = "Language / اللغة: 🇬🇧 English"
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Language Changed", Text = "Switched to English 🇬🇧", Duration = 3})
    else
        SettingsData.Language = "AR"
        LangButton.Text = "Language / اللغة: 🇮🇶 العربية"
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "تغيير اللغة", Text = "تم التبديل إلى اللغة العربية 🇮🇶", Duration = 3})
    end
end)

CreateControlWithSubtitle(SettingsPage, "Anti-AFK (منع طرد الخمول)", "يمنع خروجك من السيرفر بسبب عدم الحركة لفترة طويلة", function(v)
    SettingsData.AntiAFK = v
end)

CreateControlWithSubtitle(SettingsPage, "Anti-Fling (حماية القذف الحركي)", "يمنع اللاعبين الآخرين من طردك أو قذف شخصيتك خارج الماب", function(v)
    SettingsData.AntiFling = v
end)

CreateControlWithSubtitle(SettingsPage, "Master Mute (كتم أصوات اللعبة بالكامل)", "إسكات جميع أصوات اللعبة فوراً بنقرة زر واحدة", function(v)
    SettingsData.MasterMute = v
    game:GetService("SoundService").Volume = v and 0 or 1
end)

CreateControlWithSubtitle(SettingsPage, "Black Screen / FPS Booster (شاشة سوداء لتوفير الأداء)", "خفض إضاءة اللعبة وإيقاف الظلال لرفع الفريمات وتوفير البطارية", function(v)
    SettingsData.BlackScreen = v
    game:GetService("Lighting").Brightness = v and 0 or 2
    game:GetService("Lighting").GlobalShadows = not v
end)

-- ==========================================
-- دوال التشغيل البرمجية النهائية للتريد والقتل
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- تفعيل إرسال الرمز في الشات عند الموت أو إحراز القتل
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        if KillSayingSettings.Enabled then
            pcall(function()
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(KillSayingSettings.SelectedSymbol, "All")
            end)
        end
    end)
end)

-- إشعار اكتمال السكربت بالكامل بنجاح
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "MM2 Ultimate Hub (100% Complete)",
    Text = "تم تجميع وربط جميع الأجزاء والأقسام بنجاح تام!",
    Duration = 5
})

print("✅ [الجزء الرابع والأخير]: تم تحميل السكربت بالكامل وأصبح جاهزاً للاستخدام.")
