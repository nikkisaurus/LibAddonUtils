local lib = LibStub:NewLibrary("LibAddonUtils-1.0", 1)

if not lib then
  return
end

if not lib.frame then
    lib.frame = CreateFrame("Frame")
end

lib.frame:SetScript("OnEvent", function(self, event, ...)
    return self[event] and self[event](self, event, ...)
end)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Core utilities

function lib.tcount(tbl)
    local counter = 0
    for k, v in pairs(tbl) do
        counter = counter + 1
    end

    return counter
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function lib.pairs(tbl, func)
    local a = {}

    for n in pairs(tbl) do
        table.insert(a, n)
    end

    table.sort(a, func)

    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], tbl[a[i]]
        end
    end

    return iter
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function lib.printt(tbl, cond)
    if type(tbl) == "table" then
        for k, v in lib.pairs(tbl) do
            if cond == 1 then
                print(k)
            elseif cond == 2 then
                print(v)
            else
                print(k, v)
            end
        end

        return true
    end
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function lib.round(num, decimals)
    return tonumber((("%%.%df"):format(decimals)):format(num))
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function lib.unpack(tbl, default)
    if type(tbl) == "table" then
        if not unpack(tbl) then
            local newTbl = {}
            for k, v in lib.pairs(tbl) do
                tinsert(newTbl, v)
            end
            return unpack(newTbl)
        else
            return unpack(tbl)
        end
    elseif default then
        return unpack(default)
    else
        return tbl
    end
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- Addon utilities

local cache = {}
function lib.CacheItem(itemID, callback, ...)
    local args = {...}
    if type(itemID) == "table" then
        itemID = callback
        if callback then
            callback = args[1]
            args[1] = nil
        end
    end

    itemID = GetItemInfoInstant(itemID)
    if itemID and not GetItemInfo(itemID) then
        tinsert(cache, {itemID, callback, lib.unpack(args)})
        return false
    elseif callback then
        callback(lib.unpack(args))
        return true
    end
end
-- To do: set up support for itemName/itemLink
-- Will have to check if it's not an id, then save the id and add it to the table.

lib.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
function lib.frame:GET_ITEM_INFO_RECEIVED(_, itemID, success)
    if (not itemID or not success) then return end

    local itemName, itemLink = GetItemInfo(itemID)
    for k, v in pairs(cache) do
        if v[1] == itemName or v[1] == itemLink or v[1] == itemID then
            lib:CacheItem(lib.unpack(cache[k]))
            cache[k] = nil
        end
    end
end