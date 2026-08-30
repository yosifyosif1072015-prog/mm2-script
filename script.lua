local P,LP,Cam,RS,TS=game:GetService("Players"),game:GetService("Players").LocalPlayer,workspace.CurrentCamera,game:GetService("RunService"),game:GetService("TweenService")
local SG=Instance.new("ScreenGui",LP:WaitForChild("PlayerGui"))SG.ResetOnSpawn=false

local MF=Instance.new("Frame",SG)
MF.Name = "XenoPremiumMM2_Vertical"
MF.Size=UDim2.new(0,160,0,260)
MF.Position=UDim2.new(0.1,0,0.2,0)
MF.BackgroundColor3=Color3.fromRGB(20,20,25);MF.Active=true;MF.Draggable=true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8)

local T=Instance.new("TextLabel",MF)
T.Size=UDim2.new(1,0,0,35)T.BackgroundColor3=Color3.fromRGB(35,35,45)T.Text="XENO | MM2 V22 🩸"T.TextColor3=Color3.fromRGB(255,255,255)T.TextSize=13;T.Font=Enum.Font.SourceSansBold

local C=Instance.new("Frame",MF)
C.Size=UDim2.new(1,-16,1,-45)C.Position=UDim2.new(0,8,0,40)C.BackgroundTransparency=1
local L=Instance.new("UIListLayout",C)L.SortOrder=Enum.SortOrder.LayoutOrder;L.Padding=UDim.new(0,5)

local function cB(t,cl)
    local b=Instance.new("TextButton",C)
    b.Size=UDim2.new(1,0,0,28)b.BackgroundColor3=cl;b.BorderSizePixel=0;b.Text=t;b.TextColor3=Color3.fromRGB(255,255,255)b.TextSize=12;b.Font=Enum.Font.SourceSansSemibold;b.Active=true;b.Selectable=true
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,5)
    return b 
end

local M,S,Sp,G,K,A=cB("👁️ كشف القاتل",Color3.fromRGB(40,40,45)),cB("👁️ كشف الشريف",Color3.fromRGB(40,40,45)),cB("⚡ السرعة العالية",Color3.fromRGB(40,40,45)),cB("🔫 جلب السلاح",Color3.fromRGB(45,60,110)),cB("🩸 قتل الجميع",Color3.fromRGB(150,40,40)),cB("🎯 أيمبوت صامت بالطلقة",Color3.fromRGB(40,40,45))
local Mo,So,Spo,Ao,GunC=false,false,false,false,nil

local function act(b,f)
    b.MouseButton1Click:Connect(f)
    b.MouseButton1Down:Connect(f)
    b.Activated:Connect(f)
end

act(M,function()Mo=notMo;M.BackgroundColor3=Mo and Color3.fromRGB(180,40,40) or Color3.fromRGB(40,40,45)end)
act(S,function()So=notSo;S.BackgroundColor3=So and Color3.fromRGB(40,100,180) or Color3.fromRGB(40,40,45)end)
act(Sp,function()Spo=notSpo;Sp.BackgroundColor3=Spo and Color3.fromRGB(40,140,40) or Color3.fromRGB(40,40,45)end)
act(A,function()Ao=notAo;A.Text=Ao and "🎯 الأيمبوت: مشغل ✅" or "🎯 أيمبوت صامت بالطلقة"A.BackgroundColor3=Ao and Color3.fromRGB(40,140,40) or Color3.fromRGB(40,40,45)end)

local function scanForGun()
    local target = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("DroppedGun")
    if target then return target end
    for _, o in pairs(workspace:GetDescendants()) do
        if o:IsA("Model") and (o.Name == "GunDrop" or o.Name == "DroppedGun") then
            return o:FindFirstChild("Gun") or o:FindFirstChildOfClass("Part") or o:FindFirstChildOfClass("MeshPart")
        elseif o:IsA("Part") and (o.Name == "GunDrop" or o.Name == "DroppedGun") then
            return o
        end
    end
    return nil
end

task.spawn(function()while true do GunC = scanForGun() task.wait(0.5) end end)

act(G,function()
    GunC = scanForGun()
    if GunC and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then 
        local root = LP.Character.HumanoidRootPart
        root.Velocity = Vector3.new(0,0,0)
        root.CFrame = GunC.CFrame * CFrame.new(0, 0.2, 0)
    else
        G.Text = "❌ لم يسقط بعد"
        task.wait(1)
        G.Text = "🔫 جلب السلاح"
    end 
end)

act(K,function()local k=LP.Character:FindFirstChild("Knife") or LP.Backpack:FindFirstChild("Knife")if k then k.Parent=LP.Character;local oP=LP.Character.HumanoidRootPart.CFrame;task.spawn(function()for _,p in pairs(P:GetPlayers()) do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health>0 then LP.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,1)task.wait(0.05)k:Activate()end end;LP.Character.HumanoidRootPart.CFrame=oP end)end end)

local OldNamecall;
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod()
    if Ao and Method == "FindPartOnRayWithIgnoreList" and not checkcaller() then
        for _, p in pairs(P:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
                local isM = p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife")
                if isM then
                    return p.Character.Head, p.Character.Head.Position, Vector3.new(0,0,0), p.Character.Head.Material
                end
            end
        end
    end
    return OldNamecall(Self, ...)
end)

RS.Heartbeat:Connect(function()
    if Spo and LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = 45 elseif LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = 16 end;
    if Mo or So then 
        for _,p in pairs(P:GetPlayers()) do 
            if p~=LP and p.Character then 
                local m,s=p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife"), p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun")
                if (m and Mo) or (s and So) then 
                    local h=p.Character:FindFirstChild("XenoHl") or Instance.new("Highlight",p.Character)
                    h.Name="XenoHl"
                    h.FillTransparency=0.5;h.Enabled=true;
                    h.FillColor=m and Color3.fromRGB(255,0,0) or Color3.fromRGB(0,100,255)
                else 
                    local h=p.Character:FindFirstChild("XenoHl") if h then h.Enabled=false end 
                end 
            end 
        end 
    end
end)
