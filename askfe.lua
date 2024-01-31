getgenv().ScriptSettings = {
    NoUi = true,
    CustomSettings = {
        FarmCoin = false -- Auto Farm
    }
}


getfenv().LPH_NO_VIRTUALIZE = function(f) return f end;
getfenv().LPH_JIT = function(f) return f end;


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Braven1111/test/main/iyotpr"))()
local Settings = {}

local plr = game.Players.LocalPlayer
local SaveFileName = getgenv().SaveFileName or plr.Name.."_PET99.json"

function SaveSettings()
    local HttpService = game:GetService("HttpService")
    if not isfolder("CTE HUB") then
        makefolder("CTE HUB")
    end
    writefile("CTE HUB/" .. SaveFileName, HttpService:JSONEncode(Settings))
end

function ReadSetting() 
    local s,e = pcall(function() 
        local HttpService = game:GetService("HttpService")
        if not isfolder("CTE HUB") then
            makefolder("CTE HUB")
        end
        return HttpService:JSONDecode(readfile("CTE HUB/" .. SaveFileName))
    end)
    if s then return e 
    else
        SaveSettings()
        return ReadSetting()
    end
end
Settings = ReadSetting()

local StoppedTp = false
getgenv().CauCa = true

if not getgenv().Tasks then 
    getgenv().Tasks = {}
    Tasks.__index = Tasks
    
    function Tasks.new(name,func)
        local obj = {
            Name = name,
            Function = func
        }
        setmetatable(obj, Tasks)
        return obj
    end
    
    function Tasks:Stop() 
        if not self:IsRunning() then return end
        if self.Thread then 
            task.cancel(self.Thread)
        end
        if self.ForceStoped then 
            self.ForceStoped()
        end
    end
    function Tasks:Start() 
        if self:IsRunning() then return end
        self.Thread = task.spawn(self.Function)
        return self
    end
    
    function Tasks:IsRunning() 
        if not self.Thread then return false end
        return coroutine.status(self.Thread) ~= "dead"
    end
end

if not getgenv().ListTask then 
    getgenv().ListTask = {}
end

local TaskHandler = {}

function TaskHandler:AddTask(Name, func)
    ListTask[Name] = Tasks.new(name,func)
    return ListTask[Name]
end

function TaskHandler:StopTask(Name)
    if not ListTask[Name] then return end
    ListTask[Name]:Stop()
end

function TaskHandler:CancelAll()
    for k, v in pairs(ListTask) do
        v:Stop()
    end
end
TaskHandler:CancelAll()

table.clear(getgenv().ListTask)
getgenv().ListTask = {}

local ScriptRunning = true
TaskHandler:AddTask("AutoSave",function() 
    while wait(2) do 
        SaveSettings()
    end
end):Start().ForceStoped = function() 
    ScriptRunning = false
end


local plr = game.Players.LocalPlayer

function Tap() 
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Click"):FireServer(Ray.new(Vector3.new(1378.8731689453125, 75.38618469238281, -4397.716796875), Vector3.new(0.8105669021606445, -0.5571429133415222, -0.18048004806041718)))
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_InvokeCustomFromClient"):InvokeServer("AdvancedFishing","Clicked")
end 
function ThaCan(pos) 
    if not pos then 
        pos = Vector3.new(tonumber("1448."..plr.UserId), 61.625038146972656, tonumber("-4409."..plr.UserId))
    end
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Click"):FireServer(Ray.new(Vector3.new(1378.8731689453125, 75.38618469238281, -4397.716796875), Vector3.new(0.8105669021606445, -0.5571429133415222, -0.18048004806041718)))


    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_FireCustomFromClient"):FireServer("AdvancedFishing","RequestReel")


    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Instancing_FireCustomFromClient"):FireServer("AdvancedFishing","RequestCast",pos)


end
function IsFishingGuiEnabled() 
    local s,e = pcall(function() 
        return game:GetService("Players").LocalPlayer.PlayerGui._INSTANCES.FishingGame
    end)
    if not s then return false end
    
    return e.Enabled
end

function IsPlayerFishing() 
    local s,e = pcall(function() 
        if plr.Character.Model.Rod:FindFirstChild("FishingLine") then 
            return plr.Character.Model.Rod:FindFirstChild("FishingLine")
        end
        return false
    end)
    if not s then return false end
    return e
end
getgenv().Time = 1.1
function CheckThaCan() 
    local Line = IsPlayerFishing()
    if not Line:FindFirstChild("Value") then 
        Instance.new("NumberValue",Line).Value = tick()
    else
        if Line then 
            for k,v in game.ReplicatedStorage.__DIRECTORY.FishingRods:GetChildren() do 
                if v:FindFirstChild("Model") and v:IsA("ModuleScript") and v.Model:FindFirstChild("Rod") then 
                    if Line.Parent.MeshId == v.Model.Rod.MeshId then
                        if tick() - Line.Value.Value > require(v).MinFishingTime * getgenv().Time then 
                            return true
                        else
                            return false
                        end
                        break
                    end
                end
            end
        end
    end
    
