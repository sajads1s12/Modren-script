-- Ultimate Speed Script Hub / Rayfield UI (Arabic & English Built-in)

local CustomImageID = "rbxassetid://76030535720323" 

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Ultimate Speed Script Hub | by Sajjad",
   LoadingTitle = "جاري تحميل السكربت...",
   LoadingSubtitle = "من تطوير سجاد",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SajjadHub",
      FileName = "SpeedSimConfig"
   },
   Discord = { Enabled = false },
   KeySystem = false
})

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

-- TABS
local MainTab = Window:CreateTab("Main Auto (الرئيسي)", CustomImageID)
local TreadmillsTab = Window:CreateTab("Treadmills (أجهزة المشي)", CustomImageID)
local ShopTab = Window:CreateTab("Shop & Skins (المتجر)", CustomImageID)
local SettingsTab = Window:CreateTab("Settings (الإعدادات)", CustomImageID)

-- MAIN TAB TOGGLES
MainTab:CreateToggle({
   Name = "Auto Win (Teleport) | فوز تلقائي",
   CurrentValue = false,
   Flag = "AutoWinTP",
   Callback = function(Value) Config.AutoWinTP = Value end,
})

MainTab:CreateToggle({
   Name = "Auto Win (Auto Walk) | مشي تلقائي",
   CurrentValue = false,
   Flag = "AutoWinWalk",
   Callback = function(Value) Config.AutoWinWalk = Value end,
})

MainTab:CreateToggle({
   Name = "Speed-Based Wins | فوز بأقصى سرعة",
   CurrentValue = false,
   Flag = "SpeedBasedWins",
   Callback = function(Value) Config.SpeedBasedWins = Value end,
})

MainTab:CreateSection("Rebirth & Speed | الريبيرث والسرعة")

MainTab:CreateToggle({
   Name = "Auto Rebirth | ريبيرث تلقائي",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value) Config.AutoRebirth = Value end,
})

MainTab:CreateToggle({
   Name = "Speed Auto-Lock | قفل السرعة",
   CurrentValue = false,
   Flag = "LockSpeed",
   Callback = function(Value) Config.LockSpeed = Value end,
})

-- TREADMILLS TAB TOGGLES
TreadmillsTab:CreateToggle({
   Name = "Auto Best Treadmill | أفضل سير مجاني",
   CurrentValue = false,
   Flag = "SmartTreadmill",
   Callback = function(Value) Config.SmartTreadmill = Value end,
})

TreadmillsTab:CreateDropdown({
   Name = "Select Treadmill Manually | اختيار سير محدد",
   Options = TreadmillList,
   CurrentOption = {"Free Treadmill"},
   MultipleOptions = false,
   Flag = "SelectedTreadmill",
   Callback = function(Option) Config.SelectedTreadmill = Option[1] end,
})

-- SHOP TAB TOGGLES
ShopTab:CreateToggle({
   Name = "Auto Buy Secret Skins | شراء سيكرت (1B)",
   CurrentValue = false,
   Flag = "AutoBuySecret",
   Callback = function(Value) Config.AutoBuySecret = Value end,
})

ShopTab:CreateToggle({
   Name = "Auto Buy Mythic Skins | شراء ميثيك (300M)",
   CurrentValue = false,
   Flag = "AutoBuyMythic",
   Callback = function(Value) Config.AutoBuyMythic = Value end,
})

ShopTab:CreateToggle({
   Name = "Auto Equip Best Skin | لبس أفضل سكن",
   CurrentValue = false,
   Flag = "AutoEquipBest",
   Callback = function(Value) Config.AutoEquipBest = Value end,
})

-- SETTINGS & REJOIN TAB
SettingsTab:CreateSection("Connection Options | خيارات الاتصال")

SettingsTab:CreateToggle({
   Name = "Auto Rejoin on Disconnect | إرجاع تلقائي عند الفصل",
   CurrentValue = true,
   Flag = "AutoRejoin",
   Callback = function(Value) Config.AutoRejoin = Value end,
})

SettingsTab:CreateToggle({
   Name = "Auto Rejoin Every 1 Hour | تجديد السيرفر كل ساعة",
   CurrentValue = false,
   Flag = "AutoServerHopHourly",
   Callback = function(Value) Config.AutoServerHopHourly = Value end,
})

SettingsTab:CreateButton({
   Name = "Rejoin Server Now | إعادة دخول فورية",
   Callback = function()
       game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

SettingsTab:CreateSection("Performance | الأداء والسرعة")

SettingsTab:CreateToggle({
   Name = "Super Low Graphics | تقليل الجودة وتخفيف اللاغ",
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
   Name = "Black Screen Mode | وضع الشاشة السوداء",
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
   Name = "Ghost Mode | وضع الشبح (إخفاء اللاعب)",
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
   Name = "Anti-AFK Protection | منع الطرد",
   CurrentValue = true,
   Flag = "AntiAFK",
   Callback = function(Value) Config.AntiAFK = Value end,
})

-- ========================================================
--              FLOATING CIRCULAR TOGGLE BUTTON
-- ========================================================

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

Rayfield:Notify({
   Title = "Sajjad Script Hub",
   Content = "تم التحميل بنجاح مع الدعم المزدوج للغة!",
   Duration = 5,
   Image = CustomImageID,
})
