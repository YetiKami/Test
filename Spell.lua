local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fireballSpell = ReplicatedStorage:WaitForChild("FireballSpell")

-- Here you set your fireballs Speed
local FireballSpeed = 100 

-- Here you set your fireballs Damage
local FireballDamage = 10

fireballSpell.OnServerEvent:Connect(function(player, fireball)
	
	print("UwU") -- This is a Test print
	
	-- Create the fireball
	local fireballClone = fireball:Clone()
	fireballClone.Parent = game.Workspace
	fireballClone.CanCollide = false
	
	-- Setting a HitCheck variable so the enemy doesnt take damage multiple times
	local HitCheck = false
	
	-- Set the position
	local HumanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
	fireballClone.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
	
	wait() -- This is here so it has time to spawn in at the correct position otherwise it starts moving before even spawning
	
	-- Set the Speed and Direction
	local fireVelocity = Instance.new("BodyVelocity", fireballClone)
	fireVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	fireVelocity.Velocity = HumanoidRootPart.CFrame.LookVector * FireballSpeed
	--fireballClone.Velocity = HumanoidRootPart.CFrame.LookVector * FireballSpeed
	
	-- Make the fireball deal damage or explode against a structure
	fireballClone.Touched:Connect (function(hit)
		
		-- Checking if the thing hit by the fireball is an enemy
		local enemy = hit.Parent:FindFirstChild("Humanoid")
		if enemy then
			
			-- Avoiding the player who casts to get damaged
			if enemy == player.Character:WaitForChild("Humanoid") then
				return	
					
			-- Dealing Damage to the enemy
			else 
				if HitCheck == false then
					hit.Parent:FindFirstChild("Humanoid"):TakeDamage(FireballDamage)
					HitCheck = true
				end
	
				--fireballClone:Destroy()  /// THIS COULD BE ONE WAY TO IT IF U WANT THE SPEEL TO HIT ONLY ONE ENNEMY
				
			end
			
		-- Make the part explode when it hits an object in the workspace
		elseif hit.Parent == workspace then
			print("UwU")
			fireballClone:Destroy()
		end
	end)
end)
