while true do
game.ReplicatedStorage.Remotes.RequestGhostSpawn:InvokeServer()
while true do
for i, v in pairs(game.Workspace.GhostCoins:GetChildren()) do
 if v:IsA("MeshPart") then
local Player = game.Players.LocalPlayer.Character
  local Target = v.CFrame
  Player.HumanoidRootPart.CFrame = CFrame.new(Target.Position.X, Target.Position.Y, Target.Position.Z)
 end
end
wait(0.25)
end
end
