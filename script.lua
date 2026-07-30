-- ==========================================
-- Keyboard Simulator - Sajjad Modern Hub (Rayfield UI)
-- ==========================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "KEYBOARD HUB | v2.2.0",
   LoadingTitle = "Sajjad Modern Script",
   LoadingSubtitle = "by Sajjad",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SajjadHubConfig",
      FileName = "KeyboardSimConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false -- بدون نظام مفاتيح لسهولة التشغيل
})

-- ==========================================
-- 📌 التبويبات (Tabs)
-- ==========================================
local MainTab = Window:CreateTab("⚡ Main", 4483362458)
local BuyTab = Window:CreateTab("🛒 Auto Buy", 4483362458)
local SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)

-- ==========================================
-- 🎯 تبويب MAIN (الفوز والتنقل والسرعة)
-- ==========================================

MainTab:CreateSection("Auto Win Settings")

-- اختيار منصة الفوز / الفلوس (Target Win Block)
local selectedWinBlock = nil
local winBlockNames = {}

-- بحث تلقائي عن منصات الفوز داخل الماب لتغذية القائمة
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and (v.Name:lower():find("win") or v.Name:lower():find("wb")) then
        table.insert(winBlockNames, v.Name)
    end
end

if #winBlockNames == 0 then
    winBlockNames = {"WB1 (1K)", "WB5 (10K)", "WB14 (50K)", "Auto Highest"}
end

MainTab:CreateDropdown({
   Name = "Target Win Block (اختيار كمية الفوز)",
   Options = winBlockNames,
   CurrentOption = winBlockNames[1],
   MultipleOptions = false,
   Flag = "TargetWinDropdown",
   Callback = function(Option)
       selectedWinBlock = Option[1]
   end,
})

-- زر تفعيل الفوز التلقائي (Auto Win - Tween/Walk)
local autoWinActive = false
MainTab:CreateToggle({
   Name = "Auto Win (Smart Walk / Teleport)",
   CurrentValue = false,
   Flag = "AutoWinToggle",
   Callback = function(Value)
      autoWinActive = Value
      task.spawn(function()
          while autoWinActive do
              pcall(function()
                  local char = game.Players.LocalPlayer.Character
                  if char and char:FindFirstChild("HumanoidRootPart") then
                      -- البحث عن المنصة المحددة ونقل اللاعب إليها
                      for _, obj in pairs(workspace:GetDescendants()) do
                          if not autoWinActive then break end
                          if obj:IsA("BasePart") and (obj.Name == selectedWinBlock or obj.Name:lower():find("win")) then
                              char.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                              task.wait(0.2)
                          end
                      end
                  end
              end)
              task.wait(0.5)
          end
      end)
   end,
})

MainTab:CreateSection("Speed Control")

-- سرعة المشي المخصصة
MainTab:CreateSlider({
   Name = "Travel Speed (السرعة المخصصة)",
   Range = {16, 500},
   Increment = 5,
   Suffix = " Speed",
   CurrentValue = 100,
   Flag = "SpeedSlider",
   Callback = function(Value)
       pcall(function()
           if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
           end
       end)
   end,
})

-- Smart Speed (السرعة القصوى تلقائياً)
local smartSpeed = false
MainTab:CreateToggle({
   Name = "Smart Speed (Max Owned)",
   CurrentValue = false,
   Flag = "SmartSpeedToggle",
   Callback = function(Value)
       smartSpeed = Value
       task.spawn(function()
           while smartSpeed do
               pcall(function()
                   local player = game.Players.LocalPlayer
                   local char = player.Character
                   if char and char:FindFirstChild("Humanoid") then
                       char.Humanoid.WalkSpeed = 350 -- يضبط أقصى سرعة
                   end
               end)
               task.wait(0.5)
           end
       end)
   end,
})

-- ==========================================
-- 🛒 تبويب AUTO BUY
-- ==========================================
BuyTab:CreateSection("Automation")

BuyTab:CreateToggle({
   Name = "Auto Collect Coins",
   CurrentValue = false,
   Flag = "AutoCoins",
   Callback = function(Value)
       -- كود جمع الكوينز
   end,
})

-- ==========================================
-- ⚙️ تبويب SETTINGS & UTILITY
-- ==========================================
SettingsTab:CreateSection("Utility")

SettingsTab:CreateToggle({
   Name = "Clean RAM Hourly / Rejoin",
   CurrentValue = false,
   Flag = "CleanRam",
   Callback = function(Value)
       if Value then
           task.spawn(function()
               task.wait(3600)
               game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
           end)
       end
   end,
})

-- زر إخفاء/إظهار الواجهة (Toggle Key)
SettingsTab:CreateKeybind({
   Name = "UI Toggle Key (زر إخفاء/فتح القائمة)",
   CurrentKeybind = "K",
   HoldToInteract = false,
   Flag = "UIKeybind",
   Callback = function(Keybind)
       Rayfield:Toggle()
   end,
})
