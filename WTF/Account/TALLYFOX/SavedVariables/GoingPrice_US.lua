
GoingPrice_US_SV = {
	["_reKeep"] = {
	},
	["_base"] = {
		["name"] = "GoingPrice",
		["settings"] = {
			["always_load"] = {
			},
			["sourceTitleColor"] = {
				1, -- [1]
				8, -- [2]
				0, -- [3]
			},
			["modifier"] = 4,
			["date"] = 1369374462,
			["statisticColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
			},
			["pullDateColor"] = {
				1, -- [1]
				8, -- [2]
				0, -- [3]
			},
		},
	},
	["_tooltip_order"] = 970,
	["_pullDate"] = {
		["checked"] = true,
		["keep"] = true,
	},
	["_firstKey"] = "Market Mean",
	["_index"] = {
		["Std Deviation"] = 2,
		["Buy From Vendor"] = 3,
		["Market Mean"] = 1,
	},
	["_discard"] = {
		["checked"] = false,
	},
	["Market Mean"] = {
		["keep"] = true,
		["checked"] = true,
		["next"] = "Std Deviation",
	},
	["Buy From Vendor"] = {
		["keep"] = true,
		["checked"] = true,
		["prev"] = "Std Deviation",
	},
	["_lib_minor_version"] = 7,
	["_lastKey"] = "Buy From Vendor",
	["_lib_major_version"] = 2,
	["Std Deviation"] = {
		["prev"] = "Market Mean",
		["keep"] = true,
		["checked"] = true,
		["next"] = "Buy From Vendor",
	},
}
