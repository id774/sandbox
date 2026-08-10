-- Count the words of a fixed text, most frequent first and alphabetically within a tie.
-- Run: lua word_frequency.lua

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
