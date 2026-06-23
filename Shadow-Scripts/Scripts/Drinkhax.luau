-- Load External UI Library
local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event .. "GrannyHub - Drinkhax" .. getgenv().event)

-- Config with all possible toggles
getgenv().config = {
	autodrink = false,
	autoequip = false,
	autoprestige = false,
	autocollectgems = false,
	walkspeed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	walkonwater = false,
	night = false,
	antikick = false,
	btools = false,
	Hideout = false,
	HackerPlace = false,
	shiftlock = false,
	BpCounter = false,
	BurpUI = false,
}

-- Load/Save Config
local function Load()
	if isfile("GrannyHub/Drinkhax.json") then
		local decoded = game:GetService("HttpService"):JSONDecode(readfile("GrannyHub/Drinkhax.json"))
		for k, v in pairs(decoded) do
			if getgenv().config[k] ~= nil then
				getgenv().config[k] = v
			end
		end
	end
end

local function Save()
	writefile("GrannyHub/Drinkhax.json", game:GetService("HttpService"):JSONEncode(getgenv().config))
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

local TeleportTab = gui:CreateTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Teleport")

local LocalPlayerTab = gui:CreateTab("Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Player")

local WorldChangesTab = gui:CreateTab("World")
local WorldChangesSection = WorldChangesTab:NewSection("World")

local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

-- Initializing flag
getgenv().initializing = true

AutofarmSection:NewLabel("---AutoFarm---")

-- Auto Drink toggle setup
local autodrink = AutofarmSection:NewToggle("Fast Drink", function(enabled)
	if getgenv().initializing then return end
	getgenv().config.autodrink = enabled
	Save()
	local event = game.ReplicatedStorage.RemoteEvents.DrinkEvent
	spawn(function()
		while getgenv().config.autodrink do wait()
			local event = game.ReplicatedStorage.RemoteEvents.DrinkEvent
			
			local drinks = {
				"Starter Drink", "Second Drink", "Third Drink", "Fourth Drink", "Fifth Drink",
				"Sixth Drink", "Seventh Drink", "Eighth Drink", "Ninth Drink",
				"Atomic Drink", "Omega Burp Juice", "Thunder Fizz", "Garlic Juice"
			}
		for i,v in ipairs(drinks) do
				event:FireServer(v)
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
			local Backpack = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
			local Character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
			local BurpPoints = game:GetService("Players").LocalPlayer.leaderstats:WaitForChild("Burp points")
			for _, item in pairs(Character:GetChildren()) do
				if item:IsA("Tool") then
					item.Parent = Backpack
				end
			end
			local drinks = {
				"Garlic Juice", "Thunder Fizz", "Omega Burp Juice", "Atomic Drink",
				"Ninth Drink", "Eighth Drink", "Seventh Drink", "Sixth Drink",
				"Fifth Drink", "Fourth Drink", "Third Drink", "Second Drink", "Starter Drink"
			}
					if not Backpack:FindFirstChild("Starter Drink") and not Character:FindFirstChild("Starter Drink") then
						Character:BreakJoints()
				end
			for _, drink in ipairs(drinks) do
				local tool = Backpack:FindFirstChild(drink)
				if tool then
					local req = tool:FindFirstChild("Requirement")
					if req and BurpPoints.Value >= req.Value then
						tool.Parent = Character
						break
					end
				end
			end
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
			game.ReplicatedStorage.RemoteEvents:WaitForChild("PrestigeEvent"):FireServer()
		end
	end)
end)

local autocollectgems = AutofarmSection:NewToggle("Auto Collect Gems", function(v)
	if getgenv().initializing then return end
	getgenv().config.autocollectgems = v
	Save()
	spawn(function()
		while getgenv().config.autocollectgems do
			wait(1)
			for _, gem in pairs(workspace.Diamonds:GetChildren()) do
			if gem then
				firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, gem, 1)
				wait()
				firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, gem, 0)
			end
			end
		end
	end)
end)

LocalPlayerSection:NewLabel("---Local player---")

local walkspeed = LocalPlayerSection:NewToggle("WalkSpeed", function(v)
	if getgenv().initializing then return end
	getgenv().config.walkspeed = v
	Save()
	local defaultSpeed = game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed
	task.spawn(function()
		--Compatiblity Check
		if not hookmetamethod and newcclosure then
			warn("---Unsupported Exploit---")
			warn("---Missing Function hookmetamethod or newcclosure---")
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.walkspeed == true then
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 1000
				else
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
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
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 1000
				else
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		end
	end)
end)

local infjump = LocalPlayerSection:NewToggle("Infinity Jump", function(v)
    if getgenv().initializing then return end
	getgenv().config.infjump = v
	Save()
	if v then
		if infjump then infjump:Disconnect() end
		infjump = game:GetService("UserInputService").JumpRequest:Connect(function()
			local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	else
		if infjump then
			infjump:Disconnect()
			infjump = nil
		end
	end
end)

local noclipConnection
local noclip = LocalPlayerSection:NewToggle("Noclip", function(v)
	getgenv().config.noclip = v
	if noclipConnection then noclipConnection:Disconnect() end
	if v then
		noclipConnection = game:GetService("RunService").Stepped:Connect(function()
			if game:GetService("Players").LocalPlayer.Character then
				for _, part in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
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
		local backpack = game:GetService("Players").LocalPlayer.Backpack

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
		for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Hammer" then v:Remove() end if v.Name == "Clone" then v:Remove() end if v.Name == "Grab" then v:Remove() end
		end
	end
end)

local BurpUI = LocalPlayerSection:NewToggle("Burp UI", function(v)
    if getgenv().initializing then return end
	getgenv().config.BurpUI = v
	Save()
	if getgenv().config.BurpUI == true then
		local BurpUIUrl = string.format("%s/Shit/%s", getgenv().address, "BurpUI.luau")
        loadstring(game:HttpGet(BurpUIUrl))()
	elseif getgenv().config.BurpUI == false then
		game.CoreGui.BurpUI:Destroy()
	end
end)

local BpCounter = LocalPlayerSection:NewToggle("Bp Counter", function(v)
if getgenv().initializing then return end
	getgenv().config.BpCounter = v
	Save()
	if v == true then
		if not game.CoreGui:FindFirstChild("GainUI") then
			local bpcounter = string.format("%s/Shit/%s", getgenv().address, "BpCounter.luau")
			loadstring(game:HttpGet(bpcounter))()
		end
	else
		game.CoreGui.GainUI:Destroy()
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

local ts = game:GetService("TweenService")

TeleportSection:NewLabel("---Teleport---")
TeleportSection:NewLabel("---Safe Places---")

	TeleportSection:NewButton("Hideout", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(242.99, 17280.223, -264.544))}):Play()
	end)
	
	TeleportSection:NewButton("Hacker Place", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(351, 98, -5098))}):Play()
	end)

