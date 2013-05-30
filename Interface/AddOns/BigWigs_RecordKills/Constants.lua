--@Name: BigWigs RecordKills
--@Author: Kiezo @ Bleeding Hollow
--===============================================================================
local _,NS = ...

-- CONSTANTS --
NS.Constants = {}
local C = NS.Constants

C["MAX_LEVEL"] = GetMaxPlayerLevel()
C["MINIMUM_TIER"] = 14
C["CURRENT_TIER"] = 15

C["RAID_LOOKUP"] = {	
	[14] = {
		raids = {
			[1] = {
				["name"] = "Mogu'shan Vaults",
				["zoneID"] = 896,
				["level"] = 90,
				["encounters"] = {
					[1] = {
						eName = "The Stone Guard",
						eID = 679,
					},
					[2] = {
						eName = "Feng the Accursed",
						eID = 689,
					},
					[3] = {
						eName = "Gara'jal the Spiritbinder",
						eID = 682,
					},
					[4] = {
						eName = "The Spirit Kings",
						eID = 687,
					},
					[5] = {
						eName = "Elegon",
						eID = 726,
					},
					[6] = {
						eName = "Will of the Emperor",
						eID = 677,
					},
				},
			},
			[2] = {
				["name"] = "Heart of Fear",
				["zoneID"] = 897,
				["level"] = 90,
				["encounters"] = {
					[1] = {
						eName = "Imperial Vizier Zor'lok",
						eID = 745,
					},
					[2] = {
						eName = "Blade Lord Ta'yak",
						eID = 744,
					},
					[3] = {
						eName = "Garalon",
						eID = 713,
					},
					[4] = {
						eName = "Wind Lord Mel'jarak",
						eID = 741,
					},
					[5] = {
						eName = "Amber-shaper Un'sok",
						eID = 737,
					},
					[6] = {
						eName = "Grand Empress Shek'zeer",
						eID = 743,
					},
				},
			},
			[3] = {
				["name"] = "Terrace of Endless Spring",
				["zoneID"] = 886,
				["level"] = 90,
				["encounters"] = {
					[1] = {
						eName = "Protectors of the Endless",
						eID = 683,
					},
					[2] = {
						eName = "Tsulong",
						eID = 742,
					},
					[3] = {
						eName = "Lei Shi",
						eID = 729,
					},
					[4] = {
						eName = "Sha of Fear",
						eID = 709,
					},
				},
			},
		},
	},
	[15] = {
		raids = {
			[1] = {
				["name"] = "Throne of Thunder",
				["zoneID"] = 930,
				["level"] = 90,
				["encounters"] = {
					[1] = {
						eName = "Jin'rokh the Breaker",
						eID = 827,
					},
					[2] = {
						eName = "Horridon",
						eID = 819,
					},
					[3] = {
						eName = "Council of Elders",
						eID = 816,
					},
					[4] = {
						eName = "Tortos",
						eID = 825,
					},
					[5] = {
						eName = "Megaera",
						eID = 821,
					},
					[6] = {
						eName = "Ji-Kun",
						eID = 828,
					},
					[7] = {
						eName = "Durumu the Forgotten",
						eID = 818,
					},
					[8] = {
						eName = "Primordius",
						eID = 820,
					},
					[9] = {
						eName = "Dark Animus",
						eID = 824,
					},
					[10] = {
						eName = "Iron Qon",
						eID = 817,
					},
					[11] = {
						eName = "Twin Consorts",
						eID = 829,
					},
					[12] = {
						eName = "Lei Shen",
						eID = 832,
					},
					[13] = {
						eName = "Ra-den",
						eID = 831,
					},
				},
			},
		},
		--[16] = new tier starts here
	},
}

C["DIFFICULTY"] = {
	[3] = {
		["index"] = 3,
		["shortName"] = "10",
		["longName"] = "10 Man",
	},
	[4] = {
		["index"] = 4,
		["shortName"] = "25",
		["longName"] = "25 Man",
	},
	[5] = {
		["index"] = 5,
		["shortName"] = "10H",
		["longName"] = "10 Man Heroic",
	},
	[6] = {
		["index"] = 6,
		["shortName"] = "25H",
		["longName"] = "25 Man Heroic",
	},
	[7] = {
		["index"] = 7,
		["shortName"] = "LFR",
		["longName"] = "Looking For Raid",
	},
}