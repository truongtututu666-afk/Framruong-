-- ⚡ Trường Anh Farm Rương - Auto Chest toàn map
-- GUI bật/tắt, kéo thả được
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local HRP = char:WaitForChild("HumanoidRootPart")

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
local Title = Instance.new("TextLabel", Frame)
local ToggleBtn = Instance.new("TextButton", Frame)

-- GUI style
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true
Frame.Visible = true

Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "⚡ Trường Anh Farm Rương"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.TextScaled = true

ToggleBtn.Size = UDim2.new(1, -20, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 50)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleBtn.Text = "▶ Bật Auto Farm"
ToggleBtn.TextScaled = true
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- AutoFarm logic
local farming = false
local function collectChest(chest)
    if chest and chest:IsDescendantOf(workspace) then
        -- ClickDetector
        local clickDetector = chest:FindFirstChildWhichIsA("ClickDetector")
        if clickDetector then
            fireclickdetector(clickDetector)
        end
        -- TouchPart
        local touchPart = chest:FindFirstChildWhichIsA("BasePart")
        if touchPart then
            firetouchinterest(HRP, touchPart, 0)
            task.wait()
            firetouchinterest(HRP, touchPart, 1)
        end
    end
end

-- Vòng lặp farm
task.spawn(function()
    while task.wait(1) do
        if farming then
            for _, obj in pairs(workspace:GetDescendants()) do
                if string.find(obj.Name:lower(), "chest") and obj:IsA("Model") then
                    collectChest(obj)
                end
            end
        end
    end
end)

-- Nút bật/tắt
ToggleBtn.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        ToggleBtn.Text = "⏹ Tắt Auto Farm"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        ToggleBtn.Text = "▶ Bật Auto Farm"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    end
end)
