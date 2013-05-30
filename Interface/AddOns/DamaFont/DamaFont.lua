--[[

    DamaFont by Stormcast @ Lightbringer EU


	You can add more fonts, by copying the file to the Fonts folder found
	inside this files folder. Then just add a row to the table below.
	The first text is the fonts name and the second is its filename.

]]

-- [[[[[[[ ADD[''] = '',  FONTS HERE ! ]]]]]]]] --
local fonts = {
    ['Yikes!'] = 'yikes.ttf',
    ['Sound System'] = 'sound_system.ttf',
    ['Unsteady Oversteer'] = 'unsteady_oversteer.ttf',
    ['OpTic'] = 'OpTic.ttf',
    ['Foo'] = 'foo.ttf',
    ['akaDylan'] = 'akaDylan.ttf',
    ['Lambada Dexter'] = 'LambadaDexter.ttf',
    ['Wayoshi'] = 'wayoshi.ttf',
    ['Yard Sale'] = 'YARDSALE.TTF',
    ['Nightmare AOE'] = 'NightAOE.ttf',

    ['Vinque'] = 'vinque.ttf',
    ['Tiza'] = 'tiza.ttf',
    ['Technoid'] = 'TECHNOID.TTF',
    ['Tannenberg Fett'] = 'TannenbergFett.ttf',
    ['Squared Display'] = 'Squared Display.ttf',
    ['Ruptured Sans'] = 'RupturedSans.ttf',
    ['Rapscallion'] = 'RAPSCALL.TTF',
    ['Old London'] = 'OldLondon.ttf',
    ['Mirage Gothic'] = 'Mirage final.ttf',
    ['MB Think Twice'] = 'MB-ThinkTwice_Regular.ttf',
    ['Manuskript Gothisch'] = 'Manuskript Gothisch UNZ1A.ttf',
    ['Komika Parch'] = 'KOMIKAP_.ttf',
    ['I Fink U Freeky'] = 'i_fink_u_freeky.ttf',
    ['Grusskarten Gotisch'] = 'GrusskartenGotisch.ttf',
    ['Destroyed Aero'] = 'Destroyed Aero.ttf',
    ['AmazDooM'] = 'AmazDooMLeft.ttf'

};
-- [[[[[[[[[[[[[[---]]]]]]]]]]]]]]]] --


-- DON'T CHANGE ANYTHING BELOW THIS POINT --
-- initialize the variables (make them globals)
local DamaFont = LibStub( "AceAddon-3.0" ):NewAddon( "DamaFont", "AceConsole-3.0", "AceEvent-3.0" );
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0");
--local AceGUI = libStub("AceGUI-3.0");

-- configs (default values)
local defaults = {
    profile = {
        font = 'Yikes!',
        fontpath = 'Interface\\AddOns\\DamaFont\\Fonts\\yikes.ttf'
    }
};
local lfp = 'Interface\\AddOns\\DamaFont\\Fonts\\';

function DamaFont:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("DamaFontDB", defaults);
	DAMAGE_TEXT_FONT = self.db.profile.fontpath;

    --local AceConfigReg = LibStub("AceConfigRegistry-3.0")
    local AceConfigDialog = LibStub("AceConfigDialog-3.0")

    -- register other stuff
    LibStub("AceConfig-3.0"):RegisterOptionsTable("DamaFont", self:GetOptions());
    self.optionsFrame = AceConfigDialog:AddToBlizOptions("DamaFont","DamaFont");

	-- let's register the fonts to sharedmedia
	for i, n in pairs(fonts) do
    	LSM:Register('font', i, lfp..n);
	end


	-- the preview frame
	f = CreateFrame("Frame","DamaFontPreviewFrame",UIParent);
	f:SetFrameStrata("DIALOG");
	f:SetPoint("CENTER");
	f:SetWidth(500);
	f:SetHeight(150);
	f:SetClampedToScreen(true);
	f:SetMovable(true);
	f:EnableMouse(true);
	f:RegisterForDrag("LeftButton");
	f:SetScript("OnDragStart", f.StartMoving);
	f:SetScript("OnDragStop", f.StopMovingOrSizing);
	f:Hide();

	f.texture = f:CreateTexture();
	f.texture:SetAllPoints(f);
	f.texture:SetTexture(0, 0, 0, 0.3);

	f.text = f:CreateFontString(nil, "OVERLAY");
	f.text:SetFont(self.db.profile.fontpath, 32);
	f.text:SetTextHeight(64);
	f.text:SetAllPoints(f);
	f.text:SetTextColor(1, 0.9, 0);
	f.text:SetShadowColor(0, 0, 0);
	f.text:SetShadowOffset(5, 3);
	f.text:SetText('1234567890');

end

function DamaFont:OnEnable()
    self:PrintText('loaded');
    self:RegisterChatCommand("damafont", function() self:OpenOptions() end);
end

function DamaFont:PrintText(s)
    DEFAULT_CHAT_FRAME:AddMessage("DamaFont: ".. tostring(s));
end

-- :OpenOptions(): Opens the options window.
function DamaFont:OpenOptions()
    InterfaceOptionsFrame_OpenToCategory(self.optionsFrame);
end

function DamaFont:GetOptions()
    local options = {
        name = "DamaFont",
        handler = DamaFont,
        type = 'group',
        childGroups ='tree',
        args = {
            font = {
                order = 0,
                type = 'select',
                dialogControl = 'LSM30_Font', --Select your widget here
                name = 'Damage Font',
                desc = 'The font you would like to see as your damage font.',
                values = LSM:HashTable("font"), -- pull in your font list from LSM
                width = 'double',
                get = function()
                    return self.db.profile.font -- get the value from the db
                end,
                set = function(smth, key)
                    self.db.profile.font = key; -- set the new value to the db
                    self.db.profile.fontpath = LSM:Fetch('font', key, true);
                    f.text:SetFont(self.db.profile.fontpath, 32);
					f.text:SetTextHeight(64);
                end,
            },
            button = {
            	order = 0,
            	type = 'execute',
            	name = 'Show/hide preview',
            	desc = 'Click here to show or hide the preview frame for the font.',
            	func = function ()
            		if f:IsVisible() then
            			f:Hide();
            		else
            			f:Show();
            		end
            	end

            },
            textbox = {
                order = 1,
                type = 'group',
                inline = true,
                name = ' ',
                args = {
		            text = {
						type = 'description',
						name = 'Remember that you need to log out and back in again for the font to change!',
						fontSize = 'medium'
					}
				}
			}
        }
    }
    return options
end
