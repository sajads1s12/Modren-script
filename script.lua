-- Ultimate Speed Script Hub / Rayfield UI (Multi-Language: Arabic & English)

local CustomImageID = "rbxassetid://76030535720323" 

-- Language Translations Setup
local Translations = {
    AR = {
        WindowTitle = "سكربت السرعة | تطوير سجاد",
        LoadingTitle = "جاري تحميل السكربت...",
        LoadingSubtitle = "من تطوير سجاد",
        TabMain = "التلقائي الرئيسي",
        TabTreadmills = "أجهزة المشي",
        TabShop = "المتجر والسكنات",
        TabSettings = "الإعدادات والإعادة",
        
        AutoWinTP = "فوز تلقائي (انتقال سريع)",
        AutoWinWalk = "فوز تلقائي (مشي تلقائي)",
        SpeedBasedWins = "فوز حسب السرعة (دفع بأقصى سرعة)",
        RebirthSection = "الريبيرث والسرعة",
        AutoRebirth = "ريبيرث تلقائي",
        LockSpeed = "قفل السرعة (منع الرست)",
        
        SmartTreadmill = "أفضل سير متاح مجاناً",
        SelectTreadmill = "اختيار السير يدوياً",
        
        AutoBuySecret = "شراء سكنات السيكرت (حد 1B)",
        AutoBuyMythic = "شراء سكنات الميثيك (حد 300M)",
        AutoEquipBest = "تجهيز أفضل سكن تلقائياً",
        
        ConnSection = "خيارات الاتصال التلقائي",
        AutoRejoin = "إعادة دخول عند الانقطاع",
        AutoServerHop = "إعادة دخول / تنقل كل ساعة",
        RejoinNow = "إعادة دخول فورية الآن",
        PerfSection = "الأداء والسرعة",
        LowGraphics = "تقليل الجودة (تخفيف اللاغ)",
        BlackScreen = "وضع الشاشة السوداء (توفير البطارية)",
        GhostMode = "وضع الشبح (إخفاء الشخصية)",
        AntiAFK = "حماية من الطرد (Anti-AFK)",
        
        NotifyTitle = "Sajjad Script Hub",
        NotifyContent = "تم تشغيل السكربت بنجاح!",
        LangPromptTitle = "اختر اللغة / Select Language"
    },
    EN = {
        WindowTitle = "Ultimate Speed Hub | by Sajjad",
        LoadingTitle = "Loading Script...",
        LoadingSubtitle = "Developed by Sajjad",
        TabMain = "Main Auto",
        TabTreadmills = "Treadmills",
        TabShop = "Shop & Skins",
        TabSettings = "Settings & Rejoin",
        
        AutoWinTP = "Auto Win (Teleport)",
        AutoWinWalk = "Auto Win (Auto Walk)",
        SpeedBasedWins = "Speed-Based Wins (Max Push)",
        RebirthSection = "Rebirth & Speed",
        AutoRebirth = "Auto Rebirth",
        LockSpeed = "Speed Auto-Lock (Prevent Reset)",
        
        SmartTreadmill = "Auto Best Available Treadmill",
        SelectTreadmill = "Select Treadmill Manually",
        
        AutoBuySecret = "Auto Buy Secret Skins (Limit 1B)",
        AutoBuyMythic = "Auto Buy Mythic Skins (Limit 300M)",
        AutoEquipBest = "Auto Equip Best Skin",
        
        ConnSection = "Auto Connection Options",
        AutoRejoin = "Auto Rejoin on Disconnect",
        AutoServerHop = "Auto Rejoin / Hop Every 1 Hour",
        RejoinNow = "Rejoin Current Server Now",
        PerfSection = "Performance",
        LowGraphics = "Super Low Graphics",
        BlackScreen = "Black Screen Mode (Battery Saver)",
        GhostMode = "Ghost Mode (Hide Character)",
        AntiAFK = "Anti-AFK Protection",
        
        NotifyTitle = "Sajjad Script Hub",
        NotifyContent = "Script loaded successfully!",
        LangPromptTitle = "Select Language"
    }
}

