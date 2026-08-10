-- Sort a fixed table with a quicksort that builds a new table at each step.
-- Run: lua quicksort.lua

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
