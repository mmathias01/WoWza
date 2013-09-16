-- ============================================================================
-- == BRFData - A collection of helpful data manipulation functions.         ==
-- ============================================================================

BRFData = LibStub("AceAddon-3.0"):NewAddon("BRFData", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("BrokerRecountFu")

-- ============================================================================
-- == OnInitialize()                                                         ==
-- ==                                                                        ==
-- == This function is called when the addon is initialised.                 ==
-- ============================================================================

function BRFData:OnInitialize()
end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is enabled.                     ==
-- ============================================================================

function BRFData:OnEnable()
end

-- ============================================================================
-- == OnEnable()                                                             ==
-- ==                                                                        ==
-- == This function is called when the addon is disabled.                    ==
-- ============================================================================

function BRFData:OnDisable()
end

-- ============================================================================
-- ==  PadLeadingZeros(number, length)                                       ==
-- ==                                                                        ==
-- == This function pads a number with leading zeros to ensure it represents ==
-- == a string with length matching the supplied length parameter.           ==
-- ============================================================================

function BRFData:PadLeadingZeros(number, length)

  local stringLength = string.len(number)
  local padCount     = length - stringLength

  if padCount > 0 then
    for index = 1, padCount, 1 do
      number = "0" .. number
    end
  end

  return number

end

-- ============================================================================
-- == BRFData:StringSplit(text, separator)                                    ==
-- ==                                                                        ==
-- == This function receives a string and converts it into a list of         ==
-- == arguments, using a supplied separator character.                       ==
-- ============================================================================

function BRFData:StringSplit(text, separator)

  if text == nil then
    text = ""
  end

  if tostring(text) == "true" or tostring(text) == "false" then
    text = ""
  end

  local args = {}
  local i = 0

  -- search for separators in the string and return the separated data
  for value in string.gmatch(text, "[^"..separator.."]+") do
    i = i + 1
    args[i] = value
  end

  return args

end

-- ============================================================================
-- ==  AsResourceName(text)                                                  ==
-- ==                                                                        ==
-- == This function converts the supplied text into a format suitable for    ==
-- == use as all or part of a resource name - that is, the key used to       ==
-- == reference values in the localisation files.                            ==
-- ============================================================================

function BRFData:AsResourceName(text)

  text = string.lower(text)
  text = string.gsub(text, " ", "")

  return text

end

-- ============================================================================
-- == SafeString(value)                                                      ==
-- ==                                                                        ==
-- == Checks supplied parameter, replaces unsafe values as required.         ==
-- ============================================================================

function BRFData:SafeString(value)

  if value == nil then
    value = ""
  end

  return value

end

-- ============================================================================
-- == SafeNumber(value)                                                      ==
-- ==                                                                        ==
-- == Checks supplied parameter, replaces unsafe values as required.         ==
-- ============================================================================

function BRFData:SafeNumber(value)

  if value == nil then
    value = 0
  end

  return value

end

-- ============================================================================
-- == SafeNumericBoolean(value)                                              ==
-- ==                                                                        ==
-- == Checks supplied parameter, replaces unsafe values as required.         ==
-- ============================================================================

function BRFData:SafeNumericBoolean(value)

  if value == nil then
    value = "0"
  else
    value = "1"
  end

  return value

end

-- ============================================================================
-- == BooleanAsText(value)                                                   ==
-- ==                                                                        ==
-- == Expresses a boolean as text. True maps to "Yes", false to "No"         ==
-- ============================================================================

function BRFData:BooleanAsText(value)

  if value == nil then
    value = true
  end

  if value then
    return L["data-conversion-boolean-as-text-yes"]
  else
    return L["data-conversion-boolean-as-text-no"]
  end

end

-- ============================================================================
-- == JoinTables(table1, table2)                                             ==
-- ==                                                                        ==
-- == This function simply joins two tables together and returns the result. ==
-- ============================================================================

function BRFData:JoinTables(table1, table2)

   for k,v in ipairs(table2) do
      table.insert(table1, v)
   end

   return table1

end

-- ============================================================================
-- == IsInTable(dataTable, dataValue)                                        ==
-- ==                                                                        ==
-- == This function indicates whether the supplied value is contained in the ==
-- == supplied table, returning true if it is, false otherwise.              ==
-- ============================================================================

function BRFData:IsInTable(dataTable, dataValue)

  for i,v in ipairs(dataTable) do
    if BRFData:SafeString(v) == BRFData:SafeString(dataValue) then
      return true
    end
  end

  return false

end

-- ============================================================================
-- == BuildStringFromTable(dataTable, dataString, separator)                 ==
-- ==                                                                        ==
-- == This function builds a string from a table by concatenating all values ==
-- == together, using a nominal separator between values. The string being   ==
-- == built is also a parameter allowing the string to contain data before   ==
-- == the concatenation process begins.                                      ==
-- ==                                                                        ==
-- == Example: A table containing names, a dataString of "My friends:" and a ==
-- ==          separator of ", " would give something like...                ==
-- ==                                                                        ==
-- ==          "My friends: Bobby, Charlie, Sue"                             ==
-- ==                                                                        ==
-- ============================================================================

function BRFData:BuildStringFromTable(dataTable, dataString, separator)

  for i,v in ipairs(dataTable) do

    if i > 1 then
      dataString = dataString .. separator
    end

    dataString = dataString .. v

  end

  return dataString

end

-- ============================================================================
-- == SecondsToMinutes(seconds)                                              ==
-- ==                                                                        ==
-- == This function converts a value in seconds to a value in minutes and    ==
-- == seconds.                                                               ==
-- ============================================================================

function BRFData:SecondsToMinutes(seconds)

  local minutes      = math.floor(tonumber(seconds/60))

  seconds = seconds - (minutes * 60)

  local wholeSeconds = BRFData:StringSplit(seconds, ".")

  local timeString = minutes .. "m" .. wholeSeconds[1] .. "s"

  return timeString

end

-- ============================================================================
-- == BRFData:GetTimeString()                                                ==
-- ==                                                                        ==
-- == This function returns a simple HH:MM timestring.                       ==
-- ============================================================================

function BRFData:GetTimeString()

  local hours,minutes = GetGameTime();
  local timeString    = BRFData:PadLeadingZeros(BRFData:SafeNumber(hours), 2) .. ":" .. BRFData:PadLeadingZeros(BRFData:SafeNumber(minutes), 2)

  return timeString

end

-- ============================================================================
-- == GetFirstWord(text)                                                     ==
-- ==                                                                        ==
-- == This function returns the first word in the supplied text.             ==
-- ============================================================================

function BRFData:GetFirstWord(text)

  local firstWord = ""
  local words     = BRFData:StringSplit(text, " ")

  if #words > 0 then
    firstWord = BRFData:SafeString(words[1])
  end

  return firstWord

end

-- ============================================================================
-- == RemoveLastWord(text)                                                   ==
-- ==                                                                        ==
-- == This function returns the text with the last word removed.             ==
-- ============================================================================

function BRFData:RemoveLastWord(text)

  local firstWords = ""
  local words      = BRFData:StringSplit(text, " ")

  if #words > 0 then
    for i,v in ipairs(words) do
      if i < #words then
        if i > 1 then
          firstWords = firstWords .. " "
        end
        firstWords = firstWords .. words[i]
      end
    end

  end

  return firstWords

end

-- ============================================================================
-- == BRFData:DecorateNumber(value)                                          ==
-- ==                                                                        ==
-- == This function returns the supplied numeric value with commas inserted  ==
-- == according to the practice. eg: 1000000.00 -> 1,000,000.00              ==
-- ==                                                                        ==
-- == It may become desireable to adapt this later to be able to decorate    ==
-- == numbers more flexibly since in some territories, the equivalent        ==
-- == decoration would be: 1000000,00 -> 1.000.000,00                        ==
-- ============================================================================

function BRFData:DecorateNumber(value)

  if value == nil then return 0 end

  if BRFConfig:GetIsEnabledCompactSystemNumbers(nil) == true then
    return BRFData:CompactValue(value)
  else
    return BRFData:AddThousandSeparators(value)
  end

end

-- ============================================================================
-- == BRFData:AddThousandSeparators(value)                                   ==
-- ==                                                                        ==
-- == This function returns the supplied numeric value with commas inserted  ==
-- == according to the practice. eg: 1000000.00 -> 1,000,000.00              ==
-- ============================================================================

function BRFData:AddThousandSeparators(value)

  if value == nil then return 0 end

  value = ("%.0f"):format(value)
  local left,num,right = string.match(value,'^([^%d]*%d)(%d+)(.-)$')
  local decoratedValue = left and left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse()) or value --..right

  return BRFData:FixSeparators(decoratedValue)

