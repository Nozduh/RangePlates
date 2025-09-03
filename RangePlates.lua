-- Store common reference spells by class
local CLASS_REFERENCE_SPELL = {
    ["MAGE"] = "Fireball",
    ["SHAMAN"] = "Lightning Bolt",
    ["PRIEST"] = "Smite",
    ["WARLOCK"] = "Shadow Bolt",
    ["PALADIN"] = "Judgement",
    ["DRUID"] = "Wrath",
    ["HUNTER"] = "Arcane Shot",
    ["ROGUE"] = "Throw",
    ["WARRIOR"] = "Charge",
}
-- Default colors
local defaultColors = { inRange = {0, 1, 0}, outRange = {1, 0, 0}, unknown = {1, 1, 1} }
local function getSavedSetting(key, fallback)
    if RP_Settings and RP_Settings[key] then
        return RP_Settings[key]
    end
    return fallback
end

local function enumerate_nameplates()
    local plates = {}
    local base = WorldFrame
    for i = 1, base:GetNumChildren() do
        local child = select(i, base:GetChildren())
        if child and child:IsShown() and child:GetName() == nil then
            local overlay, name = child:GetRegions()
            if name and name.GetText and name:GetText() then
                table.insert(plates, {frame = child, nameRegion = name, mobname = name:GetText()})
            end
        end
    end
    return plates
end

local function UpdateTargetNameplateColor()
    local plates = enumerate_nameplates()
    local refSpell = getSavedSetting("refSpell", "Attack")
    local colors = getSavedSetting("colors", defaultColors)
    for _, info in ipairs(plates) do
        if info.mobname and UnitExists("target") and UnitName("target") == info.mobname then
            if IsSpellInRange(refSpell, "target") == 1 then
                info.nameRegion:SetTextColor(unpack(colors.inRange))
            else
                info.nameRegion:SetTextColor(unpack(colors.outRange))
            end
        else
            info.nameRegion:SetTextColor(unpack(colors.unknown))
        end
    end
end

local UPDATE_INTERVAL = 0.25
local elapsedSinceUpdate = 0

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
    if not RP_Settings then RP_Settings = {} end
    if not RP_Settings.refSpell then
        local _, class = UnitClass("player")
        RP_Settings.refSpell = CLASS_REFERENCE_SPELL[class] or "Attack"
    end
    if not RP_Settings.colors then
        RP_Settings.colors = defaultColors
    end
    self:SetScript("OnUpdate", function(self, elapsed)
        elapsedSinceUpdate = elapsedSinceUpdate + elapsed
        if elapsedSinceUpdate > UPDATE_INTERVAL then
            UpdateTargetNameplateColor()
            elapsedSinceUpdate = 0
        end
    end)
end)

-- SLASH COMMANDS

SLASH_RPREFSPELL1 = "/rpspell"
SlashCmdList["RPREFSPELL"] = function(msg)
    if msg and msg ~= "" then
        RP_Settings.refSpell = msg
        print("Reference spell set to:", msg)
    else
        print("Usage: /rpspell <spell name>")
    end
end

-- Natural language color table (add any more you wish!)
local NAMED_COLORS = {
    ["red"]        = {1,0,0},
    ["green"]      = {0,1,0},
    ["blue"]       = {0,0,1},
    ["yellow"]     = {1,1,0},
    ["orange"]     = {1,0.5,0},
    ["purple"]     = {0.6,0,0.7},
    ["magenta"]    = {1,0,1},
    ["pink"]       = {1,0.4,0.7},
    ["white"]      = {1,1,1},
    ["black"]      = {0,0,0},
    ["gray"]       = {0.5,0.5,0.5},
    ["grey"]       = {0.5,0.5,0.5},
    ["cyan"]       = {0,1,1},
    ["teal"]       = {0,0.8,0.8},

    ["light blue"] = {0.4,0.8,1},
    ["light green"] = {0.6,1,0.6},
    ["light red"]   = {1,0.6,0.6},
    ["light yellow"] = {1,1,0.7},
    ["light purple"] = {0.8,0.7,1},
    ["light pink"]   = {1,0.7,0.9},
    ["light gray"]   = {0.8,0.8,0.8},
    ["light grey"]   = {0.8,0.8,0.8},

    ["dark blue"] = {0,0,0.5},
    ["dark green"] = {0,0.5,0},
    ["dark red"]   = {0.5,0,0},
    ["dark purple"]= {0.3,0,0.4},
    ["dark orange"]= {0.7,0.3,0},
    ["dark gray"]  = {0.2,0.2,0.2},
    ["dark grey"]  = {0.2,0.2,0.2},
}

local function colorHelp()
    print("Usage: /rpcolor [in|out] [color name]")
    print("Color examples: green, red, blue, light blue, magenta, yellow, orange, dark red, white, etc.")
end

SLASH_RPCOLOR1 = "/rpcolor"
SlashCmdList["RPCOLOR"] = function(msg)
    local place, color = msg:match("^(%S+)%s+(.+)$")
    if not (place and color) then
        colorHelp()
        return
    end
    place = place:lower()
    color = color:lower()
    local rgb = NAMED_COLORS[color]
    if not rgb then
        print("Unknown color! Try common colors like red, blue, light green, magenta, etc.")
        return
    end
    if place == "in" then
        RP_Settings.colors.inRange = rgb
        print("In-range color set to", color)
    elseif place == "out" then
        RP_Settings.colors.outRange = rgb
        print("Out-of-range color set to", color)
    else
        colorHelp()
    end
end

-- RESET COMMAND
SLASH_RPRESET1 = "/rpreset"
SlashCmdList["RPRESET"] = function()
    RP_Settings = nil
    ReloadUI()
end