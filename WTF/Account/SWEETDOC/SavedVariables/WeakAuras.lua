
WeakAurasSaved = {
	["login_squelch_time"] = 5,
	["registered"] = {
	},
	["frame"] = {
		["xOffset"] = -261.9979248046875,
		["yOffset"] = -12,
		["height"] = 500.0000610351563,
		["width"] = 610.0001220703125,
	},
	["tempIconCache"] = {
		["Evangelism"] = "Interface\\Icons\\Spell_Holy_DivineIllumination",
		["Tidal Waves"] = "Interface\\Icons\\Spell_Shaman_TidalWaves",
		["Serendipity"] = "Interface\\Icons\\Spell_Holy_Serendipity",
		["Divine Insight"] = "Interface\\Icons\\spell_priest_burningwill",
	},
	["displays"] = {
		["Evangelism"] = {
			["xOffset"] = 0,
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "preset",
					["preset"] = "shrink",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "preset",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["trigger"] = {
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["remaining"] = "0",
				["custom_hide"] = "timed",
				["type"] = "aura",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["countOperator"] = "==",
				["event"] = "Action Usable",
				["debuffType"] = "HELPFUL",
				["use_remaining"] = true,
				["use_spellName"] = true,
				["count"] = "5",
				["unevent"] = "auto",
				["subeventPrefix"] = "SPELL",
				["use_inverse"] = false,
				["names"] = {
					"Evangelism", -- [1]
				},
				["spellName"] = 81700,
			},
			["stickyDuration"] = false,
			["progressPrecision"] = 0,
			["font"] = "Arm Wrestler",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["fontSize"] = 15,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["cooldown"] = false,
			["desaturate"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = false,
			["id"] = "Evangelism",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["custom_hide"] = "timed",
						["subeventSuffix"] = "_CAST_START",
						["countOperator"] = ">",
						["subeventPrefix"] = "SPELL",
						["names"] = {
							"Evangelism", -- [1]
						},
						["use_spellName"] = true,
						["count"] = "4",
						["use_unit"] = true,
						["spellName"] = 81700,
						["unit"] = "player",
						["event"] = "Action Usable",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["spellName"] = 81700,
					},
				}, -- [1]
			},
			["inverse"] = false,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["disjunctive"] = true,
			["selfPoint"] = "CENTER",
			["numTriggers"] = 2,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
					["do_custom"] = false,
				},
			},
			["untrigger"] = {
				["spellName"] = 81700,
			},
			["displayIcon"] = "Interface\\Icons\\Ability_Priest_Archangel",
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				0, -- [1]
				1, -- [2]
				0.3058823529411765, -- [3]
				1, -- [4]
			},
		},
		["Power Infusion"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 10060,
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["use_remaining"] = false,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["use_talent"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = 14,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["stacksPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 10060,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["id"] = "Power Infusion",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 10060,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 10060,
					},
				}, -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Rapture"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["borderBackdrop"] = "None",
			["xOffset"] = -530.1038818359375,
			["stacksFlags"] = "None",
			["yOffset"] = -446.2668151855469,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["rotateText"] = "LEFT",
			["textSize"] = 15,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["sourceunit"] = "player",
				["duration"] = "12",
				["names"] = {
					"Borrowed Time", -- [1]
				},
				["custom_hide"] = "timed",
				["type"] = "event",
				["subeventSuffix"] = "_ENERGIZE",
				["ownOnly"] = true,
				["event"] = "Combat Log",
				["spellName"] = "Rapture",
				["powerType"] = 0,
				["use_spellName"] = true,
				["unevent"] = "timed",
				["use_sourceunit"] = true,
				["use_powerType"] = true,
				["unit"] = "player",
				["debuffType"] = "HELPFUL",
				["subeventPrefix"] = "SPELL",
			},
			["text"] = false,
			["barColor"] = {
				0.5843137254901961, -- [1]
				0.7803921568627451, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
			},
			["height"] = 180,
			["timer"] = false,
			["timerFlags"] = "None",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["barInFront"] = false,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["numTriggers"] = 1,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacks"] = false,
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["border"] = true,
			["borderEdge"] = "Square Outline",
			["regionType"] = "aurabar",
			["borderSize"] = 17,
			["alpha"] = 1,
			["icon_side"] = "RIGHT",
			["stacksFont"] = "Friz Quadrata TT",
			["id"] = "Rapture",
			["auto"] = true,
			["texture"] = "Graphite",
			["textFont"] = "DorisPP",
			["borderOffset"] = 4,
			["timerSize"] = 15,
			["displayTextRight"] = "%p",
			["additional_triggers"] = {
			},
			["timerFont"] = "DorisPP",
			["frameStrata"] = 1,
			["width"] = 22.99997138977051,
			["icon"] = true,
			["borderInset"] = 29,
			["inverse"] = false,
			["stickyDuration"] = false,
			["orientation"] = "VERTICAL_INVERSE",
			["displayIcon"] = "Interface\\Icons\\Spell_Holy_Rapture",
			["displayTextLeft"] = "%n",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Pain Suppression"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 33206,
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["use_remaining"] = false,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["cooldown"] = true,
			["untrigger"] = {
				["spellName"] = 33206,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["id"] = "Pain Suppression",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 33206,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 33206,
					},
				}, -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["inverse"] = false,
			["xOffset"] = 0,
			["numTriggers"] = 2,
			["disjunctive"] = true,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Serendipity (Holy)"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["preset"] = "shrink",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "shrink",
				},
			},
			["trigger"] = {
				["spellName"] = 47540,
				["use_remaining"] = false,
				["use_inverse"] = false,
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["debuffType"] = "HELPFUL",
				["remaining"] = "0",
				["unevent"] = "auto",
				["names"] = {
					"Serendipity", -- [1]
				},
				["use_spellName"] = true,
				["unit"] = "player",
				["type"] = "aura",
				["custom_hide"] = "timed",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["untrigger"] = {
				["spellName"] = 47540,
			},
			["additional_triggers"] = {
			},
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["id"] = "Serendipity (Holy)",
			["inverse"] = false,
			["disjunctive"] = true,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Prayer of Mending"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["preset"] = "shrink",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
					["type"] = "preset",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["remaining_operator"] = "<=",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
				},
				["remaining"] = "0",
				["use_spellName"] = true,
				["spellName"] = 33076,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.20010375976563,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["stacksPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 33076,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["id"] = "Prayer of Mending",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 33076,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 33076,
					},
				}, -- [1]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Circle of Healing"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["spellName"] = 34861,
				["unevent"] = "auto",
				["use_remaining"] = false,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 34861,
					},
					["untrigger"] = {
						["spellName"] = 34861,
					},
				}, -- [1]
			},
			["untrigger"] = {
				["spellName"] = 34861,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["id"] = "Circle of Healing",
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Cooldowns Disc"] = {
			["grow"] = "HORIZONTAL",
			["controlledChildren"] = {
				"Prayer of Mending", -- [1]
				"Cascade", -- [2]
				"Spirit Shell", -- [3]
				"Pain Suppression", -- [4]
				"PW:Barrier", -- [5]
				"Shadowfiend", -- [6]
				"Power Infusion", -- [7]
				"Holy Fire", -- [8]
				"Penance", -- [9]
				"Evangelism", -- [10]
			},
			["animate"] = true,
			["anchorPoint"] = "CENTER",
			["xOffset"] = 0,
			["borderOffset"] = 16,
			["border"] = "None",
			["yOffset"] = -196.0000915527344,
			["sortHybridTable"] = {
				[3] = true,
				[4] = true,
				[5] = true,
			},
			["id"] = "Cooldowns Disc",
			["sort"] = "none",
			["backgroundInset"] = 0,
			["space"] = 8,
			["background"] = "None",
			["expanded"] = false,
			["constantFactor"] = "RADIUS",
			["align"] = "CENTER",
			["radius"] = 200,
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 423.9999389648438,
			["stagger"] = 0,
			["untrigger"] = {
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["height"] = 35.20010375976563,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["regionType"] = "dynamicgroup",
		},
		["Lightwell"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 724,
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["use_remaining"] = false,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["use_talent"] = false,
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["talent"] = 14,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Lightwell",
			["untrigger"] = {
				["spellName"] = 724,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 724,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 724,
					},
				}, -- [1]
			},
			["stickyDuration"] = false,
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Prayer of Mending (Holy)"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["preset"] = "shrink",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["use_inverse"] = false,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["use_spellName"] = true,
				["remaining"] = "0",
				["spellName"] = 33076,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.20010375976563,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Prayer of Mending (Holy)",
			["untrigger"] = {
				["spellName"] = 33076,
			},
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 33076,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 33076,
					},
				}, -- [1]
			},
			["stickyDuration"] = false,
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["PW:Barrier"] = {
			["parent"] = "Cooldowns Disc",
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["type"] = "none",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["trigger"] = {
				["debuffType"] = "HELPFUL",
				["type"] = "status",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["remaining_operator"] = "<=",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["spellName"] = 62618,
				["custom_hide"] = "timed",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["stickyDuration"] = false,
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 62618,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 62618,
					},
				}, -- [1]
			},
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["numTriggers"] = 2,
			["disjunctive"] = true,
			["id"] = "PW:Barrier",
			["untrigger"] = {
				["spellName"] = 62618,
			},
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Spirit Shell"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["spellName"] = 109964,
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["use_remaining"] = false,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["cooldown"] = true,
			["untrigger"] = {
				["spellName"] = 109964,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 109964,
					},
					["untrigger"] = {
						["spellName"] = 109964,
					},
				}, -- [1]
			},
			["id"] = "Spirit Shell",
			["disjunctive"] = true,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Cooldowns Holy"] = {
			["grow"] = "HORIZONTAL",
			["controlledChildren"] = {
				"Prayer of Mending (Holy)", -- [1]
				"Cascade (Holy)", -- [2]
				"Circle of Healing", -- [3]
				"Guardian Spirit", -- [4]
				"Divine Hymn", -- [5]
				"Lightwell", -- [6]
				"Shadowfiend (Holy)", -- [7]
				"Divine Insight", -- [8]
				"Serendipity (Holy)", -- [9]
			},
			["animate"] = true,
			["regionType"] = "dynamicgroup",
			["xOffset"] = 0,
			["backgroundInset"] = 0,
			["border"] = "None",
			["yOffset"] = -196.0000915527344,
			["anchorPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "aura",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["event"] = "Health",
				["subeventPrefix"] = "SPELL",
			},
			["sort"] = "none",
			["radius"] = 200,
			["space"] = 8,
			["background"] = "None",
			["expanded"] = true,
			["constantFactor"] = "RADIUS",
			["id"] = "Cooldowns Holy",
			["borderOffset"] = 16,
			["align"] = "CENTER",
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["additional_triggers"] = {
			},
			["rotation"] = 0,
			["frameStrata"] = 1,
			["width"] = 380.7999572753906,
			["stagger"] = 0,
			["untrigger"] = {
			},
			["numTriggers"] = 1,
			["selfPoint"] = "CENTER",
			["height"] = 35.20010375976563,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["sortHybridTable"] = {
				[3] = true,
				[4] = true,
				[5] = true,
			},
		},
		["Cascade"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["preset"] = "shrink",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
					["type"] = "preset",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 121135,
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["use_remaining"] = false,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.20003890991211,
			["load"] = {
				["use_talent"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["use_spec"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["talent"] = 16,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["cooldown"] = true,
			["untrigger"] = {
				["spellName"] = 121135,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 121135,
					},
					["untrigger"] = {
						["spellName"] = 121135,
					},
				}, -- [1]
			},
			["id"] = "Cascade",
			["disjunctive"] = true,
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Holy Fire"] = {
			["parent"] = "Cooldowns Disc",
			["untrigger"] = {
				["spellName"] = 14914,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "preset",
					["preset"] = "shrink",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "preset",
					["preset"] = "alphaPulse",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["trigger"] = {
				["debuffType"] = "HELPFUL",
				["type"] = "status",
				["subeventPrefix"] = "SPELL",
				["unevent"] = "auto",
				["use_unit"] = true,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
				},
				["subeventSuffix"] = "_CAST_START",
				["remaining"] = "0",
				["unit"] = "player",
				["spellName"] = 14914,
				["use_spellName"] = true,
				["use_inverse"] = false,
				["use_remaining"] = false,
				["custom_hide"] = "timed",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["stickyDuration"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 14914,
					},
					["untrigger"] = {
						["spellName"] = 14914,
					},
				}, -- [1]
			},
			["id"] = "Holy Fire",
			["disjunctive"] = true,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["yOffset"] = 0,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Global"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["borderBackdrop"] = "None",
			["xOffset"] = -1.10302734375,
			["stacksFlags"] = "None",
			["barInFront"] = false,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["rotateText"] = "NONE",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["sourceunit"] = "player",
				["ownOnly"] = true,
				["names"] = {
					"Borrowed Time", -- [1]
				},
				["custom_hide"] = "timed",
				["type"] = "status",
				["unevent"] = "auto",
				["use_unit"] = true,
				["subeventPrefix"] = "SPELL",
				["event"] = "Global Cooldown",
				["debuffType"] = "HELPFUL",
				["use_spellName"] = true,
				["powerType"] = 0,
				["subeventSuffix"] = "_ENERGIZE",
				["use_sourceunit"] = true,
				["use_powerType"] = true,
				["unit"] = "player",
				["spellName"] = 2061,
				["duration"] = "12",
			},
			["text"] = false,
			["barColor"] = {
				0.9490196078431372, -- [1]
				1, -- [2]
				0.9686274509803922, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["displayTextLeft"] = "%n",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["untrigger"] = {
				["spellName"] = 2061,
			},
			["timer"] = false,
			["height"] = 2.999956607818604,
			["timerFlags"] = "None",
			["load"] = {
				["class"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["stickyDuration"] = false,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["inverse"] = false,
			["yOffset"] = -250.2671203613281,
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["icon"] = false,
			["stacksFont"] = "Friz Quadrata TT",
			["border"] = true,
			["borderEdge"] = "Square Outline",
			["regionType"] = "aurabar",
			["stacks"] = false,
			["frameStrata"] = 1,
			["icon_side"] = "RIGHT",
			["borderOffset"] = 4,
			["additional_triggers"] = {
			},
			["displayTextRight"] = "%p",
			["texture"] = "Blizzard",
			["textFont"] = "DorisPP",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["auto"] = true,
			["timerSize"] = 15,
			["id"] = "Global",
			["timerFont"] = "DorisPP",
			["alpha"] = 1,
			["width"] = 444.0000305175781,
			["borderSize"] = 17,
			["borderInset"] = 29,
			["numTriggers"] = 1,
			["textSize"] = 15,
			["orientation"] = "HORIZONTAL_INVERSE",
			["displayIcon"] = "Interface\\Icons\\Spell_Holy_Rapture",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.4600000381469727, -- [4]
			},
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Shadowfiend"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["preset"] = "shrink",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
					["type"] = "preset",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["spellName"] = 123040,
				["unevent"] = "auto",
				["use_unit"] = true,
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["remaining"] = "0",
				["remaining_operator"] = "==",
				["use_remaining"] = false,
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["stacksPoint"] = "CENTER",
			["untrigger"] = {
				["spellName"] = 123040,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
			},
			["id"] = "Shadowfiend",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["inverse"] = false,
			["xOffset"] = 0,
			["numTriggers"] = 1,
			["disjunctive"] = false,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Penance"] = {
			["disjunctive"] = true,
			["untrigger"] = {
				["spellName"] = 47540,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["preset"] = "shrink",
					["type"] = "preset",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["preset"] = "alphaPulse",
					["type"] = "preset",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["use_inverse"] = false,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["subeventPrefix"] = "SPELL",
				["use_spellName"] = true,
				["remaining"] = "0",
				["spellName"] = 47540,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["stickyDuration"] = false,
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["yOffset"] = 0,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 47540,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 47540,
					},
				}, -- [1]
			},
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["parent"] = "Cooldowns Disc",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["id"] = "Penance",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Guardian Spirit"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 47788,
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["use_remaining"] = false,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Guardian Spirit",
			["untrigger"] = {
				["spellName"] = 47788,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 47788,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 47788,
					},
				}, -- [1]
			},
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Divine Insight"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["preset"] = "shrink",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 14914,
				["type"] = "aura",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["remaining_operator"] = "<=",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["use_spellName"] = true,
				["remaining"] = "0",
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
					"Divine Insight", -- [1]
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "Divine Insight",
			["untrigger"] = {
				["spellName"] = 14914,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["additional_triggers"] = {
			},
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Divine Hymn"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 64843,
				["type"] = "status",
				["use_remaining"] = false,
				["unevent"] = "auto",
				["remaining_operator"] = "<=",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["use_spellName"] = true,
				["remaining"] = "0",
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
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
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["untrigger"] = {
				["spellName"] = 64843,
			},
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["spellName"] = 64843,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 64843,
					},
				}, -- [1]
			},
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["id"] = "Divine Hymn",
			["inverse"] = false,
			["disjunctive"] = true,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Cascade (Holy)"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["preset"] = "shrink",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["spellName"] = 121135,
				["type"] = "status",
				["custom_hide"] = "timed",
				["unevent"] = "auto",
				["use_remaining"] = false,
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.20003890991211,
			["load"] = {
				["use_talent"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
					},
				},
				["talent"] = 16,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["stacksPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 121135,
					},
					["untrigger"] = {
						["spellName"] = 121135,
					},
				}, -- [1]
			},
			["untrigger"] = {
				["spellName"] = 121135,
			},
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["id"] = "Cascade (Holy)",
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Shadowfiend (Holy)"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["preset"] = "shrink",
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["type"] = "preset",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["trigger"] = {
				["custom_hide"] = "timed",
				["type"] = "status",
				["spellName"] = 123040,
				["unevent"] = "auto",
				["use_remaining"] = false,
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["remaining_operator"] = "==",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.2,
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_combat"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Holy",
			["cooldown"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 123040,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = false,
			["id"] = "Shadowfiend (Holy)",
			["stickyDuration"] = false,
			["stacksPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
	},
}
