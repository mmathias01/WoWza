-- ============================================================================
-- == BRFConsole - A collection of functions related to interactions that    ==
-- ==              occur via the console. This includes most forms of chat   ==
-- ==              based communication and the display of text-messages      ==
-- ==              within Chat windows.                                      ==
-- ============================================================================

BRFConsole = LibStub("AceAddon-3.0"):NewAddon("BRFConsole", "AceConsole-3.0")
local L    = LibStub("AceLocale-3.0"):GetLocale("BrokerRecountFu")

-- ============================================================================
-- == OnInitialize()                                                         ==
-- ==                                                                        ==
-- == This function is called when the addon is initialised.                 ==
-- ============================================================================

function BRFConsole:OnInitialize()
end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is enabled.                     ==
-- ============================================================================

function BRFConsole:OnEnable()
end

-- ============================================================================
-- == OnDisable()                                                            ==
-- ==                                                                        ==
-- == This function is called when the addon is disabled.                    ==
-- ============================================================================

function BRFConsole:OnDisable()
end

-- ============================================================================
-- == ExecuteChatCommand(arg)                                                ==
-- ==                                                                        ==
-- == This function attempts to execute the supplied argument as though it   ==
-- == were a command entered by the user in the chat window.                 ==
-- ============================================================================

function BRFConsole:ExecuteChatCommand(arg)

  if( not DEFAULT_CHAT_FRAME ) then return end

  DEFAULT_CHAT_FRAME.editBox:SetText(arg);
  ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox);

end

-- ============================================================================
-- == SendChatMessage(messageText, channelName, language, recipient)         ==
-- ==                                                                        ==
-- == This function is ostensibly a wrapper to the normal SendChatMessage    ==
-- == function with minor changes as follows:                                ==
-- ==                                                                        ==
-- == 1: Language is checked because it may not be passed in.                ==
-- == 2: If channelName = "CHAT", output is routed to self:Print() instead.  ==
-- == 3: If channelName = "NULL", output is muted.                           ==
-- ==                                                                        ==
-- == The intention for the existence of the NULL option for the channel     ==
-- == name is to allow for functions to pass a parameter that can be         ==
-- == switched between a normal channel and null to turn on/off debug mode   ==
-- == features.                                                              ==
-- ============================================================================

function BRFConsole:SendChatMessage(messageText, channelName, language, recipient)

  -- == -----------------------------------------------------------------------
  -- == -- Check whether the language option has been provided.              --
  -- == -----------------------------------------------------------------------
  if language == nil or language == " " then
    language = nil
  end

  channelName = BRFConsole:SafeChatChannelName(channelName)

  -- == -----------------------------------------------------------------------
  -- == -- Send chat output to 'chat' or to intended channel if not 'NULL'.  --
  -- == -----------------------------------------------------------------------
  if channelName == "CHAT" then
    BRFConsole:PrintChatMessage(messageText)
  elseif channelName == "ERRORFRAME" then
    BRFConsole:PrintErrorFrameMessage(messageText)
  elseif channelName ~= "NULL" then
    SendChatMessage(messageText, channelName, language, recipient)
  end

end

-- ============================================================================
-- == PrintChatMessage(messageText)                                          ==
-- ==                                                                        ==
-- == This function prints the supplied message text parameter to the chat   ==
-- == window. Since the chat-window supports colour encoding of content, the ==
-- == text is preprocessed to colourise recognised tokens.                   ==
-- ============================================================================

function BRFConsole:PrintChatMessage(messageText)

  -- Colourise: '[BRF] - Subtitle - OtherText...', Yellow Subtitle.
  messageText = string.gsub(messageText, "[%-](.-)[%-]", "-|cffffff00%1|r-", 1)

  -- Colourise: '[BRF]', Blizzard-Blue [BRF].
  messageText = string.gsub(messageText, "[%[]BRF[%]]", "|cff00c0ff[BRF]|r", 1)

  print(messageText)

end

-- ============================================================================
-- == PrintErrorFrameMessage(messageText)                                    ==
-- ==                                                                        ==
-- == This function prints the supplied message text parameter to the UI     ==
-- == error-frame.                                                           ==
-- ============================================================================

function BRFConsole:PrintErrorFrameMessage(messageText)

  UIErrorsFrame:AddMessage(messageText, 0, 1.0, 1.0, 1.0, 1)

end

-- ============================================================================
-- == SendWrappedMessage(messageText, channelName)                           ==
-- ==                                                                        ==
-- == This function processes the supplied messageText data into a series of ==
-- == individual messages which are then output to the channel identified by ==
-- == the channelName parameter.                                             ==
-- ============================================================================

