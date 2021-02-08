-- Toc push for 7.3
-- AdiBags_fishing - Adds various lures,poles,hats and boots to filter out
-- Created by Frostanon character is Frost-Xavius please credit whenever.

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local N = addon.N
local MatchIDs
local Tooltip
local Result = {}

local function AddToSet(Set, List)
	for _, v in ipairs(List) do
		Set[v] = true
	end
end

local fishingpoles = {
	133755,		-- Underlight Angler - +60 fishskill and Teleport to pools
	180136,		-- The Brokers Angle'r - +15 fishskill and increased chance to find bait while fishing in shadowlands
	44050,		-- Mastercraft Kalu'ak Fishing Pole - +30 fishskill and Underwaterbreathing
	25978,		-- Seth's Graphite Fishing Pole - +20 fishskill
	19022,		-- Nat Pagle's Extreme Angler FC-5000 - +20 fishskill
	6367,		-- Big Iron Fishing Pole - +20 fishskill
	6366,		-- Darkwood Fishing Pole - +15 fishskill
	120163,		-- Thruk's Fishing Rod - +3 fishskill
	45858,		-- Nat's Lucky Fishing Pole - +25 fishskill
	19970,		-- Arcanite Fishing Pole - +40 fishskill
	84661,		-- Dragon Fishing Pole - +30 fishskill
	45991,		-- Bone Fishing Pole - +30 fishskill
	118381,		-- Ephemeral Fishing Pole - +100 fishskill
	45992,		-- Jeweled Fishing Pole - +30 fishskill
	46337,		-- Staats' Fishing Pole - +2 fishskill
	12225,		-- Blump Family Fishing Pole - +3 fishskill
	6365,		-- Strong Fishing Pole - +5 fishskill
	116826,		-- Draenic Fishing Pole - +30 fishskill and Lure +200
	84660,		-- Pandaren Fishing Pole - +10 fishskill
	116825,		-- Savage Fishing Pole - +30 fishskill and Lure +200
	6256,		-- Fishing Pole - Regular fishingpole
}

local hats = {
	117405,		-- Nat's Drinking Hat - +10 fishskill and Lure +150
	19972,		-- Lucky Fishing Hat - +5 fishskill
	19969,		-- Nat Pagle's Extreme Anglin' Boots - +5 fishskill
	33820,		-- Weather-Beaten Fishing Hat - +5 fishskill and Lure +75
	50287,		-- Boots of the Bay - +15 fishskill and Whisks you away to the finest drinking establishment in Booty Bay
	93732,		-- Darkmoon Fishing Cap - +5 fishskill and Summon a pool of shipwrecked debris
	88710,		-- Nat's Hat - +5 fishskill and Lure +150
	118393,		-- Tentacled Hat - +100 fishskill
	118380,		-- Hightfish Cap - +100 fishskill
}
local fishingETC = {
	88535,		-- Sharpenend Tuskarr Spear - +15 fishskill
	68796,		-- Reinforced Fishing Line - +1 fishskill
	34836,		-- Spun Truesilver Fishing Line - +3 fishskill
	19971,		-- High Test Eternium Fishing Line - +5 fishskill
	116117,		-- Rook's Lucky Fishin' Line - +4 fishskill
	34832,		-- Captain Rumsey's Lager - +10 fishskill
	19979,		-- Hook of the Master Angler - Turns you into a fish
	67404,		-- Glass Fishing Bobber - +15 fishskill
	6529,		-- Shiny Bauble - +25 fishskill
	6530,		-- Nightcrawlers - +50 fishskill
	6811,		-- Aquadynamic Fish Lens - +50 fishskill
	6532,		-- Bright Baubles - +75 fishskill
	7307,		-- Flesh Eating Worm - +75 fishskill
	6533,		-- Aquadynamic Fish Attractor - +100 fishskill
	62673,		-- Feathered Lure - +100 fishskill
	34861,		-- Sharpened Fish Hook - +100 fishskill
	46006,		-- Glow Worm - +100 fishskill
	68049,		-- Heat-Treated Spinning Lure - +150 fishskill
	133725,		-- Leyshimmer Blenny
	133726,		-- Nar'thalas Hermit
	133727,		-- Ghostly Queenfish
	133701,		-- Skrog Toenail
	133702,		-- Aromatic Murloc Slime
	133703,		-- Pearlescent Conch
	133704,		-- Rusty Queenfish Brooch
	133733,		-- Ancient Highmountain Salmon
	133732,		-- Coldriver Carp
	133731,		-- Mountain Puffer
	133709,		-- Funky Sea Snail
	133710,		-- Salmon Lure
	133712,		-- Frost Worm
	133711,		-- Swollen Murloc Egg
	133736,		-- Thundering Stormray
	133734,		-- Oodelfjisk
	133735,		-- Graybelly Lobster
	133713,		-- Moosehorn Hook
	133714,		-- Silverscale Minnow
	133715,		-- Ancient Vrykul Ring
	133716,		-- Soggy Drakescale
	133730,		-- Ancient Mossgill
	133728,		-- Terrorfin
	133729,		-- Thorned Flounder
	133705,		-- Rotten Fishbone
	133707,		-- Nightmare Nightcrawler
	133708,		-- Drowned Thistleleaf
	133739,		-- Tainted Runescale Koi
	133738,		-- Seerspine Puffer
	133737,		-- Magic-Eater Frog
	133720,		-- Demonic Detritus
	133719,		-- Sleeping Murloc
	139175,		-- Arcane Lure
	136376,		-- Murloc Bobber
	136375,		-- Squeaky Duck Bobber
	141975,		-- Mark of Aquaos
	138777,		-- Drowned Mana
	133717,		-- Enchanted Lure
	133741,		-- Seabottom Squid
	133740,		-- Axefish
	133742,		-- Ancient Black Barracuda
	133723,		-- Stunned, Angry Shark
	133721,		-- Message in a Beer Bottle
	133722,		-- Axefish Lure
	133724,		-- Decayed Whale Blubber
	133795,		-- Ravenous Fly
	128229,		-- Felmouth Frenzy Bait
	127994,		-- Felmouth Frenzy Lunker
	124674,		-- Day-Old Darkmoon Doughnut - +200 fishskill
	122742,		-- Bladebone Hook
	110294,		-- Blackwater Whiptail Bait
	110293,		-- Abyssal Gulper Eel Bait
	110292,		-- Sea Scorpion Bait
	110291,		-- Fire Ammonite Bait
	110290,		-- Blind Lake Sturgeon Bait
	110289,		-- Fat Sleeper Bait
	110274,		-- Jawless Skulker Bait
	146848,		-- Fragmented Enchantment
	180168,		-- Oribobber
	173038,		-- Lost Sole Bait
	173043,		-- Elysian Thade Bait
	173040,		-- Silvergill Pike Bait
	173041,		-- Pocked Bonefish Bait
	173039,		-- Iridescent Amberjack Bait
	173042,		-- Spinefin Piranha Bait
}

