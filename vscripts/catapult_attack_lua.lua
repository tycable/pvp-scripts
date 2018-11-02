catapult_attack_lua=class({})
LinkLuaModifier( "modifier_catapult_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_catapult_attack_absorb", LUA_MODIFIER_MOTION_NONE )

function catapult_attack_lua:OnSpellStart( )
	self.bonus_damage=self:GetSpecialValueFor("bonus_damage")
	self.duration=self:GetSpecialValueFor("duration")

	EmitSoundOn( "Hero_TemplarAssassin.Refraction", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_catapult_attack", { duration = self.duration } )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_catapult_attack_absorb", { duration = self.duration } )

end


function teleport_1(params)
	local radius=params.ability:GetSpecialValueFor("radius")
	local duration=params.ability:GetSpecialValueFor("duration")
	local vision_radius=params.ability:GetSpecialValueFor("vision_radius")

	local endPos=params.target_points[1]
	local casterPos=params.caster:GetAbsOrigin()
	local direction=endPos-casterPos

	local targetTable=FindUnitsInRadius(params.caster:GetTeam(),casterPos,nil,radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,DOTA_UNIT_TARGET_HERO,0,0,false)

	for k,v in pairs(targetTable) do
		local startPos=v:GetAbsOrigin()
		local pos=startPos+direction
		local ent=Entities:CreateByClassname("prop_dynamic")
		ent:SetModel("models/heroes/monkey_king/transform_invisiblebox.vmdl")
		FindClearSpaceForUnit( ent, pos, true)
		local nFXIndex=ParticleManager:CreateParticle("particles/customgames/capturepoints/cp_wood.vpcf",PATTACH_ABSORIGIN,ent)
		AddFOWViewer(params.caster:GetTeam(),pos,vision_radius,duration,true)
		ent:SetContextThink("CreateParticle_Delay",function()
			ParticleManager:DestroyParticle(nFXIndex,false)
			ParticleManager:ReleaseParticleIndex(nFXIndex)
			ent:Destroy()
			FindClearSpaceForUnit( v, pos, true) return nil end,duration)
	end
end