function BRFConsole:SendWrappedMessage(messageText, channelName, language, recipient)

  local maxWidth        = BRFConfig:GetChatWindowTextMaxWidth(nil)
  local words           = BRFData:StringSplit(messageText, " ")
  local characterCount  = 0
  local thisLineText    = " "
  local spacerChar      = ""

  -- Loop through the list of words, printing as many per line as the maximum
  -- line width allows.
  for i,v in ipairs(words) do

    if (characterCount + string.len(v)) < maxWidth then
      thisLineText   = thisLineText .. spacerChar .. v
      characterCount = characterCount + string.len(v) + 1
      spacerChar     = " "
    else
      BRFConsole:SendChatMessage(thisLineText, channelName, language, recipient)
      thisLineText      = spacerChar .. v .. spacerChar
      characterCount    = 0
      spacerChar        = ""
    end

  end

  -- Check if there are any words remaining to be printed as a final non-full
  -- line.
  if string.len(thisLineText) > 0 then
    BRFConsole:SendChatMessage(thisLineText, channelName, language, recipient)
  end

end

-- ============================================================================
-- == SendChannelMessage(messageText, channelNumber)                         ==
-- ==                                                                        ==
-- == This function sends the supplied message text to the nominated chat    ==
-- == channel. If the nominated channelNumber is 0, it is assumed that no    ==
-- == suitable channel exists and the output is redirected to the CHAT       ==
-- == channel instead.                                                       ==
-- ============================================================================

function BRFConsole:SendChannelMessage(messageText, channelNumber)

  if channelNumber == 0 then
    BRFConsole:SendChatMessage(messageText, "CHAT", nil, nil)
  else
    BRFConsole:SendChatMessage(messageText, "CHANNEL", nil, channelNumber)
  end

end

-- ============================================================================
-- == SendTitleBar(channelName)                                              ==
-- ==                                                                        ==
-- == This function outputs a title-bar configured to the width specified in ==
-- == the configuration property describing the maximum chat window width.   ==
-- ============================================================================

function BRFConsole:SendTitleBar(channelName)

  local titleBarText = ""
  local maxWidth     = abs(BRFConfig:GetChatWindowTextMaxWidth(nil) * 1.5 )

  for i=1,maxWidth do
    titleBarText = titleBarText .. "-"
  end

  BRFConsole:SendChatMessage(BRFConsole:GetTitleBar(), channelName, nil, nil)

end

-- ============================================================================
-- == GetTitleBar()                                                          ==
-- ==                                                                        ==
-- == This function returns a title-bar whose width is defined by the        ==
-- == current max-width calculation.                                         ==
-- ============================================================================

function BRFConsole:GetTitleBar()

  local titleBarText = ""
  local maxWidth     = abs(BRFConfig:GetChatWindowTextMaxWidth(nil) * 1.5 )

  for i=1,maxWidth do
    titleBarText = titleBarText .. "-"
  end

  return titleBarText

end

-- ============================================================================
-- == Debug(messageText)                                                     ==
-- ==                                                                        ==
-- == This function outputs the supplied message text to the "CHAT" channel  ==
-- == as a standard format 'debug' message if the debug-mode is currently    ==
-- == enabled.                                                               ==
-- ==                                                                        ==
-- == Typically, the debug message format would be:                          ==
-- ==                                                                        ==
-- == "[DEBUG] - {topicname} - Message"                                      ==
-- ============================================================================

function BRFConsole:Debug(messageText)

  -- Return immediately if the messageText parameter is empty/null.
  if messageText == nil then return end

  -- Only proceed if the Debug feature is enabled.
  if BRFConfig:GetIsEnabledDebugMode(nil) then

    local debugText = "|cffff0000" .. "[DEBUG]" .. "|r" .. " - " .. messageText

    -- The debug filter is not enabled so output debug message.
    BRFConsole:SendChatMessage(debugText, "CHAT", nil, nil)

  end

end

-- ============================================================================
-- == SafeChatChannelName(channelName)                                       ==
-- ==                                                                        ==
-- == This function simply checks that the supplied channelName parameter    ==
-- == would be safe to use in the context of this user. If the name would be ==
-- == considered unsafe, a safe alternative is substituted.                  ==
-- ============================================================================

function BRFConsole:SafeChatChannelName(channelName)

  -- == -----------------------------------------------------------------------
  -- == -- Setup variables that will be needed.                              --
  -- == -----------------------------------------------------------------------
  local playerName = UnitName("player")

  -- == -----------------------------------------------------------------------
  -- == -- [GUILD] Checks...                                                 --
  -- == -----------------------------------------------------------------------
  if channelName == "GUILD" then
    if not IsInGuild() then
      channelName = "CHAT"
      BRFConsole:Debug(L["con-player-not-in-guild"])
    end
  end

  -- == -----------------------------------------------------------------------
  -- == -- [RAID] Checks...                                                  --
  -- == -----------------------------------------------------------------------
  if channelName == "RAID" then
    if not BRFCommon:IsPlayerInRaid() then
      channelName = "PARTY"
      BRFConsole:Debug(L["con-player-not-in-raid"] )
    end
  end

  -- == -----------------------------------------------------------------------
  -- == -- [PARTY] Checks...                                                 --
  -- == -----------------------------------------------------------------------
  if channelName == "PARTY" then
    if not BRFCommon:IsPlayerInParty() then
      channelName = "CHAT"
      BRFConsole:Debug(L["con-player-not-in-party"] )
    end
  end

  -- == -----------------------------------------------------------------------
  -- == -- Return the value, adjusted or otherwise, of channelName.          --
  -- == -----------------------------------------------------------------------
  return channelName

end
