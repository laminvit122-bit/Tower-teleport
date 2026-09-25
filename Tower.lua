-- ============================================
-- Tower of Hell Teleport Script v4
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- ============================================
-- ОДИНАКОВЫЕ КООРДИНАТЫ ДЛЯ ОБЕИХ БАШЕН
-- ============================================
local SHARED_POS = Vector3.new(-52.0, 319.2, -0.0)

local teleports = {
    ["Tower Noob"] = SHARED_POS,
    ["Tower Pro"]  = SHARED_POS,
    ["The Tower"]  = nil,
}

-- ============================================
-- РАЗМЕРЫ
-- ============================================
local MAIN_W_SCALE = 0.30
local MAIN_H_SCALE = 0.45
local MINI_SCALE   = 0.10
local MINI_ASPECT  = 1.5

-- ============================================
-- ID КАРТИНКИ ДЛЯ КВАДРАТА
-- ============================================
local MINI_IMAGE_ID = "rbxassetid://139196736118392"

-- ============================================
-- СОЗДАНИЕ GUI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TowerTeleportGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

-- ============================================
-- ГЛАВНОЕ ОКНО
-- ============================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(MAIN_W_SCALE, 0, MAIN_H_SCALE, 0)
mainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 100, 100)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- ============================================
-- МИНИ-КВАДРАТ
-- ============================================
local miniFrame = Instance.new("Frame")
miniFrame.Name = "MiniFrame"
miniFrame.Size = UDim2.new(MINI_SCALE, 0, MINI_SCALE * MINI_ASPECT, 0)
miniFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
miniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
miniFrame.BorderSizePixel = 0
miniFrame.Active = true
miniFrame.Visible = false
miniFrame.ClipsDescendants = true
miniFrame.Parent = screenGui

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 12)
miniCorner.Parent = miniFrame

local miniStroke = Instance.new("UIStroke")
miniStroke.Color = Color3.fromRGB(255, 100, 100)
miniStroke.Thickness = 2
miniStroke.Parent = miniFrame

local miniImage = Instance.new("ImageLabel")
miniImage.Name = "MiniImage"
miniImage.Size = UDim2.new(1, -6, 1, -6)
miniImage.Position = UDim2.new(0, 3, 0, 3)
miniImage.BackgroundTransparency = 1
miniImage.Image = MINI_IMAGE_ID
miniImage.ScaleType = Enum.ScaleType.Fit
miniImage.Parent = miniFrame

local miniImageCorner = Instance.new("UICorner")
miniImageCorner.CornerRadius = UDim.new(0, 10)
miniImageCorner.Parent = miniImage

-- ============================================
-- ВЕРХНЯЯ ПАНЕЛЬ
-- ============================================
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

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
minimizeBtn.Name = "MinimizeBtn"
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

local minBtnCorner = Instance.new("UICorner")
minBtnCorner.CornerRadius = UDim.new(0, 6)
minBtnCorner.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
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

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 6)
closeBtnCorner.Parent = closeBtn

minimizeBtn.MouseEnter:Connect(function()
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(110, 110, 130)
end)
minimizeBtn.MouseLeave:Connect(function()
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
end)
closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
end)

-- ============================================
-- КОНТЕЙНЕР СКРОЛЛА (ScrollingFrame)
-- ============================================
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
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

-- Автообновление CanvasSize
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- ============================================
-- СОЗДАНИЕ КНОПКИ
-- ============================================
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
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.new(
            math.min(baseColor.R * 1.3, 1),
            math.min(baseColor.G * 1.3, 1),
            math.min(baseColor.B * 1.3, 1)
        )
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = baseColor
    end)
    
    return btn
end

-- ============================================
-- ТЕЛЕПОРТ
-- ============================================
local function teleportTo(position)
    if not position then return false end
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
        return true
    end
    return false
end

-- ============================================
-- КНОПКИ
-- ============================================
local towerNoobBtn = createButton("Tower Noob", 1, Color3.fromRGB(60, 180, 80))
towerNoobBtn.MouseButton1Click:Connect(function()
    if teleportTo(teleports["Tower Noob"]) then
        towerNoobBtn.Text = "✅ Tower Noob"
        task.wait(0.6)
        towerNoobBtn.Text = "Tower Noob"
    else
        towerNoobBtn.Text = "⚠ Нет координат"
        task.wait(1)
        towerNoobBtn.Text = "Tower Noob"
    end
end)