local function MatchIDs_Init(self)
	wipe(Result)

	AddToSet(Result, fishingpoles)

	if self.db.profile.movehats then
		AddToSet(Result, hats)
	end

	if self.db.profile.movefishingETC then
		AddToSet(Result, fishingETC)
	end

	return Result
 end

local function Tooltip_Init()
	local tip, leftside = CreateFrame("GameTooltip"), {}
	for i = 1, 6 do
		local Left, Right = tip:CreateFontString(), tip:CreateFontString()
		Left:SetFontObject(GameFontNormal)
		Right:SetFontObject(GameFontNormal)
		tip:AddFontStrings(Left, Right)
		leftside[i] = Left
	end
	tip.leftside = leftside
	return tip
end

local setFilter = AdiBags:RegisterFilter("Fishing items", 100, "ABEvent-1.0")
setFilter.uiName = N["Fishing Settings"]
setFilter.uiDesc = N["Hats and fishing Accessories settings."]

function setFilter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace("Fishing Tools", {
		profile = {
			movehats = true,
			movefishingETC = true,
		}
	})
end

function setFilter:Update()
	MatchIDs = nil
	self:SendMessage("AdiBags_FiltersChanged")
end

function setFilter:OnEnable()
	AdiBags:UpdateFilters()
end

function setFilter:OnDisable()
	AdiBags:UpdateFilters()
end

function setFilter:Filter(slotData)
	MatchIDs = MatchIDs or MatchIDs_Init(self)
	if MatchIDs[slotData.itemId] then
		return N["Fishing Tools"]
	end

	Tooltip = Tooltip or Tooltip_Init()
	Tooltip:SetOwner(UIParent,"ANCHOR_NONE")
	Tooltip:ClearLines()

	if slotData.bag == BANK_CONTAINER then
		Tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
	else
		Tooltip:SetBagItem(slotData.bag, slotData.slot)
	end

	Tooltip:Hide()
end

function setFilter:GetOptions()
	return {
		movehats = {
			name  = N["Hats"],
			desc  = N["Show Hats in this group."],
			type  = "toggle",
			order = 20
		},
		movefishingETC = {
			name  = N["Fishing Accessories"],
			desc  = N["Show Fishing Accessories in this group."],
			type  = "toggle",
			order = 20
		},
	},
	AdiBags:GetOptionHandler(self, false, function()
		return self:Update()
	end)
end
