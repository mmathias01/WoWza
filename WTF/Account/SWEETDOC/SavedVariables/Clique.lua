
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
			["specswap"] = false,
			["downclick"] = false,
		},
	},
	["profileKeys"] = {
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Jolokia - Dragonblight"] = "Jolokia - Dragonblight",
		["Ziagi - Terenas"] = "Ziagi - Terenas",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
		["Majandra - Darrowmere"] = "Majandra - Darrowmere",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra - Dragonblight",
		["Cellestia - Windrunner"] = "Cellestia - Windrunner",
	},
	["profiles"] = {
		["Jolokya - Dragonblight"] = {
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
		["Jolokia - Dragonblight"] = {
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
		["Ziagi - Terenas"] = {
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
		["Cellestia - Terenas"] = {
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
		["Majandra - Darrowmere"] = {
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
		["Jolobank - Dragonblight"] = {
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
		["Majandra - Dragonblight"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
						["ooc"] = true,
					},
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
					["spell"] = "Halo",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_priest_halo",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Dispel Magic",
					["key"] = "BUTTON3",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_NullifyDisease",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Divine Star",
					["key"] = "BUTTON2",
					["sets"] = {
					},
					["icon"] = "Interface\\Icons\\spell_priest_divinestar",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Purify",
					["key"] = "BUTTON3",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Cascade",
					["key"] = "BUTTON2",
					["sets"] = {
					},
					["icon"] = "Interface\\Icons\\ability_priest_cascade",
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
		["Cellestia - Windrunner"] = {
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
