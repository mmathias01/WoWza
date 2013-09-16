
PawnCommon = {
	["ShowUpgradesOnTooltips"] = true,
	["ShowSpace"] = true,
	["AlignNumbersRight"] = false,
	["ShowItemID"] = false,
	["ShowValuesForUpgradesOnly"] = false,
	["Debug"] = false,
	["ShowReforgingAdvisor"] = true,
	["ColorTooltipBorder"] = true,
	["ShowTooltipIcons"] = false,
	["ShowLootUpgradeAdvisor"] = true,
	["ShowSocketingAdvisor"] = true,
	["Scales"] = {
		["\"Wowhead\":ShamanEnhancement"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "ff2800",
			["LocalizedName"] = "Shaman: enhancement",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf1e00",
		},
		["\"Wowhead\":DeathKnightUnholyDps"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "ff4d6b",
			["LocalizedName"] = "DK: unholy",
			["DoNotShow1HUpgrades"] = true,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf3950",
		},
		["\"Wowhead\":RogueAssassination"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "fff569",
			["LocalizedName"] = "Rogue: assassination",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bfb74e",
		},
		["\"Wowhead\":WarriorArms"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "c79c6e",
			["LocalizedName"] = "Warrior: arms",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "957552",
		},
		["\"Wowhead\":WarlockDestruction"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "bca5ff",
			["LocalizedName"] = "Warlock: destruction",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "8d7bbf",
		},
		["\"Wowhead\":MonkMistweaver"] = {
			["PerCharacterOptions"] = {
				["Shenlu-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							0.490368202877347, -- [1]
							61937, -- [2]
							84, -- [3]
						},
						["INVTYPE_FEET"] = {
							0.4889051450865642, -- [1]
							65961, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							2.196049743964887, -- [1]
							5201, -- [2]
							0, -- [3]
						},
						["INVTYPE_HAND"] = {
							0.000243842965130456, -- [1]
							58925, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							0.6108266276517922, -- [1]
							51964, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							0.5379175810777859, -- [1]
							62039, -- [2]
							84, -- [3]
						},
						["INVTYPE_LEGS"] = {
							1.075591319190441, -- [1]
							62026, -- [2]
							84, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							0.000975371860521824, -- [1]
							42952, -- [2]
							79, -- [3]
						},
						["INVTYPE_CHEST"] = {
							0.002682272616435016, -- [1]
							48689, -- [2]
							79, -- [3]
						},
					},
				},
				["Ziagi-Terenas"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "00ff96",
			["LocalizedName"] = "Monk: mistweaver",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "00bf70",
		},
		["\"Wowhead\":PaladinTank"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "f58cba",
			["LocalizedName"] = "Paladin: tank",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "b7698b",
		},
		["\"Wowhead\":HunterBeastMastery"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "abd473",
			["LocalizedName"] = "Hunter: beast mastery",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "809f56",
		},
		["Resto: Crit (Non Capped)"] = {
			["NormalizationFactor"] = 1,
			["Values"] = {
				["IsOffHand"] = -1000000,
				["CritRating"] = 45,
				["HasteRating"] = 60,
				["MasteryRating"] = 40,
				["IsCrossbow"] = -1000000,
				["MetaSocketEffect"] = 16000,
				["IsPolearm"] = -1000000,
				["IsGun"] = -1000000,
				["IsWand"] = -1000000,
				["IsBow"] = -1000000,
				["IsPlate"] = -1000000,
				["Intellect"] = 100,
				["Is2HSword"] = -1000000,
				["SpellPower"] = 75,
				["Spirit"] = 65,
				["IsSword"] = -1000000,
			},
			["UpgradesFollowSpecialization"] = true,
			["Color"] = "00ff80",
			["PerCharacterOptions"] = {
				["Jolokia-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							611.4675324675325, -- [1]
							86691, -- [2]
							0, -- [3]
						},
						["INVTYPE_FEET"] = {
							491.2207792207792, -- [1]
							95222, -- [2]
							0, -- [3]
						},
						["INVTYPE_LEGS"] = {
							773.5064935064935, -- [1]
							95323, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							259.7402597402597, -- [1]
							86748, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							1884.532467532468, -- [1]
							86893, -- [2]
							0, -- [3]
						},
						["INVTYPE_FINGER"] = {
							410.2987012987013, -- [1]
							95139, -- [2]
							0, -- [3]
							391.7402597402598, -- [4]
							95514, -- [5]
							0, -- [6]
						},
						["INVTYPE_HAND"] = {
							577.8441558441558, -- [1]
							95311, -- [2]
							0, -- [3]
						},
						["INVTYPE_WRIST"] = {
							417.0649350649351, -- [1]
							94767, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							492.077922077922, -- [1]
							95714, -- [2]
							0, -- [3]
						},
						["INVTYPE_NECK"] = {
							390.8441558441559, -- [1]
							95145, -- [2]
							0, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							473.8961038961039, -- [1]
							95695, -- [2]
							0, -- [3]
						},
						["INVTYPE_CHEST"] = {
							634.7012987012987, -- [1]
							89834, -- [2]
							0, -- [3]
						},
						["INVTYPE_WEAPONMAINHAND"] = {
							1457.883116883117, -- [1]
							86862, -- [2]
							0, -- [3]
						},
					},
				},
			},
		},
		["\"Wowhead\":PaladinHoly"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "f58cba",
			["LocalizedName"] = "Paladin: holy",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "b7698b",
		},
		["\"Wowhead\":RogueCombat"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "fff569",
			["LocalizedName"] = "Rogue: combat",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bfb74e",
		},
		["\"Wowhead\":PriestDiscipline"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "e0e0e0",
			["LocalizedName"] = "Priest: discipline",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "a8a8a8",
		},
		["\"Wowhead\":DeathKnightBloodTank"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "ff4d6b",
			["LocalizedName"] = "DK: blood",
			["DoNotShow1HUpgrades"] = true,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf3950",
		},
		["\"Wowhead\":MageFrost"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "69ccf0",
			["LocalizedName"] = "Mage: frost",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "4e99b3",
		},
		["Ele: Below Hit Cap"] = {
			["NormalizationFactor"] = 1,
			["Values"] = {
				["IsOffHand"] = -1000000,
				["CritRating"] = 139,
				["IsPlate"] = -1000000,
				["HasteRating"] = 165,
				["MasteryRating"] = 146,
				["IsCrossbow"] = -1000000,
				["MetaSocketEffect"] = 16000,
				["IsPolearm"] = -1000000,
				["IsGun"] = -1000000,
				["IsBow"] = -1000000,
				["IsSword"] = -1000000,
				["IsWand"] = -1000000,
				["HitRating"] = 180,
				["Is2HSword"] = -1000000,
				["SpellPower"] = 312,
				["Spirit"] = 180,
				["Intellect"] = 374,
			},
			["UpgradesFollowSpecialization"] = true,
			["Color"] = "6e95ff",
			["PerCharacterOptions"] = {
				["Jolokia-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							496.8262032085562, -- [1]
							86691, -- [2]
							0, -- [3]
						},
						["INVTYPE_FEET"] = {
							445.0133689839572, -- [1]
							95222, -- [2]
							0, -- [3]
						},
						["INVTYPE_LEGS"] = {
							656.6183155080214, -- [1]
							95323, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							225.1430481283423, -- [1]
							86748, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							1883.465909090909, -- [1]
							86893, -- [2]
							0, -- [3]
						},
						["INVTYPE_FINGER"] = {
							350.4157754010695, -- [1]
							95139, -- [2]
							0, -- [3]
							343.3529411764706, -- [4]
							95514, -- [5]
							0, -- [6]
						},
						["INVTYPE_HAND"] = {
							493.7513368983957, -- [1]
							95311, -- [2]
							0, -- [3]
						},
						["INVTYPE_WRIST"] = {
							352.8823529411765, -- [1]
							94767, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							418.9411764705882, -- [1]
							95714, -- [2]
							0, -- [3]
						},
						["INVTYPE_NECK"] = {
							340.9017379679144, -- [1]
							95145, -- [2]
							0, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							402.3288770053476, -- [1]
							95695, -- [2]
							0, -- [3]
						},
						["INVTYPE_CHEST"] = {
							537.4338235294117, -- [1]
							89834, -- [2]
							0, -- [3]
						},
						["INVTYPE_WEAPONMAINHAND"] = {
							1498.233957219251, -- [1]
							86862, -- [2]
							0, -- [3]
						},
					},
				},
			},
		},
		["\"Wowhead\":ShamanRestoration"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "00ff80",
			["LocalizedName"] = "Shaman: restoration",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "00bf60",
		},
		["\"Wowhead\":MageFire"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "69ccf0",
			["LocalizedName"] = "Mage: fire",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "4e99b3",
		},
		["Resto: Mastery Build"] = {
			["NormalizationFactor"] = 1,
			["Values"] = {
				["IsOffHand"] = -1000000,
				["CritRating"] = 40,
				["HasteRating"] = 60,
				["MasteryRating"] = 55,
				["IsCrossbow"] = -1000000,
				["MetaSocketEffect"] = 16000,
				["Spirit"] = 65,
				["IsGun"] = -1000000,
				["IsWand"] = -1000000,
				["IsBow"] = -1000000,
				["IsSword"] = -1000000,
				["Intellect"] = 100,
				["Is2HSword"] = -1000000,
				["SpellPower"] = 75,
				["IsPolearm"] = -1000000,
				["IsPlate"] = -1000000,
			},
			["UpgradesFollowSpecialization"] = true,
			["Color"] = "00ff80",
			["PerCharacterOptions"] = {
				["Cellestia-Terenas"] = {
					["Visible"] = true,
				},
			},
		},
		["\"Wowhead\":WarriorFury"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "c79c6e",
			["LocalizedName"] = "Warrior: fury",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "957552",
		},
		["\"Wowhead\":WarlockAffliction"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "bca5ff",
			["LocalizedName"] = "Warlock: affliction",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "8d7bbf",
		},
		["\"Wowhead\":PriestHoly"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "e0e0e0",
			["LocalizedName"] = "Priest: holy",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "a8a8a8",
		},
		["\"Wowhead\":WarlockDemonology"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "bca5ff",
			["LocalizedName"] = "Warlock: demonology",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "8d7bbf",
		},
		["\"Wowhead\":MonkBrewmaster"] = {
			["PerCharacterOptions"] = {
				["Shenlu-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							10.04679376083189, -- [1]
							61937, -- [2]
							84, -- [3]
						},
						["INVTYPE_FEET"] = {
							6.802426343154246, -- [1]
							65961, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							0.8422876949740035, -- [1]
							5201, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							4.405545927209706, -- [1]
							62039, -- [2]
							84, -- [3]
						},
						["INVTYPE_WRIST"] = {
							1.275563258232236, -- [1]
							74578, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							6.750433275563259, -- [1]
							51964, -- [2]
							0, -- [3]
						},
						["INVTYPE_HAND"] = {
							3.568457538994801, -- [1]
							58925, -- [2]
							0, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							8.786828422876949, -- [1]
							42952, -- [2]
							79, -- [3]
						},
						["INVTYPE_LEGS"] = {
							10.66377816291161, -- [1]
							62026, -- [2]
							84, -- [3]
						},
						["INVTYPE_CHEST"] = {
							11.76429809358752, -- [1]
							48689, -- [2]
							79, -- [3]
						},
					},
				},
				["Ziagi-Terenas"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "00ff96",
			["LocalizedName"] = "Monk: brewmaster",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "00bf70",
		},
		["\"Wowhead\":DruidRestoration"] = {
			["PerCharacterOptions"] = {
				["Jolobank-Dragonblight"] = {
					["Visible"] = true,
				},
				["Jolokya-Dragonblight"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "ff7d0a",
			["LocalizedName"] = "Druid: restoration",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf5d07",
		},
		["\"Wowhead\":DruidFeralDps"] = {
			["PerCharacterOptions"] = {
				["Jolobank-Dragonblight"] = {
					["Visible"] = true,
				},
				["Jolokya-Dragonblight"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "ff7d0a",
			["LocalizedName"] = "Druid: feral",
			["DoNotShow1HUpgrades"] = true,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf5d07",
		},
		["\"Wowhead\":HunterMarksman"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "abd473",
			["LocalizedName"] = "Hunter: marksman",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "809f56",
		},
		["\"Wowhead\":RogueSubtlety"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "fff569",
			["LocalizedName"] = "Rogue: subtlety",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bfb74e",
		},
		["\"Wowhead\":ShamanElemental"] = {
			["PerCharacterOptions"] = {
				["Cellestia-Terenas"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "6e95ff",
			["LocalizedName"] = "Shaman: elemental",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "526fbf",
		},
		["\"Wowhead\":PaladinRetribution"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "f58cba",
			["LocalizedName"] = "Paladin: retribution",
			["DoNotShow1HUpgrades"] = true,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "b7698b",
		},
		["\"Wowhead\":MageArcane"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "69ccf0",
			["LocalizedName"] = "Mage: arcane",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "4e99b3",
		},
		["\"Wowhead\":DeathKnightFrostDps"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "ff4d6b",
			["LocalizedName"] = "DK: frost",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf3950",
		},
		["\"Wowhead\":WarriorTank"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "c79c6e",
			["LocalizedName"] = "Warrior: tank",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = true,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "957552",
		},
		["\"Wowhead\":MonkWindwalker"] = {
			["PerCharacterOptions"] = {
				["Shenlu-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							2.65781574694066, -- [1]
							61937, -- [2]
							84, -- [3]
						},
						["INVTYPE_FEET"] = {
							1.137150773493419, -- [1]
							65961, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							0.5139690602632187, -- [1]
							5201, -- [2]
							0, -- [3]
						},
						["INVTYPE_HAND"] = {
							0.1987993534980374, -- [1]
							58925, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							1.421149849919187, -- [1]
							51964, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							1.178942507504041, -- [1]
							62039, -- [2]
							84, -- [3]
						},
						["INVTYPE_LEGS"] = {
							2.159085661510044, -- [1]
							62026, -- [2]
							84, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							2.314477026090972, -- [1]
							42952, -- [2]
							79, -- [3]
						},
						["INVTYPE_CHEST"] = {
							3.00877395520665, -- [1]
							48689, -- [2]
							79, -- [3]
						},
					},
				},
				["Ziagi-Terenas"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "00ff96",
			["LocalizedName"] = "Monk: windwalker",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "00bf70",
		},
		["\"Wowhead\":DruidBalance"] = {
			["PerCharacterOptions"] = {
				["Jolobank-Dragonblight"] = {
					["Visible"] = true,
				},
				["Jolokya-Dragonblight"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "ff7d0a",
			["LocalizedName"] = "Druid: balance",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf5d07",
		},
		["Resto: Crit (Haste Capped)"] = {
			["NormalizationFactor"] = 1,
			["Values"] = {
				["IsOffHand"] = -1000000,
				["CritRating"] = 45,
				["HasteRating"] = 35,
				["MasteryRating"] = 40,
				["IsCrossbow"] = -1000000,
				["MetaSocketEffect"] = 16000,
				["Spirit"] = 65,
				["IsGun"] = -1000000,
				["IsWand"] = -1000000,
				["IsBow"] = -1000000,
				["IsSword"] = -1000000,
				["Intellect"] = 100,
				["Is2HSword"] = -1000000,
				["SpellPower"] = 75,
				["IsPolearm"] = -1000000,
				["IsPlate"] = -1000000,
			},
			["UpgradesFollowSpecialization"] = true,
			["Color"] = "00ff80",
			["PerCharacterOptions"] = {
				["Jolokia-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							643.8888888888888, -- [1]
							86691, -- [2]
							0, -- [3]
						},
						["INVTYPE_FEET"] = {
							525.3333333333334, -- [1]
							95222, -- [2]
							0, -- [3]
						},
						["INVTYPE_LEGS"] = {
							767.4305555555555, -- [1]
							95323, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							271.9861111111111, -- [1]
							86748, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							1973.305555555556, -- [1]
							86893, -- [2]
							0, -- [3]
						},
						["INVTYPE_FINGER"] = {
							411.6111111111111, -- [1]
							95514, -- [2]
							0, -- [3]
							408.3194444444445, -- [4]
							95139, -- [5]
							0, -- [6]
						},
						["INVTYPE_HAND"] = {
							579.1111111111111, -- [1]
							95311, -- [2]
							0, -- [3]
						},
						["INVTYPE_WRIST"] = {
							439.3611111111111, -- [1]
							94767, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							510.5416666666667, -- [1]
							95714, -- [2]
							0, -- [3]
						},
						["INVTYPE_NECK"] = {
							407.4027777777778, -- [1]
							95145, -- [2]
							0, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							479.8333333333333, -- [1]
							95695, -- [2]
							0, -- [3]
						},
						["INVTYPE_CHEST"] = {
							659.8611111111111, -- [1]
							89834, -- [2]
							0, -- [3]
						},
						["INVTYPE_WEAPONMAINHAND"] = {
							1538.444444444445, -- [1]
							86862, -- [2]
							0, -- [3]
						},
					},
				},
			},
		},
		["\"Wowhead\":HunterSurvival"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "abd473",
			["LocalizedName"] = "Hunter: survival",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "809f56",
		},
		["\"Wowhead\":PriestShadow"] = {
			["PerCharacterOptions"] = {
			},
			["Color"] = "e0e0e0",
			["LocalizedName"] = "Priest: shadow",
			["DoNotShow1HUpgrades"] = false,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "a8a8a8",
		},
		["Ele: Above Hit Cap"] = {
			["NormalizationFactor"] = 1,
			["Values"] = {
				["IsOffHand"] = -1000000,
				["Intellect"] = 374,
				["IsWand"] = -1000000,
				["CritRating"] = 139,
				["IsBow"] = -1000000,
				["IsSword"] = -1000000,
				["IsPlate"] = -1000000,
				["IsCrossbow"] = -1000000,
				["MetaSocketEffect"] = 16000,
				["HasteRating"] = 165,
				["MasteryRating"] = 146,
				["Is2HSword"] = -1000000,
				["SpellPower"] = 312,
				["IsPolearm"] = -1000000,
				["IsGun"] = -1000000,
			},
			["UpgradesFollowSpecialization"] = true,
			["Color"] = "6e95ff",
			["PerCharacterOptions"] = {
				["Jolokia-Dragonblight"] = {
					["Visible"] = true,
					["BestItems"] = {
						["INVTYPE_HEAD"] = {
							561.1646126760563, -- [1]
							86691, -- [2]
							0, -- [3]
						},
						["INVTYPE_FEET"] = {
							581.9718309859155, -- [1]
							95222, -- [2]
							0, -- [3]
						},
						["INVTYPE_LEGS"] = {
							826.6593309859155, -- [1]
							95323, -- [2]
							0, -- [3]
						},
						["INVTYPE_CLOAK"] = {
							251.8485915492958, -- [1]
							86748, -- [2]
							0, -- [3]
						},
						["INVTYPE_2HWEAPON"] = {
							2472.347711267606, -- [1]
							86893, -- [2]
							0, -- [3]
						},
						["INVTYPE_FINGER"] = {
							393.0739436619718, -- [1]
							95139, -- [2]
							0, -- [3]
							380.6619718309859, -- [4]
							95514, -- [5]
							0, -- [6]
						},
						["INVTYPE_HAND"] = {
							563.7816901408452, -- [1]
							95311, -- [2]
							0, -- [3]
						},
						["INVTYPE_WRIST"] = {
							378.5801056338028, -- [1]
							94767, -- [2]
							0, -- [3]
						},
						["INVTYPE_WAIST"] = {
							472.0933098591549, -- [1]
							95714, -- [2]
							0, -- [3]
						},
						["INVTYPE_NECK"] = {
							391.5977112676056, -- [1]
							95145, -- [2]
							0, -- [3]
						},
						["INVTYPE_SHOULDER"] = {
							444.7852112676056, -- [1]
							95695, -- [2]
							0, -- [3]
						},
						["INVTYPE_CHEST"] = {
							598.0255281690141, -- [1]
							89834, -- [2]
							0, -- [3]
						},
						["INVTYPE_WEAPONMAINHAND"] = {
							1937.263204225352, -- [1]
							86862, -- [2]
							0, -- [3]
						},
					},
				},
			},
		},
		["\"Wowhead\":DruidFeralTank"] = {
			["PerCharacterOptions"] = {
				["Jolobank-Dragonblight"] = {
					["Visible"] = true,
				},
				["Jolokya-Dragonblight"] = {
					["Visible"] = true,
				},
			},
			["Color"] = "ff7d0a",
			["LocalizedName"] = "Druid: guardian",
			["DoNotShow1HUpgrades"] = true,
			["NormalizationFactor"] = 1,
			["DoNotShow2HUpgrades"] = false,
			["UpgradesFollowSpecialization"] = true,
			["Provider"] = "Wowhead",
			["UnenchantedColor"] = "bf5d07",
		},
	},
	["Digits"] = 1,
	["ButtonPosition"] = 2,
	["LastVersion"] = 1.809,
	["ShowQuestUpgradeAdvisor"] = true,
	["ShownGettingStarted"] = true,
	["ShowEnchanted"] = false,
}
