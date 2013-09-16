
WeakAurasSaved = {
	["login_squelch_time"] = 5,
	["registered"] = {
	},
	["frame"] = {
		["xOffset"] = -1297.999755859375,
		["yOffset"] = -12,
		["height"] = 492,
		["width"] = 630,
	},
	["tempIconCache"] = {
		["Tidal Waves"] = "Interface\\Icons\\Spell_Shaman_TidalWaves",
	},
	["displays"] = {
		["Tidal Waves"] = {
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["cooldown"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["yOffset"] = -40,
			["untrigger"] = {
				["spellName"] = 53390,
				["totemType"] = 3,
			},
			["anchorPoint"] = "CENTER",
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["inverse"] = false,
			["customTextUpdate"] = "update",
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "grow",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["preset"] = "bounce",
					["type"] = "preset",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["icon"] = true,
			["stickyDuration"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Tidal Waves",
			["desaturate"] = false,
			["frameStrata"] = 1,
			["width"] = 40,
			["trigger"] = {
				["use_form"] = true,
				["spellId"] = "53390",
				["remaining_operator"] = "<",
				["unit"] = "player",
				["ownOnly"] = true,
				["remaining"] = "2",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
				["use_totemType"] = true,
				["use_remaining"] = true,
				["use_powertype"] = false,
				["debuffType"] = "HELPFUL",
				["name"] = "Tidal Waves",
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["unevent"] = "auto",
				["use_inverse"] = false,
				["totemType"] = 3,
				["event"] = "Cooldown Progress (Spell)",
				["totemName"] = "Healing Stream Totem",
				["use_name"] = true,
				["use_spellName"] = true,
				["inverse"] = true,
				["name_operator"] = "==",
				["spellName"] = 53390,
				["use_totemName"] = true,
				["names"] = {
					"Tidal Waves", -- [1]
				},
				["fullscan"] = true,
			},
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["xOffset"] = 122.0010375976563,
			["height"] = 40,
			["displayIcon"] = "Interface\\Icons\\Spell_Shaman_TidalWaves",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Unleash Elements"] = {
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["xOffset"] = -122.0001220703125,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["untrigger"] = {
				["spellName"] = 73680,
				["totemType"] = 3,
			},
			["regionType"] = "icon",
			["anchorPoint"] = "CENTER",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "grow",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "bounce",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["customTextUpdate"] = "update",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["do_message"] = false,
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["trigger"] = {
				["use_totemName"] = true,
				["subeventPrefix"] = "SPELL",
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["use_remaining"] = true,
				["unevent"] = "auto",
				["use_unit"] = true,
				["spellName"] = 73680,
				["event"] = "Cooldown Progress (Spell)",
				["totemName"] = "Healing Stream Totem",
				["unit"] = "player",
				["use_spellName"] = true,
				["subeventSuffix"] = "_CAST_START",
				["type"] = "status",
				["names"] = {
				},
				["use_inverse"] = true,
				["totemType"] = 3,
				["remaining_operator"] = "~=",
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Unleash Elements",
			["desaturate"] = false,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["width"] = 40,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["icon"] = true,
			["height"] = 40,
			["yOffset"] = -120,
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Stormlash"] = {
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["xOffset"] = 122.0010375976563,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["untrigger"] = {
				["totemType"] = 3,
				["spellName"] = 120668,
			},
			["anchorPoint"] = "CENTER",
			["regionType"] = "icon",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["customTextUpdate"] = "update",
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["id"] = "Stormlash",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["remaining_operator"] = "~=",
				["use_unit"] = true,
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["use_inverse"] = true,
				["totemName"] = "Healing Stream Totem",
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["use_totemName"] = true,
				["use_spellName"] = true,
				["names"] = {
				},
				["use_remaining"] = true,
				["unevent"] = "auto",
				["subeventPrefix"] = "SPELL",
				["unit"] = "player",
				["spellName"] = 120668,
			},
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["width"] = 40,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["preset"] = "grow",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "preset",
					["preset"] = "bounce",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["height"] = 40,
			["yOffset"] = -120,
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Healing Stream"] = {
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = -199.9999084472656,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["untrigger"] = {
				["spellName"] = 5394,
				["totemType"] = 3,
			},
			["anchorPoint"] = "CENTER",
			["stacksPoint"] = "BOTTOMRIGHT",
			["xOffset"] = 122.0010375976563,
			["selfPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["trigger"] = {
				["remaining_operator"] = "~=",
				["subeventPrefix"] = "SPELL",
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["use_remaining"] = true,
				["unevent"] = "auto",
				["use_unit"] = true,
				["spellName"] = 5394,
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["unit"] = "player",
				["use_spellName"] = true,
				["subeventSuffix"] = "_CAST_START",
				["type"] = "status",
				["names"] = {
				},
				["use_totemName"] = true,
				["totemName"] = "Healing Stream Totem",
				["use_inverse"] = true,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "grow",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["preset"] = "bounce",
					["type"] = "preset",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "Healing Stream",
			["width"] = 40,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["icon"] = true,
			["height"] = 40,
			["regionType"] = "icon",
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Healing Rain"] = {
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksPoint"] = "BOTTOMRIGHT",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 3,
					["multi"] = {
						[3] = true,
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["yOffset"] = -199.9998168945313,
			["regionType"] = "icon",
			["untrigger"] = {
				["totemType"] = 3,
				["spellName"] = 73920,
			},
			["xOffset"] = -122.0001220703125,
			["icon"] = true,
			["customTextUpdate"] = "update",
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["do_message"] = false,
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["id"] = "Healing Rain",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["use_inverse"] = true,
				["subeventPrefix"] = "SPELL",
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["type"] = "status",
				["unevent"] = "auto",
				["use_totemName"] = true,
				["totemName"] = "Healing Stream Totem",
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["remaining_operator"] = "~=",
				["use_spellName"] = true,
				["names"] = {
				},
				["use_remaining"] = true,
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["spellName"] = 73920,
				["use_unit"] = true,
			},
			["stickyDuration"] = false,
			["frameStrata"] = 1,
			["width"] = 40,
			["desaturate"] = false,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["preset"] = "grow",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "bounce",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["height"] = 40,
			["anchorPoint"] = "CENTER",
			["cooldown"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
	},
}
