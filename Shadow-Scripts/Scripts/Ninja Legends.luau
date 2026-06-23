local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Ninja Legends"..getgenv().event)
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Initialization
getgenv().initializing = true

getgenv().config = {
    autoequipsword = false,
	autoswingsword = false,
	buyallbelts = false,
	buyallswords = false,
	buyallranks = false,
	buyallshurikens = false,
	buyallskills = false,
	buyallranks = false,
	autosell = false,
	infdoublejump = false,
	speed = false,
	antiafk = false,
	infyield = false,
	shiftlock = false,
	infjump = false,
}

-- Load / Save config
local function Load()
	if isfile("GrannyHub/NinjaLegends.json") then
		getgenv().config = HttpService:JSONDecode(readfile("GrannyHub/NinjaLegends.json"))
	end
end

local function Save()
	writefile("GrannyHub/NinjaLegends.json", HttpService:JSONEncode(getgenv().config))
end

-- GUI Tabs
local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")
local PlayerTab = gui:CreateTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")
local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

AutofarmSection:NewLabel("---Autofarm---")

local autoequipsword = AutofarmSection:NewToggle("Auto Equip Sword", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoequipsword = v
	Save()
	task.spawn(function()
		while getgenv().config.autoequipsword do
			wait(0.1)
			for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
if v:IsA("Tool") and v:FindFirstChild("attackShurikenScript") then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
end
if v:IsA("Tool") and v:FindFirstChild("attackKatanaScript") then 
game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)                            
end
end
	end
	end)
end)

local autoswingsword = AutofarmSection:NewToggle("Auto Swing Sword", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoswingsword = v
	Save()
	task.spawn(function()
		while getgenv().config.autoswingsword do
			wait(0.1)
			for _, tool in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
				if tool:IsA("Tool") then
					tool:Activate()
				end
			end
		end
	end)
end)

local autosell = AutofarmSection:NewToggle("Auto Sell", function(v)
	if getgenv().initializing then return end
	getgenv().config.autosell = v
	Save()
	task.spawn(function()
		while getgenv().config.autosell do
			wait(0.1)
			firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, workspace.sellAreaCircles.sellAreaCircle.circleInner, 1)
			wait()
			firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, workspace.sellAreaCircles.sellAreaCircle.circleInner, 0)
		end
	end)
end)

local buyallswords = AutofarmSection:NewToggle("Buy All Swords", function(v)
	if getgenv().initializing then return end
	getgenv().config.buyallswords = v
	Save()
	task.spawn(function()
		while getgenv().config.buyallswords do
			wait(0.5)
            local oh1 = "buyAllSwords"
local oh2 = {"Ground", "Astral Island", "Space Island","Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
for i = 1,#oh2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
end
		end
	end)
end)

local buyallbelts = AutofarmSection:NewToggle("Buy All Belts", function(v)
	if getgenv().initializing then return end
	getgenv().config.buyallbelts = v
	Save()
	task.spawn(function()
		while getgenv().config.buyallbelts do
			wait(0.5)
            local oh1 = "buyAllBelts"
local oh2 = {"Ground", "Astral Island", "Space Island","Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
for i = 1,#oh2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
end
		end
	end)
end)

local buyallranks = AutofarmSection:NewToggle("Buy All Ranks", function(v)
	if getgenv().initializing then return end
	getgenv().config.buyallranks = v
	Save()
	task.spawn(function()
		while getgenv().config.buyallranks do
			wait(0.5)
            local oh1 = "buyRank"
            local oh2 = game:GetService("ReplicatedStorage").Ranks.Ground:GetChildren()
            for i = 1,#oh2 do
            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i].Name)
            end
		end
	end)
end)

local buyallskills = AutofarmSection:NewToggle("Buy All Skills", function(v)
	if getgenv().initializing then return end
	getgenv().config.buyallskills = v
	Save()
	task.spawn(function()
		while getgenv().config.buyallskills do
			wait(0.5)
            local oh1 = "buyAllSkills"
local oh2 = {"Ground", "Astral Island", "Space Island","Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
for i = 1,#oh2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
end
		end
	end)
end)

local buyallshurikens = AutofarmSection:NewToggle("Buy All Shurikens", function(v)
	if getgenv().initializing then return end
	getgenv().config.buyallshurikens = v
	Save()
	task.spawn(function()
		while getgenv().config.buyallshurikens do
			wait(0.5)
            local oh1 = "buyAllShurikens"
local oh2 = {"Ground", "Astral Island", "Space Island","Tundra Island", "Eternal Island", "Sandstorm", "Thunderstorm", "Ancient Inferno Island", "Midnight Shadow Island", "Mythical Souls Island", "Winter Wonder Island"}
for i = 1,#oh2 do
game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
end
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
				if getgenv().config.speed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 100
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
	UIS.JumpRequest:Connect(function()
		if getgenv().config.infjump == true then
			local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end)

PlayerSection:NewButton("Unlock All Islands", function()
for i,v in next, game.workspace.islandUnlockParts:GetChildren() do 
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
wait()
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
wait(.5)
end
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
	if v then
		local vu = game:service("VirtualUser")
		LocalPlayer.Idled:Connect(function()
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end)
	end
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
if getgenv().config.autoequipsword then
		autoequipsword:EnableToggle()
	end
	if getgenv().config.autoswingsword then
		autoswingsword:EnableToggle()
	end
	if getgenv().config.autosell then
		autosell:EnableToggle()
	end
	if getgenv().config.buyallswords then
		buyallswords:EnableToggle()
	end
	if getgenv().config.buyallbelts then
		buyallbelts:EnableToggle()
	end
	if getgenv().config.buyallshurikens then
		buyallshurikens:EnableToggle()
	end
	if getgenv().config.buyallskills then
		buyallskills:EnableToggle()
	end
	if getgenv().config.buyallranks then
		buyallranks:EnableToggle()
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
	if getgenv().config.infjump then
	    infjump:EnableToggle()
	end
end)

local MarketplaceService = game:GetService("MarketplaceService")
local placeId = game.PlaceId
local GameName = MarketplaceService:GetProductInfo(placeId).Name

print("---Welcome to Shadow Scripts---")
print("---Detecting Game...---")
print("---"..GameName.." Detected---")
print("---Loading Script...---")
print("---Loading Config---")
print("---Script has successfully Loaded---")