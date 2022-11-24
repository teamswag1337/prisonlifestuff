--converts 0.6 punch for 2.0
ply = game.Players.LocalPlayer.Character

local tool = Instance.new('Tool', game.Players.LocalPlayer.Backpack)
local handle = Instance.new('Part', tool)
handle.Name = 'Handle'
handle.Size = Vector3.new(0.2, 0.2, 0.2)
handle.Transparency = 1
tool.Name = "Fight"

tool.Equipped:connect(function(mouse)
    local llanim = Instance.new('Animation')
    llanim.AnimationId = 'http://www.roblox.com/asset/?id=218401948'
	anim = ply.Humanoid:LoadAnimation(llanim)
	local rarm=ply:findFirstChild("Right Arm")
	local larm = ply:findFirstChild("Left Arm")
	local deb = false
	pressedalready = false
	function touched(part)
		local hum = part.Parent:findFirstChild("Humanoid")
		if hum then
			if deb ~= true then
				deb = true
                ply.Head.punchSound:Play()
				wait(.4)
				game.ReplicatedStorage.meleeEvent:FireServer(game.Players[hum.Parent.Name])
				wait(.2)
				game.ReplicatedStorage.meleeEvent:FireServer(game.Players[hum.Parent.Name])
				wait(1.4)
				deb = false
			end
		end
	end
	mouse.Button1Down:connect(function()
		if pressedalready == false then
			ply.Humanoid.WalkSpeed = 8
			pressedalready = true
			if rarm and larm then
				rt = rarm.Touched:connect(touched)
				lt = larm.Touched:connect(touched)
			end
		anim:Play()
		elseif pressedalready == true then
			ply.Humanoid.WalkSpeed = 16
			pressedalready = false
			anim:Stop()
			rt:disconnect()
			lt:disconnect()
		end
	end)
end)

tool.Unequipped:connect(function()
	anim:Stop()
	ply.Humanoid.WalkSpeed = 16
	if pressedalready == true then
	rt:disconnect()
	lt:disconnect()
	end
end)
