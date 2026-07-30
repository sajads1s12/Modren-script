-- Ultimate Speed Script Hub / Rayfield UI (Mobile Optimized)

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
   Discord = {
      Enabled = false
   },
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
    AutoRejoin = true
}

-- Treadmill Multipliers List
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
local MainTab = Window:CreateTab("Main Auto", 4483362458)
local TreadmillsTab = Window:CreateTab("Treadmills", 4483362458)
local ShopTab = Window:CreateTab("Shop & Skins", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- MAIN TAB
MainTab:CreateToggle({
   Name = "Auto Win (Teleport)",
   CurrentValue = false,
   Flag = "AutoWinTP",
   Callback = function(Value) Config.AutoWinTP = Value end,
})

MainTab:CreateToggle({
   Name = "Auto Win (Auto Walk)",
   CurrentValue = false,
   Flag = "AutoWinWalk",
   Callback = function(Value) Config.AutoWinWalk = Value end,
})

MainTab:CreateToggle({
   Name = "Speed-Based Wins (Max Wins)",
   CurrentValue = false,
   Flag = "SpeedBasedWins",
   Callback = function(Value) Config.SpeedBasedWins = Value end,
})

MainTab:CreateSection("Rebirth & Speed")

MainTab:CreateToggle({
   Name = "Auto Rebirth (Based on Level)",
   CurrentValue = false,
   Flag = "AutoRebirth",
   Callback = function(Value) Config.AutoRebirth = Value end,
})

MainTab:CreateToggle({
   Name = "Speed Auto-Lock (Prevent Reset)",
   CurrentValue = false,
   Flag = "LockSpeed",
   Callback = function(Value) Config.LockSpeed = Value end,
})

-- TREADMILLS TAB
TreadmillsTab:CreateToggle({
   Name = "Auto Best Available Treadmill",
   CurrentValue = false,
   Flag = "SmartTreadmill",
   Callback = function(Value) Config.SmartTreadmill = Value end,
})

TreadmillsTab:CreateDropdown({
   Name = "Select Treadmill Manually",
   Options = TreadmillList,
   CurrentOption = {"Free Treadmill"},
   MultipleOptions = false,
   Flag = "SelectedTreadmill",
   Callback = function(Option) Config.SelectedTreadmill = Option[1] end,
})

-- SHOP TAB
ShopTab:CreateToggle({
   Name = "Auto Buy Secret Skins (Limit 1B)",
   CurrentValue = false,
   Flag = "AutoBuySecret",
   Callback = function(Value) Config.AutoBuySecret = Value end,
})

ShopTab:CreateToggle({
   Name = "Auto Buy Mythic Skins (Limit 300M)",
   CurrentValue = false,
   Flag = "AutoBuyMythic",
   Callback = function(Value) Config.AutoBuyMythic = Value end,
})

ShopTab:CreateToggle({
   Name = "Auto Equip Best Skin",
   CurrentValue = false,
   Flag = "AutoEquipBest",
   Callback = function(Value) Config.AutoEquipBest = Value end,
})

-- SETTINGS TAB
SettingsTab:CreateToggle({
   Name = "Super Low Graphics",
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
   Name = "Black Screen Mode (Battery Saver)",
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
   Name = "Ghost Mode (Hide Character)",
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
   Name = "Anti-AFK Protection",
   CurrentValue = true,
   Flag = "AntiAFK",
   Callback = function(Value) Config.AntiAFK = Value end,
})

SettingsTab:CreateToggle({
   Name = "Auto Rejoin on Disconnect",
   CurrentValue = true,
   Flag = "AutoRejoin",
   Callback = function(Value) Config.AutoRejoin = Value end,
})

-- Anti-AFK Logic
local VirtualUser = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

-- Auto Rejoin
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if Config.AutoRejoin and child.Name == "ErrorPrompt" then
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
end)

Rayfield:Notify({
   Title = "Sajjad Script Hub",
   Content = "تم تشغيل واجهة Rayfield بنجاح!",
   Duration = 5,
   Image = 4483362458,
})
