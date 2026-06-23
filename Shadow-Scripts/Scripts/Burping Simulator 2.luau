local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Burping Simulator 2"..getgenv().event)

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
	autodrink = false,
	fastdrink = false,
	autoequip = false,
	autoprestige = false,
	walkspeed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	night = false,
	btools = false,
	shiftlock = false,
	autocollectgems = false,
}

-- Load/Save Config
local function Load()
	if isfile("GrannyHub/Drinkhax2.json") then
		local decoded = HttpService:JSONDecode(readfile("GrannyHub/Drinkhax2.json"))
		for k, v in pairs(decoded) do
			if getgenv().config[k] ~= nil then
				getgenv().config[k] = v
			end
		end
	end
end

local function Save()
	writefile("GrannyHub/Drinkhax2.json", HttpService:JSONEncode(getgenv().config))
end

-- Helper to auto-enable toggles
local function TryEnable(toggle, name)
	if getgenv().config[name] then
		toggle:EnableToggle()
	end
end

-- UI Setup
local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")

local LocalPlayerTab = gui:CreateTab("Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Player")

local TeleportTab = gui:CreateTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Teleport")

local WorldChangesTab = gui:CreateTab("World")
local WorldChangesSection = WorldChangesTab:NewSection("World")

local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

-- Initializing flag
getgenv().initializing = true

TeleportSection:NewLabel("---Teleport---")

TeleportSection:NewButton("Fav Spot", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2214, 453, 83)
end)

TeleportSection:NewButton("Second Island", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1165, 452, -30)
end)

TeleportSection:NewButton("Candy Island", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1470, 452, -3)
end)

TeleportSection:NewButton("Moon Base", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2108, 7968, -219)
end)

AutofarmSection:NewLabel("---AutoFarm---")

-- Auto Drink toggle setup
local fastdrink = AutofarmSection:NewToggle("Fast Drink", function(enabled)
	if getgenv().initializing then return end
	getgenv().config.fastdrink = enabled
	Save()
	local event = game.ReplicatedStorage.Events.DrinkEvent
	spawn(function()
		while getgenv().config.fastdrink do wait()
			event:FireServer()
		end
	end)
end)

local autodrink = AutofarmSection:NewToggle("Auto Drink", function(enabled)
	if getgenv().initializing then return end
	getgenv().config.autodrink = enabled
	Save()
	spawn(function()
		while getgenv().config.autodrink do wait()
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
          if v:IsA("Tool") then
           v:Activate()
            end
           end
            end
	end)
end)

local autocollectgems = AutofarmSection:NewToggle("Auto Collect Gems", function(enabled)
	if getgenv().initializing then return end
	getgenv().config.autocollectgems = enabled
	Save()
	local event = game.ReplicatedStorage.Events.DrinkEvent
	spawn(function()
		while getgenv().config.autocollectgems do wait(1)
for i,v in pairs(game.Workspace.Gems:GetChildren()) do
if v then
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
wait()
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
end
end
		end
	end)
end)

