-- word_frequency.lua: Word frequencies of a fixed sentence
--
-- Description:
-- Count the words of a fixed text, most frequent first and alphabetically within a tie.
--
-- Part of the basics cross-language exercise set: the input is fixed in the
-- source, and the output is the same as that of the same exercise in every
-- other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lua word_frequency.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

local text = "the quick brown fox jumps over the lazy dog the fox barks"

local counts = {}
for word in text:gmatch("%S+") do
  counts[word] = (counts[word] or 0) + 1
end

local ranked = {}
for word, count in pairs(counts) do
  ranked[#ranked + 1] = { word = word, count = count }
end

table.sort(ranked, function(a, b)
  if a.count ~= b.count then
    return a.count > b.count
  end
  return a.word < b.word
end)

for _, entry in ipairs(ranked) do
  print(entry.word .. " " .. entry.count)
end