local towerProBtn = createButton("Tower Pro", 2, Color3.fromRGB(220, 190, 50))
towerProBtn.MouseButton1Click:Connect(function()
    if teleportTo(teleports["Tower Pro"]) then
        towerProBtn.Text = "✅ Tower Pro"
        task.wait(0.6)
        towerProBtn.Text = "Tower Pro"
    else
        towerProBtn.Text = "⚠ Нет координат"
        task.wait(1)
        towerProBtn.Text = "Tower Pro"
    end
end)

local theTowerBtn = createButton("The Tower (Soon)", 3, Color3.fromRGB(200, 60, 60))
theTowerBtn.MouseButton1Click:Connect(function()
    if teleports["The Tower"] then
        teleportTo(teleports["The Tower"])
    else
        theTowerBtn.Text = "Скоро..."
        task.wait(1)
        theTowerBtn.Text = "The Tower (Soon)"
    end
end)

-- ============================================
-- ПЕРЕТАСКИВАНИЕ
-- ============================================
local function makeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
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
local isMinimized = false
local isAnimating = false

local function animateFrame(frame, sizeGoal, posGoal, dur)
    local tween = TweenService:Create(
        frame,
        TweenInfo.new(dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = sizeGoal, Position = posGoal }
    )
    tween:Play()
    return tween
end

local function minimizeWindow()
    if isAnimating or isMinimized then return end
    isAnimating = true

    mainFrame:SetAttribute("SavedPos", mainFrame.Position)
    miniFrame.Position = mainFrame.Position

    local goalSize = UDim2.new(MINI_SCALE, 0, MINI_SCALE * MINI_ASPECT, 0)
    titleBar.Visible = false
    scrollFrame.Visible = false

    local tween = animateFrame(mainFrame, goalSize, miniFrame.Position, 0.3)
    tween.Completed:Wait()

    mainFrame.Visible = false
    miniFrame.Visible = true
    isMinimized = true
    isAnimating = false
end

local function restoreWindow()
    if isAnimating or not isMinimized then return end
    isAnimating = true

    miniFrame:SetAttribute("SavedPos", miniFrame.Position)

    local savedMainPos = mainFrame:GetAttribute("SavedPos")
    if not savedMainPos then
        savedMainPos = miniFrame.Position
    end

    mainFrame.Position = miniFrame.Position
    mainFrame.Size = UDim2.new(MINI_SCALE, 0, MINI_SCALE * MINI_ASPECT, 0)
    mainFrame.Visible = true
    titleBar.Visible = false
    scrollFrame.Visible = false

    miniFrame.Visible = false

    local goalSize = UDim2.new(MAIN_W_SCALE, 0, MAIN_H_SCALE, 0)
    local tween = animateFrame(mainFrame, goalSize, savedMainPos, 0.3)
    tween.Completed:Wait()

    titleBar.Visible = true
    scrollFrame.Visible = true
    isMinimized = false
    isAnimating = false
end

minimizeBtn.MouseButton1Click:Connect(minimizeWindow)

-- Клик по квадрату
local miniClickDetected = false
local miniTouchStart = nil

miniImage.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        miniClickDetected = true
        miniTouchStart = input.Position
    end
end)

miniImage.InputEnded:Connect(function(input)
    if not miniClickDetected then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        local moved = 0
        if miniTouchStart then
            local delta = input.Position - miniTouchStart
            moved = math.abs(delta.X) + math.abs(delta.Y)
        end
        if moved < 10 then
            restoreWindow()
        end
        miniClickDetected = false
        miniTouchStart = nil
    end
end)

-- ============================================
-- УДАЛЕНИЕ
-- ============================================
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("[Tower TP] Скрипт выгружен")
end)

print("[Tower TP] Скрипт v4 загружен!")
print("Обе башни: -52.0, 319.2, -0.0")
