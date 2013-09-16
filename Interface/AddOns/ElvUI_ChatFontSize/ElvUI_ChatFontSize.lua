local ADDON_NAME, ADDON, _ = ...

-- Setup Global
_G[ADDON_NAME] = ADDON

-- Setup Local
local A, C = ADDON, { }     -- Addon Engine, Addon Config
local defaultProfile = {
  fontSize = 12,
}

function A:LoadConfig(database)
    setmetatable(C, {
    __index = function(table, key)
        return database[key]
      end,
    __newindex = function(table, key, value)
        database[key] = value
      end,
  })
end

function A.Event_EnterWorld(self)
  self:UnregisterEvent("PLAYER_ENTERING_WORLD")
  
  if not ElvChatFontDB then ElvChatFontDB = defaultProfile end
  A:LoadConfig(ElvChatFontDB)
  
  -- Get ElvUI
  if not ElvUI or not ElvUI[1].Chat then
    print("|cff1784d1ElvUI|r ChatFontSize: |cffFF0000 Requires ElvUI with chat enabled to run!")
    return
  end
  local E = ElvUI[1]
  local L = ElvUI[2]
  
  -- Hook ElvUI Setup Chat Method
  A.ElvUI_Chat_SetupChat = E.Chat.SetupChat
  
  E.Chat.SetupChat = function(self, event, ...)
      A.ElvUI_Chat_SetupChat(self, event, ...)
      A:UpdateChatSize()    -- POST UPDATE: Change font sizes of the chat frames:
    end
  
  A:UpdateChatSize()
end

function A:UpdateChatSize()
  for _, frameName in pairs(CHAT_FRAMES) do
    local frame = _G[frameName]
    local font, size, outline = frame:GetFont()
    
    
    -- Change the font size
    frame:SetFont(font, C.fontSize or size, outline)
  end
end

-- Register Event to load our saved vars
local entering = CreateFrame("FRAME")
entering:RegisterEvent("PLAYER_ENTERING_WORLD")
entering:SetScript("OnEvent", A.Event_EnterWorld)

local function LoadOptions()
	print("loaded options")

	local E = ElvUI[1]
  local L = ElvUI[2]

	-- Register Options
  E.Options.args.chat.args.fontGroup.args.fontOutline.order = 3
  E.Options.args.chat.args.fontGroup.args.fontSize = {
    order = 2,
    name = L["Font Size"],
    type = "range",
    min = 6, max = 22, step = 1,
    get = function(index) return C[index[#index]] end,
    set = function(index, value) C[index[#index]] = value; A:UpdateChatSize() end,
  }
end

-- Register Event to Load Options
local frame = CreateFrame("FRAME")
frame:RegisterEvent('ADDON_LOADED')
frame:SetScript('OnEvent', function(self, event, addon)
	if event == 'ADDON_LOADED' and addon == 'ElvUI_Config' then
		LoadOptions()
		self:UnregisterEvent('ADDON_LOADED')
	end
end)