end
local plr = game.Players.LocalPlayer
function GetPlayerRobber() 
    local s,e = pcall(function() 
        for k,v in workspace.__THINGS.__INSTANCE_CONTAINER.Active.AdvancedFishing.Bobbers:GetChildren() do 
            if v:FindFirstChild("Bobber") then 
                -- if (#v.Bobber:GetJoints() >= 1 and v.Bobber:GetJoints()[1]:IsDescendantOf(plr.Character)) or (v.Bobber.Position - Pos).magnitude < 10 then 
                --     return v.Bobber
                -- end
                local Number = tonumber("1448."..plr.UserId)
                

                if math.abs(v.Bobber.Position.X - tonumber("1448."..plr.UserId)) < 0.001 or  math.abs(v.Bobber.Position.z - tonumber("-4409."..plr.UserId)) < 0.001 then 
                    return v.Bobber
                end
            end
        end
    end)
    if not s then return false end
    return e
end
function GetNearestTeleport() 
    local s,e = pcall(function() 
        local NearestTeleport
        for k,v in workspace.__THINGS.Instances:GetChildren() do 
            if v:FindFirstChild("Teleports") then 
                if v.Teleports:FindFirstChild("Leave") then 
                    if not NearestTeleport then 
                        NearestTeleport = v
                    end
                    if plr:DistanceFromCharacter(v.Teleports.Leave.Position) < plr:DistanceFromCharacter(NearestTeleport.Teleports.Leave.Position) then 
                        NearestTeleport = v
                    end
                end
            end
        end
        return NearestTeleport
    end)

    if not s then return nil end
    return e
end

function IsPlayerInMapCauCa() 
    if game.Workspace:FindFirstChild("Map") then return false end
    
    local s,e = pcall(function() 
        if workspace.__THINGS.__INSTANCE_CONTAINER.Active:FindFirstChild("AdvancedFishing") then 
            if plr:DistanceFromCharacter(Vector3.new(1381.8416748046875, 64.95339965820312, -4451.9794921875)) < 500 then 
                return true
            end
        end
    end)

    if not s then return false end
    return e
end
function Noclip()
    for i, v in ipairs(plr.Character:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide == true then
            v.CanCollide = false
        end
    end
end
game:GetService("RunService").Stepped:Connect(function()
    if getgenv().noclip then
        if plr.Character ~= nil then
            Noclip()
        end
    end
end)
spawn(function()
    while wait(2) do
        pcall(function()
            if noclip and not plr.Character.HumanoidRootPart:FindFirstChild("coems") then
                local BV = Instance.new("BodyVelocity", plr.Character.HumanoidRootPart)
                BV.Name = "coems"
                BV.Velocity = Vector3.new(0, 0, 0)
                BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            elseif not noclip then 
                if plr.Character.HumanoidRootPart:FindFirstChild("coems") then 
                    plr.Character.HumanoidRootPart:FindFirstChild("coems"):Destroy()
                end
            end
        end)
    end
end)

-- local s,e = pcall(function() 
--     print(game:GetService("RunService"):GetAllBoundInfo())
--     for k,v in game:GetService("RunService"):GetAllBoundInfo() do print(k,v) end
    
-- end)
-- print(s,e)
-- if game:GetService("ReplicatedFirst"):FindFirstChild("Blunder") then 
--     game:GetService("ReplicatedFirst"):FindFirstChild("Blunder"):Destroy()
--     print("Xoa r")
-- end

function BoostFps() 
    StopCheckPet = true
    task.spawn(function() 
        if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("Parallel Pet Actors") then 
            game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("Parallel Pet Actors"):Destroy()
        end
        plr.PlayerScripts.Scripts:Destroy()
        -- plr.PlayerScripts.Scripts.Game["Breakable VFX (Enchants, etc.)"]:Destroy()
        game.Workspace.Map:Destroy()
        for k,v in game.Workspace:GetChildren() do 
            if v.Name ~= plr.Name then 
                pcall(function() 
                    v:Destroy()
                end)
            end
        end
        for k,v in plr.PlayerGui:GetChildren() do v:Destroy() end
        -- if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("Scripts") then 
        --     for k,v in game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("Scripts"):GetChildren() do 
        --         if v.Name ~= "Core" then
        --             if v.Name == "Game" then 
        --                 for k,v in v:GetChildren() do 
        --                     if v.Name ~= "Orbs Frontend" and v.Name ~= "Lootbags Frontend" then 
        --                         v:Destroy()
        --                     end
        --                 end
        --             else
        --                 v:Destroy()
        --             end
        --         end
                
        --     end
        --     --game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("Scripts"):Destroy()
        -- end
        --game.ReplicatedStorage.Library:Destroy()
        -- for k,v in game:GetService("Players").LocalPlayer.PlayerScripts.Scripts:GetChildren() do 
        --     if v.Name ~= "Game" then 
        --         v:Destroy()
        --     end
        -- end
        -- for k,v in game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game:GetChildren() do 
        --     if not table.find({
        --         "Giftbags Frontend",
        --          "Lootbags Frontend",
        --         "Orbs Frontend",
        --      },v.Name) then 
        --         v:Destroy()
        --     end
        -- end
        -- for k,v in game.Workspace:GetChildren() do 
        --     if v.Name ~= plr.Name and v.Name ~= "__DEBRIS" and v.Name ~= "__THINGS" then 
        --         pcall(function() 
        --             v:Destroy()
        --         end)
        --     end
        -- end
        -- for k,v in game.Workspace["__DEBRIS"]:GetChildren() do 
        --     v:Destroy()
        -- end
        
        -- for k,v in game.Workspace["__DEBRIS"]:GetChildren() do 
        --     if v.Name ~= "Pets" and v.Name ~="Orbs" and v.Name ~="Lootbags" then 
        --         v:Destroy()
        --     end
        -- end

        
        -- pcall(function() 
        --     game.Players.LocalPlayer.PlayerScripts.Scripts.Game.Breakables["Breakables Frontend"]:Destroy()
        --     game.Workspace["__THINGS"].Breakables:Destroy()
        -- end)


        

        

        local Orbs = {}
        local Lootbags = {}
    
       
    
        game.ReplicatedStorage.Network["Orbs: Create"].OnClientEvent:Connect(function(v) 
            for k,v in v do 
                table.insert(Orbs,v.id)
            end
        end)

        game.ReplicatedStorage.Network:WaitForChild("Lootbags_Create").OnClientEvent:Connect(function(v) 
            table.insert(Lootbags,v.uid)
        end)
        print("DOne")
        while wait(3) do 
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect"):FireServer({
                Orbs
            })
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Orbs: Collect"):FireServer({
                Lootbags
            })
            table.clear(Orbs)
            table.clear(Lootbags)
        end
    end)
