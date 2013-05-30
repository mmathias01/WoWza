local major = 2
local minor = 5

local oldlib = LibStub("LibGoingPrice-"..major,true)

local lib, oldminor = LibStub:NewLibrary("LibGoingPrice-"..major, minor)

if not lib then
    oldlib = nil
	return	-- already loaded and no upgrade necessary
end

lib._loaderAddOnVersion = 0

lib._texts = {}

if oldminor and oldlib._loaderAddOnVersion then
    -- Remember oldlib's texts and loader version
    for k,v in pairs(oldlib._texts) do
        lib._texts[k] = v   
    end

    lib._loaderAddOnVersion = oldlib._loaderAddOnVersion
end

local L = lib._texts

oldlib = nil -- Don't need oldlib anymore

-- LibGoingPrice currently depends on LibExtraTip
--
local lib_tt = LibStub("LibExtraTip-1")

lib_tt:SetEmbedMode(false)
lib_tt:RegisterTooltip(GameTooltip)
lib_tt:RegisterTooltip(ItemRefTooltip)

local function addonShouldLoadOnThisRealm(addon)
    local currentRealm = GetRealmName()

    return not addon._realm_name or ( currentRealm == addon._realm_name or
            currentRealm == L[addon._realm_name] )
end

function lib_tt:AddColorMoneyLine(tooltip,text,money,r,g,b,mr,mg,mb,embed,concise)
    local reg = lib_tt.tooltipRegistry[tooltip]
    assert(reg, "Unknown tooltip passed to LibExtraTip:AddMoneyLine()")

    if r and not g then embed = r r = nil end
    embed = embed ~= nil and embed or lib_tt.embedMode

    local moneyText = lib_tt:GetMoneyText(money, concise)

    if not embed then
        reg.extraTip:AddDoubleLine(text,moneyText,r,g,b,mr,mg,mb)
        reg.extraTipUsed = true
    else
        tooltip:AddDoubleLine(text,moneyText,lr,lg,lb,1,1,1)
    end
end

lib.nameColor = "ffff5400"
lib.evilColor = "ffff1111"
lib.saintColor = "ff8888ff"

local function onEnter(o)
	GameTooltip:SetOwner(o, "ANCHOR_TOPRIGHT");

	GameTooltip:SetText(o._tooltip_text, nil, nil, nil, nil, 1) 

	GameTooltip:Show()
end

local function onLeave(o)
	GameTooltip:Hide()
end

local function GetItemId(itemName)
	local item,itemLink = GetItemInfo(itemName)
	return tonumber(string.match(itemLink,"|Hitem:(%d+):.*|h"))
end

