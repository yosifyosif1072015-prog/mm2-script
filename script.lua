-- MM2 Hub Console Version
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local speedOn = false
local espOn = false

print("╔════════════════════╗")
print("║  YOSIF HUB MM2 V2  ║")
print("╚════════════════════╝")
print("")
print("الأوامر:")
print("1. /speed - تفعيل/تعطيل السرعة")
print("2. /esp - تفعيل/تعطيل ESP")
print("")

-- معالج الأوامر
game:GetService("Chat"):Chat(LocalPlayer.Character.Head, "Hub Ready!", Enum.ChatColor.Green)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.V then
        speedOn = not speedOn
        print(speedOn and "✅ السرعة: مفعلة" or "❌ السرعة: معطلة")
    end
    
    if input.KeyCode == Enum.KeyCode.B then
        espOn = not espOn
        print(espOn and "✅ ESP: مفعل" or "❌ ESP: معطل")
    end
end)

-- حلقة تنفيذ الخواص
RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character then return end
    
    -- السرعة
    if speedOn then
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 45
        end
    else
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
    
    -- ESP
    if espOn then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hl = player.Character:FindFirstChild("ESPHighlight")
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "ESPHighlight"
                    hl.Parent = player.Character
                    hl.FillTransparency = 0.4
                    hl.OutlineTransparency = 0
                end
                
                local knife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
                local gun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
                
                if knife then
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                elseif gun then
                    hl.FillColor = Color3.fromRGB(0, 100, 255)
                else
                    hl.FillColor = Color3.fromRGB(0, 255, 100)
                end
                hl.Enabled = true
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local hl = player.Character:FindFirstChild("ESPHighlight")
                if hl then hl:Destroy() end
            end
        end
    end
end)

print("✅ الكود شغال الآن!")
print("اضغط V للسرعة")
print("اضغط B للـ ESP")
