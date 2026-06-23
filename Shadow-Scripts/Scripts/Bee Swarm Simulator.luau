local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Bee Swarm Simulator"..getgenv().event)
getgenv().initializing = true  -- added flag

local HttpService = game:GetService("HttpService")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Config structure
getgenv().config = {
    walkspeed = false,
    infjump = false,
    antiafk = false,
    infyield = false,
    shiftlock = false,
}

-- Load / Save config
function Load()
    if isfile("GrannyHub/BeeSwarmSim.json") then
        getgenv().config = HttpService:JSONDecode(readfile("GrannyHub/BeeSwarmSim.json"))
    end
end

function Save()
    writefile("GrannyHub/BeeSwarmSim.json", HttpService:JSONEncode(getgenv().config))
end

-- Tabs and Sections
local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")

local TeleportTab = gui:CreateTab("Teleport")
local TeleportSection = TeleportTab:NewSection("Teleport")

local LocalPlayerTab = gui:CreateTab("Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Player")

local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

AutofarmSection:NewLabel("---Autofarm---")

AutofarmSection:NewToggle("Autofarm Gui", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VerbalHubz/Verbal-Hub/refs/heads/main/Bee%20Swarm%20Sim.Lua", true))()
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
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
			wait(0.2)
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
			wait(0.2)
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

    game:GetService("UserInputService").JumpRequest:Connect(function()
        if getgenv().config.infjump then
            pcall(function()
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end)
        end
    end)
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
    game:service("Players").LocalPlayer.Idled:Connect(function()
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

local teleportLocations = {
    Hive = Vector3.new(-139, 4, 307),
    ["Ticket Shop"] = Vector3.new(-237, 18, 387),
    ["Mountain Top"] = Vector3.new(77, 176, -188),
    ["Pumpkin Field"] = Vector3.new(-169, 68, -170),
    ["Cactus Field"] = Vector3.new(-192, 68, -102),
    ["Pine Field"] = Vector3.new(-315, 68, -186),
    ["Pro Shop"] = Vector3.new(-419, 69, -16),
    ["Rose Field"] = Vector3.new(-326, 20, 124),
    ["Red HQ"] = Vector3.new(-319, 21, 210),
    ["Blue HQ"] = Vector3.new(285, 5, 98),
    ["Sunflower Field"] = Vector3.new(-210, 4, 199),
    ["Mushroom Field"] = Vector3.new(-99, 4, 125),
    ["Dandelion Field"] = Vector3.new(-52, 4, 213),
    ["Clover Field"] = Vector3.new(134, 34, 170),
    ["Blue Field"] = Vector3.new(191, 4, 94),
    ["Bamboo Field"] = Vector3.new(124, 20, -10),
    ["Spider Field"] = Vector3.new(-29, 20, 12),
    ["Strawberry Field"] = Vector3.new(-174, 20, -18),
}

TeleportSection:NewLabel("---Teleport---")

for name, pos in pairs(teleportLocations) do
    TeleportSection:NewButton(name, function()
        local ts = game:GetService("TweenService")
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        ts:Create(hrp, TweenInfo.new(0.1), {CFrame = CFrame.new(pos)}):Play()
    end)
end

Load()

getgenv().initializing = false

pcall(function()
    if getgenv().config.infjump == true then
    infjump:EnableToggle()
    end
    if getgenv().config.antiafk == true then
    antiafk:EnableToggle()
    end
    if getgenv().config.infyield == true then
    infyield:EnableToggle()
    end
    if getgenv().config.shiftlock == true then
    shiftlock:EnableToggle()
    end
    if getgenv().config.walkspeed == true then
    walkspeed:EnableToggle()
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