function lib:DisplaySourceTitle(tooltip,id)

	local pd = _G[self._name.."_PullDateCb"]
	local sv = _G[self._name.."_SV"]
	local data = _G[self._name.."_Data"]

	if pd:GetChecked() and sv._pullDate.keep then
		local lr,lg,lb = unpack(sv._base.settings.sourceTitleColor)
		local rr,rg,rb = unpack(sv._base.settings.pullDateColor)
		value = data[id][#data[id]]
		lib_tt:AddDoubleLine(tooltip,
			self._source,"("..date("%b %d, %Y %I:%M %p",value)..")",lr,lg,lb,rr,rg,rb)
	else
		local r,g,b = unpack(sv._base.settings.sourceTitleColor)
		lib_tt:AddLine(tooltip,self._source,r,g,b)
	end
end

function lib:GetCallback()
	self._callback = self._callback or function(tooltip,item)
		local base = not self._base or _G[self._base.name]
		if not base
			or ( not (base.modifiers[base.settings.modifier][1] == "None")
				and not base.modifiers[base.settings.modifier][2]() ) then return end
	    local id = GetItemId(item)
		local wasSourceTitleDisplayed = false
		local data = _G[self._name.."_Data"]
		local sv = _G[self._name.."_SV"]

		if data[id] then
	
			local key = sv._firstKey
	
			while key do
				if sv[key].keep then
	
					local state = self[key]
					local value = data[id][sv._index[key]]
	
					if value then
	
						if not ( wasSourceTitleDisplayed or key == "Per stack" ) then
							self:DisplaySourceTitle(tooltip,id)
							wasSourceTitleDisplayed = true
						end
	
						local r,g,b = unpack(sv[key].color
												or sv._base.settings.statisticColor)
						if state.type == "integer" then
							lib_tt:AddDoubleLine(tooltip,
									"   "..L[key],value,r,g,b,r,g,b)
						elseif state.type == "date" then
							lib_tt:AddDoubleLine(tooltip,
									"   "..L[key],date("%b %d, %Y %I:%M %p",
									value),r,g,b,r,g,b)
						elseif state.type == "price" then
							if key == "Per stack" then
								local _r1,_r2,_r3,_r4,_r5,_r6,_r7,maxStack,_r9,_r0
									= GetItemInfo(id)
								if maxStack > 1 then
	
									if not wasSourceTitleDisplayed then
										self:DisplaySourceTitle(tooltip,id)
										wasSourceTitleDisplayed = true
									end
	
									lib_tt:AddMoneyLine(tooltip,
										"   "..L[key].." ("..maxStack..")",
										value,r,g,b)
								end
							else	
                                if type(value) == "table" then
                                    mr,mg,mb = unpack(value[2])
                                    lib_tt:AddColorMoneyLine(tooltip,"   "..L[key],
                                        value[1],r,g,b,mr,mg,mb)
                                else
								    lib_tt:AddMoneyLine(tooltip,"   "..L[key],value,r,g,b)
                                end
							end
                        elseif state.type == "text" then
							lib_tt:AddDoubleLine(tooltip,
									"   "..L[key],value,r,g,b,r,g,b)
						end
					end
				end
	
				key = sv[key].next
			end
		end
	end
	return self._callback
end

function lib:CopyState(s)
	local d = {}

	d._firstKey = s._firstKey
	d._lastKey = s._lastKey

	for i,k in ipairs(self._keys)  do
		d[k] = {
				checked = s[k].checked,
				keep = s[k].keep,
				prev = s[k].prev,
				next = s[k].next,
			}

		if s[k].color then
			d[k].color = {}
			d[k].color[1], d[k].color[2], d[k].color[3] = unpack(s[k].color)
		end
	end

	d._index = {}

	for k,i in pairs(s._index) do
		d._index[k] = i
	end

	d._pullDate = 	{
						checked = s._pullDate.checked,
						keep = s._pullDate.keep,
					}

	d._discard = 	{
						checked = s._discard.checked,
					}

	if s._reKeep then
		d._reKeep = {}
		for k,v in pairs(s._reKeep) do
			d._reKeep[k] = v
		end
	end

	d._tooltip_order = s._tooltip_order

	if s._base then
		local base = _G[s._base.name]
		d._base = {}
		d._base.name = s._base.name

		if base then
			--d._base.settings = base:CopyState(s._base.settings or base.defaults)
			d._base.settings = base:CopyState(base.settings or base.defaults)
		end
	end

	return d
end

function lib:UpdatePreview(state)

	local panel = _G[self._name.."_Panel"] -- Get the addon's sub-panel object.

    for i,v in pairs(self._keys) do
		_G[self._name.."_PreviewItem_"..i]:Hide()
	end

	local i = 1

	local k = state._firstKey

	while k do
		local button = _G[self._name.."_PreviewItem_"..self._index[k]]

		button:SetPoint("TOPLEFT",
						panel,
						"TOPLEFT",
						200 ,
						-25 - (25 * i))

	    local sv = _G[self._name.."_SV"]

		if sv[k].keep then
			local r,g,b = unpack(state[k].color
							or ( state._base and state._base.settings.statisticColor)
							or ( { 1, 1, 1 } ) )
			_G[button:GetName().."Text"]:SetTextColor(r,g,b)
		else
			_G[button:GetName().."Text"]:SetTextColor(0.5,0.5,0.5)
		end

		button:Show()

		k = state[k].next
		i = i + 1
	end
end

local function updateSliderText(slider)
	local sliderText = _G[slider:GetName().."Text"]
	sliderText:SetText(slider._basetext.."("..slider:GetValue()..")|r")
end

function lib:LoadPanelUI(state)

	local base = self._base and _G[self._base.name]

	-- Statistic color and checkbox's
	for i,k in ipairs(self._keys) do
		local c = _G[self._name.."_StatColor_"..i]

		if state[k].color then
			c:SetBackdropColor(unpack(state[k].color))
		else
			if base then
				if base.temp then
					c:SetBackdropColor(unpack(base.temp.statisticColor))
				else
					c:SetBackdropColor(unpack(base.settings.statisticColor))
				end
			else
				c:SetBackdropColor(1,1,1,1)
			end
		end

		local cb = _G[self._name.."_StatCb_"..i]

		-- Gray out discarded Stats
		--
		if state[k].keep then
           	getglobal(cb:GetName() .. "Text"):SetTextColor(1,1,1)
		else
           	getglobal(cb:GetName() .. "Text"):SetTextColor(0.5,0.5,0.5)
		end
		cb:SetChecked(state[k].checked)
	end
	-- Pull date checkbox
	local pd = getglobal(self._name.."_PullDateCb")
	if state._pullDate.keep then
       	getglobal(pd:GetName() .. "Text"):SetTextColor(1,1,1)
	else
       	getglobal(pd:GetName() .. "Text"):SetTextColor(0.5,0.5,0.5)
	end
	pd:SetChecked(state._pullDate.checked)

	-- Discard checkbox
	_G[self._name.."_DiscardCb"]:SetChecked(state._discard.checked)

	-- Slider
	local slider = _G[self._name.."_Slider"]
	slider:SetValue(state._tooltip_order)
	--updateSliderText(slider)

	-- List box of checked items
	self:UpdatePreview(state)
end

function lib:ReIndex()

	-- Discard unwanted statistics

	local newi = 0

	local newIndex = {}
	local newiXoldi = {}
	local sv = _G[self._name.."_SV"]

	for i,k in ipairs(self._keys) do
		if sv[k].keep then
			newi = newi + 1
			newIndex[k] = newi
			newiXoldi[newi] = sv._index[k]
		end
	end

	return newi,newiXoldi,newIndex
end

-- m 	-> newSize
-- n 	-> oldSize
-- MxN 	-> mapping from new index array to old index array
-- newIndex 	-> new mapping from keys to array index of a row of data

function lib:ShrinkData(maxNewi,newiXoldi,newIndex)

	local sv = _G[self._name.."_SV"]
	local data = _G[self._name.."_Data"]

	local v_new_str = "{"

	for i=1,maxNewi do
		v_new_str = v_new_str..tostring(i)..","
	end

	if sv._pullDate.keep then
		v_new_str = v_new_str..tostring(maxNewi+1)..","
	end

	v_new_str = v_new_str.."}"

	local new_data_ids = {}

	local empty_count = 0

	for id,v in pairs(data) do

		local f = loadstring("return "..v_new_str)

		local v_new = f()

		local empty = true

		for i=1,maxNewi do
			v_new[i] = v[newiXoldi[i]]
			if v_new[i] then empty = false end
		end

		if not empty then
			new_data_ids[#new_data_ids + 1] = id
		else
			empty_count = empty_count + 1
		end

		-- Discard the pull date if unchecked

		if sv._pullDate.keep then
			v_new[maxNewi+1] = v[#v]
		end

		v = nil
		data[id] = v_new
	end

	if empty_count > 0 then

		local new_data_str = "{"

		for i=1,#new_data_ids do
			new_data_str = new_data_str.."["..tostring(new_data_ids[i]).."] = 1,"
		end

		new_data_ids = nil -- Done with new_data_ids for empty_count > 0 case.
		--collectgarbage("collect")

		new_data_str = new_data_str.."}"

		local g = loadstring("return "..new_data_str)
		local new_data = g()

		new_data_str = nil -- Done with new_data_str
		--collectgarbage("collect")

		for id,_ in pairs(data) do
			if new_data[id] then
				new_data[id] = data[id]
			end
			data[id] = nil
		end

		data = nil -- Done with data
		_G[self._name.."_Data"] = new_data -- re-assign the global
		new_data = nil -- Done with new_data
		--collectgarbage("collect")
	else
		new_data_ids = nil -- Done with new_data_ids for empty_count <= 0 case.
	end

	--collectgarbage("collect")

	sv._index = nil
	collectgarbage("collect")

	sv._index = newIndex
end

local function okay(panel)

	local addon = _G[panel.name]
	local sv = _G[addon._name.."_SV"]

	if not addon._temp then return end

	if sv._tooltip_order ~= addon._temp._tooltip_order then 
		addon:ChangeTooltipOrder(addon._temp._tooltip_order)
	end

	sv = addon:CopyState(addon._temp)
	_G[addon._name.."_SV"] = sv -- re-assign to global

	-- if "discardCheckbox" is checked and there are "non-gray (keep)" checked box that
	-- are unchecked, then shrink the data.

	local discard = _G[addon._name.."_DiscardCb"]
	local pullDate = _G[addon._name.."_PullDateCb"]

	if discard:GetChecked() then

		-- Do the work, but override saved checked state to false for now.
		discard:SetChecked(false)
		sv._discard.checked = false

		-- Check to see if any Stats are to be discarded
		for i,key in ipairs(addon._keys) do
			local cb = getglobal(addon._name.."_StatCb_"..i)
			if not cb:GetChecked() then
				sv[key].keep = false
				sv._reKeep[key] = nil 
				sv._index[key] = nil
           		getglobal(cb:GetName() .. "Text"):SetTextColor(0.5,0.5,0.5)
			end
		end

		-- Check to see if the pull date is to be discarded

		if not pullDate:GetChecked() then
			sv._pullDate.keep = false
			sv._reKeep._pullDate = nil
           	_G[pullDate:GetName()..Text]:SetTextColor(0.5,0.5,0.5)
		end

		local newSize,newToOldMap,newIndex = addon:ReIndex()
		addon:ShrinkData(newSize,newToOldMap,newIndex)
	end

	-- Willy nilly, check to see if stats are to be brought back

	for i,key in ipairs(addon._keys) do
		local cb = getglobal(addon._name.."_StatCb_"..i)
		if cb:GetChecked() then sv._reKeep[key] = true end
	end

	-- Willy nilly, check to see if pull date is to be brought back

	if pullDate:GetChecked() then
		sv._reKeep._pullDate = true
	end

	addon._temp = nil
end

local function tablesAreDifferent(t1,t2,indexArray)
	for _, k in ipairs(indexArray) do
		if (t1[k._name] and not t2[k._name]) 
			or (not t1[k._name] and t2[k._name]) then
			return true
		end
	end

	return false
end

local function baseOkay(panel)
	local base = _G[panel.name]

	local date = time() -- Get the current seconds from epoch of the 'okay'.

	local shouldReloadUI = false

	if base.temp.always_load and base.settings.always_load
		and tablesAreDifferent(base.temp.always_load,base.settings.always_load,
																base.sources) then
		shouldReloadUI = true
	end

	for i,s in ipairs(base.sources) do
		local v = _G[s._name.."_SV"]
		v._base.settings = base:CopyState(base.temp)
		v._base.settings.date = date -- Mark the date.
		base.settings = v._base.settings	-- make base.settings simply reference
											-- one of the sources' settings.
	end

	base.temp = nil

	if shouldReloadUI then
		ReloadUI()
	end
end

local function cancel(panel)
	local addon = _G[panel.name]
	addon._temp = nil

	-- Rollback panel using addon's saved variable.
	addon:LoadPanelUI(_G[addon._name.."_SV"])
end

local function baseCancel(panel)
	local base = _G[panel.name]
	base.temp = nil

	base:LoadPanelUI(base.settings)
end

local function default(panel)

	local addon = _G[panel.name]

	addon._temp = addon:CopyState(addon)

	-- temp won't have 'discard' info so we have to set it here
	--
	local sv = _G[addon._name.."_SV"]

	for i,k in ipairs(addon._keys) do
		addon._temp[k].keep = sv[k].keep
	end

	addon._temp._pullDate.keep = sv._pullDate.keep

	addon._temp._index = {}
	for k,i in pairs(sv._index) do
		addon._temp._index[k] = i
	end

	addon:LoadPanelUI(addon._temp)
end

local function baseDefault(panel)
	local base = _G[panel.name]

	base.temp = base:CopyState(base.defaults) 	-- Make sure base.temp exists for this
												-- change to base.defaults

	base:LoadPanelUI(base.temp)
end

function lib:CreateOrGetTemp()
	-- if this is the first click in a "panel session", then temp is nil.
	if not self._temp then
		self._temp = self:CopyState(_G[self._name.."_SV"])
	end

	return self._temp
end

local function removeLinkedListKey(llist,k)

	local k_prev = llist[k].prev 
	local k_next = llist[k].next 

	if k_prev then
		llist[k_prev].next
			= llist[k].next
	else
		llist._firstKey
			= llist[k].next
	end

	if k_next then
		llist[k_next].prev
			= llist[k].prev
	else
		llist._lastKey
			= llist[k].prev
	end

	llist[k].prev = nil
	llist[k].next = nil
end

local function onColorClick(c)

	local parent = _G[c._parent_name]

	local temp = parent:CreateOrGetTemp()

	if IsShiftKeyDown() then
		if not c._global then
			local dcolor = {}
			if _G[parent._base.name].temp then
				dcolor = _G[parent._base.name].temp.statisticColor
			else
				dcolor = _G[parent._base.name].settings.statisticColor
			end

			parent._temp[c._key].color = nil -- Get rid of statistic's overriding color

			c:SetBackdropColor(unpack(dcolor))

			_G[c._parent_name..
				"_PreviewItem_"..
				parent._index[c._key]..
				"Text"]:SetTextColor(unpack(dcolor))

			return
		end
	end

	local cp = ColorPickerFrame

	cp.func, cp.opacityFunc, cp.cancelFunc = nil, nil, nil 

	cp:SetColorRGB(c:GetBackdropColor())
	if (not c._global) and (not temp[c._key].color) then

		-- Remember whether the stat color was actually set
		-- (overriding the global setting).
		--
		temp[c._key].color_was_nil = true

	end	
	cp.previousValues = { c:GetBackdropColor() }
	cp.hasOpacity = false

	temp._c = c

	cp._neikos_temp = temp

	local function f (restore)
		local cp = ColorPickerFrame
		local temp = cp._neikos_temp
		local c = temp._c
		local s = temp._s

		if not restore then
			c:SetBackdropColor(cp:GetColorRGB())

			if not c._global then
				temp[c._key].color = { cp:GetColorRGB() }
				local preview
					= _G[c._parent_name.."_PreviewItem_"..parent._index[c._key]]
				if temp[c._key].checked then
        			_G[preview:GetName().."Text"]:SetTextColor(cp:GetColorRGB())
				end
			else
				temp[c._key] = { cp:GetColorRGB() }

				if s and c._key == "statisticColor" then 	-- subpanel, s, just became
															-- visible and we're in the
															-- middle of changing the
															-- global statitics color.
					local addon = _G[s.name]
					for i,k in ipairs(addon._keys) do
						if ( addon._temp and (not addon._temp[k].color) )
							or ( (not addon._temp)
									and (not _G[s.name.."_SV"][k].color) ) then
							_G[s.name.."_StatColor_"..i]:SetBackdropColor(
																	cp:GetColorRGB())

							local preview = _G[s.name.."_PreviewItem_"..i]
							local cb = _G[s.name.."_StatCb_"..i]
							if cb:GetChecked() and _G[s.name.."_SV"][k].keep then
								_G[preview:GetName().."Text"]:SetTextColor(
																	cp:GetColorRGB())
							end
						end
					end
				end
			end
		else
			local r, g, b = unpack(restore)

			c:SetBackdropColor(r, g, b)
			cp:SetColorRGB(r, g, b)

			if (not c._global) and temp[c._key].color_was_nil then
				temp[c._key].color = nil
			end
		end
	end

	cp.func, cp.opacityFunc, cp.cancelFunc = f, f, f 

	cp:Hide()
	cp:Show()
end

local function onStatisticClick(cb)

	local addon = _G[cb._addon_name]

	local temp = addon:CreateOrGetTemp()

	local k = cb._key

	local first = temp._firstKey
	local last = temp._lastKey

	if cb:GetChecked() then -- Add to the end of the list

		temp[k].checked = true

		if last then
			temp[last].next = k

			temp[k].prev = last

			temp[k].next = nil
			temp._lastKey = k

		else
			temp._firstKey = k
			temp._lastKey = k
		end

	else -- remove from the list

		temp[k].checked = false

		removeLinkedListKey(temp,k)

	end		

	addon:UpdatePreview(temp)
end

local function onValueChanged(o)
	updateSliderText(o)
	local temp = _G[o._addon_name]:CreateOrGetTemp()
	temp._tooltip_order = o:GetValue()
end

local function onPullDateClick(cb)
	local temp = _G[cb._addon_name]:CreateOrGetTemp()
	temp._pullDate.checked = cb:GetChecked()
end

local function onDiscardClick(cb)
	local temp = _G[cb._addon_name]:CreateOrGetTemp()
	temp._discard.checked = cb:GetChecked()
end

local function doNothing(button)
end

local function verifySV(sv,addon)
	return sv -- Simple check for now.
end

local function getDropDownTooltipText(o,modifier)
	if modifier == 4 then
		return string.format(L["Show %s statistics\non mouseover only."],o._base_name)
	else
		return string.format(
            L["Show %s statistics\non mouseover with |c%s%s|r key\ndown."],
                                o._base_name,lib.nameColor,o._modifiers[modifier][1])
	end
end

local function createAddonPanel(addon)
	-- Now create the addon's sub-panel.
	-- Let it be REFERENCED by a global variable named <addon name>_Panel
	-- BUT we will set its 'name' member to <addon name> in case we need
	-- to get the addon object from the panel object by using _G[panel.name]
	--
	local baseName = addon._base.name
	local addonName = addon._name
	local url = addon._url

	local panel = CreateFrame("Frame",addon._name.."_Panel")
	panel.name = addon._name
	panel.parent = baseName

	local fs_left = panel:CreateFontString()

	fs_left:SetPoint('TOPLEFT', panel, 'TOPLEFT', 20, -20)
	fs_left:SetFontObject(GameFontNormalLarge)
	fs_left:SetText(baseName.." - "..addon._source)

    for i,k in ipairs(addon._keys) do

        local cb = CreateFrame(	"CheckButton",
								addonName.."_StatCb_"..i,
								panel,
								"InterfaceOptionsCheckButtonTemplate")
		cb._addon_name = addonName

        getglobal(cb:GetName() .. "Text"):SetText(L[k])
		cb._key = k
		cb._tooltip_text = L["Check/Uncheck to Show/Hide this statistic"]

        cb:SetPoint("TOPLEFT", panel, "TOPLEFT", 45, -20 - (25 * i))
		cb:SetScript("OnClick",onStatisticClick)
		cb:SetScript("OnEnter",onEnter)
		cb:SetScript("OnLeave",onLeave)

		local c = CreateFrame( "Button",
								addonName.."_StatColor_"..i,
								panel)
								--"UIPanelButtonTemplate")
		c._parent_name = addonName

		c._key = k
		c._tooltip_text
            = string.format(
                L["|c%sClick:|r Override the default color for this statistic.\n|c%sShift-Click:|r Return to default color."],
                lib.nameColor,lib.nameColor)

		c:SetPoint("RIGHT", cb , "LEFT", -10, 0) 
		c:SetWidth(16) 
		c:SetHeight(16) 

		c:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
						edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                      	tile = false, tileSize = 0, edgeSize = 10, 
                        insets = { left = 2, right = 2, top = 2, bottom = 2 }});

		c:SetBackdropColor(0,0,0,0)

		c:SetScript("OnClick",onColorClick)
		c:SetScript("OnEnter",onEnter)
		c:SetScript("OnLeave",onLeave)

		c:SetScript("OnShow",
			function (self)
				if _G[self._parent_name]._temp then
					if _G[self._parent_name]._temp[self._key].color then
						self:SetBackdropColor(
							unpack(_G[self._parent_name]._temp[self._key].color) )
					else
						if _G[baseName] then
							if _G[baseName].temp then
								self:SetBackdropColor(
									unpack(_G[baseName].temp.statisticColor) )
							else
								self:SetBackdropColor(
									unpack(_G[baseName].settings.statisticColor) )
							end
						else
							self:SetBackdropColor(1,1,1,1)
						end
					end
				else
		    		if _G[self._parent_name.."_SV"][self._key].color then
						self:SetBackdropColor(
							unpack(_G[self._parent_name.."_SV"][self._key].color) )
					else
						if _G[baseName] then
							if _G[baseName].temp then
								self:SetBackdropColor(
									unpack(_G[baseName].temp.statisticColor) )
							else
								self:SetBackdropColor(
									unpack(_G[baseName].settings.statisticColor) )
							end
						else
							self:SetBackdropColor(1,1,1,1)
						end
					end
				end
			end)

		-- Create (button) frames stats
		--
		local button = CreateFrame("Button",
					addonName.."_PreviewItem_"..i,
					panel,
					"OptionsListButtonTemplate") 
					--"UIPanelButtonTemplate") 

		button._addon_name = addonName

		-- We will call SetPoint in the update function.

        button._tooltip_text = "Preview of statistics\nand the order in which\nthey will appear."

		button:SetScript("OnClick",doNothing)
		button:SetScript("OnEnter",onEnter)
		button:SetScript("OnLeave",onLeave)

		button:SetScript("OnShow",
						function (self)
							if _G[addonName.."_SV"][k].keep then
								_G[self:GetName().."Text"]:SetTextColor(
									c:GetBackdropColor())
							else
								_G[self:GetName().."Text"]:SetTextColor(
									0.5,0.5,0.5,0.5)
							end
						end)

		--button:SetNormalTexture([[Interface\BUTTONS\UI-Listbox-Highlight2]])
		--button:SetNormalFontObject("GameFontHighlight")
        button:SetText(L[k])
		button:SetWidth(150)
		button:SetHeight(16)
    end

	local slider = CreateFrame(	"Slider",
								addonName.."_Slider",
								panel,
								"OptionsSliderTemplate")
	slider._addon_name = addonName

	slider:SetMinMaxValues(0,1000)
	slider:SetValueStep(10)
	slider._basetext = "|cffffd100"..L["Placement"].." " 
	_G[slider:GetName().."Text"]:SetText(slider._basetext)
	_G[slider:GetName().."Low"]:SetText(L["Higher"])
	_G[slider:GetName().."High"]:SetText(L["Lower"])

	slider:SetPoint("BOTTOM", panel,"BOTTOM",0,50)

	slider._tooltip_text = string.format(L["Move |cffff0000%s|r statistics Higher/Lower\nin the tooltip window."],addon._source)

	slider:SetScript("OnEnter",onEnter)
	slider:SetScript("OnLeave",onLeave)
	slider:SetScript("OnValueChanged",onValueChanged)

	slider:Show()

	local pullDate = CreateFrame(	"CheckButton",
									addonName.."_PullDateCb",
									panel,
									"InterfaceOptionsCheckButtonTemplate")
	pullDate._addon_name = addonName

	getglobal(pullDate:GetName() .. "Text"):SetText(L["Show Pull Date"])
    pullDate:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 25, 5)

	pullDate._tooltip_text = string.format(L["Show the date that the above\nstatistics were mined from\n|cffff0000 %s|r"],url)

	pullDate:SetScript("OnClick",onPullDateClick)
	pullDate:SetScript("OnEnter",onEnter)
	pullDate:SetScript("OnLeave",onLeave)

	pullDate:Show()

	local discard = CreateFrame(	"CheckButton",
									addonName.."_DiscardCb",
									panel,
									"InterfaceOptionsCheckButtonTemplate")
	discard._addon_name = addonName

	getglobal(discard:GetName() .. "Text"):SetText(L["Discard Unchecked"])
    discard:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -125, 5)

	discard._tooltip_text = string.format(L["Check here to clear unchecked statistics from addon memory.\n\n|c%sNote:|r Discarding data might take a few seconds. |c%s\n\nBut:|r It will also shrink %s's memory usage.\n\nRe-check them and type |c%s\"/console reloadui\"|r to get them back."],lib.nameColor,lib.saintColor,addon._name,lib.nameColor)

	discard:SetScript("OnClick",onDiscardClick)
	discard:SetScript("OnEnter",onEnter)
	discard:SetScript("OnLeave",onLeave)

	discard:Show()

	panel.okay = okay
	panel.cancel = cancel
	panel.default = default

	panel:SetScript("OnShow",function(self)
								local base = _G[baseName]
								if base and base.temp then
									base.temp._s = self -- Helps when updating all stat
														-- colors.
								end
							end)

	panel:SetScript("OnHide",function(self)
								local base = _G[baseName]
								if base and base.temp then
									base.temp._s = nil	-- Helps when updating all stat
														-- colors.
								end
							end)

    InterfaceOptions_AddCategory(panel)
