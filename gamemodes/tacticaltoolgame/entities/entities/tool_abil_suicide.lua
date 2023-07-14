ENT.Type 	= "point"
ENT.Base 	= "base_ttgabil"


if !SERVER then return end
------------------------------------------------------------------------------------------------
--all server from now on
------------------------------------------------------------------------------------------------

ENT.Step = 1
ENT.Cancel = false

function ENT:DoAbility()
	if self.Cooldown == true then
		self:CooldownSound()
	return 
	end
	if GetTeamRole( self.Owner:Team() ) == "Attacking" then
		if G_CurrentPhase == "GameSetup" then
			return 
		elseif G_CurrentPhase == "DefendersBuy" then
			return 
		elseif G_CurrentPhase == "AttackersBuy" then
			return 
		elseif G_CurrentPhase == "Planning" then
			return 
		elseif G_CurrentPhase == "Setup" then
			return 
		end
	end
	if self.Step == 1 then
		self.Owner:EmitSound( self.Ref.sound_charge )
		self.Step = 2
		self.Cancel = false
		
		timer.Simple( self.Ref.charge_time, function()
			if not IsValid(self) then return end
			if self.Cancel == true then 
			self.Owner:StopSound( self.Ref.sound_charge )
			self.Owner:EmitSound( self.Ref.sound_cancel )
			return 
			end
			
			self:Explode( )
				
			self:InitiateCooldown()
		end)
		
	elseif self.Step == 2 then
		self.Owner:EmitSound( self.Ref.sound_charge )
		self.Cancel = false
		self.Step = 1
		
		

	timer.Simple( self.Ref.charge_time, function()
		if not IsValid(self) then return end
		if self.Cancel == true then 
		self.Owner:StopSound( self.Ref.sound_charge )
		self.Owner:EmitSound( self.Ref.sound_cancel )
		return 
		end
		
		self:Explode( )
			
		self:InitiateCooldown()

	end)
end
end



function ENT:Explode( )
	local explosion = ents.Create( "env_explosion" )		///create an explosion and delete the prop
		explosion:SetPos( self.Owner:GetPos() + Vector(0,0,50) )
		explosion:SetOwner( self.Owner )
		explosion:Spawn()
		explosion:SetKeyValue( "iRadiusOverride", self.Ref.iradiusoverride )
		explosion:SetKeyValue( "iMagnitude", self.Ref.imagnitude )
		explosion:SetKeyValue("spawnflags","64")
		explosion:Fire( "Explode", 0, 0 )

		
	self.Owner:EmitSound( self.Ref.sound_explode )
	


end