end
function ListToOb(tabl, tf)
    local out = {}
    for k, v in pairs(tabl) do
        if tf then
            out[v] = true
        else
            out[v] = false
        end
    end
    return out
end
function SetupTF(TF,Name) 
    local ListTF = ListToOb(TF)
    
    if not Settings[Name] then Settings[Name] = ListTF else  for k,v in pairs(Settings[Name]) do 
        ListTF[k]=v
    end Settings[Name] = ListTF end
    return ListTF
end

function GetTableQuest() 
    for k,v in getgc() do 
        if type(v) == "function" then 
            if tostring(getfenv(v).script) == "Ranks" then 
                if #debug.getconstants(v) > 50 and #debug.getconstants(v) < 100 then 
                    for k,v in debug.getupvalues(v) do 
                        if type(v) == "table" then 
                            for k,v2 in v do 
                                if type(v2) == "table" and pcall(function() return v2.UID end) and v2.UID then
                                    getgenv().QuestTable = v
                                    break
                                end
                            end
                        end
                    end
                    break
                end
            end
        end
        if getgenv().QuestTable then break end
    end
    return getgenv().QuestTable
end
function GetGoalsTable() 
    local tvk = require(game:GetService("ReplicatedStorage").Library.Client.RankCmds)
    local Goals = getupvalues(tvk.MakeTitle)[2].Goals
    local ReturnedGoalTable = {}
    for k,v in Goals do 
        ReturnedGoalTable[v] = k
    end
    return Goals,ReturnedGoalTable
end
function GetTablePlayerPet() 
    for k,v in getgc() do 
        if type(v) == "function" then 
            if tostring(getfenv(v).script) == "PlayerPet" then
                if debug.getinfo(v).name == "Get" then 
                    return getupvalue(v,1)
                end
                
            end
        end
    end
end
function InstantTpPet() 
    local List = {}
    for k,v in GetTablePlayerPet() do 
        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Pets_Unfavorite"):FireServer(k)
        List[k] = {
            ["targetValue"] = "3177473860",
            ["targetType"] = "Player"
        }
    end
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Pets_ToggleFavoriteMode"):FireServer()

    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Pets_SetTargetBulk"):FireServer(List)
end

function GetTablePlayerPet() 
    for k,v in getgc() do 
        if type(v) == "function" then 
            if tostring(getfenv(v).script) == "PlayerPet" then
                if debug.getinfo(v).name == "Get" then 
                    return getupvalue(v,1)
                end
            end
        end
    end
end
local old = require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier
require(game.ReplicatedStorage.Library.Client.PlayerPet).CalculateSpeedMultiplier = function(...) 
    if ScriptRunning and Settings.FarmCoin then 
        return 1000
    end
    return old(...)
end
local old = require(game.ReplicatedStorage.Library.Client.UpgradeCmds).GetPower
require(game.ReplicatedStorage.Library.Client.UpgradeCmds).GetPower = function(...)
    local a = ... 
    if a == "Magnet" and ScriptRunning then 
        return 1000
    end
    return old(...)
end
local PlayerPet = GetTablePlayerPet()
local PlayerPetIndex = {}
local StopCheckPet = false
spawn(function() 
    while true and not StopCheckPet do 
        PlayerPetIndex = {}
        for k,v in PlayerPet do 
            table.insert(PlayerPetIndex,k)
        end
        wait(5)
    end
end)



local ListFeature = {}

function SetFeatureState(Name,State) 
    local Task = ListTask[Name]
    if Task then 
        Settings[Name] = State
        if State then 
            if not Task:IsRunning() then 
                Task:Start()
            end
        else
            Task:Stop()
        end
    end
end
function SetFeatureFunction(Name,func,Default) 
    Default = Settings[Name]
    local Task = TaskHandler:AddTask(Name,func)
    ListFeature[Name] = Task
    if Default then 
        Settings[Name] = Default
        Task:Start()
    end
    return Task
end

function TP(pos) 
    if not game.Workspace:FindFirstChild("Map") then 
        local NearestTeleport = GetNearestTeleport()
        if NearestTeleport then 
            if plr:DistanceFromCharacter(NearestTeleport.Teleports.Leave.Position) < 1000 then 
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(NearestTeleport.Teleports.Leave.Position)
                wait(3)
            end
        end
    end
    plr.Character.HumanoidRootPart.CFrame = pos
end