end

local function onEvent(self,event,arg)
	if (event == "ADDON_LOADED") then
		local lc_name = string.lower(arg)
		if ( lc_name == string.lower(self._addon_name) ) then
			self:UnregisterEvent("ADDON_LOADED")
			if IsAddOnLoaded("EnhTooltip") then
				DEFAULT_CHAT_FRAME:AddMessage(string.format(
						L["|c%s%s: |rDetected the deprecated |c%sEnhTooltip|r AddOn. |c%sGoingPrice|r now uses |c%sLibExtraTip|r. Please disable |c%sEnhTooltip|r or use an earlier version of the |c%sGoingPrice|r base AddOn."],lib.nameColor,self._addon_name,lib.evilColor,lib.saintColor,lib.saintColor,lib.evilColor,lib.saintColor))
			end

			local addon = _G[self._addon_name]

			local sv = nil

			-- Verify the integrity of SV.
			-- If it fails verification then reset it to default values.
			--
			sv = _G[self._addon_name.."_SV"]

			if not verifySV(sv,addon) then
				_G[self._addon_name.."_SV"] = addon:CopyState(addon)
				sv = _G[self._addon_name.."_SV"]
			else	
				-- Make sure existing saved variable (SV) is up-to-date

				-- Look for any new stats
				--
				for _,k in ipairs(addon._keys) do
					if not string.match(k, "^_.*") and not sv[k] then
						sv[k] = {}
						sv[k].checked = false
						sv[k].keep = false
					end
				end

				-- Now remove any deprecated SV stats
				--
				for k,_ in pairs(sv) do
					if not string.match(k, "^_.*") and not addon[k] then
						removeLinkedListKey(sv,k)
						sv[k] = nil
					end
				end
				-- Now update SV's reverse map.
				--
				sv._index = nil
				sv._index = {}

				for k,i in pairs(addon._index) do
					sv._index[k] = i
				end

				if not sv._tooltip_order then
					sv._tooltip_order = addon._tooltip_order
				end

				for k,v in pairs(sv._reKeep) do
					if k == "_pullDate" then
						sv._pullDate.keep = true
					else
						sv[k].keep = true
					end
				end
		
				sv._reKeep = {}

				-- At this point SV is up to date. Now see if we have discarded
				-- statistics. If so, re-index and shrink.
				--
				for k,_ in pairs(sv._index) do
					if not sv[k].keep then
						local newSize,newToOldMap,newIndex
							= addon:ReIndex()
						addon:ShrinkData(newSize,newToOldMap,newIndex)
						break
					end
				end
			end

			-- Finally mark the SV with the library version
			--
			sv._lib_major_version = major
			sv._lib_minor_version = minor

			-- Introduce some current library members into SV
			--
			if not sv._base then
				sv._base = {}
				sv._base.name = addon._base.name -- addon._base was initialized before
												 -- this event handler was ever defined.
			end

			-- If the "base addon" object does not exist, create it.
			--
			local base = _G[addon._base.name]
			local base_panel = _G[addon._base.name.."_Panel"]

			if not base then
				base = {}
				_G[addon._base.name] = base
				base.name = addon._base.name
				base.modifiers = base_panel._modifiers

				base.defaults = {}

				local d = base.defaults
				d.date = 0 -- Zero date (seconds from epoch) means default.

				d.modifier = 4

				d.sourceTitleColor = {1,8,0}
				d.statisticColor = {1,1,1}
				d.pullDateColor = {1,8,0}

				d.always_load = {}

				function base:LoadPanelUI(state)
					local temp = self:CreateOrGetTemp()

					local m = _G[self.name.."_ModifierMenu"]
					local i = state.modifier
					UIDropDownMenu_SetSelectedID(m,i)
					m._tooltip_text = getDropDownTooltipText(m,state.modifier)

					-- Quirky menu behaviour forces me to trigger the "OnShow"
					-- script in order to explicitly set the menu's text which
					-- quirkingly gets contaminated by other menus' text.
					m:Hide()
					m:Show()

					for _,gcolor in ipairs({"sourceTitleColor",
											"statisticColor",
											"pullDateColor"} ) do
						local c = _G[self.name.."_Global_"..gcolor]
						c:SetBackdropColor(unpack(state[gcolor]))
					end

					if state.always_load then
						for _, k in ipairs(self.sources) do
							temp.always_load[k._name] = state.always_load[k._name]
						end
					end

					_G[self.name.."_OthersFrame"]:Update()
				end

				function base:CopyState(s)
					local d = {}
				
					local defaults = self.defaults
				
					d.date = s.date
				
					d.modifier = s.modifier or defaults.modifier
				
					for _,c in ipairs({	"sourceTitleColor",
										"statisticColor",
										"pullDateColor" }) do
						d[c] = { unpack(s[c]) }
					end

					d.always_load = {}

					if s.always_load then
						for k, _ in pairs(s.always_load) do
							d.always_load[k] = true	
						end
					end

					return d
				end

				function base:CreateOrGetTemp()
					if not self.temp then
						self.temp = self:CopyState(self.settings)
					end

					return self.temp
				end
			end

			-- Register data source addon to the "base addon"
			--
			base.sources = base.sources or {}

			if not sv._base.settings then
				if base.settings then
					sv._base.settings = base:CopyState(base.settings)
				else
					sv._base.settings = base:CopyState(base.defaults)
					base.settings = sv._base.settings
				end
			else
				sv._base.settings = base:CopyState(sv._base.settings) -- Make it good

				if base.settings then
					if sv._base.settings.date > base.settings.date then
						for i,s in ipairs(base.sources) do
							local v = _G[s._name.."_SV"]
							v._base.settings = base:CopyState(sv._base.settings)
						end
						base.settings = sv._base.settings
					end
				else
					base.settings = sv._base.settings
				end
			end

			base.sources[#base.sources+1] = addon

			base:LoadPanelUI(base.settings)

            -- Let's not load realm specific addons that don't pertain the the current
            -- player's realm.
            -- Later, maybe leave this up to a global option checkbox for the user.
            --

            if addonShouldLoadOnThisRealm(addon) or
				( base.settings.always_load
							  and base.settings.always_load[addon._name] ) then

				createAddonPanel(addon)

				addon:LoadPanelUI(sv)
				addon._temp = nil 	-- lib:LoadPanelUI() triggers the tooltip slider's
									-- OnValueChanged event when it's being set for the
									-- first time (and not user manipulated). This mistake
									-- will incorrectly initialize the _temp variable and
									-- cause subpanel okay's -- which, unfortunately, are
									-- triggered by parent panel okay's -- to replace
									-- the global SV file.
								
				lib_tt:AddCallback(addon:GetCallback(),sv._tooltip_order)
				DEFAULT_CHAT_FRAME:AddMessage("|c"..lib.nameColor ..
							self._addon_name.." "..L["loaded"])
			else
        		_G[addon._name.."_Data"] = nil
	    		collectgarbage("collect")
            end
		end
	end
end

function lib:ChangeTooltipOrder(order)
    --DEFAULT_CHAT_FRAME:AddMessage("|c"..lib.nameColor.."About to change order to "..order)

	local callback = self:GetCallback()

    -- Take a peek at the first element of sortedCallback to check its type
    if type(lib_tt.sortedCallbacks[1]) == "function" then
        -- Do it the easy way
        lib_tt:RemoveCallback(callback)
        lib_tt:AddCallback(callback,order)
        --DEFAULT_CHAT_FRAME:AddMessage("|c"..lib.nameColor.."Done the EASY way!")
        return true
    elseif type(lib_tt.sortedCallbacks[1]) == "table" then
        -- Do it the hard way
        -- Linearly search for my callback's table-counter-part key
        for i,c in ipairs(lib_tt.sortedCallbacks) do
            if c.callback == callback then
                lib_tt.callbacks[c] = order
                local callbacks = lib_tt.callbacks
                sortFunc = function(a,b)
                    return callbacks[a] < callbacks[b]
                end
                table.sort(lib_tt.sortedCallbacks,sortFunc)
                --DEFAULT_CHAT_FRAME:AddMessage("|c"..lib.nameColor.."Done the HARD way!")
                return true
            end
        end
    else
        return nil
    end
end

local function onMenuItemClick(self,menu, modifier)
	UIDropDownMenu_SetSelectedID(menu, self:GetID())
	local base = _G[menu._base_name]
	local temp = base:CreateOrGetTemp()
	temp.modifier = modifier
	menu._tooltip_text = getDropDownTooltipText(menu,modifier)
end

local function initialize(m,level)
	local info = UIDropDownMenu_CreateInfo()
	for i,k in ipairs(m._modifiers) do
		info = UIDropDownMenu_CreateInfo()
		info.text = L[k[1]]
		info.value = k[2]
		info.func = onMenuItemClick
		info.arg1 = m
		info.arg2 = i

		info.tooltipTitle = L[k[1]]

		info.tooltipText = getDropDownTooltipText(m,i)

		UIDropDownMenu_AddButton(info,level)
	end
end

local function createBasePanel(name, toc_keys, toc_vals, notes)
	local panel = CreateFrame("Frame",name.."_Panel")
	
	panel.parent = nil
	panel.name = name

	local ft = panel:CreateFontString()
	
	ft:SetPoint('TOPLEFT', panel, 'TOPLEFT', 20, -20)
	ft:SetFontObject(GameFontNormalLarge)
	ft:SetText(panel.name)
	
	local fn = panel:CreateFontString()
	
	fn:SetPoint('TOPLEFT', panel, 'TOPLEFT', 20, -50)
	fn:SetWidth(350)
	fn:SetFontObject(GameFontNormalSmall)
	fn:SetJustifyH("LEFT")
	fn:SetText("|cffffffff"..notes.." "..L["Expand to configure data source(s)."])
	
	for i,k in ipairs(toc_keys) do
	
	    --local v = GetAddOnMetadata(arg,k)
	    --toc_vals[k] = v
	
	    local l = panel:CreateFontString()
	    local r = panel:CreateFontString()
	
	    l:SetPoint('TOPRIGHT', panel, 'TOPLEFT', 100, -90-20*(i-1))
	    r:SetPoint('TOPLEFT', l, 'TOPRIGHT', 10, 0)
	
	    l:SetFontObject(GameFontNormalSmall)
	    r:SetFontObject(GameFontNormalSmall)
	
	    --k_deXed = string.gsub(k,"^X.","")
	
	    --l:SetText(k_deXed)
	    l:SetText(L[k])
	    --r:SetText("|cff7777ff"..v)
	    r:SetText("|cff7777ff"..toc_vals[k])
	end

	local got = panel:CreateFontString()
	got:SetPoint('CENTER', panel, 'BOTTOM', 0, 280)
	got:SetFontObject(GameFontNormalLarge)
	got:SetText(L["Global Options"])

	local mt = panel:CreateFontString()
	mt:SetPoint('TOPLEFT', panel, 'BOTTOM', -250, 240)
	mt:SetFontObject(GameFontNormal)
	mt:SetText(L["Tooltip Key"])

	panel._modifiers =	{	
							{"ALT",IsAltKeyDown},
							{"CRTL",IsControlKeyDown},
							{"SHIFT",IsShiftKeyDown},
							{"None",nil},
						}

	local menu = CreateFrame( "Frame", panel.name.."_ModifierMenu",
									panel,"UIDropDownMenuTemplate" )

	menu:EnableMouse(true)
	menu._modifiers = panel._modifiers
	menu._base_name = panel.name

   	menu:SetPoint("TOPLEFT", panel, "BOTTOM", -265, 225)

	menu:SetScript("OnEnter",onEnter)
	menu:SetScript("OnLeave",onLeave)

	menu:SetScript("OnShow",function(self)
								local i = UIDropDownMenu_GetSelectedID(self)
								local text = L[self._modifiers[i][1]]
								_G[self:GetName().."Text"]:SetText(text)
							end)

	UIDropDownMenu_Initialize(menu, initialize)
	UIDropDownMenu_SetWidth(menu, 90);
	UIDropDownMenu_SetButtonWidth(menu, 90)
	UIDropDownMenu_SetSelectedID(menu, 4)
	UIDropDownMenu_JustifyText(menu, "RIGHT")

	local ort = panel:CreateFontString()

	ort:SetPoint('TOPLEFT', panel, 'BOTTOM', 85, 240)
	ort:SetFontObject(GameFontNormal)
	ort:SetText(L["Also Load:"])

	local ROW_HEIGHT = 20
	local MAX_ROWS = 8

	local othersFrame = CreateFrame("Frame", panel.name.."_OthersFrame", panel)

	othersFrame:SetPoint('TOPLEFT', panel, 'BOTTOM', 75, 220)
	othersFrame:EnableMouse(true)
	othersFrame:SetSize(196, ROW_HEIGHT * MAX_ROWS + 16)

	othersFrame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		tile = true,
		tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})

	function othersFrame:Update()
		local base = _G[panel.name]
		local temp = base:CreateOrGetTemp()

		local installed = base.sources
		local maxValue = #installed
	
		-- Call the FauxScrollFrame template's Update function, with
		-- the relevant parameters:
		FauxScrollFrame_Update(self.scrollBar, maxValue, MAX_ROWS, ROW_HEIGHT)
			-- #1 is a reference to the scroll bar frame.
			-- #2 is the total number of data available to be shown.
			-- #3 is how many rows of data can be displayed at once.
			-- #4 is the height of each row.
	
		-- Now figure out which datum to show in each row,
		-- and show it:
		local offset = FauxScrollFrame_GetOffset(self.scrollBar)
		for i = 1, MAX_ROWS do
			local value = i + offset
			if value <= maxValue then
				-- There is a datum available to show.
	
				-- Get a local reference to the row to save
				-- two table lookups:
				local row = self.rows[i]
				-- Fill in the row with the datum:
	        	getglobal(row:GetName() .. "Text"):SetText(installed[value]._name)
				row:SetChecked(temp.always_load[installed[value]._name])
				-- Show the row:
				row:Show()
			else
				-- We've reached the end of the data.
				-- Hide the row:
				self.rows[i]:Hide()
			end
		end
	end

	local othersScrollBar = CreateFrame("ScrollFrame", "$parent_OthersScrollBar",
							othersFrame, "FauxScrollFrameTemplate")

	othersScrollBar:SetPoint("TOPLEFT", 0, -8)
	othersScrollBar:SetPoint("BOTTOMRIGHT", -30, 8)

	othersScrollBar:SetScript("OnVerticalScroll",function(self,offset) 
			-- These first two lines replace a call to the global 
			-- FauxScrollFrame_OnVerticalScroll function, saving a
			-- global lookup and a function call.
			self.offset = math.floor(offset / ROW_HEIGHT + 0.5)
		
			-- FauxScrollFrame_OnVerticalScroll can also call an update
			-- function if we pass it one, but since we aren't using it,
			-- we should just call the function ourselves:
			othersFrame:Update()
		end)

	othersScrollBar:SetScript("OnShow", function()
		othersFrame:Update()
	end)

	othersFrame.scrollBar = othersScrollBar

	local rows = setmetatable({}, { __index = function(t, i)
		local base = _G[panel.name]
	
		local row = CreateFrame("CheckButton", "$parentRow"..i, othersFrame,
								"InterfaceOptionsCheckButtonTemplate")
		row:SetSize(ROW_HEIGHT, ROW_HEIGHT)
		getglobal(row:GetName().."Text"):SetSize(150, ROW_HEIGHT)
		row:SetNormalFontObject(GameFontHighlightLeft)
		row._tooltip_text = L["If checked, this addon will load\neven if it's data pertains to\na different realm/region."]
		row:SetScript("OnEnter",onEnter)
		row:SetScript("OnLeave",onLeave)

		row:SetScript("OnClick", function(self)
			local temp = base:CreateOrGetTemp();
			temp.always_load[_G[self:GetName().."Text"]:GetText()] = self:GetChecked()
		end)
		
		if i == 1 then
			row:SetPoint("TOPLEFT", othersFrame, 8, -8)
		else
			row:SetPoint("TOPLEFT", othersFrame.rows[i-1], "BOTTOMLEFT")
		end
		
		rawset(t, i, row)
		return row
	end })

	othersFrame.rows = rows

	local ct = panel:CreateFontString()
	ct:SetPoint('TOPLEFT', panel, 'BOTTOM', -50, 240)
	ct:SetFontObject(GameFontNormal)
	ct:SetText(L["Default Colors"])

	for i,gcolor in ipairs( {
				{ 	key = "sourceTitleColor",
					name = L["Source Title"],
					tooltip = L["Data source title's color."] },
				{	key = "statisticColor",
					name = L["Statistic"],
					tooltip = L["Default statistic color."] } ,
				{ 	key = "pullDateColor",
					name = L["Pull Date"],
					tooltip = L["Pull date color."]}, } ) do



		local c = CreateFrame( "Button",
								panel.name.."_Global_"..gcolor.key,
								panel)

		c._global = true
		c._parent_name = panel.name
		
		c._key = gcolor.key

		c._tooltip_text = gcolor.tooltip

		c:SetPoint("LEFT", ct , "LEFT", -10, -25*i) 
		c:SetWidth(16) 
		c:SetHeight(16) 

		c:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
						edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                      	tile = false, tileSize = 0, edgeSize = 10, 
                        insets = { left = 2, right = 2, top = 2, bottom = 2 }});

		c:SetBackdropColor(0,0,0,0);

		c:SetScript("OnClick",onColorClick)
		c:SetScript("OnEnter",onEnter)
		c:SetScript("OnLeave",onLeave)

		local cl = CreateFrame( "Button",
								panel.name.."_Gobal_"..gcolor.key.."_Label",
								panel)

		cl._parent_name = panel.name
		cl._key = gcolor.key

		cl._tooltip_text = gcolor.tooltip

		cl:SetPoint("LEFT", c, "RIGHT")
		local clf = cl:CreateFontString()
		clf:SetPoint("LEFT", cl, "LEFT")
		clf:SetFontObject(GameFontNormal)
		clf:SetTextColor(1,1,1)
		clf:SetText("   "..gcolor.name)
		cl:SetWidth(clf:GetWidth())
		cl:SetHeight(clf:GetHeight())

		cl:SetScript("OnEnter",onEnter)
		cl:SetScript("OnLeave",onLeave)

	end

	panel.okay = baseOkay
	panel.cancel = baseCancel
	panel.default = baseDefault

	InterfaceOptions_AddCategory(panel)
	
	DEFAULT_CHAT_FRAME:AddMessage(string.format(
                        L["|cffff5400GoingPrice Library version %s Loaded."],
                                    toc_vals.Version))
