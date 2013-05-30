
CliqueDB = nil
CliqueDB3 = {
	["char"] = {
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
		["Cellestia - Windrunner"] = "Cellestia - Windrunner",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Ziagi - Terenas"] = "Ziagi - Terenas",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
	},
	["profiles"] = {
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
	},
}