SetFeatureFunction("CauCa",function() 
    while wait() do
        if not StoppedTp then 
            if not IsPlayerInMapCauCa() then 
                if not game.Workspace:FindFirstChild("Map") then 
                    local NearestTeleport = GetNearestTeleport()
                    if NearestTeleport then 
                        if plr:DistanceFromCharacter(NearestTeleport.Teleports.Leave.Position) < 1000 then 
                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(NearestTeleport.Teleports.Leave.Position)
                            wait(3)
                        end
                    end
                else
                    if workspace.__THINGS.Instances:FindFirstChild("AdvancedFishing") then 
                        if workspace.__THINGS.Instances.AdvancedFishing:FindFirstChild("Teleports") and workspace.__THINGS.Instances.AdvancedFishing.Teleports:FindFirstChild("Enter") then 
                            plr.Character.HumanoidRootPart.CFrame = CFrame.new(workspace.__THINGS.Instances.AdvancedFishing.Teleports.Enter.Position)
                            wait(3)
                        end
                    end
                end
            else
                if IsFishingGuiEnabled() then 
                    task.spawn(Tap)
                    task.spawn(Tap)
                    wait()
                else
                    if not IsPlayerFishing() then 
                        ThaCan()
                        pcall(function() 
                            plr.Character.Model.Rod:WaitForChild("FishingLine",2)
                        end)
                        getgenv().Start = tick()
                    else
                        local Robber = GetPlayerRobber()
                        if Robber then
                            if Robber:FindFirstChild("ReadyToCheck") then
                                if math.abs((Robber.CFrame.Y - math.floor(Robber.CFrame.Y)) - 0.625) > 0.1 then 
                                    ThaCan()
                                    if getgenv().Start then print(tick() - getgenv().Start) end
                                end
                            else
                                if math.abs((Robber.CFrame.Y - math.floor(Robber.CFrame.Y)) - 0.625) < 0.03 then 
                                    Instance.new("BoolValue",Robber).Name = "ReadyToCheck"
                                end
                            end
                        else
                            pcall(function() 
                                if not plr.Character.Model.Rod.FishingLine:FindFirstChild("Value") then 
                                    Instance.new("NumberValue",plr.Character.Model.Rod.FishingLine).Value = tick()
                                end
                                if tick() - plr.Character.Model.Rod.FishingLine.Value.Value > 4 then 
                                    ThaCan()
                                end
                            end)
                        end
                        -- if not plr.Character.Model.Rod:FindFirstChild("Sound") then 
                        --     ThaCan()
                        --     wait(1)
                        -- end
                        -- if CheckThaCan() then 
                        --     ThaCan()
                        --     wait(1)
                        -- end
                    end
                end
            end
        end
    end
end)

local StringMapData = [[
    {"81 | Empyrean Dungeon":{"p":"1070,-36,4095"},"9 | Misty Falls":{"p":"376,14,29"},"63 | Frost Mountains":{"p":"1210,14,2689"},"56 | Fairytale Castle":{"p":"258,14,2471"},"13 | Dark Forest":{"p":"533,14,264"},"50 | Fire Dojo":{"p":"1093,14,2119"},"41 | Hot Springs":{"p":"663,14,1708"},"69 | Golden Road":{"p":"733,14,3219"},"28 | Shanty Town":{"p":"667,14,1019"},"87 | Toys and Blocks":{"p":"96,14,4291"},"77 | Haunted Mansion":{"p":"573,14,3740"},"40 | Ski Town":{"p":"663,14,1521"},"79 | Dungeon":{"p":"1070,-36,3764"},"74 | Witch Marsh":{"p":"259,14,3567"},"44 | Obsidian Cave":{"p":"1113,14,1734"},"78 | Dungeon Entrance":{"p":"909,-36,3740"},"64 | Ice Sculptures":{"p":"1210,14,2863"},"10 | Mine":{"p":"216,14,55"},"4 | Green Forest":{"p":"690,14,-204"},"37 | Snow Village":{"p":"1122,14,1470"},"90 | Clouds":{"p":"-64,114,4851"},"67 | Polar Express":{"p":"1050,14,3219"},"59 | Cozy Village":{"p":"576,14,2665"},"62 | Colorful Mountains":{"p":"1052,14,2665"},"1 | Spawn":{"p":"247,14,-205"},"58 | Fairy Castle":{"p":"416,14,2664"},"57 | Royal Kingdom":{"p":"258,14,2640"},"5 | Autumn":{"p":"848,14,-181"},"97 | Heaven Golden Castle":{"p":"-64,114,5962"},"72 | Runic Altar":{"p":"258,14,3245"},"47 | Underworld Bridge":{"p":"1418,14,1929"},"84 | Gummy Forest":{"p":"578,14,4291"},"83 | Cotton Candy Forest":{"p":"738,14,4291"},"46 | Underworld":{"p":"1417,14,1758"},"65 | Snowman Town":{"p":"1210,14,3021"},"43 | Volcano":{"p":"964,14,1734"},"34 | Grand Canyons":{"p":"812,14,1257"},"11 | Crystal Caverns":{"p":"216,14,238"},"70 | No Path Forest":{"p":"574,14,3219"},"12 | Dead Forest":{"p":"375,14,264"},"24 | Palm Beach":{"p":"811,14,785"},"14 | Mushroom Field":{"p":"693,14,265"},"15 | Enchanted Forest":{"p":"851,14,290"},"98 | Colorful Clouds":{"p":"-64,114,6120"},"17 | Jungle":{"p":"695,14,499"},"16 | Crimson Forest":{"p":"851,14,473"},"18 | Jungle Temple":{"p":"535,14,499"},"19 | Oasis":{"p":"373,14,499"},"80 | Treasure Dungeon":{"p":"1070,-36,3937"},"20 | Beach":{"p":"215,14,499"},"75 | Haunted Forest":{"p":"259,14,3731"},"55 | Fairytale Meadows":{"p":"258,14,2312"},"94 | Cloud Palace":{"p":"-64,114,5488"},"52 | Bamboo Forest":{"p":"575,14,2121"},"27 | Pirate Tavern":{"p":"825,14,1019"},"49 | Metal Dojo":{"p":"1259,14,2121"},"32 | Red Desert":{"p":"513,14,1257"},"3 | Castle":{"p":"534,14,-234"},"30 | Fossil Digsite":{"p":"362,14,1043"},"22 | Shipwreck":{"p":"374,-36,785"},"39 | Ice Rink":{"p":"820,14,1494"},"88 | Carnival":{"p":"-64,14,4316"},"23 | Atlantis":{"p":"535,-36,785"},"25 | Tiki":{"p":"971,14,810"},"26 | Pirate Cove":{"p":"971,14,994"},"68 | Firefly Cold Forest":{"p":"891,14,3219"},"29 | Desert Village":{"p":"513,14,1019"},"33 | Wild West":{"p":"663,14,1257"},"60 | Rainbow River":{"p":"735,14,2665"},"38 | Icy Peaks":{"p":"969,14,1494"},"86 | Sweets":{"p":"256,14,4291"},"48 | Underworld Castle":{"p":"1417,14,2095"},"99 | Rainbow Road":{"p":"-64,158,6432"},"36 | Mountains":{"p":"1122,14,1282"},"31 | Desert Pyramids":{"p":"362,14,1232"},"95 | Heaven Gates":{"p":"-64,114,5648"},"85 | Chocolate Waterfall":{"p":"417,14,4291"},"2 | Colorful Forest":{"p":"372,14,-204"},"61 | Colorful Mines":{"p":"893,14,2665"},"93 | Cloud Houses":{"p":"-64,114,5327"},"45 | Lava Forest":{"p":"1262,14,1734"},"35 | Safari":{"p":"965,14,1257"},"91 | Cloud Garden":{"p":"-64,114,5008"},"92 | Cloud Forest":{"p":"-64,114,5166"},"54 | Flower Field":{"p":"258,14,2146"},"66 | Ice Castle":{"p":"1210,14,3194"},"21 | Coral Reef":{"p":"215,-36,759"},"51 | Samurai Village":{"p":"735,14,2121"},"53 | Zen Garden":{"p":"417,14,2121"},"6 | Cherry Blossom":{"p":"848,14,3"},"82 | Mythic Dungeon":{"p":"1070,-36,4268"},"76 | Haunted Graveyard":{"p":"413,14,3740"},"8 | Backyard":{"p":"534,14,22"},"7 | Farm":{"p":"693,14,28"},"73 | Wizard Tower":{"p":"258,14,3412"},"96 | Heaven":{"p":"-64,114,5805"},"71 | Ancient Ruins":{"p":"416,14,3219"},"89 | Theme Park":{"p":"-64,14,4488"}}
]]

