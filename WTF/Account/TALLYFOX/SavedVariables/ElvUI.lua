
ElvDB = {
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Cellestia - Ele",
		["Cellestia - Terenas"] = "Cellestia - Resto",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Shenlu - Dragonblight"] = "Cellestia - Ele",
	},
	["gold"] = {
		["Terenas"] = {
			["Cellestia"] = 98272940,
		},
		["Dragonblight"] = {
			["Jolobank"] = 24970,
			["Jolokya"] = 0,
			["Shenlu"] = 22575,
			["Jolokia"] = 146780207,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Cellestia - Terenas"] = {
					["profile"] = "Cellestia - Ele",
					["specGroup"] = 1,
					["talentGroup"] = 1,
					["enabled"] = true,
				},
				["Jolokia - Dragonblight"] = {
					["profile"] = "Cellestia - Resto",
					["specGroup"] = 1,
					["talentGroup"] = 1,
					["enabled"] = true,
				},
			},
		},
	},
	["global"] = {
		["unitframe"] = {
			["aurafilters"] = {
				["Blacklist"] = {
					["spells"] = {
						["Lightning Shield"] = {
							["enable"] = true,
							["priority"] = 0,
						},
						["Honorless Target"] = {
							["enable"] = true,
							["priority"] = 0,
						},
						["Water Shield"] = {
							["enable"] = true,
							["priority"] = 0,
						},
						["Well Fed"] = {
							["enable"] = true,
							["priority"] = 0,
						},
					},
				},
			},
		},
	},
	["profiles"] = {
		["Jolokia - Dragonblight"] = {
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT248450",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0132",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM076",
				["ElvUF_FocusMover"] = "BOTTOMElvUIParentBOTTOM310432",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM038",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-278132",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0176",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0275",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT248450",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT248450",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM3124",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-3124",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM-12450",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM278132",
			},
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.87,
						["g"] = 0.44,
						["r"] = 0,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["party"] = {
						["horizontalSpacing"] = 9,
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 16,
							["xOffset"] = -4,
							["yOffset"] = -7,
						},
						["power"] = {
							["text_format"] = "",
						},
						["healPrediction"] = true,
						["growthDirection"] = "LEFT_UP",
						["GPSArrow"] = {
							["size"] = 40,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:deficit]",
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:short]",
							["position"] = "TOP",
						},
						["verticalSpacing"] = 9,
						["height"] = 45,
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["xOffset"] = 50,
							["useFilter"] = "TurtleBuffs",
							["perrow"] = 1,
							["noDuration"] = false,
						},
						["width"] = 80,
						["roleIcon"] = {
							["position"] = "BOTTOMRIGHT",
						},
					},
					["raid40"] = {
						["height"] = 30,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
						},
						["growthDirection"] = "LEFT_UP",
					},
					["raid10"] = {
						["horizontalSpacing"] = 9,
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 16,
							["xOffset"] = -4,
							["enable"] = true,
							["yOffset"] = -7,
						},
						["positionOverride"] = "BOTTOMRIGHT",
						["healPrediction"] = true,
						["growthDirection"] = "LEFT_UP",
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 45,
						["verticalSpacing"] = 9,
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["xOffset"] = 50,
							["useFilter"] = "TurtleBuffs",
							["perrow"] = 1,
							["noDuration"] = false,
						},
						["rdebuffs"] = {
							["enable"] = false,
						},
					},
					["raid25"] = {
						["horizontalSpacing"] = 9,
						["debuffs"] = {
							["anchorPoint"] = "TOPRIGHT",
							["sizeOverride"] = 16,
							["xOffset"] = -4,
							["enable"] = true,
							["yOffset"] = -7,
						},
						["healPrediction"] = true,
						["growthDirection"] = "LEFT_UP",
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 45,
						["verticalSpacing"] = 9,
						["buffs"] = {
							["noConsolidated"] = false,
							["sizeOverride"] = 22,
							["useBlacklist"] = false,
							["enable"] = true,
							["playerOnly"] = false,
							["yOffset"] = -6,
							["clickThrough"] = true,
							["xOffset"] = 50,
							["useFilter"] = "TurtleBuffs",
							["perrow"] = 1,
							["noDuration"] = false,
						},
						["rdebuffs"] = {
							["enable"] = false,
						},
					},
					["player"] = {
						["castbar"] = {
							["height"] = 28,
							["width"] = 406,
						},
					},
					["target"] = {
						["aurabar"] = {
							["attachTo"] = "BUFFS",
						},
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
						["debuffs"] = {
							["enable"] = false,
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
					},
				},
			},
			["general"] = {
				["valuecolor"] = {
					["b"] = 0.87,
					["g"] = 0.44,
					["r"] = 0,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar4"] = {
					["enabled"] = false,
				},
				["bar5"] = {
					["buttons"] = 12,
				},
				["bar2"] = {
					["enabled"] = true,
				},
			},
			["layoutSet"] = "healer",
			["datatexts"] = {
				["panels"] = {
					["LeftChatDataPanel"] = {
						["left"] = "Spell/Heal Power",
						["right"] = "Haste",
					},
				},
			},
			["hideTutorial"] = 1,
			["currentTutorial"] = 3,
		},
		["Cellestia - Terenas"] = {
			["currentTutorial"] = 4,
			["datatexts"] = {
				["panels"] = {
					["LeftChatDataPanel"] = {
						["left"] = "Spell/Heal Power",
						["right"] = "Spec Switch",
					},
				},
			},
			["movers"] = {
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0104",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM0180",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM064",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-27865",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM27864",
			},
			["layoutSet"] = "dpsCaster",
			["unitframe"] = {
				["units"] = {
					["target"] = {
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
						["debuffs"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
						["aurabar"] = {
							["attachTo"] = "BUFFS",
						},
					},
					["party"] = {
						["targetsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["petsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["debuffs"] = {
							["initialAnchor"] = "TOPLEFT",
						},
					},
					["raid40"] = {
						["health"] = {
							["text"] = true,
						},
					},
				},
			},
			["general"] = {
				["valuecolor"] = {
					["r"] = 0.09,
					["g"] = 0.513,
					["b"] = 0.819,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
			},
		},
		["Shenlu - Dragonblight"] = {
			["currentTutorial"] = 1,
			["datatexts"] = {
				["actionbar1"] = true,
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Spec Switch",
					["RightMiniPanel"] = "Time",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
					},
					["Actionbar1DataPanel"] = {
						["middle"] = "Hit Rating",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["Actionbar3DataPanel"] = "Spell/Heal Power",
					["Actionbar5DataPanel"] = "DPS",
				},
				["actionbar3"] = true,
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM278110",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM042",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM038",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-278110",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM31022",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-31022",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
			},
			["layoutSet"] = "dpsCaster",
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0,
						["g"] = 1,
						["b"] = 0.59,
					},
					["castClassColor"] = true,
					["healthclass"] = true,
				},
				["units"] = {
					["player"] = {
						["castbar"] = {
							["height"] = 28,
							["width"] = 406,
						},
					},
					["raid10"] = {
						["positionOverride"] = "BOTTOMRIGHT",
						["debuffs"] = {
							["sizeOverride"] = 16,
						},
						["buffs"] = {
							["sizeOverride"] = 22,
						},
					},
					["party"] = {
						["buffs"] = {
							["sizeOverride"] = 22,
						},
					},
					["target"] = {
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
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
					},
					["raid25"] = {
						["debuffs"] = {
							["sizeOverride"] = 16,
						},
						["buffs"] = {
							["sizeOverride"] = 22,
						},
					},
				},
			},
			["hideTutorial"] = 1,
			["general"] = {
				["valuecolor"] = {
					["r"] = 0,
					["g"] = 1,
					["b"] = 0.59,
				},
				["bordercolor"] = {
					["r"] = 0.31,
					["g"] = 0.31,
					["b"] = 0.31,
				},
				["bottomPanel"] = false,
				["topPanel"] = false,
			},
		},
		["Jolokya - Dragonblight"] = {
			["currentTutorial"] = 2,
			["movers"] = {
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
			},
		},
		["Cellestia - Resto"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["loginmessage"] = false,
				["vendorGrays"] = true,
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["b"] = 0.054,
					["g"] = 0.054,
					["r"] = 0.054,
				},
				["topPanel"] = false,
				["autoRoll"] = true,
				["autoRepair"] = "GUILD",
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM073",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-45429",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM023",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM057",
				["ElvAB_4"] = "TOPRIGHTElvUIParentTOPRIGHT-4-395",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM070",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-36",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0407",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM31223",
				["TempEnchantMover"] = "TOPRIGHTElvUIParentTOPRIGHT-3-267",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-544328",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-31223",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-135-300",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM070",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM074",
				["AlertFrameMover"] = "BOTTOMElvUIParentBOTTOM0472",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT470148",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-465151",
			},
			["gridSize"] = 128,
			["hideTutorial"] = 1,
			["auras"] = {
				["consolidatedBuffs"] = {
					["filter"] = false,
				},
			},
			["unitframe"] = {
				["fontSize"] = 11,
				["colors"] = {
					["castColor"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["auraBarBuff"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["health"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
				},
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
				["statusbar"] = "Aluminium",
				["units"] = {
					["tank"] = {
						["enable"] = false,
					},
					["raid10"] = {
						["enable"] = false,
					},
					["player"] = {
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
						},
						["power"] = {
							["text_format"] = "[powercolor][power:current-percent]",
						},
					},
					["party"] = {
						["showSolo"] = true,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["useFilter"] = "Blacklist",
							["initialAnchor"] = "TOPLEFT",
						},
						["point"] = "LEFT",
						["power"] = {
							["text_format"] = "",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["width"] = 80,
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["yOffset"] = 1,
							["width"] = 80,
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["roleIcon"] = {
							["position"] = "BOTTOMLEFT",
						},
						["height"] = 52,
						["xOffset"] = 5,
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["yOffset"] = 1,
							["xOffset"] = 0,
							["width"] = 80,
						},
						["columnAnchorPoint"] = "LEFT",
					},
					["raid40"] = {
						["roleIcon"] = {
							["enable"] = true,
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
						["enable"] = false,
						["healPrediction"] = true,
						["name"] = {
							["position"] = "TOP",
						},
						["height"] = 36,
					},
					["raid25"] = {
						["enable"] = false,
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
						},
						["rdebuffs"] = {
							["xOffset"] = 0,
							["yOffset"] = 0,
							["size"] = 15,
						},
					},
					["assist"] = {
						["enable"] = false,
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["target"] = {
						["debuffs"] = {
							["enable"] = false,
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
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
					["boss"] = {
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
					},
				},
			},
			["datatexts"] = {
				["actionbar3"] = true,
				["panelTransparency"] = true,
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Broker Volume",
					["RightMiniPanel"] = "Time",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
						["right"] = "ArkInventory_Money",
					},
					["Actionbar1DataPanel"] = {
						["right"] = "Mana Regen",
						["left"] = "Spec Switch",
						["middle"] = "HPS",
					},
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["Actionbar3DataPanel"] = "Skada",
					["Actionbar5DataPanel"] = "Spell/Heal Power",
				},
				["actionbar1"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["font"] = "Vixar",
				["fontOutline"] = "OUTLINE",
				["bar2"] = {
					["enabled"] = true,
				},
				["bar5"] = {
					["point"] = "TOPLEFT",
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["bar4"] = {
					["backdrop"] = false,
				},
			},
			["layoutSet"] = "healer",
		},
		["Cellestia - Ele"] = {
			["currentTutorial"] = 1,
			["hideTutorial"] = 1,
			["auras"] = {
				["consolidatedBuffs"] = {
					["filter"] = false,
				},
			},
			["layoutSet"] = "healer",
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM073",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-45429",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM022",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM057",
				["ElvAB_4"] = "TOPRIGHTElvUIParentTOPRIGHT-4-394",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM070",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-36",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0407",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM31322",
				["TempEnchantMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-255",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-544328",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-3",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-465151",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT470148",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM070",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0105",
				["AlertFrameMover"] = "BOTTOMElvUIParentBOTTOM0472",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-31222",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
			},
			["gridSize"] = 128,
			["tooltip"] = {
				["spellid"] = false,
			},
			["unitframe"] = {
				["fontSize"] = 11,
				["units"] = {
					["tank"] = {
						["targetsGroup"] = {
							["enable"] = false,
						},
						["enable"] = false,
					},
					["party"] = {
						["debuffs"] = {
							["initialAnchor"] = "TOPLEFT",
						},
						["targetsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["petsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
					},
					["boss"] = {
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
					},
					["raid40"] = {
						["name"] = {
							["position"] = "TOP",
						},
						["roleIcon"] = {
							["enable"] = true,
						},
						["healPrediction"] = true,
						["enable"] = false,
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
							["text"] = true,
						},
						["height"] = 36,
					},
					["raid25"] = {
						["rdebuffs"] = {
							["xOffset"] = 0,
							["yOffset"] = 0,
						},
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["player"] = {
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
						},
						["buffs"] = {
							["useFilter"] = "Blacklist",
						},
					},
					["target"] = {
						["debuffs"] = {
							["enable"] = false,
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
						["aurabar"] = {
							["attachTo"] = "BUFFS",
						},
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
					},
				},
				["font"] = "ElvUI Font",
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["castColor"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
					["health"] = {
						["b"] = 0.1,
						["g"] = 0.1,
						["r"] = 0.1,
					},
				},
				["fontOutline"] = "NONE",
				["statusbar"] = "Aluminium",
			},
			["datatexts"] = {
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Broker Volume",
					["RightMiniPanel"] = "Time",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
					},
					["Actionbar1DataPanel"] = {
						["right"] = "Haste",
						["left"] = "Spec Switch",
						["middle"] = "Crit Chance",
					},
					["Actionbar5DataPanel"] = "XPStat",
					["Actionbar3DataPanel"] = "Skada",
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
				},
				["actionbar3"] = true,
				["actionbar1"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
				},
				["bar2"] = {
					["enabled"] = true,
				},
				["bar5"] = {
					["point"] = "TOPLEFT",
					["buttons"] = 12,
				},
				["bar4"] = {
					["point"] = "TOPLEFT",
				},
			},
			["general"] = {
				["autoRepair"] = "GUILD",
				["bottomPanel"] = false,
				["backdropfadecolor"] = {
					["b"] = 0.054,
					["g"] = 0.054,
					["r"] = 0.054,
				},
				["valuecolor"] = {
					["b"] = 0.819,
					["g"] = 0.513,
					["r"] = 0.09,
				},
				["loginmessage"] = false,
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["topPanel"] = false,
			},
		},
		["Jolobank - Dragonblight"] = {
			["movers"] = {
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
			},
			["currentTutorial"] = 4,
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Jolokia - Dragonblight",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
	},
	["profiles"] = {
		["Jolokia - Dragonblight"] = {
			["general"] = {
				["minimapbar"] = {
					["buttonSize"] = 20,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["equipment"] = {
				["specialization"] = {
					["enable"] = true,
				},
				["primary"] = "Healing",
				["secondary"] = "DPS",
			},
			["addonskins"] = {
				["EmbedSkada"] = true,
				["EmbedalDamageMeter"] = false,
				["EmbedSystemDual"] = true,
			},
			["skins"] = {
				["addons"] = {
					["EmbedSkada"] = true,
					["AlwaysTrue"] = true,
				},
			},
			["theme"] = "class",
			["install_complete"] = "5.89",
		},
		["Cellestia - Terenas"] = {
			["equipment"] = {
				["primary"] = "Healing",
				["specialization"] = {
					["enable"] = true,
				},
				["secondary"] = "DPS",
			},
			["general"] = {
				["normTex"] = "Graphite",
				["glossTex"] = "Graphite",
				["minimapbar"] = {
					["buttonSize"] = 20,
				},
			},
			["skins"] = {
				["blizzard"] = {
					["auctionhouse"] = false,
				},
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "default",
			["install_complete"] = "5.22",
		},
		["Jolokya - Dragonblight"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "5.89",
		},
		["Jolobank - Dragonblight"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "5.96",
		},
		["Shenlu - Dragonblight"] = {
			["general"] = {
				["autorepchange"] = false,
			},
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
					["EmbedSkada"] = true,
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "6.36",
		},
	},
}
