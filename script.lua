-- MM2 Hub with Simple GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- متغيرات الحالة
local speedOn = false
local espOn = false
local aimOn = false

-- إنشاء الـ GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2Hub"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- العنوان الرئيسي
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(0, 300, 0, 50)
titleLabel.Position = UDim2.new(0, 20, 0, 20)
titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "🩸 YOSIF HUB MM2"
titleLabel.BorderSizePixel = 0
titleLabel.Parent = screenGui

-- زر السرعة
local speedButton = Instance.new("TextButton")
speedButton.Name = "SpeedButton"
speedButton.Size = UDim2.new(0, 260, 0, 40)
speedButton.Position = UDim2.new(0, 20, 0, 80)
speedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.TextSize = 16
speedButton.Font = Enum.Font.Gotham
speedButton.Text = "⚡ السرعة: OFF"
speedButton.BorderSizePixel = 0
speedButton.Parent = screenGui

speedButton.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedButton.BackgroundColor3 = speedOn and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
    speedButton.Text = speedOn and "⚡ السرعة: ON" or "⚡ السرعة: OFF"
end)

-- زر الـ ESP
local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Size = UDim2.new(0, 260, 0, 40)
espButton.Position = UDim2.new(0, 20, 0, 130)
espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 16
espButton.Font = Enum.Font.Gotham
espButton.Text = "👁️ ESP: OFF"
espButton.BorderSizePixel = 0
espButton.Parent = screenGui

espButton.MouseButton1Click:Connect(function()
    espOn = not espOn
    espButton.BackgroundColor3 = espOn and Color3.fromRGB(0, 100, 255) or Color3.fromRGB(50, 50, 50)
    espButton.Text = espOn and "👁️ ESP: ON" or "👁️ ESP: OFF"
end)

-- زر الـ Aim
local aimButton = Instance.new("TextButton")
aimButton.Name = "AimButton"
aimButton.Size = UDim2.new(0, 260, 0, 40)
aimButton.Position = UDim2.new(0, 20, 0, 180)
aimButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimButton.TextSize = 16
aimButton.Font = Enum.Font.Gotham
aimButton.Text = "🎯 Aim Bot: OFF"
aimButton.BorderSizePixel = 0
aimButton.Parent = screenGui

aimButton.MouseButton1Click:Connect(function()
    aimOn = not aimOn
    aimButton.BackgroundColor3 = aimOn and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(50, 50, 50)
    aimButton.Text = aimOn and "🎯 Aim Bot: ON" or "🎯 Aim Bot: OFF"
end)

-- زر الإغلاق
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 260, 0, 40)
closeButton.Position = UDim2.new(0, 20, 0, 230)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "❌ إغلاق"
closeButton.BorderSizePixel = 0
closeButton.Parent = screenGui

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- حلقة الخواص
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character then
        -- السرعة
        if speedOn and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 45
        elseif LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
        
        -- ESP
        if espOn then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = player.Character:FindFirstChild("ESPHighlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
                        highlight.Parent = player.Character
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                    end
                    
                    local hasKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
                    local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
                    
                    if hasKnife then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    elseif hasGun then
                        highlight.FillColor = Color3.fromRGB(0, 100, 255)
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 100)
                    end
                end
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("ESPHighlight")
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end
end)

print("✅ MM2 Hub مفعل - واجهة ظاهرة الآن!")
