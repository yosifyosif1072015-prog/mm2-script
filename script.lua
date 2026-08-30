-- MM2 Luxury Vertical Hub V23 - Rayfield Touch Bypass Edition (محدث)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua'))()

-- إنشاء النافذة
local Window = Rayfield:CreateWindow({
   Name = "YOSIF HUB | MM2 V23 🩸",
   LoadingTitle = "جاري التحميل...",
   LoadingSubtitle = "by Yosif",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("الميزات الرئيسية ⚡", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local MurderESP, SheriffESP, InnocentESP, SpeedOn, AimOn = false, false, false, false, false

-- دالة مساعدة: تحقق من وجود HumanoidRootPart
local function hasHRP(p)
    return p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
end

-- دالة مساعدة: العثور على سلاح مسقط (Part أو Model مع PrimaryPart أو "Handle")
local function findDroppedGun()
    -- تحقق من الأسماء الشائعة أولاً
    local candidates = {"GunDrop", "DroppedGun"}
    for _, name in ipairs(candidates) do
        local obj = workspace:FindFirstChild(name)
        if obj then
            if obj:IsA("BasePart") then return obj end
            if obj:IsA("Model") then
                if obj.PrimaryPart then return obj.PrimaryPart end
                local part = obj:FindFirstChild("Handle") or obj:FindFirstChildOfClass("BasePart")
                if part then return part end
            end
        end
    end
    -- فحص عام في المشهد
    for _, o in pairs(workspace:GetDescendants()) do
        if o.Name == "Gun" and o:IsA("BasePart") then
            return o
        end
        if o:IsA("Model") and (o.Name == "GunDrop" or o.Name == "DroppedGun") then
            if o.PrimaryPart then return o.PrimaryPart end
            local part = o:FindFirstChild("Handle") or o:FindFirstChildOfClass("BasePart")
            if part then return part end
        end
    end
    return nil
end

-- إنشاء/إزالة الهايلايت بطريقة آمنة
local function getOrCreateHL(char)
    if not char then return nil end
    local hl = char:FindFirstChild("YosifHL")
    if not hl then
        hl = Instance.new("Highlight")
        hl.Name = "YosifHL"
        hl.Parent = char
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 1
        hl.Enabled = false
    end
    return hl
end

-- Toggle: كشف القاتل
Tab:CreateToggle({
    Name = "👁️ كشف القاتل (أحمر)",
    CurrentValue = false,
    Callback = function(Value)
        MurderESP = Value
        if not Value then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    local hl = p.Character:FindFirstChild("YosifHL")
                    if hl and hl:IsA("Highlight") then hl:Destroy() end
                end
            end
        end
    end
})

-- Toggle: كشف الشريف
Tab:CreateToggle({
    Name = "👁️ كشف الشريف (أزرق)",
    CurrentValue = false,
    Callback = function(Value)
        SheriffESP = Value
        if not Value then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    local hl = p.Character:FindFirstChild("YosifHL")
                    if hl and hl:IsA("Highlight") then hl:Destroy() end
                end
            end
        end
    end
})

-- Toggle: كشف المواطن (لا تظهر أسلحة)
Tab:CreateToggle({
    Name = "👁️ كشف المواطن (أخضر)",
    CurrentValue = false,
    Callback = function(Value)
        InnocentESP = Value
        if not Value then
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    local hl = p.Character:FindFirstChild("YosifHL")
                    if hl and hl:IsA("Highlight") then hl:Destroy() end
                end
            end
        end
    end
})

-- Toggle: سرعة
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

-- Toggle: أيمبوت صامت
Tab:CreateToggle({
    Name = "🎯 أيمبوت (صامت)",
    CurrentValue = false,
    Callback = function(Value)
        AimOn = Value
    end
})

-- زر: انتقال للسلاح المسقط
Tab:CreateButton({
    Name = "🔫 انتقال للسلاح المسقط",
    Callback = function()
        local gunPart = findDroppedGun()
        if not gunPart then
            Rayfield:Notify({Title = "خطأ", Content = "لم يتم إيجاد سلاح مسقط في المشهد.", Duration = 3})
            return
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = gunPart.CFrame * CFrame.new(0, 0.5, 0)
            Rayfield:Notify({Title = "تم", Content = "انتقلت إلى مكان السلاح.", Duration = 2})
        else
            Rayfield:Notify({Title = "خطأ", Content = "شخصيتك غير جاهزة.", Duration = 2})
        end
    end
})

-- زر: جلب السلاح والتقاطه (يحاول وضعه في الشخصية)
Tab:CreateButton({
    Name = "🔫 جلب والتقاط السلاح",
    Callback = function()
        local gunPart = findDroppedGun()
        if not gunPart then
            Rayfield:Notify({Title = "خطأ", Content = "لم يتم إيجاد سلاح مسقط.", Duration = 3})
            return
        end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = gunPart.CFrame * CFrame.new(0, 0.5, 0)
            Rayfield:Notify({Title = "تم", Content = "انتقلت إلى السلاح، حاول التقاطه يدوياً أو تلقائياً حسب المود.", Duration = 2})
        end
    end
})

-- زر: قتل الجميع (يعمل إذا كنت القاتل وتحمل السكين)
Tab:CreateButton({
    Name = "🩸 قتل الجميع فوراً (Kill All)",
    Callback = function()
        local char = LocalPlayer.Character
        if not char then
            Rayfield:Notify({Title = "خطأ", Content = "شخصيتك غير جاهزة.", Duration = 2})
            return
        end
        local knife = char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
        if not knife then
            Rayfield:Notify({Title = "خطأ", Content = "يجب أن تكون القاتل وتحمل السكين!", Duration = 3})
            return
        end
        knife.Parent = char
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local oldCFrame = hrp.CFrame
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local targetHRP = p.Character:FindFirstChild("HumanoidRootPart")
                if targetHRP then
                    hrp.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 1)
                    task.wait(0.06)
                    -- استدعاء تفعيل السكين إذا متاح
                    if type(knife.Activate) == "function" then
                        pcall(function() knife:Activate() end)
                    else
                        -- محاولة استخدام RemoteEvent أو غيرها (غير مضمونة)
                    end
                end
            end
        end
        hrp.CFrame = oldCFrame
        Rayfield:Notify({Title = "تم", Content = "انتهى محاولة قتل الجميع.", Duration = 2})
    end
})

-- Hook بسيط للأيمبوت الصامت عبر __namecall (قد يحتاج إلى دعم Exploit)
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod()
    local args = {...}
    if AimOn and Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        -- حاول إرجاع رأس أي لاعب عدو موجود
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                local isS = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
                -- إذا كان لاعباً مميزاً (قاتل أو الشريف) أهدف إلى رأسه
                if isM or isS then
                    return p.Character.Head, p.Character.Head.Position, Vector3.new(0,0,0), p.Character.Head.Material
                end
            end
        end
    end
    return OldNamecall(Self, unpack(args))
end)

-- حلقة الخادم التي تشغّل ESP والخواص
RunService.Heartbeat:Connect(function()
    -- سرعة
    if SpeedOn and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 45
    end

    -- ESP
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local haveKnife = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
            local haveGun = p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
            local hl = getOrCreateHL(p.Character)

            -- تحديد اللون وتمكين/تعطيل حسب الوضع
            if MurderESP and haveKnife then
                hl.Enabled = true
                hl.FillColor = Color3.fromRGB(255, 0, 0)
            elseif SheriffESP and haveGun then
                hl.Enabled = true
                hl.FillColor = Color3.fromRGB(0, 100, 255)
            elseif InnocentESP and not haveGun and not haveKnife then
                hl.Enabled = true
                hl.FillColor = Color3.fromRGB(0, 255, 100)
            else
                if hl then hl.Enabled = false end
            end
        end
    end
end)

-- تنظيف عند إيقاف الـ GUI أو تعطيله: (اختياري) يمكن إضافة زر لإغلاق/تنظيف

Rayfield:Notify({Title = "جاهز", Content = "YOSIF HUB | MM2 V23 جاهز للاستخدام.", Duration = 2})
