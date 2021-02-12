-- AdiBags_Shadowlands_Skinning - Adds skinning for shadowlands.
-- Created by N6REJ character is Bearesquishy - dalaran please credit whenever.
-- Source on GitHub: https://github.com/N6REJ/AdiBags_Shadowlands_Crafting

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local N = addon.N
local MatchIDs
local Tooltip
local Result = {}
local FilterTitle = "Skinning" -- Filter title to display in bag

local function AddToSet(Set, List)
	for _, v in ipairs(List) do
		Set[v] = true
	end
end

local database = {
	172089,	-- Desolate Leather
	172092,	-- Pallid Bone
	172094,	-- Callous Hide
	172096,	-- Heavy Desolate Leather
	172097,	-- Heavy Callous Hide
	172438,	-- Enchanted Heavy Callous Hide
	177279,	-- Gaunt Sinew
	178787,	-- Orboreal Shard
}

local function MatchIDs_Init(self)
	wipe(Result)

	AddToSet(Result, database)

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

local setFilter = AdiBags:RegisterFilter(FilterTitle, 100, "ABEvent-1.0")

function setFilter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace(FilterTitle)
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
		return N[FilterTitle]
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