local MapPosition = game:GetService("HttpService"):JSONDecode(StringMapData)

local MapData = {}
local MapNames = {}
table.insert(MapNames,"VIP")
MapData["VIP"] = {
    Name = "VIP",
    Parent = "Spawn",
    CFrame = CFrame.new(214.229645, 27.7442703, -587.279358, 1, 0, 0, 0, 1, 0, 0, 0, 1)
}
for k,v in MapPosition do
    local MapName = tostring(string.gsub(string.match(k, "%D+"), " | ", ""))
    local Level = tonumber(string.match(k, "%d+"))
    if Level and MapName and MapPosition[k] then 
        local cf = Vector3.new(unpack(string.split(MapPosition[k].p, ",")))
        MapData[k] = {
            Name = MapName,
            Level = Level,
            FolderName = k,
            CFrame = CFrame.new(cf) * CFrame.new(0,3,0),
            --TeleportPosition = v.PERSISTENT.Teleport.Position
        }
    
        table.insert(MapNames,k)
    end
end


if not getgenv().Breakables then 
    getgenv().Breakables = {}
    getgenv().BreakableIdList = {}
end


-- for k,v in getgenv().Breakables["VIP"] do
--     game.Workspace.__THINGS.Breakables:FindFirstChild(v):FindFirstChildOfClass("MeshPart").Transparency = 1
-- end

getgenv().Tvk = function(...) 
    local v = ...
    if v.Breakables_Created then 
        for k,v in v.Breakables_Created do 
            for k,v in v do 
                local ParentUid = v.parentID
                local BreakabeId = v.id
                if string.match(BreakabeId,"Diamond") and ParentUid == "Spawn" then ParentUid = "VIP" end
                if not ParentUid then return end
                if not Breakables[ParentUid] then 
                    Breakables[ParentUid] = {}
                end
                Breakables[ParentUid][v.uid] = v.uid
                BreakableIdList[v.uid] = ParentUid
                --print("Added")
            end
        end
    end
    if v.Breakables_Destroyed then 
        for k,v in v.Breakables_Destroyed do 
            local Id = v[2]
            local ParentId = BreakableIdList[Id]
            if ParentId then 
                Breakables[ParentId][Id] = nil
                BreakableIdList[Id] = nil
            end
        end
    end
    -- for k,v in v do 

    --     if k ~= "Breakables_UpdatePets" then 
    --         if type(v) == "table" then 
    --             for k2,v2 in v do 
    --                 warn(k,k2,v2)
    --                     for k,v in v[1] do 
    --                         if type(v) == "table" then 
    --                             for k,v in v do 
    --                                 print("Inside",k2,k,v)
    --                             end
    --                         else
    --                             print(k2,k,v)
    --                         end
    --                     end
    --             end
    --         end        
    --     end
    -- end
end
if not getgenv().OnClient then 
    game.ReplicatedStorage.Network.Breakables_BulkUpdate.OnClientEvent:Connect(function(...) 
        getgenv().Tvk(...)
    end)
    getgenv().OnClient = true
end


