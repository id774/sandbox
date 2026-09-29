-- quicksort.lua: Quicksort of a fixed integer sequence
--
-- Description:
-- Sort a fixed table with a quicksort that builds a new table at each step.
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
--     lua quicksort.lua
--
-- Requirements:
-- - Lua 5.3 or later
-- - No third-party package is required

local function quicksort(items)
  if #items <= 1 then
    return items
  end

  local pivot = items[1]
  local smaller, larger = {}, {}
  for i = 2, #items do
    local target = items[i] <= pivot and smaller or larger
    target[#target + 1] = items[i]
  end

  local sorted = quicksort(smaller)
  sorted[#sorted + 1] = pivot
  for _, value in ipairs(quicksort(larger)) do
    sorted[#sorted + 1] = value
  end
  return sorted
end

print(table.concat(quicksort({ 5, 3, 8, 4, 2, 7, 1, 10, 9, 6 }), " "))