TeleportSection:NewLabel("---Main---")

	TeleportSection:NewButton("Fav Spot", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(-73, 48, 90))}):Play()
	end)
	
	TeleportSection:NewButton("Safe Zone", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(-55, 48, -3))}):Play()
	end)
	
	TeleportSection:NewButton("Disco Island", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(65, 48, 621))}):Play()
	end)
	
	TeleportSection:NewButton("Second Island", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(-1088, 48, -13))}):Play()
	end)
	
	TeleportSection:NewButton("Top Hotel", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(-1064, 183, 197))}):Play()
	end)
	
	TeleportSection:NewButton("Island", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(-1085, 66, -765))}):Play()
	end)
	
	TeleportSection:NewButton("Sky Island", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(2159, 1456, -1001))}):Play()
	end)
	
	TeleportSection:NewButton("Cloud One", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(243, 559, 612))}):Play()
	end)
	
	TeleportSection:NewButton("Cloud Two", function()
		ts:Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = CFrame.new(Vector3.new(-1185, 566, -298))}):Play()
	end)

WorldChangesSection:NewLabel("---Safe Places---")

local Hideout = WorldChangesSection:NewToggle("Hideout", function(v)
	if getgenv().initializing then return end
	getgenv().config.Hideout = v
	Save()
	if getgenv().config.Hideout == true then
		local hideout = string.format("%s/Shit/%s", getgenv().address, "Hideout.luau")
		loadstring(game:HttpGet(hideout))()
	else
		workspace["Hideout"]:Destroy()
	end
end)

local HackerPlace = WorldChangesSection:NewToggle("Hacker Place", function(v)
	if getgenv().initializing then return end
	getgenv().config.HackerPlace = v
	Save()
	if getgenv().config.HackerPlace == true then
		local hackerplace = string.format("%s/Shit/%s", getgenv().address, "HackerPlace.luau")
		loadstring(game:HttpGet(hackerplace))()
	else
		workspace["HackerPlace"]:Destroy()
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
		local body = game:GetService("HttpService"):JSONDecode(req.Body)
		for _, v in ipairs(body.data) do
			if v.playing < v.maxPlayers and v.id ~= game.JobId then
				table.insert(servers, v.id)
			end
		end
		if #servers > 0 then
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game:GetService("Players").LocalPlayer)
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
	local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:Connect(function()
		if getgenv().config.antiafk == true then
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end
	end)
end)

local antikick = MiscSection:NewToggle("Anti Kick", function(v)
	if getgenv().initializing then return end
	getgenv().config.antikick = v
	Save()
	
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

WorldChangesSection:NewLabel("---Other Map Changes---")

local walkonwater = WorldChangesSection:NewToggle("Walk on Water", function(v)
    if getgenv().initializing then return end
	getgenv().config.walkonwater = v
	Save()
	for _, obj in pairs(workspace:GetChildren()) do
		if obj:IsA("Part") and obj.Color == Color3.fromRGB(9, 137, 207) then
			obj.CanCollide = v
		end
	end
end)

WorldChangesSection:NewLabel("---Envirement Changes---")

local night = WorldChangesSection:NewToggle("Night", function(v)
    if getgenv().initializing then return end
	getgenv().config.night = v
	Save()
	game.Lighting.TimeOfDay = v and "00:00:00" or "12:00:00"
end)

for _, obj in pairs(workspace.Clouds:GetChildren()) do obj.CanCollide = true end
for i,v in pairs(game:GetService("Workspace").BorderWalls:GetChildren()) do if v.CFrame == CFrame.new(115.923157, 170.17775, -281.131958, 0, 0, -1, 0, 1, 0, 1, 0, 0) then v.CanCollide = false end end
game:GetService("GuiService").ErrorMessageChanged:Connect(function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)

Load()
getgenv().initializing = false
pcall(function()
TryEnable(autodrink, "autodrink")
TryEnable(autoequip, "autoequip")
TryEnable(autoprestige, "autoprestige")
TryEnable(autocollectgems, "autocollectgems")
TryEnable(walkspeed, "walkspeed")
TryEnable(infjump, "infjump")
TryEnable(antiafk, "antiafk")
TryEnable(infyield, "infyield")
TryEnable(walkonwater, "walkonwater")
TryEnable(night, "night")
TryEnable(antikick, "antikick")
TryEnable(btools, "btools")
TryEnable(Hideout, "Hideout")
TryEnable(HackerPlace, "HackerPlace")
TryEnable(shiftlock, "shiftlock")
TryEnable(BpCounter, "BpCounter")
TryEnable(BurpUI, "BurpUI")
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