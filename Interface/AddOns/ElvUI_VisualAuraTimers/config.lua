local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local VAT = E:NewModule('VisualAuraTimers', 'AceEvent-3.0')
local A = E:GetModule('Auras');

-- Defaults
P['VAT'] = {
	['enable'] = true,
	['noduration'] = true,
	['position'] = 'BOTTOM',
	['barWidth'] = 6,
	['barHeight'] = 5,
	['showText'] = false,
	['tenable'] = true,
	['threshold'] = {
		['buffs'] = false,
		['buffsvalue'] = 5,
		['debuffs'] = true,
		['debuffsvalue'] = 10,
		['tempenchants'] = false,
		['tempenchantsvalue'] = 60,
	},
	['enableStaticColor'] = false,
	['staticColor'] = {r = 0, g = 0.8, b = 0},
}

function VAT:InsertOptions()
	if not E.Options.args.blazeplugins then
		E.Options.args.blazeplugins = {
			order = -2,
			type = 'group',
			name = 'Plugins (by Blazeflack)',
			args = {},
		}
	end
	E.Options.args.blazeplugins.args.VAT = {
		order = 50,
		type = 'group',
		name = 'VisualAuraTimers',
		disabled = function() return not E.private.auras.enable end,
		args = {
			settings = {
				order = 1,
				type = 'group',
				name = L['Visual Timers'],
				guiInline = true,
				get = function(info) return E.db.VAT[ info[#info] ] end,
				set = function(info, value) E.db.VAT[ info[#info] ] = value; end,
				args = {
					enable = {
						type = 'toggle',
						order = 1,
						name = L['Enable'],
						desc = L['Show timers as bars instead of text.'],
						set = function(info, value) E.db.VAT.enable = value; end,
					},
					noduration = {
						type = 'toggle',
						order = 2,
						name = L['No Duration'],
						desc = L['Show bars for auras without a duration.'],
						set = function(info, value) E.db.VAT.noduration = value; end,
						disabled = function() return not E.db.VAT.enable end,
					},
					statusbar = {
						type = 'group',
						order = 3,
						name = L['Statusbar Options'],
						guiInline = true,
						args = {
							position = {
								type = 'select',
								order = 1,
								name = L['Statusbar Position'],
								desc = L['Choose where you want the statusbar to be positioned. If you position it on the left or right side of the icon I advice you to increase Horizontal Spacing for Buffs and Debuffs. Changing this requires you to reload UI.'],
								get = function(info) return E.db.VAT.position end,
								set = function(info, value) E.db.VAT.position = value; E:StaticPopup_Show("PRIVATE_RL") end,
								disabled = function() return not E.db.VAT.enable end,
								values = {
									['TOP'] = L['Above Icons'],
									['BOTTOM'] = L['Below Icons'],
									['LEFT'] = L['Left Side of Icons'],
									['RIGHT'] = L['Right Side of Icons'],
								},
							},
							barWidth = {
								type = 'range',
								order = 2,
								name = L['Statusbar Width'],
								desc = L['Width of the statusbar frame (default: 6). Changing this requires you to reload UI.'],
								min = 5, max = 10, step = 1,
								get = function(info) return E.db.VAT.barWidth end,
								set = function(info, value) E.db.VAT.barWidth = value; E:StaticPopup_Show("PRIVATE_RL") end,
								disabled = function() return not E.db.VAT.enable or (E.db.VAT.position == 'BOTTOM') or (E.db.VAT.position == 'TOP') end,
							},
							barHeight = {
								type = 'range',
								order = 3,
								name = L['Statusbar Height'],
								desc = L['Height of the statusbar frame (default: 5). Changing this requires you to reload UI.'],
								min = 5, max = 10, step = 1,
								get = function(info) return E.db.VAT.barHeight end,
								set = function(info, value) E.db.VAT.barHeight = value; E:StaticPopup_Show("PRIVATE_RL") end,
								disabled = function() return not E.db.VAT.enable or (E.db.VAT.position == 'LEFT') or (E.db.VAT.position == 'RIGHT') end,
							},
							spacer = {
								type = 'description',
								order = 4,
								name = '',
							},
							enableStaticColor = {
								type = 'toggle',
								order = 5,
								name = L['Enable Static Color'],
								desc = L['Changes the statusbar to use a static color instead of going from green to red the lower duration it has.'],
								disabled = function() return not E.db.VAT.enable end,
							},
							staticColor = {
								type = 'color',
								order = 6,
								name = L['Statusbar Color'],
								desc = L['Choose which color you want your statusbars to use.'],
								hasAlpha = false,
								disabled = function() return (not E.db.VAT.enableStaticColor or not E.db.VAT.enable) end,
								get = function(info)
									local t = E.db.VAT[ info[#info] ]
									return t.r, t.g, t.b, t.a
								end,
								set = function(info, r, g, b)
									E.db.VAT[ info[#info] ] = {}
									local t = E.db.VAT[ info[#info] ]
									t.r, t.g, t.b = r, g, b
								end,
							},
						}
					},
					text = {
						type = 'group',
						order = 4,
						name = L['Text Options'],
						guiInline = true,
						args = {
							showText = {
								type = 'toggle',
								order = 1,
								name = L['Always Show Text'],
								desc = L['Show text in addition to statusbars. (You might need to move the text by changing the offset in the Buffs and Debuffs section)'],
								disabled = function() return not E.db.VAT.enable end,
							},
							tenable = {
								type = 'toggle',
								order = 2,
								name = L['Text Threshold'],
								desc = L['Switch to text based timers when duration goes below threshold'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.enable) end,
							},
							spacer = {
								type = 'description',
								order = 3,
								name = '',
							},
							threshold = {
								type = 'group',
								name = L['Text Threshold'],
								order = 3,
								guiInline = true,
								get = function(info) return E.db.VAT.threshold[ info[#info] ] end,
								set = function(info, value) E.db.VAT.threshold[ info[#info] ] = value end,
								disabled = function() return (not E.db.VAT.tenable or not E.db.VAT.enable) end,
								args = {
									buffs = {
										type = 'toggle',
										order = 1,
										name = L['Buffs'],
										desc = L['If enabled, the timers on your buffs will switch to text when duration goes below set threshold.'],
										disabled = function() return (E.db.VAT.showText or not E.db.VAT.tenable or not E.db.VAT.enable) end,
									},
									debuffs = {
										type = 'toggle',
										order = 2,
										name = L['Debuffs'],
										desc = L['If enabled, the timers on your debuffs will switch to text when duration goes below set threshold.'],
										disabled = function() return (E.db.VAT.showText or not E.db.VAT.tenable or not E.db.VAT.enable) end,
									},
									tempenchants = {
										type = 'toggle',
										order = 3,
										name = L['Temporary Enchants'],
										desc = L['If enabled, the timers on your temporary enchant(s) will switch to text when duration goes below set threshold.'],
										disabled = function() return (E.db.VAT.showText or not E.db.VAT.tenable or not E.db.VAT.enable) end,
									},
									spacer = {
										type = 'description',
										order = 4,
										name = '',
									},
									buffsvalue = {
										type = 'range',
										order = 5,
										name = L['Buffs Threshold'],
										desc = L['Threshold in seconds before status bar based timers turn to text.'],
										disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.buffs or not E.db.VAT.tenable or not E.db.VAT.enable) end,
										min = 0, max = 180, step = 1,
									},
									debuffsvalue = {
										type = 'range',
										order = 6,
										name = L['Debuffs Threshold'],
										desc = L['Threshold in seconds before status bar based timers turn to text.'],
										disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.debuffs or not E.db.VAT.tenable or not E.db.VAT.enable) end,
										min = 0, max = 60, step = 1,
									},
									tempenchantsvalue = {
										type = 'range',
										order = 7,
										name = L['Temp. Threshold'],
										desc = L['Threshold in seconds before status bar based timers turn to text.'],
										disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.tempenchants or not E.db.VAT.tenable or not E.db.VAT.enable) end,
										min = 0, max = 300, step = 1,
									},
								},
							},
						},
					},
				},
			},
		},
	}
end

E:RegisterModule(VAT:GetName())