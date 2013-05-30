
WeakAurasSaved = {
	["login_squelch_time"] = 5,
	["registered"] = {
	},
	["frame"] = {
		["xOffset"] = -1297.999755859375,
		["width"] = 630,
		["height"] = 492,
		["yOffset"] = -12,
	},
	["tempIconCache"] = {
		["Tidal Waves"] = "Interface\\Icons\\Spell_Shaman_TidalWaves",
	},
	["displays"] = {
		["Tidal Waves"] = {
			["fontSize"] = 12,
			["displayStacks"] = "%s",
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
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = false,
			["untrigger"] = {
				["totemType"] = 3,
				["spellName"] = 53390,
			},
			["yOffset"] = -40,
			["anchorPoint"] = "CENTER",
			["regionType"] = "icon",
			["xOffset"] = 122.0010375976563,
			["numTriggers"] = 1,
			["customTextUpdate"] = "update",
			["selfPoint"] = "CENTER",
			["icon"] = true,
			["id"] = "Tidal Waves",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
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
			["trigger"] = {
				["use_form"] = true,
				["spellId"] = "53390",
				["remaining_operator"] = "<",
				["unit"] = "player",
				["ownOnly"] = true,
				["remaining"] = "2",
				["names"] = {
					"Tidal Waves", -- [1]
				},
				["use_totemName"] = true,
				["debuffType"] = "HELPFUL",
				["type"] = "aura",
				["use_powertype"] = false,
				["spellName"] = 53390,
				["inverse"] = true,
				["name_operator"] = "==",
				["unevent"] = "auto",
				["subeventSuffix"] = "_CAST_START",
				["use_inverse"] = false,
				["totemName"] = "Healing Stream Totem",
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["use_name"] = true,
				["use_spellName"] = true,
				["name"] = "Tidal Waves",
				["use_remaining"] = true,
				["use_totemType"] = true,
				["use_unit"] = true,
				["subeventPrefix"] = "SPELL",
				["fullscan"] = true,
			},
			["width"] = 40,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["height"] = 40,
			["displayIcon"] = "Interface\\Icons\\Spell_Shaman_TidalWaves",
			["stacksPoint"] = "BOTTOMRIGHT",
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
			["cooldown"] = false,
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
				["totemType"] = 3,
				["spellName"] = 73680,
			},
			["regionType"] = "icon",
			["yOffset"] = -120,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
					["do_message"] = false,
					["do_custom"] = false,
				},
				["finish"] = {
				},
			},
			["customTextUpdate"] = "update",
			["numTriggers"] = 1,
			["icon"] = true,
			["id"] = "Unleash Elements",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["use_totemName"] = true,
				["subeventPrefix"] = "SPELL",
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["use_remaining"] = true,
				["unevent"] = "auto",
				["remaining_operator"] = "~=",
				["totemName"] = "Healing Stream Totem",
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["use_inverse"] = true,
				["use_spellName"] = true,
				["names"] = {
				},
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["spellName"] = 73680,
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
			["stacksPoint"] = "BOTTOMRIGHT",
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
			["cooldown"] = false,
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
				["spellName"] = 120668,
				["totemType"] = 3,
			},
			["anchorPoint"] = "CENTER",
			["yOffset"] = -120,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
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
				["use_unit"] = true,
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["spellName"] = 120668,
				["unit"] = "player",
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["subeventPrefix"] = "SPELL",
				["use_spellName"] = true,
				["unevent"] = "auto",
				["use_remaining"] = true,
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
			["id"] = "Stormlash",
			["width"] = 40,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["icon"] = true,
			["height"] = 40,
			["regionType"] = "icon",
			["stacksPoint"] = "BOTTOMRIGHT",
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
			["untrigger"] = {
				["totemType"] = 3,
				["spellName"] = 5394,
			},
			["cooldown"] = false,
			["yOffset"] = -199.9999084472656,
			["anchorPoint"] = "CENTER",
			["regionType"] = "icon",
			["xOffset"] = 122.0010375976563,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["customTextUpdate"] = "update",
			["numTriggers"] = 1,
			["icon"] = true,
			["id"] = "Healing Stream",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
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
			["trigger"] = {
				["remaining_operator"] = "~=",
				["subeventPrefix"] = "SPELL",
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["use_remaining"] = true,
				["unevent"] = "auto",
				["use_inverse"] = true,
				["totemType"] = 3,
				["event"] = "Cooldown Progress (Spell)",
				["totemName"] = "Healing Stream Totem",
				["use_totemName"] = true,
				["use_spellName"] = true,
				["names"] = {
				},
				["type"] = "status",
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["spellName"] = 5394,
				["use_unit"] = true,
			},
			["desaturate"] = false,
			["frameStrata"] = 1,
			["stickyDuration"] = false,
			["width"] = 40,
			["font"] = "Friz Quadrata TT",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["height"] = 40,
			["stacksPoint"] = "BOTTOMRIGHT",
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
			["cooldown"] = false,
			["stacksPoint"] = "BOTTOMRIGHT",
			["yOffset"] = -199.9998168945313,
			["regionType"] = "icon",
			["anchorPoint"] = "CENTER",
			["xOffset"] = -122.0001220703125,
			["selfPoint"] = "CENTER",
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
				["use_inverse"] = true,
				["subeventPrefix"] = "SPELL",
				["remaining"] = "10",
				["use_totemType"] = true,
				["debuffType"] = "HELPFUL",
				["type"] = "status",
				["unevent"] = "auto",
				["use_unit"] = true,
				["spellName"] = 73920,
				["event"] = "Cooldown Progress (Spell)",
				["totemType"] = 3,
				["unit"] = "player",
				["use_spellName"] = true,
				["subeventSuffix"] = "_CAST_START",
				["use_remaining"] = true,
				["names"] = {
				},
				["remaining_operator"] = "~=",
				["totemName"] = "Healing Stream Totem",
				["use_totemName"] = true,
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
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "bounce",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["id"] = "Healing Rain",
			["width"] = 40,
			["frameStrata"] = 1,
			["desaturate"] = false,
			["stickyDuration"] = false,
			["font"] = "Friz Quadrata TT",
			["numTriggers"] = 1,
			["icon"] = true,
			["height"] = 40,
			["untrigger"] = {
				["spellName"] = 73920,
				["totemType"] = 3,
			},
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
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
	},
}
