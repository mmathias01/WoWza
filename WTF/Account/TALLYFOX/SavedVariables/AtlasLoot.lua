
AtlasLootDB = {
	["namespaces"] = {
		["DefaultFrame"] = {
			["profiles"] = {
				["Jolokia - Dragonblight"] = {
					["module"] = "AtlasLootMoP",
					["NEWpoint"] = {
						nil, -- [1]
						nil, -- [2]
						"CENTER", -- [3]
						178.9999237060547, -- [4]
						123.0000076293945, -- [5]
					},
					["instance"] = "MoguShanVaults",
				},
				["Cellestia - Terenas"] = {
					["module"] = "AtlasLootMoP",
					["NEWpoint"] = {
						nil, -- [1]
						nil, -- [2]
						"CENTER", -- [3]
						26.99994468688965, -- [4]
						122, -- [5]
					},
					["instance"] = "MoguShanVaults",
				},
			},
		},
		["AtlasLootPanel"] = {
		},
		["WishList"] = {
			["global"] = {
				["data"] = {
					["Normal"] = {
						["Terenas"] = {
							["Cellestia"] = {
								{
									{
										{
											0, -- [1]
											86885, -- [2]
											"", -- [3]
											"=q4=Spirits of the Sun", -- [4]
											"=ds=#s14#", -- [5]
											"ToESTsulong#RaidFinder", -- [6]
										}, -- [1]
										{
											0, -- [1]
											86805, -- [2]
											"", -- [3]
											"=q4=Qin-xi's Polarizing Seal", -- [4]
											"=ds=#s14#", -- [5]
											"MSVWilloftheEmperor#RaidFinder", -- [6]
										}, -- [2]
									}, -- [1]
									["info"] = {
										["icon"] = "INTERFACE\\ICONS\\Ability_BackStab",
									},
								}, -- [1]
							},
						},
						["Dragonblight"] = {
							["Jolokia"] = {
								{
									{
										{
											0, -- [1]
											86885, -- [2]
											"", -- [3]
											"=q4=Spirits of the Sun", -- [4]
											"=ds=#s14#", -- [5]
											"ToESTsulong#RaidFinder", -- [6]
										}, -- [1]
										{
											0, -- [1]
											86865, -- [2]
											"", -- [3]
											"=q4=Kri'tak, Imperial Scepter of the Swarm", -- [4]
											"=ds=#h1#, #w6#", -- [5]
											"HoFShekzeer#RaidFinder", -- [6]
										}, -- [2]
										{
											0, -- [1]
											95639, -- [2]
											"", -- [3]
											"=q4=Drape of Booming Nights", -- [4]
											"=ds=#s4#", -- [5]
											"ToTJinrokh#RaidFinder", -- [6]
										}, -- [3]
									}, -- [1]
								}, -- [1]
							},
						},
					},
				},
			},
		},
		["Filter"] = {
			["profiles"] = {
				["Jolokia - Dragonblight"] = {
					["enable"] = true,
					["filterSlots"] = {
						["Stats"] = {
							["PARRY_RATING"] = false,
							["DODGE_RATING"] = false,
							["STRENGTH"] = false,
						},
						["Armor"] = {
							["#a2#"] = false,
							["#a1#"] = false,
							["#a4#"] = false,
						},
						["WeaponsMeeleTwoHand"] = {
							["#w10#"] = false,
						},
						["WeaponsMeele"] = {
							["#w7#"] = false,
							["#w10#"] = false,
						},
						["WeaponsRanged"] = {
							["#w3#"] = false,
							["#w2#"] = false,
							["#w5#"] = false,
							["#w12#"] = false,
						},
					},
				},
				["Cellestia - Terenas"] = {
					["filterSlots"] = {
						["Stats"] = {
							["PARRY_RATING"] = false,
							["DODGE_RATING"] = false,
							["RESILIENCE_RATING"] = false,
							["EXPERTISE_RATING"] = false,
							["STRENGTH"] = false,
							["AGILITY"] = false,
						},
						["Armor"] = {
							["#a2#"] = false,
							["#a4#"] = false,
							["#a1#"] = false,
						},
						["WeaponsMeeleTwoHand"] = {
							["#w10#"] = false,
						},
						["WeaponsRanged"] = {
							["#w3#"] = false,
							["#w2#"] = false,
							["#w5#"] = false,
							["#w12#"] = false,
						},
						["WeaponsMeele"] = {
							["#w7#"] = false,
							["#w10#"] = false,
						},
					},
					["enable"] = true,
				},
			},
		},
	},
	["showWarning"] = true,
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Jolokia - Dragonblight",
		["Ziagi - Terenas"] = "Ziagi - Terenas",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
	},
	["profiles"] = {
		["Jolokia - Dragonblight"] = {
			["UseGameTooltip"] = true,
		},
		["Ziagi - Terenas"] = {
		},
		["Shenlu - Dragonblight"] = {
		},
		["Jolokya - Dragonblight"] = {
		},
		["Jolobank - Dragonblight"] = {
		},
		["Cellestia - Terenas"] = {
			["LootTableType"] = "RaidFinder",
			["LastSearch"] = "firescri",
			["ShowPriceAndDesc"] = true,
			["ShowLootTablePrice"] = false,
			["CompareFrame"] = {
				["showExtraSort"] = false,
			},
		},
	},
}
