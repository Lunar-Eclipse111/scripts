if shared.n2autofarm then shared.n2autofarm:Disconnect();end;
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local Backpack = LocalPlayer.Backpack;
local LocalCharacter = LocalPlayer.Character;
local LocalRootPart;
local LocalHumanoid;

--local character
do
    local function characterAdded(Character)
        if typeof(Character) ~= "Instance" then return;end;
        LocalCharacter = Character;
        LocalRootPart = Character:WaitForChild("HumanoidRootPart");
        LocalHumanoid = Character:WaitForChild("Humanoid");
    end;
    characterAdded(LocalCharacter);
    LocalPlayer.CharacterAdded:Connect(characterAdded);
end;

local UI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("UI");
local TargetFrame = UI.Target;
local TargetVisible = TargetFrame.Visible;
local TargetText = TargetFrame.TargetText;
local Target = TargetVisible and Players:FindFirstChild(TargetText.Text);
local TargetCharacter;
local TargetRootPart;

TargetFrame.Changed:Connect(function()
    TargetVisible = TargetFrame.Visible;

if getgenv().Autofarm == true then
game.Workspace.GameMap:Remove()
end
        if getgenv().Autofarm == false then
workspace.Gravity = 196.2;
end

end);
TargetText.Changed:Connect(function()
    Target = Players:FindFirstChild(TargetText.Text);
end);

local VotePad = workspace.Lobby.VoteStation.pad3.Position;
local function getClosestPlayer()
    local Closest;
    local MaxDistance;

    for I, Player in next, Players:GetPlayers() do
        if Player ~= LocalPlayer and LocalRootPart then
            local Character = workspace:FindFirstChild(Player.Name);
            local RootPart = Character and Character:FindFirstChild("HumanoidRootPart");
            local Humanoid = RootPart and Character:FindFirstChild("Humanoid");

            if Humanoid and Humanoid.Health > 0 then
                local Distance = (VotePad - RootPart.Position).Magnitude;
                if Distance > 300 then
                    Distance = (LocalRootPart.Position - RootPart.Position).Magnitude;
                    if Closest then
                        if Distance < MaxDistance then
                            Closest = Player;
                            MaxDistance = Distance;
                        end;
                    else
                        Closest = Player;
                        MaxDistance = Distance;
                    end;
                end;
            end;
        end;
    end;

    return Closest, MaxDistance;
end;
local ClosestPlayer;
local ClosestPlayerCharacter;
local ClosestPlayerRootPart;

local HitCheckCooldown = false;
local HitCheck = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("localknifehandler"):WaitForChild("HitCheck");
local ThrowKnife = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ThrowKnife");

local ThrowCooldown = false;
local ThrowCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);

local TPTweenInfo = TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
-- TELEPORT OFFSET

local TPOffset = CFrame.new(-1.8, -4, 1);  --(-2.-3.96,1.6)

local TweenService = game:GetService("TweenService");
shared.n2autofarm = game:GetService("RunService").Heartbeat:Connect(function()
    ClosestPlayer = getClosestPlayer();
    ClosestPlayerCharacter = ClosestPlayer and workspace:FindFirstChild(ClosestPlayer.Name);
    ClosestPlayerRootPart = ClosestPlayerCharacter and ClosestPlayerCharacter:FindFirstChild("HumanoidRootPart");
    
    -- print(TargetVisible, Target, LocalCharacter, LocalRootPart, LocalHumanoid);
    if TargetVisible and Target and LocalCharacter and LocalRootPart and LocalHumanoid and getgenv().Autofarm == true then
        TargetCharacter = workspace:FindFirstChild(Target.Name);
        TargetRootPart = TargetCharacter and TargetCharacter:FindFirstChild("HumanoidRootPart");




    --Teleport
 workspace.Gravity = -2;  -- -2
        LocalHumanoid:SetStateEnabled(15, false);
        TweenService:Create(
            LocalRootPart,
            TPTweenInfo,
            {CFrame = TargetRootPart.CFrame * TPOffset}
        ):Play();
    end;
end);

local Player = game.Players.LocalPlayer;

local cooldown = false

task.spawn(function()
    game:GetService("RunService").Stepped:connect(function()
        if Player.Character and not cooldown and game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.Visible == true and getgenv().Autofarm == true then
            if Player:DistanceFromCharacter(game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text].Head.Position) <= 6.5 then
                Player.PlayerScripts.localknifehandler.HitCheck:Fire(game.Workspace[game.Players.LocalPlayer.PlayerGui.ScreenGui.UI.Target.TargetText.Text])
                coroutine.wrap(function()
                    cooldown = true
                    task.wait(0.8)
                    cooldown = false
                end)()
            else
                task.wait()
            end
        end
    end)
end)
