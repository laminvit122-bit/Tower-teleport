-- ============================================
-- Tower of Hell Teleport Script v11 (с отладкой)
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Функция вывода в чат
local function notify(text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Tower TP",
            Text = text,
            Duration = 3
        })
    end)
    print("[Tower TP] " .. text)
end

local MAIN_W_SCALE = 0.30
local MAIN_H_SCALE = 0.45
local MINI_SCALE   = 0.10
local MINI_ASPECT  = 1.5
local MINI_IMAGE_ID = "rbxassetid://139196736118392"

-- ============================================
-- GUI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TowerTeleportGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(MAIN_W_SCALE, 0, MAIN_H_SCALE, 0)
mainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 100, 100)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(MINI_SCALE, 0, MINI_SCALE * MINI_ASPECT, 0)
miniFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
miniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Visible = false
miniFrame.ClipsDescendants = true
miniFrame.Parent = screenGui
Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 12)

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(255, 100, 100)
miniStroke.Thickness = 2
miniStroke.Parent = miniFrame

local miniImage = Instance.new("ImageLabel")
miniImage.Size = UDim2.new(1, -6, 1, -6)
miniImage.Position = UDim2.new(0, 3, 0, 3)
miniImage.BackgroundTransparency = 1
miniImage.Image = MINI_IMAGE_ID
miniImage.ScaleType = Enum.ScaleType.Fit
miniImage.Parent = miniFrame
Instance.new("UICorner", miniImage).CornerRadius = UDim.new(0, 10)

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Tower of Hell TP"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 26)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Text = "—"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 18
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.AutoButtonColor = false
minimizeBtn.Parent = titleBar
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 26)
closeBtn.Position = UDim2.new(1, -36, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

minimizeBtn.MouseEnter:Connect(function() minimizeBtn.BackgroundColor3 = Color3.fromRGB(110, 110, 130) end)
minimizeBtn.MouseLeave:Connect(function() minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100) end)
closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80) end)
closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60) end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -50)
scrollFrame.Position = UDim2.new(0, 10, 0, 44)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100)
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
scrollFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrollFrame

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

local function createButton(text, order, baseColor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -4, 0, 44)
    btn.BackgroundColor3 = baseColor
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    btn.Font = Enum.Font.GothamBold
    btn.LayoutOrder = order
    btn.AutoButtonColor = false
    btn.Parent = scrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.new(
            math.min(baseColor.R * 1.3, 1),
            math.min(baseColor.G * 1.3, 1),
            math.min(baseColor.B * 1.3, 1)
        )
    end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = baseColor end)
    
    return btn
end

-- ============================================
-- ОТЛАДКА: что вообще есть в workspace?
-- ============================================
local function debugWorkspace()
    notify("--- Поиск ---")
    
    local tower = workspace:FindFirstChild("tower")
    if not tower then
        notify("❌ Нет workspace.tower")
        -- Ищем похожие имена
        for _, obj in ipairs(workspace:GetChildren()) do
            local n = obj.Name:lower()
            if n:find("tower") or n:find("map") or n:find("level") then
                notify("Похожее: " .. obj.Name)
            end
        end
        return nil
    end
    
    notify("✅ Нашли tower")
    
    -- Перечисляем детей tower
    local names = {}
    for _, obj in ipairs(tower:GetChildren()) do
        table.insert(names, obj.Name)
    end
    notify("Дети tower: " .. table.concat(names, ", "))
    
    -- Проверяем center
    local center = tower:FindFirstChild("center")
    if center then
        notify("✅ center: " .. tostring(center.ClassName))
        notify("Позиция: " .. tostring(center.Position))
    else
        notify("❌ center НЕ найден")
    end
    
    -- Проверяем top
    local top = tower:FindFirstChild("top")
    if top then
        notify("✅ top: " .. tostring(top.ClassName))
    else
        notify("❌ top НЕ найден")
    end
    
    -- Проверяем finishes
    local finishes = tower:FindFirstChild("finishes")
    if finishes then
        notify("✅ finishes, детей: " .. #finishes:GetChildren())
    else
        notify("❌ finishes НЕ найден")
    end
    
    -- Проверяем steps
    local steps = tower:FindFirstChild("steps")
    if steps then
        notify("✅ steps, детей: " .. #steps:GetChildren())
    else
        notify("❌ steps НЕ найден")
    end
    
    return tower
end

-- ============================================
-- АВТОПОИСК ФИНИША
-- ============================================
local function findFinish()
    local tower = workspace:FindFirstChild("tower")
    if not tower then return nil, "Нет workspace.tower" end
    
    -- 1) center
    local center = tower:FindFirstChild("center")
    if center and center:IsA("BasePart") then
        return center, "center"
    end
    
    -- 2) top
    local top = tower:FindFirstChild("top")
    if top and top:IsA("BasePart") then
        return top, "top"
    end
    
    -- 3) stop в steps
    local steps = tower:FindFirstChild("steps")
    if steps then
        local best, bestY = nil, -math.huge
        for _, obj in ipairs(steps:GetChildren()) do
            if obj.Name == "stop" and obj:IsA("BasePart") and obj.Position.Y > bestY then
                bestY = obj.Position.Y
                best = obj
            end
        end
        if best then return best, "steps.stop" end
    end
    
    -- 4) stop в finishes
    local finishes = tower:FindFirstChild("finishes")
    if finishes then
        for _, obj in ipairs(finishes:GetChildren()) do
            if obj.Name == "stop" and obj:IsA("BasePart") then
                return obj, "finishes.stop"
            end
        end
    end
    
    return nil, "Ничего не нашли"
