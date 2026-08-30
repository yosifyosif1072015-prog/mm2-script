local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- متغيرات الحالة
local speedOn = true
local murdererESP = false
local sheriffESP = false
local innocentESP = false
local aimBotOn = false

-- إنشاء ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "MM2Hub"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- لوحة رئيسية
local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 300, 0, 450)
panel.Position = UDim2.new(0, 20, 0, 20)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.BorderSizePixel = 2
panel.BorderColor3 = Color3.fromRGB(255, 0, 0)
panel.Parent = gui

-- عنوان
local title = Instance.new("TextLabel")
title.Text = "🩸 MM2 HUB YOSIF"
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.BorderSizePixel = 0
title.Parent = panel

-- زر السرعة
local speedBtn = Instance.new("TextButton")
speedBtn.Text = "⚡ السرعة: ON"
speedBtn.Size = UDim2.new(1, -10, 0, 35)
speedBtn.Position = UDim2.new(0, 5, 0, 60)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 14
speedBtn.Font = Enum.Font.Gotham
speedBtn.BorderSizePixel = 0
speedBtn.Parent = panel

speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedBtn.BackgroundColor3 = speedOn and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(100, 100, 100)
    speedBtn.Text = speedOn and "⚡ السرعة: ON" or "⚡ السرعة: OFF"
end)

-- زر كشف القاتل (أحمر)
local murdererBtn = Instance.new("TextButton")
murdererBtn.Text = "👁️ كشف القاتل (أحمر)"
murdererBtn.Size = UDim2.new(1, -10, 0, 35)
murdererBtn.Position = UDim2.new(0, 5, 0, 105)
murdererBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
murdererBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
murdererBtn.TextSize = 14
murdererBtn.Font = Enum.Font.Gotham
murdererBtn.BorderSizePixel = 0
murdererBtn.Parent = panel

murdererBtn.MouseButton1Click:Connect(function()
    murdererESP = not murdererESP
    murdererBtn.BackgroundColor3 = murdererESP and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(100, 100, 100)
end)

-- زر كشف الشريف (أزرق)
local sheriffBtn = Instance.new("TextButton")
sheriffBtn.Text = "👁️ كشف الشريف (أزرق)"
sheriffBtn.Size = UDim2.new(1, -10, 0, 35)
sheriffBtn.Position = UDim2.new(0, 5, 0, 150)
sheriffBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
sheriffBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sheriffBtn.TextSize = 14
sheriffBtn.Font = Enum.Font.Gotham
sheriffBtn.BorderSizePixel = 0
sheriffBtn.Parent = panel

sheriffBtn.MouseButton1Click:Connect(function()
    sheriffESP = not sheriffESP
    sheriffBtn.BackgroundColor3 = sheriffESP and Color3.fromRGB(0, 100, 255) or Color3.fromRGB(100, 100, 100)
end)

-- زر كشف المواطن (أخضر)
local innocentBtn = Instance.new("TextButton")
innocentBtn.Text = "👁️ كشف المواطن (أخضر)"
innocentBtn.Size = UDim2.new(1, -10, 0, 35)
innocentBtn.Position = UDim2.new(0, 5, 0, 195)
innocentBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
innocentBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
innocentBtn.TextSize = 14
innocentBtn.Font = Enum.Font.Gotham
innocentBtn.BorderSizePixel = 0
innocentBtn.Parent = panel

innocentBtn.MouseButton1Click:Connect(function()
    innocentESP = not innocentESP
    innocentBtn.BackgroundColor3 = innocentESP and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(100, 100, 100)
end)

-- زر الانتقال للسلاح
local teleportGunBtn = Instance.new("TextButton")
teleportGunBtn.Text = "🔫 انتقال للسلاح"
teleportGunBtn.Size = UDim2.new(1, -10, 0, 35)
teleportGunBtn.Position = UDim2.new(0, 5, 0, 240)
teleportGunBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
teleportGunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportGunBtn.TextSize = 14
teleportGunBtn.Font = Enum.Font.Gotham
teleportGunBtn.BorderSizePixel = 0
teleportGunBtn.Parent = panel

teleportGunBtn.MouseButton1Click:Connect(function()
    local gunPart = nil
    -- البحث عن السلاح
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "Gun" or obj.Name == "GunDrop" or obj.Name == "DroppedGun") then
            gunPart = obj
            break
        end
    end
    
    if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = gunPart.CFrame * CFrame.new(0, 3, 0)
        print("✅ انتقلت للسلاح!")
    else
        print("❌ لم يتم إيجاد سلاح")
    end
end)

-- زر Aim Bot
local aimBotBtn = Instance.new("TextButton")
aimBotBtn.Text = "🎯 Aim Bot: OFF"
aimBotBtn.Size = UDim2.new(1, -10, 0, 35)
aimBotBtn.Position = UDim2.new(0, 5, 0, 285)
aimBotBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
aimBotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimBotBtn.TextSize = 14
aimBotBtn.Font = Enum.Font.Gotham
aimBotBtn.BorderSizePixel = 0
aimBotBtn.Parent = panel

aimBotBtn.MouseButton1Click:Connect(function()
    aimBotOn = not aimBotOn
    aimBotBtn.BackgroundColor3 = aimBotOn and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(100, 100, 100)
    aimBotBtn.Text = aimBotOn and "🎯 Aim Bot: ON" or "🎯 Aim Bot: OFF"
end)

-- زر إغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "❌ إغلاق"
closeBtn.Size = UDim2.new(1, -10, 0, 35)
closeBtn.Position = UDim2.new(0, 5, 0, 405)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.Gotham
closeBtn.BorderSizePixel = 0
closeBtn.Parent = panel

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- حلقة التنفيذ الرئيسية
RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character then return end
    
    -- السرعة
    if LocalPlayer.Character:FindFirstChild("Humanoid") then
        if speedOn then
            LocalPlayer.Character.Humanoid.WalkSpeed = 100
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
    
    -- ESP للاعبين
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local knife = character:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
            local gun = character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
            
            -- إنشاء أو العثور على Highlight
            local highlight = character:FindFirstChild("MM2Highlight")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "MM2Highlight"
                highlight.Parent = character
                highlight.FillTransparency = 0.3
                highlight.OutlineTransparency = 0
            end
            
            -- تحديد اللون والتفعيل/التعطيل
            if knife and murdererESP then
                highlight.Enabled = true
                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- أحمر للقاتل
            elseif gun and sheriffESP then
                highlight.Enabled = true
                highlight.FillColor = Color3.fromRGB(0, 100, 255) -- أزرق للشريف
            elseif not gun and not knife and innocentESP then
                highlight.Enabled = true
                highlight.FillColor = Color3.fromRGB(0, 255, 100) -- أخضر للمواطن
            else
                highlight.Enabled = false
            end
        end
    end
    
    -- Aim Bot - توجيه الكاميرا نحو أقرب لاعب
    if aimBotOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local closestPlayer = nil
        local closestDistance = math.huge
        local hrp = LocalPlayer.Character.HumanoidRootPart
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                local distance = (player.Character.Head.Position - hrp.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
        
        if closestPlayer and closestPlayer.Character:FindFirstChild("Head") then
            local targetHead = closestPlayer.Character.Head
            -- توجيه الكاميرا
            local camera = workspace.CurrentCamera
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
        end
    end
end)

print("✅ MM2 Hub مفعل - جميع الميزات متاحة!")
