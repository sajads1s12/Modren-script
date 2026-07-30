-- Roblox Auto Script / Fluent UI Framework (Optimized for Mobile)
-- Place ID for World 3: 93411036959889

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Ultimate Speed Script Hub",
    SubTitle = "by Sajjad",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main Auto", Icon = "play" }),
    Treadmills = Window:AddTab({ Title = "Treadmills", Icon = "activity" }),
    Shop = Window:AddTab({ Title = "Shop & Skins", Icon = "shopping-cart" }),
    Settings = Window:AddTab({ Title = "Performance & Settings", Icon = "settings" })
}

-- State Variables
local Config = {
    AutoWinTP = false,
    AutoWinWalk = false,
    SpeedBasedWins = false,
    SmartTreadmill = false,
    SelectedTreadmill = "Free",
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

-- TABS: Main Auto
Tabs.Main:AddToggle("AutoWinTP", { Title = "Auto Win (Teleport)", Default = false, Callback = function(v) Config.AutoWinTP = v end })
Tabs.Main:AddToggle("AutoWinWalk", { Title = "Auto Win (Auto Walk)", Default = false, Callback = function(v) Config.AutoWinWalk = v end })
Tabs.Main:AddToggle("SpeedBasedWins", { Title = "Speed-Based Wins (Max Wins)", Default = false, Callback = function(v) Config.SpeedBasedWins = v end })

Tabs.Main:AddSection("Rebirth & Speed")
Tabs.Main:AddToggle("AutoRebirth", { Title = "Auto Rebirth (Based on Level)", Default = false, Callback = function(v) Config.AutoRebirth = v end })
Tabs.Main:AddToggle("LockSpeed", { Title = "Speed Auto-Lock (Prevent Reset)", Default = false, Callback = function(v) Config.LockSpeed = v end })

-- TABS: Treadmills
Tabs.Treadmills:AddToggle("SmartTreadmill", { Title = "Auto Best Available Treadmill", Default = false, Callback = function(v) Config.SmartTreadmill = v end })
Tabs.Treadmills:AddDropdown("SelectedTreadmill", {
    Title = "Select Treadmill Manually",
    Values = TreadmillList,
    Default = 1,
    Callback = function(v) Config.SelectedTreadmill = v end
})

-- TABS: Shop & Skins
Tabs.Shop:AddToggle("AutoBuySecret", { Title = "Auto Buy Secret Skins (Limit 1B)", Default = false, Callback = function(v) Config.AutoBuySecret = v end })
Tabs.Shop:AddToggle("AutoBuyMythic", { Title = "Auto Buy Mythic Skins (Limit 300M)", Default = false, Callback = function(v) Config.AutoBuyMythic = v end })
Tabs.Shop:AddToggle("AutoEquipBest", { Title = "Auto Equip Best Skin", Default = false, Callback = function(v) Config.AutoEquipBest = v end })

-- TABS: Performance & Settings (Smooth Async Fix)
Tabs.Settings:AddToggle("LowGraphics", { Title = "Super Low Graphics", Default = false, Callback = function(v)
    Config.LowGraphics = v
    if v then
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
end })

local BlackScreenGui = nil
Tabs.Settings:AddToggle("BlackScreen", { Title = "Black Screen Mode (Battery & CPU Saver)", Default = false, Callback = function(v)
    Config.BlackScreen = v
    if v then
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
end })

Tabs.Settings:AddToggle("GhostMode", { Title = "Ghost Mode (Hide Character)", Default = false, Callback = function(v)
    Config.GhostMode = v
    task.spawn(function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = v and 1 or 0
                    end
                end
            end
        end)
    end)
end })

Tabs.Settings:AddToggle("AntiAFK", { Title = "Anti-AFK Protection", Default = true, Callback = function(v) Config.AntiAFK = v end })
Tabs.Settings:AddToggle("AutoRejoin", { Title = "Auto Rejoin on Disconnect", Default = true, Callback = function(v) Config.AutoRejoin = v end })

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

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
