--// Games
getgenv().games = {
public = {
["Bee Swarm Simulator.luau"] = 1537690962,
["Blood Moon Tycoon.luau"] = 961409234,
["Drinkhax.luau"] = 1747207098,
["Fast Lifting Simulator.luau"] = 88503041003371,
["Burping Simulator 2.luau"] = 96331383351255,
["Growing Simulator.luau"] = 1276175881, --// Phoenix Studios
["Innovation Inc Arctic Base.luau"] = 1033860623,
["Innovation Inc Spaceship.luau"] = 331811267,
["Lift Legends Simulator.luau"] = 5709572883,
["Lift Vehicles.luau"] = 5182200788,
["Lifting Simulator.luau"] = 3652625463,
["Lumber Simulator 2.luau"] = 1351649689,
["Ninja Legends.luau"] = 3956818381,
["No Limit Lifting Simulator.luau"] = 4898652375,
["Rabbit Simulator.luau"] = 1502601752,
["Robotic Simulator.luau"] = 1953438140,
["Titan Simulator.luau"] = 1122519450,
["Weight Champion.luau"] = 1013937126,
["Zombie Attack.luau"] = 1240123653,
},
CreatorIdPublicGames = {
["World Zero.luau"] = 4484634,
}
}

local supported = false

getgenv().address = "https://sonic998.github.io/Shadow-Scripts"
getgenv().event = ""

--// Main Loader
for scriptName, placeId in pairs(getgenv().games.public) do
if game.PlaceId == placeId then
supported = true
local scriptURL = string.format("%s/Scripts/%s", getgenv().address, scriptName)
loadstring(game:HttpGet(scriptURL))()
end
end

--// Unsupported Game
if supported == false then
local UnsupportedscriptURL = string.format("%s/Scripts/%s", getgenv().address, "Unsupported Game.luau")
loadstring(game:HttpGet(UnsupportedscriptURL))()
end
