
ElvDB = {
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Cellestia - Resto",
		["Cellestia - Terenas"] = "Cellestia - Resto",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
	},
	["gold"] = {
		["Dragonblight"] = {
			["Majandra"] = 28896239,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Jolokia - Dragonblight"] = {
					["profile"] = "Cellestia - Ele",
					["talentGroup"] = 1,
					["enabled"] = true,
				},
				["Majandra - Dragonblight"] = {
					["profile"] = "Majandra",
					["talentGroup"] = 1,
					["enabled"] = false,
				},
				["Cellestia - Terenas"] = {
					["profile"] = "Cellestia - Ele",
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
			["buffwatch"] = {
				["PRIEST"] = {
					[9] = {
						["enabled"] = true,
						["anyUnit"] = false,
						["point"] = "LEFT",
						["id"] = 114908,
						["style"] = "coloredIcon",
						["color"] = {
							["b"] = 1,
							["g"] = 0,
							["r"] = 0.9725490196078431,
						},
					},
					[10] = {
						["enabled"] = true,
						["anyUnit"] = true,
						["point"] = "RIGHT",
						["id"] = 47753,
						["displayText"] = false,
						["style"] = "coloredIcon",
						["color"] = {
							["b"] = 0,
							["g"] = 0.996078431372549,
							["r"] = 1,
						},
					},
				},
			},
		},
		["screenwidth"] = 1920,
		["screenheight"] = 1200,
	},
	["profiles"] = {
		["Majandra DPS"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["loginmessage"] = false,
				["fontSize"] = 11,
				["topPanel"] = false,
				["autoRoll"] = true,
				["autoRepair"] = "GUILD",
				["minimap"] = {
					["locationText"] = "SHOW",
					["size"] = 134,
				},
				["bottomPanel"] = false,
				["threat"] = {
					["enable"] = false,
				},
				["experience"] = {
					["enable"] = false,
					["textSize"] = 6,
					["height"] = 15,
				},
				["movertransparancy"] = 1,
				["vendorGrays"] = true,
				["reputation"] = {
					["height"] = 15,
					["textSize"] = 6,
					["mouseover"] = true,
				},
			},
			["movers"] = {
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-465151",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM0296",
				["FarmToolAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-499",
				["RaidMarkerBarAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT107223",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT-9-166",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM057",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM073",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-31226",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5185",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0190",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-36",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0103",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM31326",
				["FarmPortalAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-458",
				["TempEnchantMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-255",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT462121",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-3",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-21-196",
				["FarmSeedAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4222",
				["AurasMover"] = "TOPRIGHTElvUIParentTOPRIGHT-169-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-544328",
				["ElvAB_6"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4185",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5223",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT46499",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM062",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0105",
				["AlertFrameMover"] = "BOTTOMElvUIParentBOTTOM0472",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-42344",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
			},
			["gridSize"] = 128,
			["tooltip"] = {
				["anchor"] = "ANCHOR",
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["panelTabTransparency"] = true,
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
					["raid10"] = {
						["roleIcon"] = {
							["enable"] = false,
						},
						["health"] = {
							["frequentUpdates"] = true,
						},
						["GPSArrow"] = {
							["onMouseOver"] = false,
						},
					},
					["boss"] = {
						["width"] = 200,
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["castbar"] = {
							["width"] = 200,
						},
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["useFilter"] = "Blacklist",
							["initialAnchor"] = "TOPLEFT",
						},
						["power"] = {
							["text_format"] = "",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["roleIcon"] = {
							["position"] = "BOTTOMLEFT",
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["frequentUpdates"] = true,
							["text_format"] = "[healthcolor][health:deficit]",
							["position"] = "BOTTOM",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:medium]",
							["position"] = "TOP",
						},
						["height"] = 52,
						["width"] = 80,
						["petsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["enable"] = true,
							["yOffset"] = 1,
							["xOffset"] = 0,
							["width"] = 80,
						},
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["yOffset"] = 1,
							["width"] = 80,
						},
					},
					["raid40"] = {
						["roleIcon"] = {
							["enable"] = true,
						},
						["name"] = {
							["position"] = "TOP",
						},
						["height"] = 36,
						["healPrediction"] = true,
						["health"] = {
							["orientation"] = "VERTICAL",
							["text"] = true,
							["frequentUpdates"] = true,
						},
					},
					["assist"] = {
						["enable"] = false,
					},
					["raid25"] = {
						["height"] = 40,
						["rdebuffs"] = {
							["xOffset"] = 0,
							["size"] = 15,
							["yOffset"] = 0,
						},
						["health"] = {
							["frequentUpdates"] = true,
						},
						["healPrediction"] = true,
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["target"] = {
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 2.24,
							["rotation"] = 307,
						},
						["name"] = {
							["text_format"] = "[namecolor][name] [difficultycolor][smartlevel] [shortclassification]",
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
						["power"] = {
							["hideonnpc"] = false,
						},
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
						["classicon"] = {
							["enable"] = false,
						},
						["aurabar"] = {
							["enable"] = false,
							["attachTo"] = "BUFFS",
						},
					},
					["player"] = {
						["restIcon"] = false,
						["buffs"] = {
							["useFilter"] = "Blacklist",
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 2.24,
							["rotation"] = 307,
						},
						["castbar"] = {
							["displayTarget"] = true,
							["width"] = 440,
						},
					},
				},
			},
			["datatexts"] = {
				["fontSize"] = 11,
				["actionbar3"] = true,
				["panelTransparency"] = true,
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Broker Volume",
					["RightMiniPanel"] = "Time",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
					},
					["Actionbar1DataPanel"] = {
						["right"] = "Mana Regen",
						["left"] = "Spell/Heal Power",
						["middle"] = "HPS",
					},
					["Actionbar5DataPanel"] = "Cecile Meter Overlay",
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
				},
				["actionbar1"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["backdrop"] = true,
					["mouseover"] = true,
					["buttons"] = 12,
				},
				["fontSize"] = 9,
				["bar2"] = {
					["enabled"] = true,
					["mouseover"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["bar5"] = {
					["backdrop"] = true,
					["point"] = "TOPLEFT",
					["mouseover"] = true,
					["buttons"] = 12,
				},
				["font"] = "ElvUI Font",
				["fontOutline"] = "OUTLINE",
				["bar6"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
				},
				["bar4"] = {
					["point"] = "TOPLEFT",
					["buttonsPerRow"] = 12,
				},
			},
			["layoutSet"] = "healer",
			["VAT"] = {
				["threshold"] = {
					["buffsvalue"] = 0,
					["buffs"] = true,
				},
				["noduration"] = false,
				["enable"] = false,
			},
			["watchframe"] = {
				["raid"] = "HIDDEN",
			},
			["auras"] = {
				["consolidatedBuffs"] = {
					["filter"] = false,
				},
			},
		},
		["Majandra"] = {
			["currentTutorial"] = 1,
			["hideTutorial"] = 1,
			["chat"] = {
				["tabFont"] = "ElvUI Font",
				["panelTabTransparency"] = true,
			},
			["layoutSet"] = "healer",
			["VAT"] = {
				["threshold"] = {
					["buffs"] = true,
					["buffsvalue"] = 0,
				},
				["noduration"] = false,
				["enable"] = false,
			},
			["movers"] = {
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM0296",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM073",
				["RaidMarkerBarAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT107223",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT-9-166",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM060",
				["FarmToolAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-499",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-31226",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5185",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0190",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-36",
				["BossButton"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-565150",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM31326",
				["FarmPortalAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-458",
				["TempEnchantMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-255",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-3",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-21-196",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5223",
				["AurasMover"] = "TOPRIGHTElvUIParentTOPRIGHT-169-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-544328",
				["ElvAB_6"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4185",
				["FarmSeedAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4222",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT46499",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT462121",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM062",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0105",
				["AlertFrameMover"] = "BOTTOMElvUIParentBOTTOM0472",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-42344",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-465151",
			},
			["gridSize"] = 128,
			["tooltip"] = {
				["healthBar"] = {
					["font"] = "ElvUI Font",
				},
				["itemCount"] = false,
				["anchor"] = "ANCHOR",
			},
			["unitframe"] = {
				["fontSize"] = 11,
				["units"] = {
					["raid10"] = {
						["debuffs"] = {
							["sizeOverride"] = 12,
							["enable"] = true,
						},
						["roleIcon"] = {
							["enable"] = false,
						},
						["GPSArrow"] = {
							["onMouseOver"] = false,
						},
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
						},
						["buffs"] = {
							["countFontSize"] = 7,
							["sizeOverride"] = 12,
							["numrows"] = 2,
							["fontSize"] = 8,
						},
					},
					["assist"] = {
						["enable"] = false,
					},
					["boss"] = {
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
					},
					["party"] = {
						["horizontalSpacing"] = 3,
						["debuffs"] = {
							["enable"] = false,
							["initialAnchor"] = "TOPLEFT",
						},
						["health"] = {
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
							["text_format"] = "[healthcolor][health:deficit]",
						},
						["growthDirection"] = "RIGHT_DOWN",
						["GPSArrow"] = {
							["onMouseOver"] = false,
							["size"] = 40,
						},
						["roleIcon"] = {
							["enable"] = false,
							["position"] = "BOTTOMRIGHT",
						},
						["targetsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["power"] = {
							["text_format"] = "",
						},
						["width"] = 80,
						["name"] = {
							["text_format"] = "[namecolor][name:short]",
							["position"] = "TOP",
						},
						["petsGroup"] = {
							["initialAnchor"] = "BOTTOM",
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
						["health"] = {
							["frequentUpdates"] = true,
							["orientation"] = "VERTICAL",
							["text"] = true,
						},
						["height"] = 36,
					},
					["target"] = {
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["rotation"] = 307,
							["camDistanceScale"] = 2.24,
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
						["aurabar"] = {
							["enable"] = false,
							["attachTo"] = "BUFFS",
						},
						["power"] = {
							["hideonnpc"] = false,
						},
						["name"] = {
							["text_format"] = "[namecolor][name] [difficultycolor][smartlevel] [shortclassification]",
						},
						["classicon"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["raid25"] = {
						["rdebuffs"] = {
							["xOffset"] = 0,
							["size"] = 15,
							["yOffset"] = 0,
						},
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 40,
					},
					["player"] = {
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["rotation"] = 307,
							["camDistanceScale"] = 2.24,
						},
						["restIcon"] = false,
						["buffs"] = {
							["useFilter"] = "Blacklist",
						},
						["castbar"] = {
							["width"] = 440,
							["displayTarget"] = true,
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
				["fontSize"] = 11,
				["panelTransparency"] = true,
				["actionbar5"] = true,
				["panels"] = {
					["LeftMiniPanel"] = "Broker Volume",
					["RightMiniPanel"] = "Time",
					["RightChatDataPanel"] = {
						["middle"] = "Bags",
					},
					["Actionbar1DataPanel"] = {
						["right"] = "Mana Regen",
						["left"] = "Spell/Heal Power",
						["middle"] = "HPS",
					},
					["Actionbar5DataPanel"] = "Cecile Meter Overlay",
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
				},
				["font"] = "Cecile",
				["actionbar3"] = true,
				["actionbar1"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
					["backdrop"] = true,
					["mouseover"] = true,
				},
				["bar6"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
				},
				["fontOutline"] = "OUTLINE",
				["bar2"] = {
					["enabled"] = true,
					["mouseover"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["fontSize"] = 13,
				["bar5"] = {
					["point"] = "TOPLEFT",
					["buttons"] = 12,
					["backdrop"] = true,
				},
				["font"] = "ElvUI Font",
				["bar4"] = {
					["point"] = "TOPLEFT",
					["buttonsPerRow"] = 12,
				},
			},
			["watchframe"] = {
				["raid"] = "HIDDEN",
			},
			["general"] = {
				["fontSize"] = 11,
				["autoRepair"] = "GUILD",
				["minimap"] = {
					["locationText"] = "SHOW",
					["size"] = 134,
				},
				["bottomPanel"] = false,
				["movertransparancy"] = 1,
				["loginmessage"] = false,
				["threat"] = {
					["enable"] = false,
				},
				["vendorGrays"] = true,
				["autoRoll"] = true,
				["experience"] = {
					["enable"] = false,
					["height"] = 15,
					["textSize"] = 6,
				},
				["topPanel"] = false,
				["reputation"] = {
					["mouseover"] = true,
					["height"] = 15,
					["textSize"] = 6,
				},
			},
		},
		["Shenlu - Dragonblight"] = {
			["currentTutorial"] = 1,
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
			["hideTutorial"] = 1,
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
					["raid25"] = {
						["buffs"] = {
							["sizeOverride"] = 22,
						},
						["debuffs"] = {
							["sizeOverride"] = 16,
						},
					},
					["party"] = {
						["buffs"] = {
							["sizeOverride"] = 22,
						},
					},
				},
			},
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Jolokia - Dragonblight",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
	},
	["profiles"] = {
		["Jolokia - Dragonblight"] = {
			["equipment"] = {
				["primary"] = "Healing",
				["specialization"] = {
					["enable"] = true,
				},
				["secondary"] = "DPS",
			},
			["general"] = {
				["minimapbar"] = {
					["buttonSize"] = 20,
				},
			},
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["bags"] = {
				["enable"] = false,
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
		["Majandra - Dragonblight"] = {
			["general"] = {
				["minimapbar"] = {
					["buttonSize"] = 23,
				},
				["normTex"] = "Aluminium",
				["autorepchange"] = false,
				["lootRoll"] = false,
				["glossTex"] = "Aluminium",
			},
			["bags"] = {
				["enable"] = false,
			},
			["equipment"] = {
				["primary"] = "Disc",
				["secondary"] = "Holy",
			},
			["addonskins"] = {
				["EmbedSkada"] = true,
				["EmbedalDamageMeter"] = false,
				["TransparentEmbed"] = true,
				["EmbedSystemDual"] = true,
			},
			["skins"] = {
				["blizzard"] = {
					["trainer"] = false,
					["auctionhouse"] = false,
					["mail"] = false,
				},
				["addons"] = {
					["SkadaBelowTop"] = true,
					["EmbedSkada"] = true,
					["SkadaBackdrop"] = false,
					["TransparentEmbed"] = true,
					["EmbedSystemDual"] = true,
					["EmbedMain"] = "Skada",
					["EmbedalDamageMeter"] = false,
				},
			},
			["theme"] = "class",
			["install_complete"] = "5.99",
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
				},
			},
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "5.89",
		},
	},
}