function BreakableAdded(Breakable) 
    pcall(function() 
        local ParentUid = Breakable:GetAttribute("ParentID")
        local BreakabeId = Breakable:GetAttribute("BreakableID")
        if string.match(BreakabeId,"Diamond") and ParentUid == "Spawn" then ParentUid = "VIP" end
        if not ParentUid then return end
        if not Breakables[ParentUid] then 
            Breakables[ParentUid] = {}
        end
        Breakables[ParentUid][Breakable.Name] = Breakable.Name
        BreakableIdList[Breakable.Name] = ParentUid
        --Breakable:Destroy()
    end)
end

for k,v in workspace.__THINGS.Breakables:GetChildren() do 
    BreakableAdded(v)
end


-- workspace.__THINGS.Breakables.ChildAdded:Connect(BreakableAdded)
-- workspace.__THINGS.Breakables.ChildRemoved:Connect(function(Breakable) 
--     local id = Breakable:GetAttribute("ParentID")
--     local BreakabeId = Breakable:GetAttribute("BreakableID")
--     if string.match(BreakabeId,"Diamond") and id == "Spawn" then id = "VIP" end
--     if Breakables[id] then 
--         Breakables[id][Breakable.Name] = nil
--     end
-- end)




local TableQuest = GetTableQuest()
local _,GoalsTable = GetGoalsTable()

SetFeatureFunction("AutoRank",function() 
    while wait() do
        if plr.PlayerGui.Starter.Enabled then 
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Pick Starter Pets"):InvokeServer("Cat","Dog")
            plr.PlayerGui.Starter.Enabled = false
        end
        for k,v in TableQuest do 
            local Type = GoalsTable[v.Type]
            if v.Progress ~= v.Amount then 
                if Type == "BREAKABLE" then 
                    if v.BreakableType == "Coin" then 
                        plr.Character.HumanoidRootPart.CFrame = CFrame.new(224.70309448242188, 16.33563995361328, -205.99420166015625)
                        -- for k,v in workspace.__THINGS.Breakables:GetChildren() do 
                        --     if 
                        -- end
                    end
                end
            end
        end
    end
end)

local vu = game:GetService("VirtualUser")
plr.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

function GetSizeOfCoin(coin) return coin.Size.X ^ 2 + coin.Size.Y ^2 + coin.Size.Z ^2 end
function Length(tabl) local c = 0 for k,v in tabl do c = c + 1 end return c end
--https://www.roblox.com/games/8737899170/Pet-Simulator-99?privateServerLinkCode=17503465937270991503078054081587

-- local HookList = {}

-- if not getgenv().Hooked then 
--     local old
--     old = hookmetamethod(game,"__namecall",function(...) 
--         local self,arg = ...

--     end) 
-- end

-- function HookMt() 


-- function HookMetaMethod(a,b,func) 
--     local HookTask
--     HookTask = TaskHandler:AddTask("HookMt"..tostring(math.random(1,100000)),function() 
--         local old
--         old = hookmetamethod(a,b,function(...)
--             if HookTask:IsRunning() then 
--                 return func(...)
--             end
--             return old(...)
--         end)
--     end)
-- end

LPH_NO_VIRTUALIZE(function() 
    local old 
    old = hookmetamethod(game,"__namecall",function(...) 
        local self,arg = ...
        if not checkcaller() then 
            if Settings.FarmCoin and getnamecallmethod() == "FireServer" and ScriptRunning then 
                if Settings.FarmingMethod ~= "Engine" then 
                    if tostring(self) == "Breakables_JoinPet" or tostring(self) == "Pets_SetTargetBulk" then 
                        return
                    end
                end
            end
            if getnamecallmethod() == "FireServer" and tostring(self) == "__BLUNDER" then return end
        end
        return old(...)
    end)
end)()



SetFeatureFunction("AutoClaimFreeReward",function() 
    while true do
        for i = 1,12 do 
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Redeem Free Gift"):InvokeServer(i) 
        end
        wait(60)
    end
end)