local autoequip = AutofarmSection:NewToggle("Auto Equip Drink", function(v)
if getgenv().initializing then return end
	getgenv().config.autoequip = v
	Save()
	spawn(function()
		while getgenv().config.autoequip do
			wait(1)
			local Players = game:GetService("Players")
			local LocalPlayer = Players.LocalPlayer
			local Backpack = LocalPlayer:WaitForChild("Backpack")
			local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local Humanoid = Character:WaitForChild("Humanoid")
			local leaderstats = LocalPlayer:WaitForChild("leaderstats")
			local BurpPoints = leaderstats:WaitForChild("BurpPoints")
			
			local drinks = {
				["Fizzplosion"] = 0,
				["Guzzle Grape"] = 100,
				["Bubble Blast"] = 250,
				["Mega Slurp"] = 550,
				["Frostbite Fizz"] = 1000,
				["HotChoco"] = 3000,
				["Lightning Lemonade"] = 5000,
				["Cosmo Cola"] = 10000,
				["Pixel Punch"] = 20000,
				["Pumpkin Spice"] = 28000,
				["Tornado Tea"] = 40000,
				["Witches Brew"] = 70000,
				["Glitch Gulp"] = 100000,
				["Inferno Drink"] = 250000,
				["Wizard Drink"] = 500000,
				["Lava Drink"] = 1000000,
				["Sparkletime Drink"] = 5000000
			}
			
			local busy = false
			local currentDrink = nil
			
			local function getBestDrink(points)
				local bestName
				local bestReq = -1
				for name, req in pairs(drinks) do
					if req <= points then
						local tool = Backpack:FindFirstChild(name) or Character:FindFirstChild(name)
						if tool and tool:IsA("Tool") and req > bestReq then
							bestReq = req
							bestName = name
						end
					end
				end
				return bestName
			end
			
			local function getEquippedDrink()
				for _, tool in ipairs(Character:GetChildren()) do
					if tool:IsA("Tool") then
						return tool.Name
					end
				end
				return nil
			end
			
			local function equipBestDrink()
				if busy then return end
				busy = true
				
				local points = BurpPoints.Value
				local bestName = getBestDrink(points)
				if not bestName then busy = false return end
				
				local equipped = getEquippedDrink()
				if equipped ~= bestName then
					local tool = Backpack:FindFirstChild(bestName)
					if tool then
						Humanoid:UnequipTools()
						task.wait(0.2)
						if tool.Parent == Backpack then
							Humanoid:EquipTool(tool)
						end
						currentDrink = bestName
					end
				end
				
				busy = false
			end
			
			task.defer(equipBestDrink)
			
			BurpPoints:GetPropertyChangedSignal("Value"):Connect(function()
				task.defer(equipBestDrink)
			end)
			
			LocalPlayer.CharacterAdded:Connect(function(newChar)
				Character = newChar
				Humanoid = newChar:WaitForChild("Humanoid")
				task.wait(1)
				equipBestDrink()
			end)
		end
	end)
end)

local autoprestige = AutofarmSection:NewToggle("Auto Prestige", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoprestige = v
	Save()
	spawn(function()
		while getgenv().config.autoprestige do
			wait(1)
			game.ReplicatedStorage.Events:WaitForChild("PrestigeEvent"):FireServer()
		end
	end)
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
				if getgenv().config.walkspeed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 500
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

local btools = LocalPlayerSection:NewToggle("BTools", function(v)
    if getgenv().initializing then return end
	getgenv().config.btools = v
	Save()
	if getgenv().config.btools == true then
		local backpack = LocalPlayer.Backpack

		local function createTool(name, binType)
			local tool = Instance.new("HopperBin")
			tool.Name = name
			tool.BinType = binType
			tool.Parent = backpack
		end

		createTool("Hammer", 4)
		createTool("Clone", 3)
		createTool("Grab", 2)
	elseif getgenv().config.btools == false then
		for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Hammer" then v:Remove() end if v.Name == "Clone" then v:Remove() end if v.Name == "Grab" then v:Remove() end
		end
	end
end)

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

WorldChangesSection:NewLabel("---Envirement Changes---")

local night = WorldChangesSection:NewToggle("Night", function(v)
    if getgenv().initializing then return end
	getgenv().config.night = v
	Save()
	game.Lighting.TimeOfDay = v and "00:00:00" or "12:00:00"
end)

for i,v in pairs(workspace:GetChildren()) do if v:IsA("Part") then v.CanCollide = true end end

Load()
getgenv().initializing = false
pcall(function()
TryEnable(autodrink, "autodrink")
TryEnable(fastdrink, "fastdrink")
TryEnable(autoequip, "autoequip")
TryEnable(autoprestige, "autoprestige")
TryEnable(walkspeed, "walkspeed")
TryEnable(infjump, "infjump")
TryEnable(antiafk, "antiafk")
TryEnable(infyield, "infyield")
TryEnable(reviz, "reviz")
TryEnable(night, "night")
TryEnable(btools, "btools")
TryEnable(shiftlock, "shiftlock")
TryEnable(autocollectgems, "autocollectgems")
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