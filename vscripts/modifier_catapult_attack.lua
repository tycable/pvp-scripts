modifier_catapult_attack=class({})

function modifier_catapult_attack:DeclareFunctions()
	local funcs={
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK,
	}
	return funcs
end

function modifier_catapult_attack:OnRefresh( kv )
	self.bonus_damage=self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.duration=self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_catapult_attack:OnAttack(kv)
	local caster=self:GetCaster()
	if kv.attacker==caster then
		self:DecrementStackCount()
	end
	if caster and self:GetStackCount() ==0 then
		caster:RemoveModifierByName("modifier_catapult_attack")
	end
end


function modifier_catapult_attack:OnCreated( kv )
	self:SetStackCount(5)
	self.bonus_damage=self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.duration=self:GetAbility():GetSpecialValueFor("duration")
end

function modifier_catapult_attack:GetModifierPreAttack_BonusDamage( params )	
	return self.bonus_damage
end

function modifier_catapult_attack:GetModifierMoveSpeedBonus_Percentage(params)
	return 100
end

function modifier_catapult_attack:GetModifierAttackSpeedBonus_Constant(params)
	return 100
end