-- State Variables
local Config = {
    AutoWinTP = false,
    AutoWinWalk = false,
    SpeedBasedWins = false,
    SmartTreadmill = false,
    SelectedTreadmill = "Free Treadmill",
    AutoBuySecret = false,
    AutoBuyMythic = false,
    AutoEquipBest = false,
    AutoRebirth = false,
    LockSpeed = false,
    GhostMode = false,
    LowGraphics = false,
    BlackScreen = false,
    AntiAFK = true,
    AutoRejoin = true,
    AutoServerHopHourly = false
}

local TreadmillList = {
    "Free Treadmill",
    "3x Treadmill",
    "5x Treadmill",
    "9x Treadmill",
    "25x Treadmill",
    "100x Treadmill",
    "120x Admin Treadmill",
    "150x Admin Treadmill"
}

-- FUNCTION TO INITIALIZE FULL HUB IN SELECTED LANGUAGE
local function LoadMainHub(lang)
    local L = Translations[lang]
    
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
       Name = L.WindowTitle,
       LoadingTitle = L.LoadingTitle,
       LoadingSubtitle = L.LoadingSubtitle,
       ConfigurationSaving = {
          Enabled = true,
          FolderName = "SajjadHub",
          FileName = "SpeedSimConfig"
       },
       Discord = { Enabled = false },
       KeySystem = false
    })

    -- TABS
    local MainTab = Window:CreateTab(L.TabMain, CustomImageID)
    local TreadmillsTab = Window:CreateTab(L.TabTreadmills, CustomImageID)
    local ShopTab = Window:CreateTab(L.TabShop, CustomImageID)
    local SettingsTab = Window:CreateTab(L.TabSettings, CustomImageID)

    -- MAIN TAB TOGGLES
    MainTab:CreateToggle({
       Name = L.AutoWinTP,
       CurrentValue = false,
       Flag = "AutoWinTP",
       Callback = function(Value) Config.AutoWinTP = Value end,
    })

    MainTab:CreateToggle({
       Name = L.AutoWinWalk,
       CurrentValue = false,
       Flag = "AutoWinWalk",
       Callback = function(Value) Config.AutoWinWalk = Value end,
    })

    MainTab:CreateToggle({
       Name = L.SpeedBasedWins,
       CurrentValue = false,
       Flag = "SpeedBasedWins",
       Callback = function(Value) Config.SpeedBasedWins = Value end,
    })

    MainTab:CreateSection(L.RebirthSection)

    MainTab:CreateToggle({
       Name = L.AutoRebirth,
       CurrentValue = false,
       Flag = "AutoRebirth",
       Callback = function(Value) Config.AutoRebirth = Value end,
    })

    MainTab:CreateToggle({
       Name = L.LockSpeed,
       CurrentValue = false,
       Flag = "LockSpeed",
       Callback = function(Value) Config.LockSpeed = Value end,
    })

    -- TREADMILLS TAB TOGGLES
    TreadmillsTab:CreateToggle({
       Name = L.SmartTreadmill,
       CurrentValue = false,
       Flag = "SmartTreadmill",
       Callback = function(Value) Config.SmartTreadmill = Value end,
    })

    TreadmillsTab:CreateDropdown({
       Name = L.SelectTreadmill,
       Options = TreadmillList,
       CurrentOption = {"Free Treadmill"},
       MultipleOptions = false,
       Flag = "SelectedTreadmill",
       Callback = function(Option) Config.SelectedTreadmill = Option[1] end,
    })

    -- SHOP TAB TOGGLES
    ShopTab:CreateToggle({
       Name = L.AutoBuySecret,
       CurrentValue = false,
       Flag = "AutoBuySecret",
       Callback = function(Value) Config.AutoBuySecret = Value end,
    })

    ShopTab:CreateToggle({
       Name = L.AutoBuyMythic,
       CurrentValue = false,
       Flag = "AutoBuyMythic",
       Callback = function(Value) Config.AutoBuyMythic = Value end,
    })

    ShopTab:CreateToggle({
       Name = L.AutoEquipBest,
       CurrentValue = false,
       Flag = "AutoEquipBest",
       Callback = function(Value) Config.AutoEquipBest = Value end,
    })

    -- SETTINGS & REJOIN TAB
    SettingsTab:CreateSection(L.ConnSection)

    SettingsTab:CreateToggle({
       Name = L.AutoRejoin,
       CurrentValue = true,
       Flag = "AutoRejoin",
       Callback = function(Value) Config.AutoRejoin = Value end,
    })

    SettingsTab:CreateToggle({
       Name = L.AutoServerHop,
       CurrentValue = false,
       Flag = "AutoServerHopHourly",
       Callback = function(Value) Config.AutoServerHopHourly = Value end,
    })

    SettingsTab:CreateButton({
       Name = L.RejoinNow,
       Callback = function()
           game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
       end,
    })

    SettingsTab:CreateSection(L.PerfSection)

    SettingsTab:CreateToggle({
       Name = L.LowGraphics,
       CurrentValue = false,
       Flag = "LowGraphics",
       Callback = function(Value)
          Config.LowGraphics = Value
          if Value then
              task.spawn(function()
                  pcall(function()
                      for _, obj in ipairs(game:GetDescendants()) do
                          if obj:IsA("BasePart") then
                              obj.Material = Enum.Material.SmoothPlastic
                          elseif obj:IsA("Decal") or obj:IsA("Texture") then
                              obj:Destroy()
                          end
                      end
                  end)
              end)
          end
       end,
    })

    local BlackScreenGui = nil
    SettingsTab:CreateToggle({
       Name = L.BlackScreen,
       CurrentValue = false,
       Flag = "BlackScreen",
       Callback = function(Value)
          Config.BlackScreen = Value
          if Value then
              task.spawn(function()
                  BlackScreenGui = Instance.new("ScreenGui", game.CoreGui)
                  local Frame = Instance.new("Frame", BlackScreenGui)
                  Frame.Size = UDim2.new(1, 0, 1, 0)
                  Frame.BackgroundColor3 = Color3.new(0, 0, 0)
              end)
          elseif BlackScreenGui then
              BlackScreenGui:Destroy()
              BlackScreenGui = nil
          end
       end,
    })

    SettingsTab:CreateToggle({
       Name = L.GhostMode,
       CurrentValue = false,
       Flag = "GhostMode",
       Callback = function(Value)
          Config.GhostMode = Value
          task.spawn(function()
              pcall(function()
                  local char = game.Players.LocalPlayer.Character
                  if char then
                      for _, part in ipairs(char:GetDescendants()) do
                          if part:IsA("BasePart") then
                              part.Transparency = Value and 1 or 0
                          end
                      end
                  end
              end)
          end)
       end,
    })

    SettingsTab:CreateToggle({
       Name = L.AntiAFK,
       CurrentValue = true,
       Flag = "AntiAFK",
       Callback = function(Value) Config.AntiAFK = Value end,
    })

    -- FLOATING CIRCULAR TOGGLE BUTTON
    local ScreenGui = Instance.new("ScreenGui")
    local ToggleBtn = Instance.new("ImageButton")
    local UICorner = Instance.new("UICorner")

    ScreenGui.Name = "SajjadToggleGui"
    ScreenGui.Parent = game.CoreGui

    ToggleBtn.Name = "ToggleButton"
    ToggleBtn.Parent = ScreenGui
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
    ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
    ToggleBtn.Image = CustomImageID
    ToggleBtn.Active = true
    ToggleBtn.Draggable = true

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ToggleBtn

    local uiVisible = true
    ToggleBtn.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        if game.CoreGui:FindFirstChild("Rayfield") then
            game.CoreGui.Rayfield.Enabled = uiVisible
        end
    end)

    Rayfield:Notify({
       Title = L.NotifyTitle,
       Content = L.NotifyContent,
       Duration = 5,
       Image = CustomImageID,
    })
