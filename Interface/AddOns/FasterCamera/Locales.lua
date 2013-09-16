local _, S = ...

local L = {
	enUS = {
		CAMERA_ZOOM_INCREMENT = CAMERA_LABEL.." Zoom Increment",
		CAMERA_ZOOM_SPEED = CAMERA_LABEL.." Zoom "..SPEED,
	},
	deDE = {
		CAMERA_ZOOM_INCREMENT = "Kamerazoomschritt",
		CAMERA_ZOOM_SPEED = "Kamerazoomgeschwindigkeit",
	},
	esES = {
		CAMERA_ZOOM_INCREMENT = "Incremento Zoom de la Cámara",
		CAMERA_ZOOM_SPEED = "Velocidad Zoom de la Cámara",
	},
	--esMX = {},
	frFR = {
	},
	itIT = {
	},
	koKR = {
		CAMERA_ZOOM_INCREMENT = "카메라 줌 증가",
		CAMERA_ZOOM_SPEED = "카메라 줌 속도",
	},
	ptBR = {
		CAMERA_ZOOM_INCREMENT = "Camera Zoom Aumento",
		CAMERA_ZOOM_SPEED = "Camera Zoom Velocidade",
	},
	ruRU = {
	},
	zhCN = {
		CAMERA_ZOOM_INCREMENT = "镜头缩放增量",
		CAMERA_ZOOM_SPEED = "镜头缩放速度",
	},
	zhTW = {
		CAMERA_ZOOM_INCREMENT = "鏡頭縮放增量",
		CAMERA_ZOOM_SPEED = "鏡頭縮放速度",
	},
}

L.esMX = L.esES -- esMX is empty

S.L = setmetatable(L[GetLocale()] or L.enUS, {__index = function(t, k)
	local v = rawget(L.enUS, k) or k
	rawset(t, k, v)
	return v
end})
