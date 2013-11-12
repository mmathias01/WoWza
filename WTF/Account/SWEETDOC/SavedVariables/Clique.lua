
CliqueDB = nil
CliqueDB3 = {
	["char"] = {
		["Majandra - Dragonblight"] = {
			["sec_profileKey"] = "Majandra - Dragonblight",
			["fastooc"] = false,
			["blacklist"] = {
				["ElvUF_Player"] = true,
				["ElvUF_Target"] = true,
			},
			["alerthidden"] = true,
			["downclick"] = false,
			["pri_profileKey"] = "Majandra - Dragonblight",
			["specswap"] = false,
		},
		["Cellestia - Terenas"] = {
			["alerthidden"] = true,
			["sec_profileKey"] = "Cellestia - Terenas",
			["pri_profileKey"] = "Cellestia - Terenas",
			["fastooc"] = false,
			["downclick"] = false,
			["specswap"] = false,
		},
	},
	["profileKeys"] = {
		["Cellestia - Windrunner"] = "Cellestia - Windrunner",
		["Jolokia - Dragonblight"] = "Jolokia - Dragonblight",
		["Ziagi - Terenas"] = "Ziagi - Terenas",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Majandra - Darrowmere"] = "Majandra - Darrowmere",
	},
	["profiles"] = {
		["Cellestia - Windrunner"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Jolokia - Dragonblight"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Ziagi - Terenas"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Cellestia - Terenas"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["macrotext"] = "#showtooltip Greater Healing Wave\n/cast Ancestral Swiftness\n/cast [@mouseover] Greater Healing Wave",
					["type"] = "macro",
					["key"] = "ALT-BUTTON1",
					["sets"] = {
						["pritalent"] = true,
						["friend"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Chain Heal",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["pritalent"] = true,
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_HealingWaveGreater",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Healing Wave",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["pritalent"] = true,
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_MagicImmunity",
					["type"] = "spell",
				}, -- [4]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
					},
				}, -- [5]
			},
		},
		["Jolokya - Dragonblight"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Majandra - Dragonblight"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
						["ooc"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["spell"] = "Leap of Faith",
					["key"] = "BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\priest_spell_leapoffaith_a",
					["type"] = "spell",
				}, -- [2]
				{
					["spell"] = "Divine Star",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_divinestar",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Halo",
					["key"] = "BUTTON2",
					["sets"] = {
					},
					["icon"] = "Interface\\Icons\\ability_priest_halo",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Purify",
					["key"] = "BUTTON3",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Cascade",
					["key"] = "BUTTON2",
					["sets"] = {
					},
					["icon"] = "Interface\\Icons\\ability_priest_cascade",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Dispel Magic",
					["key"] = "BUTTON3",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_NullifyDisease",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Prayer of Mending",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					["type"] = "spell",
				}, -- [8]
			},
		},
		["Jolobank - Dragonblight"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Majandra - Darrowmere"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
	},
}
