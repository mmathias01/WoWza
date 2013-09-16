local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local VAT = E:NewModule('VisualAuraTimers', 'AceEvent-3.0')
local A = E:GetModule('Auras');

-- Defaults
P['VAT'] = {
	['enable'] = true,
	['noduration'] = true,
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
					barHeight = {
						type = 'range',
						order = 3,
						name = L['Statusbar Height'],
						desc = L['Height of the statusbar frame (default: 5). Changing this requires you to reload UI.'],
						min = 5, max = 10, step = 1,
						get = function(info) return E.db.VAT.barHeight end,
						set = function(info, value) E.db.VAT.barHeight = value; E:StaticPopup_Show("PRIVATE_RL") end,
						disabled = function() return not E.db.VAT.enable end,
					},
					showText = {
						type = 'toggle',
						order = 4,
						name = L['Show Text'],
						desc = L['Show text in addition to statusbars. (You will need to move the text by changing the offset in the Buffs and Debuffs section)'],
						disabled = function() return not E.db.VAT.enable end,
					},
					-- spacer = {
						-- type = 'description',
						-- order 5,
						-- name = '',
					-- },
					enableStaticColor = {
						type = 'toggle',
						order = 6,
						name = L['Enable Static Color'],
						desc = L['Changes the statusbar to use a static color instead of going from green to red the lower duration it has.'],
						disabled = function() return not E.db.VAT.enable end,
					},
					staticColor = {
						type = 'color',
						order = 7,
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
					tenable = {
						type = 'toggle',
						order = 8,
						name = L['Text Threshold'],
						desc = L['Switch to text based timers when duration goes below threshold'],
						disabled = function() return (E.db.VAT.showText or not E.db.VAT.enable) end,
					},
					threshold = {
						type = 'group',
						name = L['Text Threshold'],
						order = 9,
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
							buffsvalue = {
								type = 'range',
								name = L['Buffs Threshold'],
								order = 4,
								desc = L['Threshold in seconds before status bar based timers turn to text.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.buffs or not E.db.VAT.tenable or not E.db.VAT.enable) end,
								min = 0, max = 180, step = 1,
							},
							debuffsvalue = {
								type = 'range',
								name = L['Debuffs Threshold'],
								order = 5,
								desc = L['Threshold in seconds before status bar based timers turn to text.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.debuffs or not E.db.VAT.tenable or not E.db.VAT.enable) end,
								min = 0, max = 60, step = 1,
							},
							tempenchantsvalue = {
								type = 'range',
								name = L['Temp. Threshold'],
								order = 6,
								desc = L['Threshold in seconds before status bar based timers turn to text.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.tempenchants or not E.db.VAT.tenable or not E.db.VAT.enable) end,
								min = 0, max = 300, step = 1,
							},
						},
					},
				},
			},
		},
	}
end

E:RegisterModule(VAT:GetName())