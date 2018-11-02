-- Generated from template

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

function Precache( context )
	--PrecacheItemByNameSync( "npc_dota_hero_arc_warden", context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_announcer_dlc_lina.vsndevts", context )
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )		
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() ==	DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		GameRules:FinishCustomGameSetup()
		GameRules:SetStrategyTime( 0 )
		GameRules:SetShowcaseTime( 0 )
	elseif GameRules:State_Get() ==	DOTA_GAMERULES_STATE_HERO_SELECTION then
		if not PlayerResource:HasSelectedHero(0) then
			local player=PlayerResource:GetPlayer(0)
			if player then
				Tutorial:SelectHero("npc_dota_hero_templar_assassin")
			end
		end
	elseif GameRules:State_Get() ==	DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	
	
	return 1
end