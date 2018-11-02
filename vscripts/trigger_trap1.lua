function OnStartTouch(kv)
	local hero=kv.activator
	GameRules:SendCustomMessage("<font size='3' color='red'>你已进入陷阱，快离开！</font>",hero:GetTeam(),0)	
	hero.trigger_trap1_flag=.5	
	hero:SetContextThink("trigger_trap1_OnStartTouch",function() 
		local damageTable={
			victim=hero,
			attacker=hero,
			damage=hero:GetMaxHealth()*0.05,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_HPLOSS, --Optional.
			ability = nil, --Optional.
		}
		ApplyDamage(damageTable)
		hero:AddNewModifier(nil, nil, "modifier_stunned", {duration=.1})
		return hero.trigger_trap1_flag end,0)			
end

function OnEndTouch(kv)
	local hero=kv.activator
	hero.trigger_trap1_flag=nil
end