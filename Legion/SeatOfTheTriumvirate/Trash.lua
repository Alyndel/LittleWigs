--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Seat of the Triumvirate Trash", 1753)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	125836, -- Alleria Windrunner
	124171, -- Shadowguard Subjugator
	122404, -- Shadowguard Voidbender
	122405, -- Shadowguard Conjurer
	122423 -- Grand Shadow-Weaver
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = CL.autotalk
	L.custom_on_autotalk_desc = "Instantly selects Alleria Winrunner's gossip option."
	L.custom_on_autotalk_icon = mod:GetMenuIcon("SAY")
	L.gossip_available = "Gossip available"
	L.alleria_gossip_trigger = "Follow me!" -- Allerias yell after the first boss is defeated

	L.alleria = "Alleria Windrunner"
	L.subjugator = "Shadowguard Subjugator"
	L.voidbender = "Shadowguard Voidbender"
	L.conjurer = "Shadowguard Conjurer"
	L.weaver = "Grand Shadow-Weaver"
end

--------------------------------------------------------------------------------
-- Initialization
--

local matterMarker = mod:AddMarkerOption(true, "npc", 8, 248227, 8) -- Unstable Dark Matter
function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"warmup",
		{249081, "SAY"}, -- Suppression Field
		{245510, "SAY"}, -- Corrupting Void
		249078, -- Void Diffusion
		{248227, "CASTBAR"}, -- Dark Matter
		matterMarker,
	}, {
		["custom_on_autotalk"] = L.alleria,
		[249081] = L.subjugator,
		[245510] = L.voidbender,
		[249078] = L.conjurer,
		[248227] = L.weaver,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Log("SPELL_AURA_APPLIED", "SuppressionFieldApplied", 249081)
	self:Log("SPELL_AURA_APPLIED", "CorruptingVoidApplied", 245510)
	self:Log("SPELL_CAST_START", "VoidDiffusionCast", 249078)
	self:Log("SPELL_CAST_START", "DarkMatterCast", 248227)
	self:Log("SPELL_CAST_START", "CollapseCast", 248228)

	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.alleria_gossip_trigger then
		self:Bar("warmup", 38, L.gossip_available, L.custom_on_autotalk_icon)
	end
end

function mod:SuppressionFieldApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
		self:Say(args.spellId, nil, nil, "Suppression Field")
	end
end

function mod:CorruptingVoidApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "blue", "alarm")
		self:Say(args.spellId, nil, nil, "Corrupting Void")
	end
end

function mod:VoidDiffusionCast(args)
	self:MessageOld(args.spellId, "yellow", self:Interrupter() and "info", CL.casting:format(args.spellName))
end

function mod:DarkMatterCast(args)
	self:MessageOld(args.spellId, "red", "warning", CL.casting:format(args.spellName))
	if self:GetOption(matterMarker) then
		self:RegisterTargetEvents("MarkMatter")
	end
end

function mod:MarkMatter(_, unit, guid)
	if self:MobId(guid) == 124964 then -- Unstable Dark Matter
		self:CustomIcon(matterMarker, unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:CollapseCast(args)
	self:CastBar(248227, 4.9, args.spellId)
end

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(self:UnitGUID("npc")) == 125836 then
		if self:GetGossipOptions() then
			self:SelectGossipOption(1)
		end
	end
end