end

-- ============================================================================
-- == BRFData:CompactValue(value)                                            ==
-- ==                                                                        ==
-- == This function returns a compacted version of the supplied number using ==
-- == alphabetical tokens to represent unit-magnitudes.                      ==
-- ==                                                                        ==
-- == For example:                                                           ==
-- ==                                                                        ==
-- == Hundreds (0-999)                                                       ==
-- ==                                                                        ==
-- ==   >    1 ->   1                                                        ==
-- ==   >  999 -> 999                                                        ==
-- ==                                                                        ==
-- == Thousands (1000-999999)                                                ==
-- ==                                                                        ==
-- ==   =>   1000 ->   1K                                                    ==
-- ==   =>   1500 -> 1.5K                                                    ==
-- ==   => 999999 -> 999K                                                    ==
-- ==                                                                        ==
-- == Millions (1000000-999999999)                                           ==
-- ==                                                                        ==
-- ==   =>   1000000 ->   1M                                                 ==
-- ==   =>   1500000 -> 1.5M                                                 ==
-- ==   => 999999999 -> 999M                                                 ==
-- ==                                                                        ==
-- == Billions (1000000000-999999999999)                                     ==
-- ==                                                                        ==
-- ==   =>   1000000000 ->   1B                                              ==
-- ==   =>   1500000000 -> 1.5B                                              ==
-- ==   => 999999999999 -> 999B                                              ==
-- ==                                                                        ==
-- == Trillions (1000000000000-infinity)                                     ==
-- ==                                                                        ==
-- ==   =>   1000000000000 ->   1T                                           ==
-- ==   =>   1500000000000 -> 1.5T                                           ==
-- ==   => 999999999999999 -> 999T                                           ==
-- ==                                                                        ==
-- == Note that the decimal portion is only shown if it is non-zero AND if   ==
-- == there is only one significant figure being displayed.                  ==
-- ============================================================================

