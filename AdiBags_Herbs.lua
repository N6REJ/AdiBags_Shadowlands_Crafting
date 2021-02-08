-- AdiBags_Herbs - Adds Herbs for shadowlands.
-- Created by N6REJ character is Bearesquishy - dalaran please credit whenever.

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

local herbs = {
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

local function MatchIDs_Init(self)
	wipe(Result)

	AddToSet(Result, herbs)

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

local setFilter = AdiBags:RegisterFilter("Herbs", 100, "ABEvent-1.0")

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
