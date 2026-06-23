local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Innovation Inc Spaceship"..getgenv().event)

-- Services
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RunS = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Config with all possible toggles
getgenv().config = {
	walkspeed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	shiftlock = false,
}

-- Load/Save Config
local function Load()
	if isfile("GrannyHub/InnovationIncSpaceship.json") then
		local decoded = HttpService:JSONDecode(readfile("GrannyHub/InnovationIncSpaceship.json"))
		for k, v in pairs(decoded) do
			if getgenv().config[k] ~= nil then
				getgenv().config[k] = v
			end
		end
	end
end

local function Save()
	writefile("GrannyHub/InnovationIncSpaceship.json", HttpService:JSONEncode(getgenv().config))
end

-- Helper to auto-enable toggles
local function TryEnable(toggle, name)
	if getgenv().config[name] then
		toggle:EnableToggle()
	end
end

-- UI Setup

local LocalPlayerTab = gui:CreateTab("Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Player")

local ControlsTab = gui:CreateTab("Controls")
local ControlsSection = ControlsTab:NewSection("Controls")

local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

-- Initializing flag
getgenv().initializing = true

ControlsSection:NewLabel("---Suit Equipment---")

ControlsSection:NewButton("Equip Suit", function()
local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-221, 107, -946)
wait(0.5)
fireproximityprompt(workspace.HazmatGivers.Model1.Forcefield.ProximityPrompt)
wait(0.5)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)

ControlsSection:NewButton("Unequip Suit", function()
local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-194, 108, -1163)
wait(3)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)

LocalPlayerSection:NewLabel("---Local player---")

local walkspeed = LocalPlayerSection:NewToggle("WalkSpeed", function(v)
	if getgenv().initializing then return end
	getgenv().config.walkspeed = v
	Save()
	local defaultSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
	task.spawn(function()
		--Compatiblity Check
		if not hookmetamethod and newcclosure then
			warn("---Unsupported Exploit---")
			warn("---Missing Function hookmetamethod or newcclosure---")
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.walkspeed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 100
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		elseif hookmetamethod and newcclosure then
			--Bypass
			local OldIndex; OldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, Idx)
				if tostring(Self) == "Humanoid" and Idx == "WalkSpeed" then
					return
				end
				return OldIndex(Self, Idx)
			end))
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.walkspeed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 100
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		end
	end)
end)

local infjump = LocalPlayerSection:NewToggle("Infinity Jump", function(v)
    if getgenv().initializing then return end
	getgenv().config.infjump = v
	Save()
	UIS.JumpRequest:Connect(function()
		if getgenv().config.infjump == true then
			local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end)

local noclipConnection
local noclip = LocalPlayerSection:NewToggle("Noclip", function(v)
	getgenv().config.noclip = v
	if noclipConnection then noclipConnection:Disconnect() end
	if v then
		noclipConnection = game:GetService("RunService").Stepped:Connect(function()
			if LocalPlayer.Character then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						if getgenv().config.noclip == true then
							part.CanCollide = false
						else
							part.CanCollide = true
						end
					end
				end
			end
		end)
	end
end)

LocalPlayerSection:NewLabel("---Tools---")


local shiftlock = LocalPlayerSection:NewToggle("Shiftlock", function(v)
    if getgenv().initializing then return end
	getgenv().config.shiftlock = v
	Save()
	if getgenv().config.shiftlock == true then
		local ShiftLockUrl = string.format("%s/Shit/%s", getgenv().address, "ShiftLock.luau")
		loadstring(game:HttpGet(ShiftLockUrl))()
	elseif getgenv().config.shiftlock == false then
		game.CoreGui.Shiftlock:Destroy()
	end
end)

MiscSection:NewLabel("---Misc---")

MiscSection:NewButton("Rejoin", function()
	TeleportService:Teleport(game.PlaceId)
end)

MiscSection:NewButton("Server Hop", function()
	if request then
		local servers = {}
		local req = request({
			Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
		})
		local body = HttpService:JSONDecode(req.Body)
		for _, v in ipairs(body.data) do
			if v.playing < v.maxPlayers and v.id ~= game.JobId then
				table.insert(servers, v.id)
			end
		end
		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
		else
			print("Serverhop: Couldn't find a server.")
		end
	else
		print("Incompatible Exploit: Missing 'request'")
	end
end)

MiscSection:NewLabel("---Bypasses---")

local antiafk = MiscSection:NewToggle("Anti Afk", function(v)
	if getgenv().initializing then return end
	getgenv().config.antiafk = v
	Save()
	local vu = game:service("VirtualUser")
	LocalPlayer.Idled:Connect(function()
		if getgenv().config.antiafk == true then
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end
	end)
end)

MiscSection:NewLabel("--Admin Scripts--")

local infyield = MiscSection:NewToggle("Inf Yield", function(v)
	if getgenv().initializing then return end
	getgenv().config.infyield = v
	Save()
	if getgenv().config.infyield == true then
		local infyield = string.format("%s/Shit/%s", getgenv().address, "InfYield.luau")
		loadstring(game:HttpGet(infyield))()
	elseif getgenv().config.infyield == false then
		game.CoreGui.InfYield:Destroy()
	end
end)

Load()
getgenv().initializing = false
pcall(function()
TryEnable(walkspeed, "walkspeed")
TryEnable(infjump, "infjump")
TryEnable(antiafk, "antiafk")
TryEnable(infyield, "infyield")
TryEnable(shiftlock, "shiftlock")
end)

local MarketplaceService = game:GetService("MarketplaceService")
local placeId = game.PlaceId
local GameName = MarketplaceService:GetProductInfo(placeId).Name

print("---Welcome to Shadow Scripts---")
print("---Detecting Game---")
print("---"..GameName.." Detected---")
print("---Loading Script---")
print("---Loading Config---")
print("---Script has successfully Loaded---")
print("---Granny going fire---")