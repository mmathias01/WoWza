
ElvDB = {
	["profileKeys"] = {
		["Kodeak - Terenas"] = "Kodeak - Terenas",
		["Saphiira - Terenas"] = "Saphiira - Terenas",
		["Sapphira - Terenas"] = "Sapphira - Terenas",
	},
	["gold"] = {
		["Terenas"] = {
			["Saphiira"] = 90991378,
			["Kodeak"] = 1061580,
			["Sapphira"] = 9183,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["profiles"] = {
		["Kodeak - Terenas"] = {
			["currentTutorial"] = 1,
			["datatexts"] = {
				["panels"] = {
					["LeftChatDataPanel"] = {
						["left"] = "Attack Power",
						["right"] = "Haste",
					},
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM038",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
			},
			["layoutSet"] = "dpsMelee",
			["general"] = {
				["valuecolor"] = {
					["r"] = 0.77,
					["g"] = 0.12,
					["b"] = 0.23,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
			},
			["hideTutorial"] = 1,
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.77,
						["g"] = 0.12,
						["b"] = 0.23,
					},
					["castClassColor"] = true,
					["castColor"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["health"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["healthclass"] = true,
				},
				["units"] = {
					["target"] = {
						["debuffs"] = {
							["enable"] = false,
						},
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
						},
					},
					["player"] = {
						["portrait"] = {
							["enable"] = true,
							["overlay"] = true,
						},
					},
				},
			},
		},
		["Saphiira - Terenas"] = {
			["currentTutorial"] = 6,
			["general"] = {
				["valuecolor"] = {
					["r"] = 0.99,
					["g"] = 0.99,
					["b"] = 0.99,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM042",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM038",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM278110",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-278110",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
			},
			["layoutSet"] = "dpsCaster",
			["datatexts"] = {
				["panels"] = {
					["LeftChatDataPanel"] = {
						["left"] = "Spell/Heal Power",
						["right"] = "Haste",
					},
				},
			},
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.99,
						["g"] = 0.99,
						["b"] = 0.99,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["target"] = {
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
						["debuffs"] = {
							["enable"] = false,
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
					},
					["player"] = {
						["castbar"] = {
							["height"] = 28,
							["width"] = 406,
						},
					},
				},
			},
		},
		["Sapphira - Terenas"] = {
			["currentTutorial"] = 2,
			["movers"] = {
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
			},
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Kodeak - Terenas"] = "Kodeak - Terenas",
		["Saphiira - Terenas"] = "Saphiira - Terenas",
		["Sapphira - Terenas"] = "Sapphira - Terenas",
	},
	["profiles"] = {
		["Kodeak - Terenas"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["theme"] = "class",
			["install_complete"] = "5.88",
		},
		["Saphiira - Terenas"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["theme"] = "class",
			["install_complete"] = "5.88",
		},
		["Sapphira - Terenas"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "5.88",
		},
	},
}
