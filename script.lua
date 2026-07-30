-- ==========================================
-- Keyboard Simulator - Modern Hub (Sajjad)
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- إعدادات الحاوية الرئيسية (GUI)
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "SajjadModernHub"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true -- تحريك القائمة في الشاشة

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- العنوان الرئيسي
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
Title.Text = "⚡ KEYBOARD HUB"
Title.TextColor3 = Color3.fromRGB(0, 210, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- قائمة العناصر القابلة للتمرير
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 5, 0, 50)
Container.Size = UDim2.new(1, -10, 1, -55)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 4
Container.CanvasSize = UDim2.new(0, 0, 0, 300)

UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutIndex
UIListLayout.Padding = UDim.new(0, 8)

-- دالة تصميم الأزرار التفاعلية الحديثة
local function createToggle(text, callback)
    local btn = Instance.new("TextButton")
    local btnCorner = Instance.new("UICorner")
    
    btn.Parent = Container
    btn.Size = UDim2.new(1, -6, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text .. " : OFF"
    
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 120) -- أخضر للـ ON
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = text .. " : ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(38, 38, 46) -- رمادي غامق للـ OFF
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            btn.Text = text .. " : OFF"
        end
        task.spawn(function()
            callback(active)
        end)
    end)
end

-- ==========================================
-- 🛠️ الأزرار والوظائف
-- ==========================================

-- 1. زر GodMode
createToggle("God Mode", function(state)
    -- تفعيل وضع الخلود
end)

-- 2. زر زيادة السرعة
createToggle("Auto Speed (100)", function(state)
    pcall(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = state and 100 or 16
        end
    end)
end)

-- 3. زر جمع الكوينز
local coinsLoop = false
createToggle("Auto Collect Coins", function(state)
    coinsLoop = state
    while coinsLoop do
        pcall(function()
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, item in pairs(workspace:GetDescendants()) do
                if not coinsLoop then break end
                if item:IsA("BasePart") and (item.Name == "Coin" or item.Name == "Token" or item.Name == "Gold") then
                    hrp.CFrame = item.CFrame
                    task.wait(0.05)
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 4. زر تفريغ الرام وإعادة الدخول التلقائي كل ساعة
local ramLoop = false
createToggle("Clean RAM Hourly", function(state)
    ramLoop = state
    if ramLoop then
        task.spawn(function()
            task.wait(3600)
            if ramLoop then
                local ts = game:GetService("TeleportService")
                ts:Teleport(game.PlaceId, game.Players.LocalPlayer)
            end
        end)
    end
end)