end

-- ============================================
-- ТЕЛЕПОРТ
-- ============================================
local function teleportToFinish()
    local finish, source = findFinish()
    if not finish then
        notify("⚠ " .. tostring(source))
        return false
    end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then
        notify("⚠ Нет персонажа")
        return false
    end
    
    -- Телепорт
    char.HumanoidRootPart.CFrame = CFrame.new(finish.Position + Vector3.new(0, 5, 0))
    char.HumanoidRootPart.Velocity = Vector3.new(0, -20, 0)
    notify("✅ Телепорт на " .. source)
    notify("Позиция: " .. tostring(finish.Position))
    return true
end

-- ============================================
-- КНОПКИ
-- ============================================
local towerNoobBtn = createButton("Tower Noob", 1, Color3.fromRGB(60, 180, 80))
towerNoobBtn.MouseButton1Click:Connect(function()
    if teleportToFinish() then
        towerNoobBtn.Text = "✅ Tower Noob"
        task.wait(0.6)
        towerNoobBtn.Text = "Tower Noob"
    else
        towerNoobBtn.Text = "⚠ Проверь чат"
        task.wait(1.5)
        towerNoobBtn.Text = "Tower Noob"
    end
end)

local towerProBtn = createButton("Tower Pro", 2, Color3.fromRGB(220, 190, 50))
towerProBtn.MouseButton1Click:Connect(function()
    if teleportToFinish() then
        towerProBtn.Text = "✅ Tower Pro"
        task.wait(0.6)
        towerProBtn.Text = "Tower Pro"
    else
        towerProBtn.Text = "⚠ Проверь чат"
        task.wait(1.5)
        towerProBtn.Text = "Tower Pro"
    end
end)

local debugBtn = createButton("🔍 Отладка", 3, Color3.fromRGB(80, 80, 120))
debugBtn.MouseButton1Click:Connect(function()
    debugWorkspace()
    debugBtn.Text = "🔍 Смотри чат"
    task.wait(1)
    debugBtn.Text = "🔍 Отладка"
end)

local theTowerBtn = createButton("The Tower (Soon)", 4, Color3.fromRGB(200, 60, 60))
theTowerBtn.MouseButton1Click:Connect(function()
    theTowerBtn.Text = "Скоро..."
    task.wait(1)
    theTowerBtn.Text = "The Tower (Soon)"
end)

-- ============================================
-- ПЕРЕТАСКИВАНИЕ
-- ============================================
local function makeDraggable(frame, handle)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
           or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
            frame:SetAttribute("SavedPos", frame.Position)
        end
    end)
end

makeDraggable(mainFrame, titleBar)
makeDraggable(miniFrame, miniImage)

-- ============================================
-- СВОРАЧИВАНИЕ
-- ============================================
local isMinimized, isAnimating = false, false

local function animateFrame(frame, sizeGoal, posGoal, dur)
    local tw = TweenService:Create(frame, TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = sizeGoal, Position = posGoal })
    tw:Play()
    return tw
end

local function minimizeWindow()
    if isAnimating or isMinimized then return end
    isAnimating = true
    mainFrame:SetAttribute("SavedPos", mainFrame.Position)
    miniFrame.Position = mainFrame.Position
    titleBar.Visible = false
    scrollFrame.Visible = false
    animateFrame(mainFrame, UDim2.new(MINI_SCALE, 0, MINI_SCALE * MINI_ASPECT, 0), miniFrame.Position, 0.3).Completed:Wait()
    mainFrame.Visible = false
    miniFrame.Visible = true
    isMinimized, isAnimating = true, false
end

local function restoreWindow()
    if isAnimating or not isMinimized then return end
    isAnimating = true
    local savedMainPos = mainFrame:GetAttribute("SavedPos") or miniFrame.Position
    mainFrame.Position = miniFrame.Position
    mainFrame.Size = UDim2.new(MINI_SCALE, 0, MINI_SCALE * MINI_ASPECT, 0)
    mainFrame.Visible = true
    titleBar.Visible = false
    scrollFrame.Visible = false
    miniFrame.Visible = false
    animateFrame(mainFrame, UDim2.new(MAIN_W_SCALE, 0, MAIN_H_SCALE, 0), savedMainPos, 0.3).Completed:Wait()
    titleBar.Visible = true
    scrollFrame.Visible = true
    isMinimized, isAnimating = false, false
end

minimizeBtn.MouseButton1Click:Connect(minimizeWindow)

local miniClick, miniStart = false, nil
miniImage.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        miniClick = true
        miniStart = input.Position
    end
end)
miniImage.InputEnded:Connect(function(input)
    if not miniClick then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        local moved = 0
        if miniStart then
            local d = input.Position - miniStart
            moved = math.abs(d.X) + math.abs(d.Y)
        end
        if moved < 10 then restoreWindow() end
        miniClick, miniStart = false, nil
    end
end)

closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

notify("Скрипт загружен! Нажми 🔍 Отладка")
