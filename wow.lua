local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "FancyPopupGui"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Name = "PopupFrame"
frame.Size = UDim2.new(0.6, 0, 0.08, 0)
frame.Position = UDim2.new(0.2, 0, -0.1, 0) -- Start off-screen at top
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Gradient background
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
})
gradient.Rotation = 90
gradient.Parent = frame

-- Text Label with Glow
local textLabel = Instance.new("TextLabel")
textLabel.Name = "PopupText"
textLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
textLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "LuaWare Succesfully Attached."
textLabel.TextColor3 = Color3.fromRGB(255, 120, 200) -- Brighter pink
textLabel.Font = Enum.Font.GothamSemibold
textLabel.TextSize = 24
textLabel.TextWrapped = true
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.Parent = frame

-- Text Glow Effect
local glow = Instance.new("UIStroke")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 150))
})
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Color = Color3.fromRGB(255, 120, 200)
glow.Transparency = 0.7
glow.Thickness = 3
glow.Parent = textLabel

-- Shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = frame
frame.ZIndex = 2
shadow.ZIndex = 1

-- Animation to slide in
local slideIn = TweenService:Create(
    frame,
    TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    {Position = UDim2.new(0.5, 0, 0.15, 0)} -- Slide to 15% from top
)

-- Glow pulse animation
local pulseGlow = TweenService:Create(
    glow,
    TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {Transparency = 0.3, Thickness = 5}
)

-- Start animations
slideIn:Play()
pulseGlow:Play()

-- Wait 3 seconds then slide out and destroy
wait(3)

-- Fade out animation
local fadeOut = TweenService:Create(
    frame,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, -0.1, 0)}
)

-- Fade text and glow
TweenService:Create(
    textLabel,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {TextTransparency = 1}
):Play()

TweenService:Create(
    glow,
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
    {Transparency = 1}
):Play()

fadeOut:Play()
fadeOut.Completed:Connect(function()
    gui:Destroy()
end)
