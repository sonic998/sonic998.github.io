--// Games
getgenv().games = {
public = {
["Drinkhax.luau"] = 1747207098,
["Drinkhax2.luau"] = 96331383351255,
["Bee Swarm Simulator.luau"] = 1537690962,
["Robotic Simulator.luau"] = 1953438140,
["Lift Legends Simulator.luau"] = 5709572883,
["Gorilla Simulator 2.luau"] = 1378712700,
["Prison Pump.luau"] = 80279663815725,
["Titan Simulator.luau"] = 1122519450,
["Weight Champion.luau"] = 1013937126,
["Growing Simulator.luau"] = 1276175881, --// Phoenix Studios
["Lifting Simulator.luau"] = 3652625463,
["Speed Prison Escape.luau"] = 73934517857372,
["Boxing Simulator OG.luau"] = 125171758402912,
["Basic Lifting Simulator.luau"] = 82699712398447,
["Rabbit Simulator.luau"] = 1502601752,
["Caveman Simulator.luau"] = 1712205464,
["Lumber Simulator 2.luau"] = 1351649689,
["Speed Simulator 3.luau"] = 2264057525,
["Galaxy Lifting Simulator.luau"] = 1181746351,
["Zombie Attack.luau"] = 1240123653,
["Blood Moon Tycoon.luau"] = 961409234,
["Innovation Inc Arctic Base.luau"] = 1033860623,
["Innovation Inc Spaceship.luau"] = 331811267,
["Mad City-Chapter1.luau"] = 91282350711571,
["Mad City-Chapter2.luau"] = 1224212277,
["Jailbreak.luau"] = 606849621,
["How Much Size Can You Get.luau"] = 91190375321255,
["Ninja Legends.luau"] = 3956818381,
["Lift Vehicles.luau"] = 5182200788,
},
CreatorIdPublicGames = {
["Punch Wall.luau"] = 255353711,
["World Zero.luau"] = 4484634,
}
}

local LoadGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local title = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local Stage1 = Instance.new("Frame")
local Stage2 = Instance.new("Frame")
local Stage3 = Instance.new("Frame")
local Stage4 = Instance.new("Frame")
local Stick = Instance.new("Frame")
local SideFrame = Instance.new("Frame")
local text = Instance.new("TextLabel")

LoadGui.Name = "LoadGui"
LoadGui.Parent = game:GetService("CoreGui")

Main.Name = "Main"
Main.Parent = LoadGui
Main.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, 0, 0, 0)
Main.Size = UDim2.new(0, 393,0, 342)

Instance.new("UICorner", Main)

title.Name = "title"
title.Parent = Main
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.BorderColor3 = Color3.fromRGB(0, 0, 0)
title.BorderSizePixel = 0
title.Position = UDim2.new(0.24427481, 0, 0, 0)
title.Size = UDim2.new(0, 200, 0, 28)
title.Font = Enum.Font.SourceSansBold
title.Text = "Shadow-Scripts"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 14.000
title.TextWrapped = true

Frame.Parent = Main
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 180)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.394402027, 0, 0.0853658542, 0)
Frame.Size = UDim2.new(0, 62, 0, 271)

Instance.new("UICorner", Frame).CornerRadius = UDim.new(1,0)

Stage1.Name = "Stage1"
Stage1.Parent = Frame
Stage1.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
Stage1.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stage1.BorderSizePixel = 0
Stage1.Size = UDim2.new(0, 62, 0, 62)

Instance.new("UICorner", Stage1).CornerRadius = UDim.new(1,0)

Stage2.Name = "Stage2"
Stage2.Parent = Frame
Stage2.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
Stage2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stage2.BorderSizePixel = 0
Stage2.Position = UDim2.new(0, 0, 0.253125846, 0)
Stage2.Size = UDim2.new(0, 62, 0, 62)

Instance.new("UICorner", Stage2).CornerRadius = UDim.new(1,0)

Stage3.Name = "Stage3"
Stage3.Parent = Frame
Stage3.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
Stage3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stage3.BorderSizePixel = 0
Stage3.Position = UDim2.new(0, 0, 0.507349193, 0)
Stage3.Size = UDim2.new(0, 62, 0, 62)

Instance.new("UICorner", Stage3).CornerRadius = UDim.new(1,0)

Stage4.Name = "Stage4"
Stage4.Parent = Frame
Stage4.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
Stage4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stage4.BorderSizePixel = 0
Stage4.Position = UDim2.new(0, 0, 0.768952429, 0)
Stage4.Size = UDim2.new(0, 62, 0, 62)

Instance.new("UICorner", Stage4).CornerRadius = UDim.new(1,0)

Stick.Name = "Stick"
Stick.Parent = Frame
Stick.BackgroundColor3 = Color3.fromRGB(0, 0, 180)
Stick.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stick.BorderSizePixel = 0
Stick.Position = UDim2.new(1, 0, 0.0996309966, 0)
Stick.Size = UDim2.new(0, 28, 0, 25)

SideFrame.Name = "SideFrame"
SideFrame.Parent = Stick
SideFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 180)
SideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideFrame.BorderSizePixel = 0
SideFrame.Position = UDim2.new(1, 0, -0.720000029, 0)
SideFrame.Size = UDim2.new(0, 95, 0, 91)

Instance.new("UICorner", SideFrame)

text.Name = "text"
text.Parent = SideFrame
text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
text.BackgroundTransparency = 1.000
text.BorderColor3 = Color3.fromRGB(0, 0, 0)
text.BorderSizePixel = 0
text.Size = UDim2.new(0, 95, 0, 91)
text.Font = Enum.Font.SourceSansBold
text.Text = "Checking Game"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true
text.TextSize = 14.000
text.TextWrapped = true
wait(1)
game:GetService("TweenService"):Create(Stick, TweenInfo.new(0.5), {Position = UDim2.new(1, 0,0.321, 0)}):Play()
text.Text = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.." Detected!"
wait(1)
game:GetService("TweenService"):Create(Stick, TweenInfo.new(0.5), {Position = UDim2.new(1, 0,0.572, 0)}):Play()
text.Text = "Loading Script"
wait(1)
game:GetService("TweenService"):Create(Stick, TweenInfo.new(0.5), {Position = UDim2.new(1, 0,0.834, 0)}):Play()
text.Text = "Script Loaded!"
wait(1)
LoadGui:Destroy()

local supported = false

getgenv().address = "https://sonic998.github.io/Shadow-Scripts"
getgenv().event = ""
--christmas
--getgenv().event = "🎄"
--easter
--getgenv().event = "🥚"

--// Main Loader
for scriptName, placeId in pairs(getgenv().games.public) do
if game.PlaceId == placeId then
supported = true
local scriptURL = string.format("%s/Scripts/%s", getgenv().address, scriptName)
loadstring(game:HttpGet(scriptURL))()
end
end

--// Punch Wall
for scriptName, creatorId in pairs(getgenv().games.CreatorIdPublicGames) do
if game.CreatorId == creatorId then
supported = true
local scriptURL = string.format("%s/Scripts/%s", getgenv().address, scriptName)
loadstring(game:HttpGet(scriptURL))()
end
end

--// Unsupported Game
if not supported then
warn("This game is not supported")
local UnsupportedscriptURL = string.format("%s/Scripts/%s", getgenv().address, "Unsupported Game.luau")
loadstring(game:HttpGet(UnsupportedscriptURL))()
end