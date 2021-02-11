-- AdiBags_Shadowlands_Herbs - Adds Herbs for shadowlands.
-- Created by N6REJ character is Bearesquishy - dalaran please credit whenever.
-- Source on GitHub: https://github.com/N6REJ/AdiBags_Shadowlands_Crafting

local addonName, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

local N = addon.N
local MatchIDs
local Tooltip
local Result = {}
local FilterName = "Skinning" -- Filter title to display in bag

local function AddToSet(Set, List)
	for _, v in ipairs(List) do
		Set[v] = true
	end
end

local database = {
	172439,	-- Enchanted Lightless Silk
	173202,	-- Shrouded Cloth
	173204,	-- Lightless Silk
	177062,	-- Penumbra Thread
	182028,	-- Bleakthread
	182050,	-- Prideweave Cloth
	182052,	-- Thread of pride
	182103,	-- Gossamer Cloth
	338270,	-- Ardensilk Cloth
	338277,	-- Bleakcloth
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

local setFilter = AdiBags:RegisterFilter(FilterName, 100, "ABEvent-1.0")

function setFilter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace(FilterName)
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
		return N[FilterName]
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
