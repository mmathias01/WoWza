
ElvDB = {
	["profileKeys"] = {
		["Jolokya - Dragonblight"] = "Jolokya - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra",
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Shenlu - Dragonblight"] = "Shenlu - Dragonblight",
	},
	["gold"] = {
		["Dragonblight"] = {
			["Majandra"] = 47845456,
			["Jolobank"] = 1908845,
			["Jolokia"] = 129292337,
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
			["char"] = {
				["Jolokia - Dragonblight"] = {
					["profile"] = "Cellestia - Resto",
					["enabled"] = true,
					["talentGroup"] = 1,
					["specGroup"] = 1,
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
		["Majandra"] = {
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
					["height"] = 15,
					["textSize"] = 6,
					["enable"] = false,
				},
				["threat"] = {
					["enable"] = false,
				},
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
				["WatchFrameMover"] = "TOPRIGHTElvUIParentTOPRIGHT-48-308",
				["BNETMover"] = "TOPRIGHTElvUIParentTOPRIGHT-4-195",
				["ElvUF_PetMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT283223",
				["TooltipMover"] = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-5223",
				["ElvAB_10"] = "TOPLEFTElvUIParentTOPLEFT41-462",
				["ElvAB_6"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4185",
				["FarmSeedAnchor"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4222",
				["ElvUF_TankMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT49394",
				["ElvAB_2"] = "TOPLEFTElvUIParentTOPLEFT0-335",
				["ElvUF_PlayerMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT464242",
				["ElvAB_7"] = "TOPLEFTElvUIParentTOPLEFT41-335",
				["ElvUF_PartyMover"] = "BOTTOMElvUIParentBOTTOM0232",
				["AlertFrameMover"] = "BOTTOMElvUIParentBOTTOM0472",
				["DebuffsMover"] = "TOPRIGHTElvUIParentTOPRIGHT-171-100",
				["MinimapMover"] = "TOPRIGHTElvUIParentTOPRIGHT-7-3",
			},
			["gridSize"] = 128,
			["bags"] = {
				["currencyFormat"] = "ICON",
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["tabFont"] = "ElvUI Font",
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
						["debuffs"] = {
							["countFontSize"] = 8,
							["sizeOverride"] = 10,
							["enable"] = true,
							["anchorPoint"] = "BOTTOMRIGHT",
							["yOffset"] = 34,
						},
						["health"] = {
							["frequentUpdates"] = true,
						},
						["power"] = {
							["height"] = 8,
						},
						["height"] = 48,
						["healPrediction"] = true,
						["buffs"] = {
							["countFontSize"] = 7,
							["sizeOverride"] = 12,
							["fontSize"] = 8,
							["numrows"] = 2,
						},
						["GPSArrow"] = {
							["onMouseOver"] = false,
						},
					},
					["party"] = {
						["horizontalSpacing"] = 3,
						["debuffs"] = {
							["enable"] = false,
							["initialAnchor"] = "TOPLEFT",
						},
						["power"] = {
							["text_format"] = "",
						},
						["growthDirection"] = "RIGHT_DOWN",
						["targetsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["name"] = {
							["text_format"] = "[namecolor][name:short]",
							["position"] = "TOP",
						},
						["health"] = {
							["text_format"] = "[healthcolor][health:deficit]",
							["frequentUpdates"] = true,
							["position"] = "BOTTOM",
						},
						["width"] = 80,
						["GPSArrow"] = {
							["size"] = 40,
							["onMouseOver"] = false,
						},
						["petsGroup"] = {
							["initialAnchor"] = "BOTTOM",
						},
						["roleIcon"] = {
							["enable"] = false,
							["position"] = "BOTTOMRIGHT",
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
						["health"] = {
							["text"] = true,
						},
						["height"] = 24,
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
							["size"] = 15,
							["yOffset"] = 0,
						},
						["health"] = {
							["frequentUpdates"] = true,
						},
						["healPrediction"] = true,
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
							["height"] = 22,
							["displayTarget"] = true,
							["width"] = 412,
						},
					},
				},
			},
			["datatexts"] = {
				["fontSize"] = 11,
				["actionbar1"] = true,
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
				["font"] = "Cecile",
			},
			["actionbar"] = {
				["bar3"] = {
					["backdrop"] = true,
					["buttons"] = 12,
				},
				["bar6"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["backdrop"] = true,
				},
				["bar2"] = {
					["enabled"] = true,
					["point"] = "TOPLEFT",
					["buttonsPerRow"] = 1,
					["mouseover"] = true,
					["backdrop"] = true,
				},
				["bar1"] = {
					["backdrop"] = true,
				},
				["bar5"] = {
					["backdrop"] = true,
					["point"] = "TOPLEFT",
					["buttons"] = 12,
				},
				["font"] = "ElvUI Font",
				["fontOutline"] = "OUTLINE",
				["macrotext"] = true,
				["fontSize"] = 11,
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
			["tooltip"] = {
				["anchor"] = "ANCHOR",
				["itemCount"] = false,
				["healthBar"] = {
					["font"] = "ElvUI Font",
				},
			},
		},
		["Jolobank - Dragonblight"] = {
			["currentTutorial"] = 2,
			["hideTutorial"] = 1,
		},
		["Majandra - Dragonblight"] = {
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
				["ElvUF_Raid10Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_PetMover"] = "BOTTOMElvUIParentBOTTOM0150",
				["BossButton"] = "BOTTOMElvUIParentBOTTOM0195",
				["ElvUF_PlayerMover"] = "BOTTOMElvUIParentBOTTOM-278110",
				["ElvUF_Raid25Mover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvUF_PartyMover"] = "BOTTOMLEFTElvUIParentBOTTOMLEFT4195",
				["ElvAB_5"] = "BOTTOMElvUIParentBOTTOM-31022",
				["ElvAB_3"] = "BOTTOMElvUIParentBOTTOM31022",
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
		["Jolobank - Dragonblight"] = "Jolobank - Dragonblight",
		["Majandra - Dragonblight"] = "Majandra - Dragonblight",
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
		["Jolobank - Dragonblight"] = {
			["skins"] = {
				["addons"] = {
					["AlwaysTrue"] = true,
				},
			},
			["install_complete"] = "5.96",
		},
		["Majandra - Dragonblight"] = {
			["equipment"] = {
				["secondary"] = "Holy",
				["primary"] = "Disc",
			},
			["general"] = {
				["normTex"] = "Aluminium",
				["minimapbar"] = {
					["backdrop"] = true,
					["buttonSize"] = 24,
				},
				["glossTex"] = "Aluminium",
				["autorepchange"] = false,
				["lootRoll"] = false,
				["dmgfont"] = "ElvUI Alt-Font",
			},
			["addonskins"] = {
				["EmbedSystemDual"] = true,
				["EmbedSkada"] = true,
				["EmbedalDamageMeter"] = false,
				["TransparentEmbed"] = true,
				["DBMSkinHalf"] = true,
				["DBMFontSize"] = 11,
				["DBMFont"] = "Arm Wrestler",
				["BigWigsHalfBar"] = false,
			},
			["skins"] = {
				["blizzard"] = {
					["auctionhouse"] = false,
					["trainer"] = false,
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
			["bags"] = {
				["enable"] = false,
			},
			["theme"] = "class",
			["install_complete"] = "5.99",
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