function BRFData:CompactValue(value)

  if string.find(value, L["data-numerical-separator-period"], 1, true) ~= nil then
    value = string.sub(value, 1, string.find(value, L["data-numerical-separator-period"], 1, true) - 1)
  end
  
  local stringLength   = string.len(value)
  local majorIndex     = stringLength
  local unitLabel      = ""
  local decoratedValue = value

  if stringLength > 12 then
    -- set for trillions
    majorIndex = -13
    unitLabel  = L["data-numerical-unit-trillions"]
  elseif stringLength > 9 then
    -- set for billions
    majorIndex = -10
    unitLabel  = L["data-numerical-unit-billions"]
  elseif stringLength > 6 then
    -- set for millions
    majorIndex = -7
    unitLabel  = L["data-numerical-unit-millions"]
  elseif stringLength > 3 then
    -- set for thousands
    majorIndex = -4
    unitLabel  = L["data-numerical-unit-thousands"]
  end

  local majorComponent = string.sub(value, 1, majorIndex)
  local minorComponent = string.sub(value, (majorIndex), (majorIndex))

  if (minorComponent ~= "0") and (tonumber(stringLength) + tonumber(majorIndex) == 0) then
    decoratedValue = majorComponent .. "." .. minorComponent .. unitLabel
  elseif BRFConfig:GetIsEnabledAlwaysShowOneDecimalPlace(nil) == true then
    decoratedValue = majorComponent .. "." .. minorComponent .. unitLabel
  else
    decoratedValue = majorComponent .. unitLabel
  end

  return BRFData:FixSeparators(decoratedValue)

end

-- ============================================================================
-- == FixSeparators(value)                                                   ==
-- ==                                                                        ==
-- == This function assumes the value passed into it will be formatted using ==
-- == the standard British/American separator convention of "," for each     ==
-- == interval of one thousand and "." for the decimal fraction.             ==
-- ==                                                                        ==
-- == Example: 123,456.789                                                   ==
-- ==                                                                        ==
-- == In some territories, this convention is reversed and numbers are       ==
-- == formatted with "." separating each interval of one thousand and ","    ==
-- == separating the decimal fraction.                                       ==
-- ==                                                                        ==
-- == Example: 123.456,789                                                   ==
-- ==                                                                        ==
-- == The addon defaults to the former behaviour but users may select the    ==
-- == latter if they prefer. This function simply ensures that the user's    ==
-- == preferred form of numerical formatting is applied.                     ==
-- ============================================================================

function BRFData:FixSeparators(value)

  local trueComma     = L["data-numerical-separator-comma"]
  local truePeriod    = L["data-numerical-separator-period"]
  local proxyComma    = "@"
  local proxyPeriod   = "#"
  local regexPrefix   = "%"

  local userThousands = BRFConfig:GetNumericalSeparatorThousands(nil)
  local userDecimals  = BRFConfig:GetNumericalSeparatorDecimals(nil)

  value = BRFData:SafeString(value)

  value = string.gsub(value, regexPrefix .. trueComma, proxyComma)
  value = string.gsub(value, regexPrefix .. truePeriod, proxyPeriod)

  value = string.gsub(value, proxyComma, userThousands)
  value = string.gsub(value, proxyPeriod, userDecimals)

  return value

end