end

-- ========================================================
--              INITIAL LANGUAGE SELECTOR UI
-- ========================================================

local LangGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ArabicBtn = Instance.new("TextButton")
local EnglishBtn = Instance.new("TextButton")
local UIFrameCorner = Instance.new("UICorner")
local UIArCorner = Instance.new("UICorner")
local UIEnCorner = Instance.new("UICorner")

LangGui.Name = "SajjadLangGui"
LangGui.Parent = game.CoreGui

MainFrame.Parent = LangGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

UIFrameCorner.CornerRadius = UDim.new(0, 12)
UIFrameCorner.Parent = MainFrame

TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "اختر اللغة / Select Language"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16

ArabicBtn.Parent = MainFrame
ArabicBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 220)
ArabicBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
ArabicBtn.Size = UDim2.new(0.8, 0, 0, 32)
ArabicBtn.Font = Enum.Font.SourceSansBold
ArabicBtn.Text = "العربية (Arabic)"
ArabicBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ArabicBtn.TextSize = 15

UIArCorner.CornerRadius = UDim.new(0, 8)
UIArCorner.Parent = ArabicBtn

EnglishBtn.Parent = MainFrame
EnglishBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
EnglishBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
EnglishBtn.Size = UDim2.new(0.8, 0, 0, 32)
EnglishBtn.Font = Enum.Font.SourceSansBold
EnglishBtn.Text = "English"
EnglishBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnglishBtn.TextSize = 15

