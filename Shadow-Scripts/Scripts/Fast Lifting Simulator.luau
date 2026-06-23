local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Fast Lifting Simulator"..getgenv().event)
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Initialization
getgenv().initializing = true

getgenv().config = {
	autolift = false,
	autoequipweight = false,
	autosell = false,
	speed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	shiftlock = false,
}

-- Load / Save config
local function Load()
	if isfile("GrannyHub/FastLiftingSimulator.json") then
		getgenv().config = HttpService:JSONDecode(readfile("GrannyHub/FastLiftingSimulator.json"))
	end
end

local function Save()
	writefile("GrannyHub/FastLiftingSimulator.json", HttpService:JSONEncode(getgenv().config))
end

-- GUI Tabs
local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")
local PlayerTab = gui:CreateTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")
local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

AutofarmSection:NewLabel("---Autofarm---")

local autolift = AutofarmSection:NewToggle("Auto Lift", function(v)
	if getgenv().initializing then return end
	getgenv().config.autolift = v
	Save()
	task.spawn(function()
		while getgenv().config.autolift do
			wait(0.2)
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") then
			if v:FindFirstChild("Picture") then
			v:Activate()
			end
			end
			end
		end
	end)
end)

local autoequipweight = AutofarmSection:NewToggle("Auto Equip Weight", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoequipweight = v
	Save()
	task.spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if getgenv().config.autoequipweight == true then
				wait(0.2)
				for i, connection in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ToolsMenu.Weight.WeightInner.ImageButton.MouseButton1Click)) do
				for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			    if v:IsA("Tool") then
		  	  if v:FindFirstChild("Picture") then
		
		        else
		        connection:Fire()
		        end
		        end
			end
			end
			end
		end)
	end)
end)

local autosell = AutofarmSection:NewToggle("Auto Sell", function(v)
	if getgenv().initializing then return end
	getgenv().config.autosell = v
	Save()
	task.spawn(function()
		while getgenv().config.autosell do
			wait(0.2)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.EffectStorage.Mark01.Detector, 1)
			wait()
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.EffectStorage.Mark01.Detector, 0)
		end
	end)
end)

PlayerSection:NewLabel("---Local player---")

local walkspeed = PlayerSection:NewToggle("WalkSpeed", function(v)
	if getgenv().initializing then return end
	getgenv().config.speed = v
	Save()
	local defaultSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
	task.spawn(function()
		--Compatiblity Check
		if not hookmetamethod and newcclosure then
			warn("---Unsupported Exploit---")
			warn("---Missing Function hookmetamethod or newcclosure---")
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.speed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 500
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
				if getgenv().config.speed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 500
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		end
	end)
end)

local infjump = PlayerSection:NewToggle("Infinity Jump", function(v)
	if getgenv().initializing then return end
	getgenv().config.infjump = v
	Save()
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if getgenv().config.infjump then
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
			end
		end)
end)

local shiftlock = PlayerSection:NewToggle("Shiftlock", function(v)
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

local noclipConnection
PlayerSection:NewToggle("Noclip", function(v)
	getgenv().noclip = v
	if noclipConnection then noclipConnection:Disconnect() end
	if v then
		noclipConnection = game:GetService("RunService").Stepped:Connect(function()
			if LocalPlayer.Character then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						if getgenv().noclip == true then
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

MiscSection:NewLabel("---Misc---")

MiscSection:NewButton("Rejoin", function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
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
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end)
end)

MiscSection:NewLabel("---Admin Scripts---")

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
	if getgenv().config.autolift then
		autolift:EnableToggle()
	end
	if getgenv().config.autoequipweight then
		autoequipweight:EnableToggle()
	end
	if getgenv().config.autosell then
		autosell:EnableToggle()
	end
	if getgenv().config.infjump then
		infjump:EnableToggle()
	end
	if getgenv().config.antiafk then
		antiafk:EnableToggle()
	end
	if getgenv().config.infyield then
		infyield:EnableToggle()
	end
	if getgenv().config.speed then
		walkspeed:EnableToggle()
	end
	if getgenv().config.shiftlock then
	     shiftlock:EnableToggle()
	end
end)

local MarketplaceService = game:GetService("MarketplaceService")
local placeId = game.PlaceId
local GameName = MarketplaceService:GetProductInfo(placeId).Name

print("---Welcome to Shadow Scripts---")
print("--Detecting Game...---")
print("---"..GameName.." Detected---")
print("---Loading Script...---")
print("---Loading Config---")
print("---Script has successfully Loaded---")