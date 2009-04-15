﻿
local BottleCap = LibStub("AceAddon-3.0"):NewAddon("BottleCap")
local db

local function bottleCaps(_, _, msg, ...)
	if db.verbose or msg == msg:upper() then
		-- Verbose Mode = all chat becomes lower case, regardless of original case
		-- else all ALL CAPS CHAT becomes lower case
		msg = msg:lower()

		-- Fix links
		msg = msg:gsub("|hitem", "|Hitem")
		msg = msg:gsub("|hquest", "|Hquest")
		msg = msg:gsub("|hspell", "|Hspell")
		msg = msg:gsub("|htalent", "|Htalent")
		msg = msg:gsub("|hachievement", "|Hachievement")
		msg = msg:gsub("|htrade", "|Htrade")
		msg = msg:gsub("|henchant", "|Henchant")
		msg = msg:gsub("|hglyph", "|Hglyph")

		return false, msg, ...
	end
end


function BottleCap:OnEnable()
	self.db = LibStub("AceDB-3.0"):New("BottleCapDB", { profile = { verbose = false }}, "Default")

	db = self.db.profile

	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", bottleCaps)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", bottleCaps)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", bottleCaps)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", bottleCaps)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("BottleCap", {
		name = "Bottle Cap",
		desc = "Converts ALL CAPS CHAT into all lowercase chat.",
		type = "group",
		get = function(key) return db[key.arg] end,
		set = function(key, value) db[key.arg] = value end,
		args = {
			verbose = {
				name = "Verbose Mode",
				desc = "Convert all chat into lowercase text, regardless of original case.",
				type = "toggle", order = 1, arg = "verbose",
			},
		}, 
	})

	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BottleCap", "Bottle Cap")
end