UIEnCorner.CornerRadius = UDim.new(0, 8)
UIEnCorner.Parent = EnglishBtn

ArabicBtn.MouseButton1Click:Connect(function()
    LangGui:Destroy()
    LoadMainHub("AR")
end)

EnglishBtn.MouseButton1Click:Connect(function()
    LangGui:Destroy()
    LoadMainHub("EN")
end)

-- ========================================================
--                  FUNCTIONAL AUTOMATION LOOPS
-- ========================================================

task.spawn(function()
    while true do
        task.wait(3600)
        if Config.AutoServerHopHourly then
            pcall(function()
                game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoWinTP then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local finishPad = workspace:FindFirstChild("Finish") or workspace:FindFirstChild("FinishPad") or workspace:FindFirstChild("WinPad")
                    if finishPad then
                        character.HumanoidRootPart.CFrame = finishPad.CFrame
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Config.AutoWinWalk or Config.SpeedBasedWins then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
                    local humanoid = character.Humanoid
                    local hrp = character.HumanoidRootPart
                    
                    humanoid:Move(Vector3.new(0, 0, -1), true)
                    
                    if Config.SpeedBasedWins then
                        local currentSpeed = humanoid.WalkSpeed
                        hrp.Velocity = hrp.CFrame.LookVector * math.max(currentSpeed, 50)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Config.AutoRebirth then
            pcall(function()
                local RebirthRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Rebirth") or game:GetService("ReplicatedStorage"):FindFirstChild("RebirthEvent")
                if RebirthRemote and RebirthRemote:IsA("RemoteEvent") then
                    RebirthRemote:FireServer()
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if Config.SmartTreadmill or Config.SelectedTreadmill then
            pcall(function()
                local treadmills = workspace:FindFirstChild("Treadmills")
                if treadmills then
                    local targetName = Config.SmartTreadmill and "Treadmill" or Config.SelectedTreadmill
                    for _, tm in ipairs(treadmills:GetChildren()) do
                        if string.find(tm.Name, targetName) and tm:FindFirstChild("HumanoidRootPart") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tm.HumanoidRootPart.CFrame
                            break
                        end
                    end
                end
            end)
        end
    end
end)

local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if Config.AutoRejoin and child.Name == "ErrorPrompt" then
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
end)
