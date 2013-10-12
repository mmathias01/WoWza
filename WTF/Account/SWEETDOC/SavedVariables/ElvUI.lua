
ElvDB = {
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Cellestia - Resto",
		["Cellestia - Terenas"] = "Cellestia - Resto",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra",
	},
	["gold"] = {
		["Dragonblight"] = {
			["Majandra"] = 42534894,
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
					["enabled"] = true,
					["talentGroup"] = 1,
					["specGroup"] = 1,
				},
			},
		},
	},
	["global"] = {
		["unitframe"] = {
			["aurafilters"] = {
				["Blacklist"] = {
					["spells"] = {
						["Well Fed"] = {
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
						["Lightning Shield"] = {
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
						["color"] = {
							["r"] = 0.9725490196078431,
							["g"] = 0,
							["b"] = 1,
						},
						["style"] = "coloredIcon",
					},
					[10] = {
						["enabled"] = true,
						["anyUnit"] = true,
						["point"] = "RIGHT",
						["id"] = 47753,
						["displayText"] = false,
						["color"] = {
							["r"] = 1,
							["g"] = 0.996078431372549,
							["b"] = 0,
						},
						["style"] = "coloredIcon",
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
				["reputation"] = {
					["height"] = 15,
					["textSize"] = 6,
					["mouseover"] = true,
				},
				["vendorGrays"] = true,
				["movertransparancy"] = 1,
				["experience"] = {
					["enable"] = false,
					["textSize"] = 6,
					["height"] = 15,
				},
				["threat"] = {
					["enable"] = false,
				},
			},
			["movers"] = {
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-42344",
				["FarmToolAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-499",
				["RaidMarkerBarAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT107223",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM0296",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM057",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM073",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0103",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5185",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0190",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-36",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-31226",
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
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT-9-166",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-465151",
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
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["auraBarBuff"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
					["health"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
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
					["player"] = {
						["restIcon"] = false,
						["buffs"] = {
							["useFilter"] = "Blacklist",
						},
						["portrait"] = {
							["overlay"] = true,
							["rotation"] = 307,
							["camDistanceScale"] = 2.24,
							["enable"] = true,
						},
						["castbar"] = {
							["displayTarget"] = true,
							["width"] = 440,
						},
					},
					["boss"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:current-percent]",
						},
						["width"] = 200,
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
					["target"] = {
						["name"] = {
							["text_format"] = "[namecolor][name] [difficultycolor][smartlevel] [shortclassification]",
						},
						["portrait"] = {
							["overlay"] = true,
							["rotation"] = 307,
							["camDistanceScale"] = 2.24,
							["enable"] = true,
						},
						["smartAuraDisplay"] = "SHOW_DEBUFFS_ON_FRIENDLIES",
						["classicon"] = {
							["enable"] = false,
						},
						["buffs"] = {
							["playerOnly"] = {
								["friendly"] = true,
							},
						},
						["power"] = {
							["hideonnpc"] = false,
						},
						["aurabar"] = {
							["enable"] = false,
							["attachTo"] = "BUFFS",
						},
					},
					["assist"] = {
						["enable"] = false,
					},
					["arena"] = {
						["width"] = 200,
						["castbar"] = {
							["width"] = 200,
						},
					},
					["raid25"] = {
						["height"] = 40,
						["rdebuffs"] = {
							["xOffset"] = 0,
							["yOffset"] = 0,
							["size"] = 15,
						},
						["health"] = {
							["frequentUpdates"] = true,
						},
						["healPrediction"] = true,
					},
					["party"] = {
						["horizontalSpacing"] = 5,
						["debuffs"] = {
							["anchorPoint"] = "BOTTOMLEFT",
							["sizeOverride"] = 0,
							["initialAnchor"] = "TOPLEFT",
							["useFilter"] = "Blacklist",
						},
						["power"] = {
							["text_format"] = "",
						},
						["enable"] = false,
						["healPrediction"] = true,
						["growthDirection"] = "RIGHT_UP",
						["targetsGroup"] = {
							["anchorPoint"] = "TOP",
							["initialAnchor"] = "BOTTOM",
							["xOffset"] = 0,
							["width"] = 80,
							["yOffset"] = 1,
						},
						["health"] = {
							["orientation"] = "VERTICAL",
							["text_format"] = "[healthcolor][health:deficit]",
							["frequentUpdates"] = true,
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
							["width"] = 80,
							["xOffset"] = 0,
							["yOffset"] = 1,
						},
						["roleIcon"] = {
							["position"] = "BOTTOMLEFT",
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
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["Actionbar5DataPanel"] = "Cecile Meter Overlay",
				},
				["actionbar1"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["mouseover"] = true,
					["backdrop"] = true,
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
					["point"] = "TOPLEFT",
					["mouseover"] = true,
					["backdrop"] = true,
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
			["auras"] = {
				["consolidatedBuffs"] = {
					["filter"] = false,
				},
			},
			["watchframe"] = {
				["raid"] = "HIDDEN",
			},
		},
		["Majandra"] = {
			["currentTutorial"] = 1,
			["bags"] = {
				["currencyFormat"] = "ICON",
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["tabFont"] = "ElvUI Font",
				["panelTabTransparency"] = true,
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
			["movers"] = {
				["ElvAB_8"] = "TOPLEFTElvUIParentTOPLEFT41-380",
				["RaidMarkerBarAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT107223",
				["MinimapButtonAnchor"] = "TOPRIGHTElvUIParentTOPRIGHT-6-161",
				["BuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-171-4",
				["ElvUF_Raid10Mover"] = "BOTTOMElvUIParentBOTTOM0177",
				["BossButton"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-164280",
				["AurasMover"] = "TOPRIGHTElvUIParentTOPRIGHT-169-4",
				["ElvUF_FocusMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-544328",
				["MicrobarMover"] = "TOPLEFTElvUIParentTOPLEFT4-4",
				["ElvUF_Raid25Mover"] = "BOTTOMElvUIParentBOTTOM063",
				["ElvUF_TargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-464242",
				["FarmToolAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-499",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["FarmPortalAnchor"] = "TOPLEFTElvUIParentTOPLEFT4-458",
				["ElvAB_9"] = "TOPLEFTElvUIParentTOPLEFT41-421",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-465151",
				["ElvAB_4"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5185",
				["PetAB"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-42344",
				["AltPowerBarMover"] = "TOPElvUIParentTOP0-36",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM-31226",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM31326",
				["ElvUF_Raid40Mover"] = "BOTTOMElvUIParentBOTTOM063",
				["TempEnchantMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-255",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM0298",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-195",
				["ElvAB_2"] = "TOPLEFTElvUIParentTOPLEFT0-335",
				["FarmSeedAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4222",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5223",
				["ElvAB_6"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4185",
				["ElvAB_10"] = "TOPLEFTElvUIParentTOPLEFT41-462",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT49394",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT283223",
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-48-308",
				["ElvAB_7"] = "TOPLEFTElvUIParentTOPLEFT41-335",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0232",
				["AlertFrameMover"] = "BOTTOMElvUIParentBOTTOM0472",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-171-100",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-3",
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
							["countFontSize"] = 8,
							["sizeOverride"] = 10,
							["yOffset"] = 34,
							["anchorPoint"] = "BOTTOMRIGHT",
							["enable"] = true,
						},
						["GPSArrow"] = {
							["onMouseOver"] = false,
						},
						["roleIcon"] = {
							["enable"] = false,
						},
						["power"] = {
							["height"] = 8,
						},
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 48,
						["buffs"] = {
							["countFontSize"] = 7,
							["fontSize"] = 8,
							["numrows"] = 2,
							["sizeOverride"] = 12,
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
					["player"] = {
						["portrait"] = {
							["rotation"] = 307,
							["enable"] = true,
							["overlay"] = true,
							["camDistanceScale"] = 2.24,
						},
						["restIcon"] = false,
						["buffs"] = {
							["useFilter"] = "Blacklist",
						},
						["castbar"] = {
							["width"] = 412,
							["displayTarget"] = true,
							["height"] = 22,
						},
					},
					["raid40"] = {
						["health"] = {
							["text"] = true,
						},
						["height"] = 24,
					},
					["raid25"] = {
						["rdebuffs"] = {
							["xOffset"] = 0,
							["yOffset"] = 0,
							["size"] = 15,
						},
						["healPrediction"] = true,
						["health"] = {
							["frequentUpdates"] = true,
						},
						["height"] = 40,
					},
					["arena"] = {
						["castbar"] = {
							["width"] = 200,
						},
						["width"] = 200,
					},
					["target"] = {
						["portrait"] = {
							["rotation"] = 307,
							["enable"] = true,
							["overlay"] = true,
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
					["party"] = {
						["horizontalSpacing"] = 3,
						["debuffs"] = {
							["enable"] = false,
							["initialAnchor"] = "TOPLEFT",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:short]",
							["position"] = "TOP",
						},
						["growthDirection"] = "RIGHT_DOWN",
						["power"] = {
							["text_format"] = "",
						},
						["roleIcon"] = {
							["enable"] = false,
							["position"] = "BOTTOMRIGHT",
						},
						["targetsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["GPSArrow"] = {
							["onMouseOver"] = false,
							["size"] = 40,
						},
						["width"] = 80,
						["health"] = {
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
							["text_format"] = "[healthcolor][health:deficit]",
						},
						["petsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
					},
				},
				["statusbar"] = "Aluminium",
				["colors"] = {
					["auraBarBuff"] = {
						["r"] = 0.1,
						["g"] = 0.1,
						["b"] = 0.1,
					},
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
				},
				["fontOutline"] = "NONE",
				["font"] = "ElvUI Font",
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
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
					["Actionbar5DataPanel"] = "Cecile Meter Overlay",
				},
				["font"] = "Cecile",
				["actionbar3"] = true,
				["actionbar1"] = true,
			},
			["actionbar"] = {
				["bar3"] = {
					["buttons"] = 12,
					["backdrop"] = true,
				},
				["fontSize"] = 11,
				["fontOutline"] = "OUTLINE",
				["bar2"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
					["buttonsPerRow"] = 1,
					["mouseover"] = true,
				},
				["bar5"] = {
					["point"] = "TOPLEFT",
					["buttons"] = 12,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["font"] = "ElvUI Font",
				["bar6"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
				},
				["macrotext"] = true,
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
				["topPanel"] = false,
				["autoRoll"] = true,
				["experience"] = {
					["height"] = 15,
					["enable"] = false,
					["textSize"] = 6,
				},
				["vendorGrays"] = true,
				["reputation"] = {
					["textSize"] = 6,
					["height"] = 15,
					["mouseover"] = true,
				},
			},
		},
		["Majandra - Dragonblight"] = {
		},
		["Shenlu - Dragonblight"] = {
			["currentTutorial"] = 1,
			["general"] = {
				["valuecolor"] = {
					["b"] = 0.59,
					["g"] = 1,
					["r"] = 0,
				},
				["bordercolor"] = {
					["b"] = 0.31,
					["g"] = 0.31,
					["r"] = 0.31,
				},
				["bottomPanel"] = false,
				["topPanel"] = false,
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_TargetTargetMover"] = "BOTTOMElvUIParentBOTTOM0110",
				["ElvUF_PlayerCastbarMover"] = "BOTTOMElvUIParentBOTTOM042",
				["ElvAB_1"] = "BOTTOMElvUIParentBOTTOM026",
				["ElvAB_2"] = "BOTTOMElvUIParentBOTTOM038",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM31022",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-278110",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-31022",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["ElvUF_TargetMover"] = "BOTTOMElvUIParentBOTTOM278110",
			},
			["layoutSet"] = "dpsCaster",
			["unitframe"] = {
				["colors"] = {
					["auraBarBuff"] = {
						["b"] = 0.59,
						["g"] = 1,
						["r"] = 0,
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
					["raid25"] = {
						["debuffs"] = {
							["sizeOverride"] = 16,
						},
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
				},
			},
			["hideTutorial"] = 1,
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
					["Actionbar5DataPanel"] = "DPS",
					["Actionbar3DataPanel"] = "Spell/Heal Power",
					["LeftChatDataPanel"] = {
						["right"] = "Durability",
						["left"] = "Guild",
						["middle"] = "Friends",
					},
				},
				["actionbar3"] = true,
			},
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Jolokia - Dragonblight"] = "Jolokia - Dragonblight",
		["Cellestia - Terenas"] = "Cellestia - Terenas",
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra - Dragonblight",
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
				["minimapbar"] = {
					["buttonSize"] = 20,
				},
				["glossTex"] = "Graphite",
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
		["Jolobank - Dragonblight"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "5.96",
		},
		["Majandra - Dragonblight"] = {
			["general"] = {
				["minimapbar"] = {
					["buttonSize"] = 24,
					["backdrop"] = true,
				},
				["normTex"] = "Aluminium",
				["autorepchange"] = false,
				["dmgfont"] = "ElvUI Alt-Font",
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
				["DBMFontSize"] = 11,
				["BigWigsHalfBar"] = false,
				["TransparentEmbed"] = true,
				["DBMSkinHalf"] = true,
				["DBMFont"] = "Arm Wrestler",
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
					["EmbedalDamageMeter"] = false,
					["EmbedMain"] = "Skada",
					["EmbedSystemDual"] = true,
				},
			},
			["theme"] = "class",
			["install_complete"] = "5.99",
		},
	},
}
