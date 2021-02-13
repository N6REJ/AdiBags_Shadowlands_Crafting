-- AdiBags_Shadowlands_Crafting
-- Created by N6REJ character is Bearesquishy - dalaran please credit whenever.
-- Source on GitHub: https://github.com/N6REJ/AdiBags_Shadowlands_Crafting


local ADDON_NAME, addon = ...

-- Get reference to AdiBags addon
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

-- Addon info
local FilterTitle = slc_meat.FilterTitle
local database = slc_meat.database
local version = GetAddOnMetadata(ADDON_NAME, "Version");
local addoninfo = 'Shadowlands Crafting - ' .. FilterTitle;

local N = addon.N
local MatchIDs
local Tooltip
local Result = {}

-- Register this addon with AdiBags
local setFilter = AdiBags:RegisterFilter(ADDON_NAME, 100, "ABEvent-1.0")
setFilter.uiName = N[addoninfo]
setFilter.uiDesc = N["Puts base " .. FilterTitle .. " crafting mats from drops or farming in their own group" .. "     Version: " .. version]

-- ??
local function AddToSet(Set, List)
	for _, v in ipairs(List) do
		Set[v] = true
	end
end

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

function setFilter:OnInitialize()
	self.db = AdiBags.db:RegisterNamespace(ADDON_NAME)
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
		return FilterTitle
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
