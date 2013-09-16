-------------------------------------------
--- Author: Ketho (EU-Boulderfist)		---
--- License: Public Domain				---
--- Created: 2011.11.06					---
--- Version: 1.5 [2013.05.23]			---
-------------------------------------------
--- Curse			http://www.curse.com/addons/wow/fastercamera
--- WoWInterface	http://www.wowinterface.com/downloads/info20483-FasterCamera.html

local NAME, S = ...
local VERSION = GetAddOnMetadata(NAME, "Version")

local ACR = LibStub("AceConfigRegistry-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

local L = S.L
local db

	----------------
	--- Prehooks ---
	----------------

local oldZoomIn = CameraZoomIn
local oldZoomOut = CameraZoomOut

function CameraZoomIn(distance)
	oldZoomIn(db.increment)
end

function CameraZoomOut(distance)
	oldZoomOut(db.increment)
end

-- tried this out in the SotA demolishers
-- the normal camera zoom functions seemed to be used instead
-- I suppose both can be used interchangeably
local oldVehicleZoomIn = VehicleCameraZoomIn
local oldVehicleZoomOut = VehicleCameraZoomOut

function VehicleCameraZoomIn(distance)
	oldVehicleZoomIn(db.increment)
end

function VehicleCameraZoomOut(distance)
	oldVehicleZoomOut(db.increment)
end

	---------------
	--- Options ---
	---------------

local cvar = {
	"cameraDistanceMoveSpeed",
	"cameraDistanceMax",
	"cameraDistanceMaxFactor",
}

local defaults = {
	db_version = 1.3, -- update this on (major) savedvars changes
	increment = 4,
	speed = 20,
	distance = 50,
}

local options = {
	type = "group",
	name = format("%s |cffADFF2Fv%s|r", NAME, VERSION),
	args = {
		inline = {
			type = "group", order = 1,
			name = " ",
			inline = true,
			args = {
				increment = {
					type = "range", order = 1,
					width = "double", descStyle = "",
					name = L.CAMERA_ZOOM_INCREMENT,
					get = function(i) return db.increment end,
					set = function(i, v) db.increment = v end,
					min = 1,
					max = 50, softMax = 10,
					step = 1,
				},
				newline1 = {type = "description", order = 2, name = "\n"},
				cameraDistanceMoveSpeed = {
					type = "range", order = 3,
					width = "double", descStyle  = "",
					name = L.CAMERA_ZOOM_SPEED,
					get = function(i) return tonumber(GetCVar("cameraDistanceMoveSpeed")) end,
					set = function(i, v) SetCVar("cameraDistanceMoveSpeed", v); db.speed = v end,
					min = 1,
					max = 50,
					step = 1,
				},
				newline2 = {type = "description", order = 4, name = "\n"},
				cameraDistanceMax = {
					type = "range", order = 5,
					width = "double", 	descStyle = "",
					name = MAX_FOLLOW_DIST,
					get = function(i) return tonumber(GetCVar("cameraDistanceMax")) end,
					set = function(i, v) SetCVar("cameraDistanceMax", v); db.distance = v end,
					min = 1,
					max = 50,
					step = 1,
				},
			},
		},
		reset = {
			type = "execute", order = 2,
			descStyle = "",
			name = DEFAULTS,
			confirm = true, confirmText = RESET_TO_DEFAULT.."?",
			func = function()
				db.increment = defaults.increment
				db.speed = tonumber(GetCVarDefault("cameraDistanceMoveSpeed"))
				db.distance = tonumber(GetCVarDefault("cameraDistanceMax"))
				for _, v in ipairs(cvar) do
					SetCVar(v, GetCVarDefault(v))
				end
			end,
		},
	},
}

	----------------------
	--- Initialization ---
	----------------------

local f = CreateFrame("Frame")

-- delay setting/overriding the CVars because it's either
-- not yet ready or is being reverted/overridden by something else
function f:OnUpdate(elapsed)
	f.delay = (f.delay or 0) + elapsed
	if f.delay > 1 then
		SetCVar("cameraDistanceMoveSpeed", db.speed)
		SetCVar("cameraDistanceMax", db.distance)
		-- cameraDistanceMax should be the only thing controlling
		-- the max camera distance, for accuracy and simplicity's sake
		SetCVar("cameraDistanceMaxFactor", 1)
		-- Disable the Blizzard Camera Slider to "hint" users it's being replaced or overridden (or rather not)
		--InterfaceOptionsCameraPanelMaxDistanceSlider:Disable()
		self:SetScript("OnUpdate", nil)
	end
end

function f:OnEvent(event, addon)
	if addon ~= NAME then return end
	
	if not FasterCameraDB2 or FasterCameraDB2.db_version ~= defaults.db_version then
		FasterCameraDB2 = defaults
	end
	db = FasterCameraDB2
	ACR:RegisterOptionsTable("FasterCamera", options)
	ACD:AddToBlizOptions("FasterCamera", NAME)
	ACD:SetDefaultSize("FasterCamera", 420, 340)
	self:SetScript("OnUpdate", f.OnUpdate)
	self:UnregisterEvent(event)
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)

	---------------------
	--- Slash Command ---
	---------------------

for i, v in ipairs({"fc", "fastercam", "fastercamera"}) do
	_G["SLASH_FASTERCAMERA"..i] = "/"..v
end

SlashCmdList.FASTERCAMERA = function(msg, editbox)
	ACD:Open("FasterCamera")
end

	---------------------
	--- LibDataBroker ---
	---------------------

local function distance()
	local maxDistance = GetCVar("cameraDistanceMax") * GetCVar("cameraDistanceMaxFactor")
	return maxDistance<=50 and maxDistance or 50
end

local dataobject = {
	type = "launcher",
	icon = "Interface\\Icons\\inv_misc_spyglass_03",
	text = NAME,
	OnClick = function(clickedframe, button)
		ACD[ACD.OpenFrames.FasterCamera and "Close" or "Open"](ACD, "FasterCamera")
	end,
	OnTooltipShow = function(tt)
		tt:AddLine("|cffADFF2F"..NAME.."|r")
		tt:AddDoubleLine(L.CAMERA_ZOOM_INCREMENT, "|cffFFFFFF"..db.increment.."|r")
		tt:AddDoubleLine(L.CAMERA_ZOOM_SPEED, "|cffFFFFFF"..db.speed.."|r")
		tt:AddDoubleLine(MAX_FOLLOW_DIST, "|cffFFFFFF"..distance().."|r")
	end,
}

LibStub("LibDataBroker-1.1"):NewDataObject(NAME, dataobject)