end

function lib:CreateDataSource(source,url)

	local baseName = "GoingPrice"
	local addonName = baseName.."_"..source
	local addon = _G[addonName] -- addon's table object should have been already defined.

	addon._name = addonName
	addon._source = source
	addon._url = url

    local currentLoaderAddOnVersion = tonumber(gsub(
            GetAddOnMetadata(addonName,"Version"),"[%d]+\.[%d]+\.([%d]+)","%1"),10)

    if addon._texts then -- check whether we're doing localizations
        for k,v in pairs(addon._texts) do
            if not L[k] or ( self._loaderAddOnVersion < currentLoaderAddOnVersion ) then
                L[k] = v
            end
        end

        self._loaderAddOnVersion = self._loaderAddOnVersion < currentLoaderAddOnVersion
                                    and currentLoaderAddOnVersion
                                        or self._loaderAddOnVersion
    end

    setmetatable(L,{__index=function(t,key) return key end}) -- setmetable regardless
                                                             -- of whether we're
                                                             -- localizing

	if ( IsAddOnLoaded(baseName) ) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(L["|c%sNote:|r |c%s%s|r base addon is no longer required. All base functionality has been factored into the |c%sLibGoingPrice|r library. Please disable/remove the |c%s%s|r base addon and from now on load only the |c%s%s_<source>|r data source addons."],lib.evilColor,lib.nameColor,baseName,lib.saintColor,lib.nameColor,baseName,lib.nameColor,baseName))
	else
		addon._base = {
			name = baseName,
			keys = {"Version", "Author", "Category", "Email", "Website"},
			values =	{
							["Version"] = string.format("%2.1f",major),
							["Author"] = "|cffffffffNeikos",
							["Category"] = "|cffffffff"..L["Auction, Economy, Tooltip"],
							["Email"] = "neikos@goingpriceaddon.com",
							["Website"] = "http://goingpriceaddon.com",
						},
			notes =	L["Get a good idea of the auction house value of any item you mouseover."], 
		}

		if not _G[baseName.."_Panel"] then
			createBasePanel(addon._base.name,
							addon._base.keys,
							addon._base.values,
							addon._base.notes)
		end
	end

	setmetatable(addon, self)
	self.__index = self

	-- Create the addon's frame
	local frame = CreateFrame("Frame",addonName.."_Frame")
	addon._frame = frame -- We should keep this around.
	frame._addon_name = addonName -- We'll need the addon's name for 'onEvent'.

	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", onEvent)
end
