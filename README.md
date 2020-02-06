# LibAddonUtils
*This library was created by **Niketa** (Nikketa-Hyjal-US) as a collection of basic addon development tools.*

## Table of Contents
- [Embedding the library](#embedding-the-library)
- [API](#api)<br>&nbsp;&nbsp;&nbsp;- [CacheItem](#cacheitemitem-callback-args)<br>&nbsp;&nbsp;&nbsp;- [ColorFontString](#colorfontstringstr-color)<br>&nbsp;&nbsp;&nbsp;- [iformat](#iformatint-ftype)<br>&nbsp;&nbsp;&nbsp;- [pairs](#pairstbl-func)<br>&nbsp;&nbsp;&nbsp;- [printt](#printttbl-condition)<br>&nbsp;&nbsp;&nbsp;- [round](#roundnumber-decimals)<br>&nbsp;&nbsp;&nbsp;- [tcount](#tcounttbl-key-value)<br>&nbsp;&nbsp;&nbsp;- [tpairs](#tpairstbl-callback-duration-key-value)<br>&nbsp;&nbsp;&nbsp;- [unpack](#unpacktbl-default)

## Embedding the library
**1. Create a folder called *Libs* in your addon directory and copy *LibAddonUtils* to this folder.**
You can also place LibAddonUtils in your main directory, but having your libraries separate can help keep things organized.

```ExampleAddon/Libs/LibAddonUtils```

**2. Create an XML file.**
```ExampleAddon/Libs/embeds.xml```

If you are using multiple libraries, you can call them in the same file. The paths to libraries you are including should be relative to the embeds file.

In this example, my embeds.xml is in the Libs folder with all of the libraries I want to load:

```
<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\FrameXML\UI.xsd">
    <Include file="LibAddonUtils\LibAddonUtils.xml"/>
</Ui>
```

**Note**: You don't have to use an XML file to load libraries. You may also call them directly in your TOC.

**3. Update your TOC.**
```
## Interface: 80200
## Title: ExampleAddon
## Notes: This addon does cool stuff!
## Author: Me
## Version: 1.0

Libs\embeds.xml

Core.lua
```
Always call libraries before your core addon files. Any files loaded before your embeds will not have access to the libraries.

If you would rather skip the XML, point to the library's XML file instead:

```Libs\LibAddonUtils\LibAddonUtils.xml```

**4. Create an addon object.**
In your core addon file, you need to create an object to reference LibAddonUtils. This library uses LibStub, so you can do that like this:

```local LibAddonUtils = LibStub("LibAddonUtils-1.0")```

You can now access any of this library's functions with this reference.

[top](#libaddonutils)

## API
### .CacheItem(*item, callback, args*)
*Use this method to cache items before calling GetItemInfo. You can supply a callback to execute when the item table is available.*

**Args:**
**itemID**: valid itemID, itemLink, itemName, or itemString.<br>**callback**: function to be called when the item has successfully been cached.<br>**args**: arguments to be sent to your callback function, as a vararg.

**Returns:**
*true* or *false* when item table is available.

**Example:**
```
> local itemName = GetItemInfo(168487)
> print(itemName)
nil
```
```
> LibAddonUtils.CacheItem(168487, function(itemID) print(GetItemInfo(itemID)) end, 168487)
Zin'anthid
```

[top](#libaddonutils)

### .ColorFontString(*str, color*)
*Colors the supplied font string.*

**Args:**
**str**: string to be colored.<br>**color**: valid color key:<br>&nbsp;&nbsp;&nbsp;&nbsp;***LIGHTRED, LIGHTBLUE, TORQUISEBLUE, SPRINGGREEN, GREENYELLOW, BLUE, PURPLE, GREEN, RED, GOLD, GOLD2, GREY, WHITE, SUBWHITE, MAGENTA, YELLOW, ORANGEY, CHOCOLATE, CYAN, IVORY, LIGHTYELLOW, SEXGREEN, SEXTEAL, SEXPINK, SEXBLUE, SEXHOTPINK***.

**Returns:**
the colored font string.

[top](#libaddonutils)

### .iformat(*int, fType*)
*Formats the supplied integer.*

**Args:**
**int**: integer to be formatted.<br>**fType**:<br>&nbsp;&nbsp;&nbsp;&nbsp;***1*** - adds commas to the integer (2000 > 2,000).<br>&nbsp;&nbsp;&nbsp;&nbsp;***2*** - abbreviates the integer (2000 > 2k).

**Returns:**
the formatted integer.

[top](#libaddonutils)

### .pairs(*tbl, func*)

*Iterates through a table based on keys.*

**Args:**
**tbl**: table to be iterated.<br>**func**: custom sort function.

[top](#libaddonutils)

### .printt(*tbl, condition*)

*Prints out table keys/values.*

**Args:**
**tbl**: table to be printed.<br>**condition**:<br>&nbsp;&nbsp;&nbsp;&nbsp;***1*** - prints key names.<br>&nbsp;&nbsp;&nbsp;&nbsp;***2*** - prints table values.<br>&nbsp;&nbsp;&nbsp;&nbsp;***nil*** - prints key/value pairs.

[top](#libaddonutils)

### .round(*number, decimals*)

*Rounds a number to x decimals.*

**Args:**
**number**: integer to be rounded.<br>**decimals**: the number of decimal places to round to.

**Example:**
```
> print(LibAddonUtils.round(3.14, 0))
3
```

[top](#libaddonutils)

### .tcount(*tbl, key, value*)
*Counts the number of entries in a table.*

**Args:**
**tbl**: table to be counted.<br>**key**: only count table entries with keys that match this paramater.<br>**value**: only count table entries with values that match this paramater.

**Returns:**
*count* as an integer.

[top](#libaddonutils)

### .tpairs(*tbl, callback, duration, key, value*)
*Throttles iterations over a table to one table entry per duration seconds.*

**Args:**
**tbl**: table to be iterated.<br>**callback**: function to be called at each iteration.<br>**duration**: number of seconds between each iteration, as an integer.<br>**key**: only iterate table entries with keys that match this paramater.<br>**value**: only iterate table entries with values that match this paramater.

**Returns:**
*tbl* and *key* are returned to the callback function.

**Example:**
```
>local myTable = {key1 = "specialValue", key2 = "value", key3 = "value", key4 = "specialValue"}
>LibAddonUtils.tpairs(myTable, function(tbl, key) print(key, tbl[key]) end, 0.01, nil, "specialValue")
key1, specialValue
key4, specialValue
```

[top](#libaddonutils)

### .unpack(*tbl, default*)
*Unpacks tables with or without indexes (unlike the default behavior of unpack, which only accepts non-indexed tables) and allows you to specify a default table to return if tbl cannot be unpacked.*

**Args:**
**tbl**: table to be unpacked.<br>**default**: table to unpack if *tbl* is invalid.

**Example:**
```
db.style = "minimal"
local styles = {
    ["default"] = {
        rgba = {1, 1, 1, 1}
    },
    ["minimal"] = {
    },
}
```

The following will cause a Lua error:
```texture:SetColorTexture(unpack(styles[db.style].rgba))```

Use this method to pass a default table .
```texture:SetColorTexture(LibAddonUtils.unpack(styles[db.style].rgba, {0, 0, 0, .75}))```

[top](#libaddonutils)