local FarmCoinTask = SetFeatureFunction("FarmCoin",function() 
    LPH_JIT(function() 
        local FarmCoinList = {
            Length = 0,
            Coins = {}
        }
        local PetJoinId = {}
        local PetPerCoin = nil
        while wait() do
            if Settings.FarmMap and MapData[Settings.FarmMap] and not StoppedTp
            then 
                --print(0)
                local BreakableFolder = Breakables[MapData[Settings.FarmMap].Name]
                --local PetPerCoin = BreakableFolder.Lenght
                if BreakableFolder then 
    
                    local NumberOfPet = #PlayerPetIndex
                    local PetPerCoin = NumberOfPet
                    if not PetPerCoin then PetPerCoin = NumberOfPet end
                    if Settings.UltraBoost then 
                        if not getgenv().BoostedFps then 
                            BoostFps()
                            getgenv().BoostedFps = true
                        end
                    end
                    plr.Character.HumanoidRootPart.CFrame = MapData[Settings.FarmMap].CFrame
                    getgenv().noclip = true
                    if Settings.FarmingMethod ~= "Engine" then 
                        if Settings.FarmingMethod == "Extreme" or FarmCoinList.Length < PetPerCoin then 
                            --print(2)
                            local Lowest
                            local AllCoinLenght
                            for k,v in BreakableFolder do 
                                --print(k,v)
                                if not FarmCoinList.Coins[k] then 
                                    local FarmingMode = Settings.FarmingMode
                                    if FarmingMode ~= "All" then 
                                        -- local MeshPart = v:FindFirstChildOfClass("MeshPart")
                                        -- if MeshPart then 
                                        --     if not Lowest then 
                                        --         Lowest = v
                                        --     end
                                        --     if FarmingMode == "Lowest Health" then 
                                        --         local Size = GetSizeOfCoin(MeshPart)
                                        --         if Size < GetSizeOfCoin(Lowest:FindFirstChildOfClass("MeshPart")) then 
                                        --             Lowest = v
                                        --         end
                                        --     elseif FarmingMode == "Highest Health" then
                                        --         local Size = GetSizeOfCoin(MeshPart)
                                        --         if Size > GetSizeOfCoin(Lowest:FindFirstChildOfClass("MeshPart")) then 
                                        --             Lowest = v
                                        --         end
                                        --     else
                                        --         Lowest = v
                                        --     end
                                        -- else
                                            
                                        -- end
                                    else
                                        if FarmCoinList.Length < PetPerCoin then 
                                            FarmCoinList.Coins[k] = v
                                            FarmCoinList.Length = FarmCoinList.Length + 1
                                            --plr.Character.HumanoidRootPart.CFrame = FarmCoinList.Coins[k]
                                        else 
                                            break
                                        end
                                    end
                                end
                                if Settings.FarmingMethod == "Extreme" then 
                                    game:GetService("ReplicatedStorage").Network.Breakables_JoinPet:FireServer(v.Name,PlayerPetIndex[math.random(1,#PlayerPetIndex)])
                                    game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage:FireServer(v.Name)
                                end
                            end 
                            if Lowest and Settings.FarmingMethod ~= "Extreme" and Settings.FarmingMethod ~= "All" then 
                                FarmCoinList.Coins[Lowest.Name] = Lowest
                                FarmCoinList.Length = FarmCoinList.Length + 1
                            end
                        end
                        if Settings.FarmingMethod ~= "Extreme" then 
                            local i = 1
                            local TargetBulk = {}
                            while i < #PlayerPetIndex do 
                                local ReachedPlusI = false
                                for k,v in FarmCoinList.Coins do 
                                    if not BreakableFolder[k] then 
                                        FarmCoinList.Coins[k] = nil
                                        FarmCoinList.Length = FarmCoinList.Length - 1
                                    else
                                        if i < #PlayerPetIndex then 
                                            if PetJoinId[PlayerPetIndex[i]] and FarmCoinList.Coins[PetJoinId[PlayerPetIndex[i]]] then 
                                                if Settings.AutoTap then 
                                                    game:GetService("ReplicatedStorage").Network.Breakables_PlayerDealDamage:FireServer(k)
                                                end
                                            else
                                                game:GetService("ReplicatedStorage").Network.Breakables_JoinPet:FireServer(k,PlayerPetIndex[i])
                                                PetJoinId[PlayerPetIndex[i]] = k
                                                TargetBulk[PlayerPetIndex[i]] = {
                                                    ["targetValue"] = k,
                                                    ["targetType"] = "Breakable"
                                                }
                                                i = i + 1
                                                ReachedPlusI = true
                                            end
                                        end
                                    end 
                                end
                                if not ReachedPlusI then break end
                            end
                        end
                    end
                else
                    plr.Character.HumanoidRootPart.CFrame = MapData[Settings.FarmMap].CFrame
                end
            end
        end
    end)()
end)
FarmCoinTask.ForceStoped = function() 
    getgenv().noclip = false
end



-- for k,v in getgc(true) do 
--     if type(v) == "table" then 
--         if pcall(function() return v.RegularMerchant.Seeds end) and v.RegularMerchant and type(v.RegularMerchant) == "table" and v.RegularMerchant.Seeds then 
--             getgenv().Table = v
--             print("Done")
--             break
--         end
--     end
-- end

--setclipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))



local Main = Library.CreateMain({Title = 'Pet Simulator 99', Desc = ''})
print("Created Main?")
local Page1 = Main.CreatePage({Page_Name = 'Main', Page_Title = 'Main Tab'})
local Section11 = Page1.CreateSection('Main')


Section11.CreateToggle({Title = 'Auto Fishing', Default = Settings.CauCa}, function(v)
    SetFeatureState("CauCa",v)
end)




Section11.CreateToggle({Title = 'Auto Claim Free Reward', Default = Settings.ClaimFree}, function(v)
   SetFeatureState("AutoClaimFreeReward",v)
end)

local Section11 = Page1.CreateSection('Auto Merchant')

Section11.CreateToggle({Title = 'Auto Merchant', Default = Settings.AutoMerchant}, function(v)
    SetFeatureState("AutoMerchant",v)
end)

--setclipboard(tostring(game.Players.LocalPlayer.Character.HumanoidRootPart.Position))
local MerchantInfo = {
    RegularMerchant = {
        Position = CFrame.new(372.11248779296875, 16.306806564331055, 551.4596557617188)
    },
    AdvancedMerchant = {
        Position = CFrame.new(808.6577758789062, 16.58210563659668, 1548.416748046875)
    },
    GardenMerchant = {
        Position = CFrame.new(258.5284729003906, 16.566850662231445, 2067.40087890625)
    }
}
local ListMerchant = {}

for k,v in MerchantInfo do 
    table.insert(ListMerchant,k)
end

ListMerchant = SetupTF(ListMerchant,"MerchantTF")

Section11.CreateDropdown({Title = 'Select Merchant', List = ListMerchant, Selected = true}, function(i, v)
    if i and v then 
        ListMerchant[i]=v
    end
end)

local MerchantsTable = getgenv().MerchantsTable



game:GetService("ReplicatedStorage"):WaitForChild("Network").Merchant_Updated.OnClientEvent:Connect(function(...)
    MerchantsTable = ...
    print(MerchantsTable)
end)



-- for k,v in getgc() do 

--     if type(v) == "function" then 
--         if tostring(getfenv(v).script) == "Traveling Merchant" and debug.getinfo(v).name == "updateUI" then 
--             for k,v in getupvalues(v)[10] do print(k,v) end
--         end
--     end
-- end

-- local a = getsenv(game.Players.LocalPlayer.PlayerScripts.Scripts.Game.Machines["Traveling Merchant"]).updateUI
-- print(a)
-- for k,v in getupvalues(a) do print(k,v) end
local plr = game.Players.LocalPlayer
local MerchantUtil = require(game.ReplicatedStorage.Library.Util.MerchantUtil)
local SaveModule = require(game.ReplicatedStorage.Library.Client.Save)
-- for k,v in SaveModule.GetSaves()[plr].MerchantExperience do print(k,v) end
-- print()
-- for k,v in getgc() do 

--     if type(v) == "function" then 
--         if tostring(getfenv(v).script) == "Traveling Merchant" and debug.getinfo(v).name == "updateUI" then 
-- --print(getupvalues(v)[1].Save:Get("ExperienceFromRespectLevel"))
--             -- for k,v in getupvalues(v)[1].Save.GetSaves() do 
--             --     warn(k,v)
--             --     for k,v in v do print(k,v.MerchantExperience) end
--             --     break
--             -- end
--            --for k,v i
--            -- print(getupvalues(v)[1].TabController:Get("ExperienceFromRespectLevel"))
--         end
--     end
-- end


SetFeatureFunction("AutoMerchant",function() 
    while wait(1) do --AdvancedMerchant.Offers["1"].PriceData.data
        if MerchantsTable and type(MerchantsTable) == "table" then 
            print("Got heare")
            for k,v in ListMerchant do
                local MerchantName = k
                if v and MerchantsTable[k] then 
                    for k,v in MerchantsTable[k].Offers do 
                        if v.Stock > 0 then 
                            local PlayerExp = SaveModule.GetSaves()[plr].MerchantExperience[MerchantName] or 1
                            local PlayerRespect = MerchantUtil.RespectLevelFromExperience(PlayerExp)
                            if PlayerRespect >= v.Respect then 
                                if plr.leaderstats["\240\159\146\142 Diamonds"].Value >= v.PriceData.data._am then 
                                    if plr:DistanceFromCharacter(MerchantInfo[MerchantName].Position.p) > 100 then 
                                        StoppedTp = true
                                        TP(MerchantInfo[MerchantName].Position)
                                        wait(1)
                                    end
                                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Merchant_RequestPurchase"):InvokeServer(MerchantName,tonumber(k))
                                end
                            end
                        end
                    end
                end
            end
        elseif MerchantsTable == nil then
            for k,v in ListMerchant do
                local MerchantName = k
                if v then 
                    if plr:DistanceFromCharacter(MerchantInfo[MerchantName].Position.p) > 100 then 
                        StoppedTp = true
                        TP(MerchantInfo[MerchantName].Position)
                        wait(1)
                    end
                    local Break 
                    for i = 1,6 do 
                        if game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Merchant_RequestPurchase"):InvokeServer(MerchantName,i) then Break = true break end
                    end
                    if Break then break end
                end
            end
            -- if MerchantTable == nil then 
            --     MerchantsTable = true
            -- end
        else
           --print(MerchantsTable)
        end
        StoppedTp = false
    end
    StoppedTp = false
end).ForceStoped = function() 
    StoppedTp = false
end
local Page1 = Main.CreatePage({Page_Name = 'Buy Item', Page_Title = 'Main Tab'})


local Page1 = Main.CreatePage({Page_Name = 'Auto Farm', Page_Title = 'Main Tab'})
local Section11 = Page1.CreateSection('Main')

Section11.CreateToggle({Title = 'Auto Farm',Desc="Will auto farm in your selected map", Default = Settings.FarmCoin}, function(v)
    SetFeatureState("FarmCoin",v)
 end)
 Section11.CreateToggle({Title = 'Auto Tap',Desc="Will auto tap in farming coin", Default = Settings.AutoTap}, function(v)
    Settings.AutoTap = v
 end)

Section11.CreateToggle({Title = 'Ultra Boost FPS',Desc="Will boost your fps (Only For Field Farm, Cannot disable, not work in engine method)", Default = Settings.UltraBoost}, function(v)
    Settings.UltraBoost = v
end)


Section11.CreateDropdown({Title = 'Select Map', List = MapNames, Selected = false}, function(v)
    Settings.FarmMap = v
end)

Section11.CreateDropdown({Title = 'Farming Mode', List = {"All"}, Selected = false}, function(v)
    Settings.FarmingMode = v
end)
Section11.CreateDropdown({Title = 'Farming Method', List = {"Script","Engine"},Default = "Script", Selected = false}, function(v)
    Settings.FarmingMethod = v
end)
Section11.CreateLabel({Title = "Method Script: Use CTE HUB implemented farm function (recommended in low level farm like vip area) \nMethod Engine: Use game built in Farm Method with pet instant tp (Not work with Ultra Boost FPS)"})

-- local Page1 = Main.CreatePage({Page_Name = 'Auto Rank', Page_Title = 'Main Tab'})
-- local Section11 = Page1.CreateSection('Main')

-- Section11.CreateToggle({Title = 'Auto Rank',Desc = "Auto farm rank", Default = Settings.AutoRank}, function(v)
--    SetFeatureState("AutoRank",v)
-- end)

-- 2 ^ 10 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2
-- = (2 * 2 * 2 * 2 * 2 ) ^ 2
-- = ((2*2)^2 * 2)^2

workspace.ALWAYS_RENDERING:Destroy()
