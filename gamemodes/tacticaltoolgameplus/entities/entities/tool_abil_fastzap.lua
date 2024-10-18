ENT.Type 	= "point"
ENT.Base 	= "base_ttgabil"


if !SERVER then return end
------------------------------------------------------------------------------------------------
--all server from now on
------------------------------------------------------------------------------------------------





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
if not IsValid(self.Owner) then return end
if self.Cooldown == true then
	self:CooldownSound()
return
end 
    

    
	if self.Owner:HowManyOfThisBuff( "Buff_Invis" ) > 0 then
		self:CooldownSound()
	return 
	end
	 
    
self.BuffSlot = self.Owner:AddBuff( "Buff_Invis" )


//ability code
self.Owner:SetNoDraw(true)
EmitSound( Sound( "skills/invisibility_start.wav" ), self.Owner:GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
self.Owner:GetActiveWeapon():SetNoDraw(true)
showname = false
	self:InitiateCooldown()
    local smoke = ents.Create("env_smokestack")
    smoke:SetPos(self.Owner:GetPos())
    smoke:SetKeyValue("InitialState", "1")
    smoke:SetKeyValue("WindAngle", "0 0 0")
    smoke:SetKeyValue("WindSpeed", "0")
    smoke:SetKeyValue("SmokeMaterial", "particle/particle_smokegrenade")
    smoke:SetKeyValue("BaseSpread", "5")
    smoke:SetKeyValue("SpreadSpeed", "10")
    smoke:SetKeyValue("Speed", "50")
    smoke:SetKeyValue("StartSize", "50")
    smoke:SetKeyValue("EndSize", "100")
    smoke:SetKeyValue("Rate", "100")
    smoke:SetKeyValue("JetLength", "50")
    smoke:Spawn()
    smoke:Activate()


	local alpha = 255
    timer.Create("SmokeFade", 0.1, 25, function()
        if IsValid(smoke) then
            smoke:SetColor(Color(255, 255, 255, alpha))
            alpha = alpha - 15
			smoke:Fire("kill", "", 1.7)
        else
            timer.Remove("SmokeFade")
        end
    end)
timer.Create( "InvisTime", 7, 0, function()
        
    
        EmitSound( Sound( "skills/invisibility_stop.wav" ), self.Owner:GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
		self.Owner:SetNoDraw(false)
		self.Owner:GetActiveWeapon():SetNoDraw(false)      
        self.Owner:RemoveBuff_BySlot(self.BuffSlot)
        timer.Simple(0.1, function()      
            hook.Remove( "Tick", "InvisRemoval" )
            hook.Remove( "EntityTakeDamage", "CheckPlayerDamage" )
            timer.Remove( "InvisTime" )
        end)

		showname = true

end )






  
        hook.Add( "PlayerDeath", "WTF", function( victim, inflictor, attacker )
            if IsValid(self.Owner) then
                if ( victim == self.Owner ) then
                    EmitSound( Sound( "skills/invisibility_stop.wav" ), self.Owner:GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
                    hook.Remove( "Tick", "InvisRemoval" )
                    -- hook.Remove( "EntityTakeDamage", "CheckPlayerDamage" )
                    timer.Remove( "InvisTime" )
                    timer.Simple(0.1, function()
                    hook.Remove( "PlayerDeath", "WTF" )                
                    end)
                end
            end
        end )

       
        hook.Add( "Tick", "InvisRemoval", function()
            if not IsValid(self.Owner) then return end    
            if ( self.Owner:KeyDown( IN_ATTACK ) ) then
                EmitSound( Sound( "skills/invisibility_stop.wav" ), self.Owner:GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
                    self.Owner:SetNoDraw(false)
                    self.Owner:GetActiveWeapon():SetNoDraw(false)
                    self.Owner:RemoveBuff_BySlot(self.BuffSlot)
                    showname = true
                    timer.Simple(0.1, function()      
                        hook.Remove( "Tick", "InvisRemoval" )
                        -- hook.Remove( "EntityTakeDamage", "stinkyroom" )
                        timer.Remove( "InvisTime" )
                    end)
            
            end
        end )
            -- hook.Add( "EntityTakeDamage", "stinkyroom", function()
            --     -- self.Owner:SetNoDraw(false)
            --     -- EmitSound( Sound( "skills/invisibility_stop.wav" ), self.Owner:GetPos(), 1, CHAN_AUTO, 1, 75, 0, 100 )
            --     --         self.Owner:GetActiveWeapon():SetNoDraw(false)
            --     --         self.Owner:RemoveBuff_BySlot(self.BuffSlot)
            --     --         showname = true
            --     --         timer.Simple(0.1, function()
            --     --             hook.Remove( "EntityTakeDamage", "stinkyroom" )
            --     --             hook.Remove( "Tick", "InvisRemoval" )
            --     --             timer.Remove( "InvisTime" )
            --     --         end)
            -- end )
            hook.Add("PlayerSpawn", "RemoveShitOnSpawn", function(ply)
                hook.Remove( "PlayerDeath", "WTF" )    
                hook.Remove( "Tick", "InvisRemoval" )
                -- hook.Remove( "EntityTakeDamage", "stinkyroom" )
                timer.Remove( "InvisTime" )
            end)
        end






