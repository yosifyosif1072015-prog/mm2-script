-- MM2 Luxury Vertical Hub V23 - Rayfield Touch Bypass Edition
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- صناعة النافذة العمودية الفخمة والمحمية من حظر اللمس تماماً
local Window = Rayfield:CreateWindow({
   Name = "YOSIF HUB | MM2 V23 🩸",
   LoadingTitle = "جاري تخطي حماية السيرفر...",
   LoadingSubtitle = "by Yosif",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false -- إلغاء نظام المفاتيح المزعج لتفتح فوراً
})

-- صناعة القائمة العمودية للميزات
local Tab = Window:CreateTab("الميزات الرئيسية ⚡", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

local MurderOn, SheriffOn, SpeedOn, AimOn = false, false, false, false

-- 1. كشف القاتل
Tab:CreateToggle({
   Name = "👁️ كشف القاتل (أحمر)",
   CurrentValue = false,
   Callback = function(Value)
       MurderOn = Value
       if not Value then
           for _, p in pairs(Players:GetPlayers()) do
               if p.Character and p.Character:FindFirstChild("XenoHl") then p.Character.XenoHl:Destroy() end
           end
       end
    Downs = true end
})

-- 2. كشف الشريف
Tab:CreateToggle({
   Name = "👁️ كشف الشريف (أزرق)",
   CurrentValue = false,
   Callback = function(Value)
       SheriffOn = Value
       if not Value then
           for _, p in pairs(Players:GetPlayers()) do
               if p.Character and p.Character:FindFirstChild("XenoHl") then p.Character.XenoHl:Destroy() end
           end
       end
   end
})

-- 3. السرعة العالية
Tab:CreateToggle({
   Name = "⚡ تفعيل السرعة العالية (45)",
   CurrentValue = false,
   Callback = function(Value)
       SpeedOn = Value
       if not Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
           LocalPlayer.Character.Humanoid.WalkSpeed = 16
       end
   end
})

-- 4. الأيمبوت الصامت بالطلقة
Tab:CreateToggle({
   Name = "🎯 الأيمبوت الصامت بالطلقة",
   CurrentValue = false,
   Callback = function(Value)
       AimOn = Value
   end
})

-- 5. جلب السلاح المتساقط فورا
Tab:CreateButton({
   Name = "🔫 جلب والتقاط السلاح المتساقط",
   Callback = function()
       local targetGun = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("DroppedGun")
       if not targetGun then
           for _, o in pairs(workspace:GetDescendants()) do
               if o:IsA("Model") and (o.Name == "GunDrop" or o.Name == "DroppedGun") then
                   targetGun = o:FindFirstChild("Gun") or o:FindFirstChildOfClass("Part") break
               end
           end
       end
       if targetGun and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
           LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
           LocalPlayer.Character.HumanoidRootPart.CFrame = targetGun.CFrame * CFrame.new(0, 0.2, 0)
       else
           Rayfield:Notify({Title = "خطأ", Content = "السلاح لم يسقط على الأرض بعد!", Duration = 2})
       end
   end
})

-- 6. قتل الجميع للقاتل
Tab:CreateButton({
   Name = "🩸 قتل الجميع فوراً (Kill All)",
   Callback = function()
       local knife = LocalPlayer.Character:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
       if knife then
           knife.Parent = LocalPlayer.Character
           local oldPos = LocalPlayer.Character.HumanoidRootPart.CFrame
           for _, p in pairs(Players:GetPlayers()) do
               if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                   LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                   task.wait(0.06)
                   knife:Activate()
                end
           end
           LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
       else
           Rayfield:Notify({Title = "خطأ", Content = "يجب أن تكون القاتل وتحمل السكين!", Duration = 2})
       end
   end
})

-- ربط الأيمبوت الصامت المطور بالـ Namecall
local OldNamecall;
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod()
    if AimOn and Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                if isM then return p.Character.Head, p.Character.Head.Position, Vector3.new(0,0,0), p.Character.Head.Material end
            end
        end
    end
    return OldNamecall(Self, ...)
end)

-- حلقة الخدمات الخلفية السلسة وبدون لاق
RunService.Heartbeat:Connect(function()
    if SpeedOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 45
    end
    if MurderOn or SheriffOn then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
                if (isM and MurderOn) or (isS and SheriffOn) then
                    local hl = p.Character:FindFirstChild("XenoHl") or Instance.new("Highlight", p.Character)
                    hl.Name = "XenoHl" hl.FillTransparency = 0.5 hl.Enabled = true
                    hl.FillColor = isM and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 100, 255)
                else
                    local hl = p.Character:FindFirstChild("XenoHl") if hl then hl.Enabled = false end
                end
            end
        end
    end
end)
