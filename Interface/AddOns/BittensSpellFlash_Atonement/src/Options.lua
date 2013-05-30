local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
	HealPercent = {
		Type = "editbox",
		Widget = "LeftEditBox1",
		Label = L["Prioritize healing under % health:"],
		MaxCharacters = 2,
		Numeric = true,
		Default = 90,
	},
	OnlyHealPercent = {
		Type = "editbox",
		Widget = "LeftEditBox2",
		Label = L["Healing only under % mana:"],
		MaxCharacters = 3,
		Numeric = true,
		Default = 25,
	},
	ConservePercent = {
		Type = "editbox",
		Widget = "RightEditBox1",
		Label = L["Mana-conscious rotation under % mana:"],
		MaxCharacters = 3,
		Numeric = true,
		Default = 50,
	},
}

c.RegisterAddon()
