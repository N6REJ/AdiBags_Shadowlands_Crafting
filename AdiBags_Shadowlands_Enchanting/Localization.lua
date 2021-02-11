-- AdiBags_Shadowlands_Enchanting - Adds Enchanting for shadowlands.
-- Created by N6REJ character is Bearesquishy - dalaran please credit whenever.
-- Source on GitHub: https://github.com/N6REJ/AdiBags_Shadowlands_Crafting

local addonName, addon = ...

local N = setmetatable({}, {
	__index = function(self, key)
		if key then
			rawset(self, key, tostring(key))
		end
		return tostring(key)
	end,
})
addon.N = N

local locale = GetLocale()

if locale == "ruRU" then
--Translation missing

elseif locale == "deDE" then
--Translation missing

elseif locale == "itIT" then
--Translation missing

elseif locale == "frFR" then
--Translation missing

elseif locale == "koKR" then
--Translation missing

elseif locale == "zhCN" then
--Translation missing

elseif locale == "ptBR" then
--Translation missing

elseif locale == "zhTW" then
--Translation missing

elseif locale == "esES" then
--Translation missing

elseif locale == "esMX" then
--Translation missing


else
-- enUS default
N["Herbs"] = true
end

-- values by their key
for k,v in pairs(N) do
	if v == true then
		N[k] = k
	end
end
