--[[
AdiBags_Bound - Adds BoE/BoA filters to AdiBags.
Copyright 2010-2012 Kevin (kevin@outroot.com)
All rights reserved.
--]]

local _, ns = ...

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})

do -- Localization
  L["Bound"] = "Bound"
  L["Put BOE/BOA in their own sections."] = "Put BOE/BOA in their own sections."

  local locale = GetLocale()
  if locale == "frFR" then

  elseif locale == "deDE" then
    
  elseif locale == "esMX" then
    
  elseif locale == "ruRU" then
    
  elseif locale == "esES" then
    
  elseif locale == "zhTW" then
    
  elseif locale == "zhCN" then
    
  elseif locale == "koKR" then
    
  end
end

local tooltip
local function create()
  local tip, leftside = CreateFrame("GameTooltip"), {}
  for i = 1, 2 do
    local L,R = tip:CreateFontString(), tip:CreateFontString()
    L:SetFontObject(GameFontNormal)
    R:SetFontObject(GameFontNormal)
    tip:AddFontStrings(L,R)
    leftside[i] = L
  end
  tip.leftside = leftside
  return tip
end

-- The filter itself

local setFilter = addon:RegisterFilter("Bound", 92, 'AceEvent-3.0')
setFilter.uiName = L['Bound']
setFilter.uiDesc = L['Put BOE/BOA in their own sections.']

function setFilter:OnInitialize()
  self.db = addon.db:RegisterNamespace('Bound', {
    profile = { enableBoE = true, enableBoA = true },
    char = {  },
  })
end

function setFilter:Update()
  self:SendMessage('AdiBags_FiltersChanged')
end

function setFilter:OnEnable()
  addon:UpdateFilters()
end

function setFilter:OnDisable()
  addon:UpdateFilters()
end

local setNames = {}

function setFilter:Filter(slotData)
  tooltip = tooltip or create()
  tooltip:SetOwner(UIParent,"ANCHOR_NONE")
  tooltip:ClearLines()
  tooltip:SetBagItem(slotData.bag, slotData.slot)

  for i = 1,2 do
    local t = tooltip.leftside[i]:GetText()
    if self.db.profile.enableBoE and t == ITEM_BIND_ON_EQUIP then
      return L["BoE"]
    elseif self.db.profile.enableBoA and (t == ITEM_ACCOUNTBOUND or t == ITEM_BIND_TO_BNETACCOUNT or t == ITEM_BNETACCOUNTBOUND) then
      return L["BoA"]
    end
  end
  tooltip:Hide()
end

function setFilter:GetOptions()
  return {
    enableBoE = {
      name = L['Enable BoE'],
      desc = L['Check this if you want a section for BoE items.'],
      type = 'toggle',
      order = 10,
    },
    enableBoA = {
      name = L['Enable BoA'],
      desc = L['Check this if you want a section for BoA items.'],
      type = 'toggle',
      order = 20,
    },
  }, addon:GetOptionHandler(self, false, function() return self:Update() end)
end
