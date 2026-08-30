local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local speedOn = true -- السرعة مفعلة من البداية
local espOn = false

-- إنشاء ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedHub"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- لوحة رئيسية
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 250, 0, 150)
panel.Position = UDim2.new(0, 20, 0, 20)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.BorderSizePixel = 2
panel.BorderColor3 = Color3.fromRGB(255, 0, 0)
panel.Parent = gui

-- عنوان
local title = Instance.new("TextLabel")
title.Text = "🚀 SPEED HUB"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.BorderSizePixel = 0
title.Parent = panel

-- زر السرعة
local speedBtn = Instance.new("TextButton")
speedBtn.Text = "السرعة: ON ⚡"
speedBtn.Size = UDim2.new(1, -10, 0, 40)
speedBtn.Position = UDim2.new(0, 5, 0, 50)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 16
speedBtn.Font = Enum.Font.Gotham
speedBtn.BorderSizePixel = 0
speedBtn.Parent = panel

speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedBtn.BackgroundColor3 = speedOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    speedBtn.Text = speedOn and "السرعة: ON ⚡" or "السرعة: OFF 🛑"
end)

-- حلقة التنفيذ
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if speedOn then
            LocalPlayer.Character.Humanoid.WalkSpeed = 100 -- سرعة عالية جداً
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

print("✅ Speed Hub مفعل - السرعة 100!")
