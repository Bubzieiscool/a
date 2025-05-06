local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PopupGui"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "PopupFrame"
frame.Size = UDim2.new(0.5, 0, 0.1, 0)
frame.Position = UDim2.new(0.25, 0, -0.1, 0) -- Start off-screen at the top
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = gui

local textLabel = Instance.new("TextLabel")
textLabel.Name = "PopupText"
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "LuaWare Injected Succesfully."
textLabel.TextColor3 = Color3.fromRGB(255, 105, 180) -- Pink color
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 20
textLabel.TextWrapped = true
textLabel.Parent = frame

-- Animation to slide in
local slideIn = game:GetService("TweenService"):Create(
    frame,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {Position = UDim2.new(0.25, 0, 0.1, 0)} -- Slide to 10% from top
)
slideIn:Play()

-- Wait 3 seconds then slide out and destroy
wait(3)

local slideOut = game:GetService("TweenService"):Create(
    frame,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {Position = UDim2.new(0.25, 0, -0.1, 0)} -- Slide back up off-screen
)
slideOut:Play()

slideOut.Completed:Connect(function()
    gui:Destroy()
end)
