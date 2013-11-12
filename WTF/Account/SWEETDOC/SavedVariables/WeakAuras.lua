
WeakAurasSaved = {
	["login_squelch_time"] = 5,
	["registered"] = {
	},
	["frame"] = {
		["xOffset"] = -237.997802734375,
		["yOffset"] = -187.9999389648438,
		["height"] = 500.0000610351563,
		["width"] = 610.0000610351563,
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
			["customText"] = "function()\n    local spellid = select(11, UnitAura(\"player\",\"Evangelism\"))\n    \n    if spellid == 81661 then\n        local stacks = select(4, UnitAura(\"player\",\"Evangelism\"))\n        return stacks, 5, true\n    else\n        return '', 5, true\n    end    \nend",
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
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["debuffType"] = "HELPFUL",
				["event"] = "Action Usable",
				["countOperator"] = "==",
				["use_remaining"] = true,
				["unevent"] = "auto",
				["use_spellName"] = true,
				["count"] = "5",
				["subeventPrefix"] = "SPELL",
				["use_inverse"] = false,
				["names"] = {
					"Evangelism", -- [1]
				},
				["spellName"] = 81700,
				["useCount"] = true,
			},
			["stickyDuration"] = false,
			["progressPrecision"] = 0,
			["font"] = "Collegiate",
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
			["fontSize"] = 10,
			["displayStacks"] = "%c",
			["regionType"] = "icon",
			["parent"] = "Cooldowns Disc",
			["cooldown"] = true,
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
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_inverse"] = false,
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 81700,
					},
					["untrigger"] = {
						["spellName"] = 81700,
					},
				}, -- [1]
			},
			["id"] = "Evangelism",
			["inverse"] = false,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["disjunctive"] = false,
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
				["unit"] = "player",
				["remaining_operator"] = "<=",
				["event"] = "Action Usable",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["remaining"] = "0",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["use_spellName"] = true,
				["use_inverse"] = false,
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
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["use_spec"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
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
			["id"] = "Power Infusion",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
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
				["names"] = {
				},
				["use_spellName"] = true,
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
			["id"] = "Circle of Healing",
			["untrigger"] = {
				["spellName"] = 34861,
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
			["stickyDuration"] = false,
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
				["use_spellName"] = true,
				["powerType"] = 0,
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
			["borderSize"] = 17,
			["stacksFont"] = "Friz Quadrata TT",
			["border"] = true,
			["borderEdge"] = "Square Outline",
			["regionType"] = "aurabar",
			["stacks"] = false,
			["alpha"] = 1,
			["icon_side"] = "RIGHT",
			["borderOffset"] = 4,
			["id"] = "Rapture",
			["displayTextRight"] = "%p",
			["texture"] = "Graphite",
			["textFont"] = "DorisPP",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["auto"] = true,
			["timerSize"] = 15,
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
				["unit"] = "player",
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["remaining"] = "0",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["use_spellName"] = true,
				["use_inverse"] = true,
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
			["parent"] = "Cooldowns Disc",
			["cooldown"] = true,
			["untrigger"] = {
				["spellName"] = 33206,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
			},
			["id"] = "Pain Suppression",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["inverse"] = false,
			["xOffset"] = 0,
			["numTriggers"] = 1,
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
				["names"] = {
				},
				["unevent"] = "auto",
				["subeventPrefix"] = "SPELL",
				["use_inverse"] = true,
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["unit"] = "player",
				["spellName"] = 14914,
				["remaining"] = "0",
				["remaining_operator"] = "<=",
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
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["stickyDuration"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["id"] = "Holy Fire",
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 47540,
					},
					["untrigger"] = {
						["spellName"] = 47540,
					},
				}, -- [1]
			},
			["disjunctive"] = false,
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
					["do_glow"] = false,
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
				["remaining_operator"] = "<=",
				["subeventSuffix"] = "_CAST_START",
				["unit"] = "player",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["subeventPrefix"] = "SPELL",
				["debuffType"] = "HELPFUL",
				["use_spellName"] = true,
				["unevent"] = "auto",
				["names"] = {
					"Serendipity", -- [1]
				},
				["remaining"] = "0",
				["use_unit"] = true,
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
				["use_inverse"] = true,
				["remaining_operator"] = ">=",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["use_spellName"] = true,
				["remaining"] = "0",
				["spellName"] = 33076,
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
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
				["class"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
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
			["additional_triggers"] = {
			},
			["id"] = "Prayer of Mending",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = false,
			["stickyDuration"] = false,
			["selfPoint"] = "CENTER",
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				0, -- [4]
			},
		},
		["Dispel"] = {
			["xOffset"] = 0,
			["untrigger"] = {
				["spellName"] = 528,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
				["main"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "pulse",
				},
				["finish"] = {
					["type"] = "preset",
					["duration_type"] = "seconds",
					["preset"] = "fade",
				},
			},
			["trigger"] = {
				["type"] = "event",
				["subeventSuffix"] = "_CAST_START",
				["duration"] = "3",
				["event"] = "Cooldown Ready (Spell)",
				["unit"] = "player",
				["use_spellName"] = true,
				["debuffType"] = "HELPFUL",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["unevent"] = "timed",
				["spellName"] = 528,
			},
			["desaturate"] = false,
			["discrete_rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["height"] = 100,
			["rotate"] = true,
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
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["parent"] = "Dispels",
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura42",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["rotation"] = 0,
			["id"] = "Dispel",
			["selfPoint"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 100,
			["stickyDuration"] = false,
			["numTriggers"] = 1,
			["inverse"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["color"] = {
				0, -- [1]
				1, -- [2]
				0.6039215686274509, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Cooldowns Disc"] = {
			["grow"] = "HORIZONTAL",
			["controlledChildren"] = {
				"Global New", -- [1]
				"Prayer of Mending", -- [2]
				"Cascade", -- [3]
				"Halo", -- [4]
				"Divine Star", -- [5]
				"Spirit Shell", -- [6]
				"Pain Suppression", -- [7]
				"PW:Barrier", -- [8]
				"Shadowfiend", -- [9]
				"Power Infusion", -- [10]
				"Evangelism", -- [11]
				"Smite", -- [12]
				"Penance", -- [13]
				"Holy Fire", -- [14]
				"Global New 2", -- [15]
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
			["space"] = 6,
			["background"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["constantFactor"] = "RADIUS",
			["id"] = "Cooldowns Disc",
			["borderOffset"] = 16,
			["align"] = "CENTER",
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["stagger"] = 0,
			["frameStrata"] = 1,
			["width"] = 566.7998657226563,
			["rotation"] = 0,
			["untrigger"] = {
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
			["height"] = 35.20010375976563,
			["expanded"] = true,
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
		["Global New"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["borderBackdrop"] = "None",
			["xOffset"] = -1.10302734375,
			["stacksFlags"] = "None",
			["yOffset"] = -250.2671203613281,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["rotateText"] = "NONE",
			["displayTextLeft"] = "%n",
			["disjunctive"] = true,
			["parent"] = "Cooldowns Disc",
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
				["sourceunit"] = "player",
				["use_inverse"] = false,
				["names"] = {
					"Borrowed Time", -- [1]
				},
				["custom_hide"] = "timed",
				["type"] = "status",
				["duration"] = "12",
				["subeventSuffix"] = "_ENERGIZE",
				["spellName"] = 2061,
				["unit"] = "player",
				["event"] = "Global Cooldown",
				["subeventPrefix"] = "SPELL",
				["use_spellName"] = true,
				["powerType"] = 0,
				["unevent"] = "auto",
				["use_sourceunit"] = true,
				["use_powerType"] = true,
				["use_unit"] = true,
				["ownOnly"] = true,
				["debuffType"] = "HELPFUL",
			},
			["text"] = false,
			["barColor"] = {
				1, -- [1]
				0.05098039215686274, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0.7254901960784314, -- [2]
				0.04705882352941176, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["icon"] = false,
			["numTriggers"] = 2,
			["height"] = 35.2,
			["timerFlags"] = "None",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
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
			["textSize"] = 15,
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["timer"] = false,
			["untrigger"] = {
				["spellName"] = 2061,
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["alpha"] = 1,
			["stacks"] = false,
			["border"] = true,
			["borderEdge"] = "Square Outline",
			["regionType"] = "aurabar",
			["borderSize"] = 17,
			["id"] = "Global New",
			["icon_side"] = "RIGHT",
			["borderOffset"] = 4,
			["timerSize"] = 8,
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["texture"] = "Aluminium",
			["textFont"] = "DorisPP",
			["stacksFont"] = "Friz Quadrata TT",
			["displayTextRight"] = "%p",
			["auto"] = false,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["percenthealth"] = "0",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["use_percenthealth"] = true,
						["percenthealth_operator"] = ">",
						["use_unit"] = true,
					},
					["untrigger"] = {
					},
				}, -- [1]
			},
			["timerFont"] = "DorisPP",
			["frameStrata"] = 1,
			["width"] = 12.6,
			["barInFront"] = true,
			["borderInset"] = 29,
			["inverse"] = true,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["orientation"] = "VERTICAL",
			["displayIcon"] = "Interface\\Icons\\Spell_Holy_Rapture",
			["desaturate"] = false,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
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
				["use_inverse"] = true,
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
				["role"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["spec"] = {
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
			["borderOffset"] = 4,
			["border"] = true,
			["borderEdge"] = "Square Outline",
			["regionType"] = "aurabar",
			["borderSize"] = 17,
			["frameStrata"] = 1,
			["icon_side"] = "RIGHT",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["additional_triggers"] = {
			},
			["timerSize"] = 15,
			["texture"] = "Blizzard",
			["textFont"] = "DorisPP",
			["stacksFont"] = "Friz Quadrata TT",
			["displayTextRight"] = "%p",
			["auto"] = true,
			["id"] = "Global",
			["timerFont"] = "DorisPP",
			["alpha"] = 1,
			["width"] = 444.0000305175781,
			["stacks"] = false,
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
				["use_inverse"] = false,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
					"Divine Insight", -- [1]
				},
				["remaining"] = "0",
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
			["additional_triggers"] = {
			},
			["untrigger"] = {
				["spellName"] = 14914,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["id"] = "Divine Insight",
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
				["names"] = {
				},
				["use_spellName"] = true,
				["remaining"] = "0",
				["remaining_operator"] = "==",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
			["id"] = "Shadowfiend (Holy)",
			["untrigger"] = {
				["spellName"] = 123040,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = false,
			["additional_triggers"] = {
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
		["Cascade (Holy) 2"] = {
			["parent"] = "Cooldowns Holy",
			["untrigger"] = {
				["spellName"] = 121135,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["debuffType"] = "HELPFUL",
				["use_remaining"] = false,
				["use_unit"] = true,
				["unevent"] = "auto",
				["subeventPrefix"] = "SPELL",
				["use_inverse"] = false,
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
				},
				["subeventSuffix"] = "_CAST_START",
				["use_spellName"] = true,
				["unit"] = "player",
				["remaining_operator"] = "<=",
				["remaining"] = "0",
				["type"] = "status",
				["custom_hide"] = "timed",
				["spellName"] = 121135,
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.20003890991211,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["talent"] = 16,
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
				["use_talent"] = true,
			},
			["fontSize"] = 24,
			["displayStacks"] = "%p",
			["regionType"] = "icon",
			["animation"] = {
				["start"] = {
					["preset"] = "shrink",
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["preset"] = "alphaPulse",
					["duration_type"] = "seconds",
					["type"] = "preset",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
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
						["spellName"] = 121135,
						["use_unit"] = true,
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["spellName"] = 121135,
					},
				}, -- [1]
			},
			["id"] = "Cascade (Holy) 2",
			["disjunctive"] = true,
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
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
		["Smite"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 585,
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
				["use_matchedRune"] = true,
				["use_inverse"] = false,
				["use_unit"] = true,
				["remaining"] = "0",
				["debuffType"] = "HELPFUL",
				["use_remaining"] = false,
				["subeventSuffix"] = "_CAST_START",
				["event"] = "Action Usable",
				["names"] = {
				},
				["unit"] = "player",
				["use_spellName"] = true,
				["spellName"] = 585,
				["subeventPrefix"] = "SPELL",
				["remaining_operator"] = "<=",
				["unevent"] = "auto",
				["type"] = "status",
				["custom_hide"] = "timed",
			},
			["stickyDuration"] = false,
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
			["desaturate"] = false,
			["cooldown"] = true,
			["selfPoint"] = "CENTER",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["custom_hide"] = "timed",
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 47540,
					},
					["untrigger"] = {
						["spellName"] = 47540,
					},
				}, -- [1]
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["use_inverse"] = true,
						["event"] = "Action Usable",
						["subeventPrefix"] = "SPELL",
						["use_spellName"] = true,
						["unit"] = "player",
						["subeventSuffix"] = "_CAST_START",
						["use_unit"] = true,
						["spellName"] = 14914,
					},
					["untrigger"] = {
						["spellName"] = 14914,
					},
				}, -- [2]
			},
			["id"] = "Smite",
			["parent"] = "Cooldowns Disc",
			["frameStrata"] = 1,
			["width"] = 35.2,
			["inverse"] = false,
			["disjunctive"] = false,
			["numTriggers"] = 3,
			["xOffset"] = 0,
			["yOffset"] = 0,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
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
				["use_inverse"] = true,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["use_spellName"] = true,
				["remaining"] = "0",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
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
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["selfPoint"] = "CENTER",
			["id"] = "PW:Barrier",
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
			["numTriggers"] = 1,
			["disjunctive"] = true,
			["additional_triggers"] = {
			},
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
				["unit"] = "player",
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["remaining"] = "0",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["use_spellName"] = true,
				["use_inverse"] = true,
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
			["parent"] = "Cooldowns Disc",
			["cooldown"] = true,
			["untrigger"] = {
				["spellName"] = 109964,
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["id"] = "Spirit Shell",
			["additional_triggers"] = {
			},
			["disjunctive"] = true,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
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
		["Purify"] = {
			["color"] = {
				0.4313725490196079, -- [1]
				0, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 0,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["selfPoint"] = "CENTER",
			["trigger"] = {
				["type"] = "event",
				["subeventSuffix"] = "_CAST_START",
				["duration"] = "3",
				["event"] = "Cooldown Ready (Spell)",
				["unit"] = "player",
				["use_spellName"] = true,
				["spellName"] = 527,
				["unevent"] = "timed",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["debuffType"] = "HELPFUL",
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["height"] = 100,
			["rotate"] = true,
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
			["fontSize"] = 12,
			["displayStacks"] = "%s",
			["mirror"] = false,
			["regionType"] = "texture",
			["blendMode"] = "ADD",
			["parent"] = "Dispels",
			["texture"] = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura42",
			["stacksContainment"] = "INSIDE",
			["zoom"] = 0,
			["auto"] = true,
			["discrete_rotation"] = 0,
			["id"] = "Purify",
			["animation"] = {
				["start"] = {
					["type"] = "preset",
					["preset"] = "fade",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "preset",
					["preset"] = "pulse",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "preset",
					["preset"] = "fade",
					["duration_type"] = "seconds",
				},
			},
			["frameStrata"] = 1,
			["width"] = 100,
			["xOffset"] = 0,
			["untrigger"] = {
				["spellName"] = 527,
			},
			["inverse"] = false,
			["numTriggers"] = 1,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["stickyDuration"] = false,
			["stacksPoint"] = "BOTTOMRIGHT",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Global New 2"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["borderBackdrop"] = "None",
			["parent"] = "Cooldowns Disc",
			["stacksFlags"] = "None",
			["untrigger"] = {
				["spellName"] = 2061,
			},
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["rotateText"] = "NONE",
			["icon"] = false,
			["backgroundColor"] = {
				0, -- [1]
				0.7254901960784314, -- [2]
				0.04705882352941176, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
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
			["trigger"] = {
				["sourceunit"] = "player",
				["duration"] = "12",
				["subeventPrefix"] = "SPELL",
				["custom_hide"] = "timed",
				["type"] = "status",
				["debuffType"] = "HELPFUL",
				["unevent"] = "auto",
				["ownOnly"] = true,
				["use_unit"] = true,
				["event"] = "Global Cooldown",
				["unit"] = "player",
				["use_spellName"] = true,
				["powerType"] = 0,
				["subeventSuffix"] = "_ENERGIZE",
				["use_sourceunit"] = true,
				["use_powerType"] = true,
				["spellName"] = 2061,
				["use_inverse"] = false,
				["names"] = {
					"Borrowed Time", -- [1]
				},
			},
			["text"] = false,
			["barColor"] = {
				1, -- [1]
				0.05098039215686274, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["stickyDuration"] = false,
			["xOffset"] = -1.10302734375,
			["textSize"] = 15,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["inverse"] = true,
			["timer"] = false,
			["timerFlags"] = "None",
			["load"] = {
				["role"] = {
					["multi"] = {
					},
				},
				["spec"] = {
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
			["displayTextLeft"] = "%n",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["barInFront"] = true,
			["disjunctive"] = true,
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["frameStrata"] = 1,
			["borderSize"] = 17,
			["border"] = true,
			["borderEdge"] = "Square Outline",
			["regionType"] = "aurabar",
			["stacks"] = false,
			["additional_triggers"] = {
				{
					["trigger"] = {
						["use_castType"] = false,
						["use_inverse"] = true,
						["use_unit"] = true,
						["spellName"] = 2061,
						["type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["percenthealth"] = "0",
						["event"] = "Health",
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["use_spellName"] = true,
						["unit"] = "player",
						["use_sourceunit"] = false,
						["names"] = {
						},
						["use_percenthealth"] = true,
						["percenthealth_operator"] = ">",
						["subeventPrefix"] = "SPELL",
					},
					["untrigger"] = {
						["spellName"] = 2061,
					},
				}, -- [1]
			},
			["icon_side"] = "RIGHT",
			["auto"] = false,
			["displayTextRight"] = "%p",
			["stacksFont"] = "Friz Quadrata TT",
			["texture"] = "Aluminium",
			["textFont"] = "DorisPP",
			["borderOffset"] = 4,
			["timerSize"] = 8,
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "Global New 2",
			["timerFont"] = "DorisPP",
			["alpha"] = 1,
			["width"] = 12.6,
			["yOffset"] = -250.2671203613281,
			["borderInset"] = 29,
			["numTriggers"] = 2,
			["height"] = 35.2,
			["orientation"] = "VERTICAL",
			["displayIcon"] = "Interface\\Icons\\Spell_Holy_Rapture",
			["selfPoint"] = "CENTER",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["Halo"] = {
			["parent"] = "Cooldowns Disc",
			["untrigger"] = {
				["spellName"] = 120517,
			},
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["useTooltip"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
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
				["use_remaining"] = false,
				["unevent"] = "auto",
				["use_inverse"] = true,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["unit"] = "player",
				["use_spellName"] = true,
				["remaining"] = "0",
				["names"] = {
				},
				["subeventPrefix"] = "SPELL",
				["subeventSuffix"] = "_CAST_START",
				["use_unit"] = true,
				["custom_hide"] = "timed",
				["spellName"] = 120517,
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "2002",
			["height"] = 35.20003890991211,
			["load"] = {
				["size"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["talent"] = 18,
				["use_spec"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["use_talent"] = true,
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["selfPoint"] = "CENTER",
			["stacksPoint"] = "CENTER",
			["stickyDuration"] = false,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["additional_triggers"] = {
			},
			["id"] = "Halo",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["inverse"] = false,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["yOffset"] = 0,
			["disjunctive"] = true,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
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
				["unit"] = "player",
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["remaining"] = "0",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["use_spellName"] = true,
				["use_inverse"] = true,
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
				["class"] = {
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
			["id"] = "Cascade",
			["additional_triggers"] = {
			},
			["disjunctive"] = true,
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 1,
			["xOffset"] = 0,
			["inverse"] = false,
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
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
				["use_inverse"] = false,
				["remaining_operator"] = "<=",
				["event"] = "Cooldown Progress (Spell)",
				["names"] = {
				},
				["remaining"] = "0",
				["use_spellName"] = true,
				["custom_hide"] = "timed",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
				["names"] = {
				},
				["use_spellName"] = true,
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
				["use_combat"] = true,
				["talent"] = 14,
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						true, -- [1]
					},
				},
				["class"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
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
			["untrigger"] = {
				["spellName"] = 724,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["id"] = "Lightwell",
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
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
			["untrigger"] = {
				["spellName"] = 33076,
			},
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["id"] = "Prayer of Mending (Holy)",
			["stickyDuration"] = false,
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
				"Cascade (Holy) 2", -- [3]
				"Circle of Healing", -- [4]
				"Guardian Spirit", -- [5]
				"Divine Hymn", -- [6]
				"Lightwell", -- [7]
				"Shadowfiend (Holy)", -- [8]
				"Divine Insight", -- [9]
				"Serendipity (Holy)", -- [10]
			},
			["animate"] = true,
			["sortHybridTable"] = {
				[3] = true,
				[4] = true,
				[5] = true,
			},
			["xOffset"] = 0,
			["radius"] = 200,
			["border"] = "None",
			["yOffset"] = -196.0000915527344,
			["regionType"] = "dynamicgroup",
			["align"] = "CENTER",
			["sort"] = "none",
			["borderOffset"] = 16,
			["space"] = 8,
			["background"] = "None",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["constantFactor"] = "RADIUS",
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
			["backgroundInset"] = 0,
			["id"] = "Cooldowns Holy",
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
			["stagger"] = 0,
			["frameStrata"] = 1,
			["width"] = 423.9998779296875,
			["rotation"] = 0,
			["untrigger"] = {
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
			["height"] = 35.20010375976563,
			["expanded"] = false,
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
			["anchorPoint"] = "CENTER",
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
				["remaining_operator"] = "<=",
				["use_inverse"] = false,
				["event"] = "Action Usable",
				["use_unit"] = true,
				["remaining"] = "0",
				["use_spellName"] = true,
				["spellName"] = 47540,
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
					["do_glow"] = false,
				},
				["finish"] = {
				},
			},
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["yOffset"] = 0,
			["id"] = "Penance",
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 1,
			["parent"] = "Cooldowns Disc",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["additional_triggers"] = {
			},
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
				["names"] = {
				},
				["use_spellName"] = true,
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
			["untrigger"] = {
				["spellName"] = 47788,
			},
			["frameStrata"] = 1,
			["width"] = 35.2,
			["numTriggers"] = 2,
			["xOffset"] = 0,
			["inverse"] = false,
			["disjunctive"] = true,
			["id"] = "Guardian Spirit",
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
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
				["unit"] = "player",
				["remaining_operator"] = "==",
				["event"] = "Cooldown Progress (Spell)",
				["use_unit"] = true,
				["subeventSuffix"] = "_CAST_START",
				["remaining"] = "0",
				["subeventPrefix"] = "SPELL",
				["names"] = {
				},
				["use_spellName"] = true,
				["use_inverse"] = true,
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
				["class"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
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
			["id"] = "Shadowfiend",
			["additional_triggers"] = {
			},
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
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
		["Dispels"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"Dispel", -- [1]
				"Purify", -- [2]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 0,
			["border"] = false,
			["yOffset"] = -133.9999389648438,
			["anchorPoint"] = "CENTER",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
			},
			["borderOffset"] = 5,
			["selfPoint"] = "BOTTOMLEFT",
			["trigger"] = {
				["names"] = {
				},
				["type"] = "aura",
				["debuffType"] = "HELPFUL",
				["unit"] = "player",
			},
			["frameStrata"] = 1,
			["expanded"] = true,
			["untrigger"] = {
			},
			["borderInset"] = 11,
			["numTriggers"] = 1,
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
			["borderEdge"] = "None",
			["id"] = "Dispels",
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
			["regionType"] = "group",
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
				["names"] = {
				},
				["use_spellName"] = true,
				["remaining"] = "0",
				["remaining_operator"] = "<=",
				["unit"] = "player",
				["subeventSuffix"] = "_CAST_START",
				["subeventPrefix"] = "SPELL",
				["use_unit"] = true,
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
				["talent"] = 16,
				["class"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
					},
				},
				["use_spec"] = true,
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
			["id"] = "Cascade (Holy)",
			["untrigger"] = {
				["spellName"] = 121135,
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
			["stickyDuration"] = false,
			["cooldown"] = true,
			["textColor"] = {
				1, -- [1]
				0.03529411764705882, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["Divine Star"] = {
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["untrigger"] = {
				["spellName"] = 110744,
			},
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
				["spellName"] = 110744,
				["type"] = "status",
				["custom_hide"] = "timed",
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
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["class"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["talent"] = 17,
				["size"] = {
					["multi"] = {
					},
				},
			},
			["fontSize"] = 24,
			["displayStacks"] = "%s",
			["regionType"] = "icon",
			["stickyDuration"] = false,
			["cooldown"] = true,
			["disjunctive"] = true,
			["stacksContainment"] = "INSIDE",
			["zoom"] = 1,
			["auto"] = true,
			["yOffset"] = 0,
			["additional_triggers"] = {
			},
			["xOffset"] = 0,
			["frameStrata"] = 1,
			["width"] = 35.19997406005859,
			["numTriggers"] = 1,
			["parent"] = "Cooldowns Disc",
			["inverse"] = false,
			["selfPoint"] = "CENTER",
			["id"] = "Divine Star",
			["actions"] = {
				["start"] = {
					["do_glow"] = false,
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
	},
}
