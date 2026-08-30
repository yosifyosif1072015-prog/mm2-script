-- MM2 Simple Hub by Yosif
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local speedOn = false
local espOn = false

print("🎮 MM2 Hub Loaded - Press X to toggle Speed, C to toggle ESP")

-- تفعيل/تعطيل السرعة بالمفاتيح
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.X then
        speedOn = not speedOn
        print(speedOn and "✅ السرعة مفعلة (45)" or "❌ السرعة معطلة (16)")
    end
    
    if input.KeyCode == Enum.KeyCode.C then
        espOn = not espOn
        print(espOn and "✅ ESP مفعل" or "❌ ESP معطل")
    end
end)

-- حلقة السرعة والـ ESP
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character then
        -- السرعة
        if speedOn and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 45
        elseif LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
        
        -- ESP (كشف اللاعبين)
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
                    
                    -- تلوين حسب الدور
                    local hasKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
                    local hasGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
                    
                    if hasKnife then
                        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- أحمر للقاتل
                    elseif hasGun then
                        highlight.FillColor = Color3.fromRGB(0, 100, 255) -- أزرق للشريف
                    else
                        highlight.FillColor = Color3.fromRGB(0, 255, 100) -- أخضر للمواطن
                    end
                end
            end
        else
            -- تعطيل الـ ESP
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild("ESPHighlight")
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end
end)

print("✅ الأوامر:")
print("X = تفعيل/تعطيل السرعة")
print("C = تفعيل/تعطيل ESP")
