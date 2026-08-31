-- ====================================================================
--  XENO & GUTA PREMIUM VERTICAL HUB - MURDER MYSTERY 2 (2026 MIGRATED)
-- ====================================================================

local p = game.Players.LocalPlayer
local pg = p:WaitForChild("PlayerGui")

if pg:FindFirstChild("XenoVerticalHub") then 
    pg.XenoVerticalHub:Destroy() 
end

local sg = Instance.new("ScreenGui", pg)
sg.Name = "XenoVerticalHub"
sg.ResetOnSpawn = false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 180, 0, 500)
f.Position = UDim2.new(0, 15, 0, 120)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
f.BorderSizePixel = 2
f.BorderColor3 = Color3.fromRGB(60, 60, 80)
f.Active, f.Draggable = true, true

local t = Instance.new("TextLabel", f)
t.Text = "XENO MM2 V5"
t.Size = UDim2.new(1, 0, 0, 35)
t.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
t.TextColor3 = Color3.fromRGB(255, 255, 255)
t.Font = Enum.Font.SourceSansBold
t.TextSize = 14

local function makeBtn(txt, yPos, cb)
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 160, 0, 35)
    b.Position = UDim2.new(0, 10, 0, yPos)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(180, 35, 35)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 12
    b.BorderSizePixel = 0
    b.MouseButton1Click:Connect(function() pcall(cb, b) end)
    return b
end

local function makeTextBox(placeholder, defaultText, yPos)
    local box = Instance.new("TextBox", f)
    box.Size = UDim2.new(0, 160, 0, 30)
    box.Position = UDim2.new(0, 10, 0, yPos)
    box.PlaceholderText = placeholder
    box.Text = defaultText
    box.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSans; box.TextSize = 12; box.BorderSizePixel = 0
    return box
end

local actM, actS, actI = false, false, false
local actSpeed, actJump, actInf, actNoclip = false, false, false, false
local targetSpeed, targetJump = 50, 100

local function runESP(role, color, state)
    task.spawn(function()
        while state do
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= p and player.Character then
                    local bp = player:FindFirstChild("Backpack")
                    local char = player.Character
                    local k = bp and (bp:FindFirstChild("Knife") or bp:FindFirstChild("DefaultKnife")) or (char:FindFirstChild("Knife") or char:FindFirstChild("DefaultKnife"))
                    local g = bp and (bp:FindFirstChild("Gun") or bp:FindFirstChild("DefaultGun")) or (char:FindFirstChild("Gun") or char:FindFirstChild("DefaultGun"))
                    local match = (role == "M" and k) or (role == "S" and g) or (role == "I" and not k and not g)
                    if match and not char:FindFirstChild("X_"..role) then
                        local hl = Instance.new("Highlight", char) hl.Name = "X_"..role; hl.FillColor = color; hl.FillTransparency = 0.4
                    elseif not match and char:FindFirstChild("X_"..role) then char["X_"..role]:Destroy() end
                end
            end
            task.wait(1)
        end
        for _, player in pairs(game.Players:GetPlayers()) do pcall(function() player.Character["X_"..role]:Destroy() end) end
    end)
end

local bM = makeBtn("كشف القاتل فقط", 45, function() actM = not actM; bM.BackgroundColor3 = actM and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35); runESP("M", Color3.fromRGB(255, 0, 0), actM) end)
local bS = makeBtn("كشف الشريف فقط", 85, function() actS = not actS; bS.BackgroundColor3 = actS and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35); runESP("S", Color3.fromRGB(0, 0, 255), actS) end)
local bI = makeBtn("كشف المواطنين فقط", 125, function() actI = not actI; bI.BackgroundColor3 = actI and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35); runESP("I", Color3.fromRGB(0, 255, 0), actI) end)

makeBtn("انتقال للسلاح الساقط", 165, function()
    local drop = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("Gun")
    if drop then p.Character.HumanoidRootPart.CFrame = drop.CFrame end
end)

makeBtn("قتل الجميع (القاتل)", 205, function()
    local knife = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
    if knife then
        knife.Parent = p.Character
        for _, enemy in pairs(game.Players:GetPlayers()) do
            if enemy ~= p and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = enemy.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                task.wait(0.12)
                if knife:FindFirstChild("Stab") then knife.Stab:FireServer() end
            end
        end
    end
end)

local txSpeed = makeTextBox("اكتب السرعة هنا", "50", 250)
local bSp = makeBtn("تفعيل السرعة", 285, function() actSpeed = not actSpeed; bSp.BackgroundColor3 = actSpeed and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35); targetSpeed = tonumber(txSpeed.Text) or 50 end)

local txJump = makeTextBox("اكتب النطة هنا", "100", 325)
local bJm = makeBtn("تفعيل النطة", 360, function() actJump = not actJump; bJm.BackgroundColor3 = actJump and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35); targetJump = tonumber(txJump.Text) or 100 end)

local bIn = makeBtn("تفعيل انفنيتي جامب", 400, function() actInf = not actInf; bIn.BackgroundColor3 = actInf and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35) end)
local bNc = makeBtn("تفعيل اختراق الجدار", 440, function() actNoclip = not actNoclip; bNc.BackgroundColor3 = actNoclip and Color3.fromRGB(35, 180, 35) or Color3.fromRGB(180, 35, 35) end)

game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        local char = p.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = actSpeed and targetSpeed or 16
            if actJump and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                char.HumanoidRootPart.Velocity = Vector3.new(char.HumanoidRootPart.Velocity.X, targetJump, char.HumanoidRootPart.Velocity.Y)
            end
            if actNoclip then
                for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
            end
        end
    end)
end)

game:GetService("UserInputService").JumpRequest:Connect(function() if actInf then pcall(function() p.Character.Humanoid:ChangeState("Jumping") end) end)
