# LibAddonUtils

_This library was created by **Niketa** (Nikketa-Hyjal-US) as a collection of basic addon development tools._

## Table of Contents

-   [LibAddonUtils](#libaddonutils)
    -   [Table of Contents](#table-of-contents)
    -   [Embedding the library](#embedding-the-library)
    -   [API](#api)
        -   [.CacheItem(_item, callback, args_)](#cacheitemitem-callback-args)
        -   [.CloneTable(_tbl_)](#clonetabletbl)
        -   [.ColorFontString(_str, color_)](#colorfontstringstr-color)
        -   [.IncrementString(_str, obj, validationFunc, args_)](#incrementstringstr-obj-validationfunc-args)
        -   [.StringToTitle(_str_)](#stringtotitlestr)
        -   [.GetTableKey(_tbl, value_)](#gettablekeytbl-value)
        -   [.iformat(_int, fType, roundDown_)](#iformatint-ftype-rounddown)
        -   [.pairs(_tbl, func_)](#pairstbl-func)
        -   [.printt(_tbl, condition_)](#printttbl-condition)
        -   [.round(_number, decimals, roundDown_)](#roundnumber-decimals-rounddown)
        -   [.tcount(_tbl, key, value_)](#tcounttbl-key-value)
        -   [.tpairs(_tbl, callback, duration, key, value, sorting_)](#tpairstbl-callback-duration-key-value)
        -   [.unpack(_tbl, default_)](#unpacktbl-default)

## Embedding the library

**1. Create a folder called _Libs_ in your addon directory and copy _LibAddonUtils_ to this folder.**
You can also place LibAddonUtils in your main directory, but having your libraries separate can help keep things organized.

`ExampleAddon/Libs/LibAddonUtils`

**2. Create an XML file.**
`ExampleAddon/Libs/embeds.xml`

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

`Libs\LibAddonUtils\LibAddonUtils.xml`

**4. Create an addon object.**
In your core addon file, you need to create an object to reference LibAddonUtils. This library uses LibStub, so you can do that like this:

`local LibAddonUtils = LibStub("LibAddonUtils-1.0")`

You can now access any of this library's functions with this reference.

**LibStub is required to use this library.**

[top](#libaddonutils)

## API

### .CacheItem(_item, callback, args_)

_Use this method to cache items before calling GetItemInfo. You can supply a callback to execute when the item table is available._

**Args:**
**itemID**: valid itemID, itemLink, itemName, or itemString.<br>**callback**: function to be called when the item has successfully been cached.<br>**args**: arguments to be sent to your callback function, as a vararg.

**Returns:**
_true_ or _false_ when item table is available.

**Example:**

```
> local itemName = GetItemInfo(168487)
> print(itemName)
nil
```

```
> LibAddonUtils.CacheItem(168487, function(itemID)
>     print(GetItemInfo(itemID))
> end, 168487)
Zin'anthid
```

[top](#libaddonutils)

### .CloneTable(_tbl_)

_Recursively clones the supplied table._

**Args:**
**tbl**: table to be cloned.

**Returns:**
cloned table.

[top](#libaddonutils)

### .ColorFontString(_str, color_)

_Colors the supplied font string._

**Args:**
**str**: string to be colored.<br>**color**: valid color key:<br>&nbsp;&nbsp;&nbsp;&nbsp;**_LIGHTRED, LIGHTBLUE, TORQUISEBLUE, SPRINGGREEN, GREENYELLOW, BLUE, PURPLE, GREEN, RED, GOLD, GOLD2, GREY, WHITE, SUBWHITE, MAGENTA, YELLOW, ORANGEY, CHOCOLATE, CYAN, IVORY, LIGHTYELLOW, SEXGREEN, SEXTEAL, SEXPINK, SEXBLUE, SEXHOTPINK_**.

**Returns:**
the colored font string.

[top](#libaddonutils)

### .IncrementString(_str, obj, validationFunc, args_)

_Adds an incremental number to the provided string._

**Args:**
**str**: string to be enumerated.<br>**obj**: Object of which validationFunc should be called from. Must return an object or nil.<br>**validationFunc**: function to validate the enumerated string.<br>**args**: args to be passed to validationfunc. The string provided to this function will be called last in the validation function.

**Returns:**
the enumerated font string.

**Example:**

```
> local db = {New = true, "New 2" = true, "New 4" = true}
> function(key)
>     return db[key]
> end
> print(LibAddonUtils.IncrementString("New", nil, "KeyExists"))
New 3
> print(LibAddonUtils.IncrementString("New", nil, "KeyExists"))
New 5
```

[top](#libaddonutils)

### .StringToTitle(_str_)

_Converts the provided string to title case._

**Args:**
**str**: string to be transformed.

**Returns:**
the transformed font string.

[top](#libaddonutils)

### .GetTableKey(_tbl, value_)

_Finds the key of the supplied table value._

**Args:**
**tbl**: table to be searched.<br>**value**: value to match.

**Returns:**
all matched keys.

[top](#libaddonutils)

### .iformat(_int, fType, roundDown_)

_Formats the supplied integer._

**Args:**
**int**: integer to be formatted.<br>**fType**:<br>&nbsp;&nbsp;&nbsp;&nbsp;**_1_** - adds commas to the integer (2000 > 2,000).<br>&nbsp;&nbsp;&nbsp;&nbsp;**_2_** - abbreviates the integer (2000 > 2k).<br>**roundDown**: floors (rounds down) the number.<br>

**Returns:**
the formatted integer.

[top](#libaddonutils)

### .pairs(_tbl, func_)

_Iterates through a table based on keys._

**Args:**
**tbl**: table to be iterated.<br>**func**: custom sort function.

[top](#libaddonutils)

### .printt(_tbl, condition_)

_Prints out table keys/values._

**Args:**
**tbl**: table to be printed.<br>**condition**:<br>&nbsp;&nbsp;&nbsp;&nbsp;**_1_** - prints key names.<br>&nbsp;&nbsp;&nbsp;&nbsp;**_2_** - prints table values.<br>&nbsp;&nbsp;&nbsp;&nbsp;**_nil_** - prints key/value pairs.

[top](#libaddonutils)

### .round(_number, decimals, roundDown_)

_Rounds a number to x decimals._

**Args:**
**number**: integer to be rounded.<br>**decimals**: the number of decimal places to round to.<br>**roundDown**: floors (rounds down) the number.

**Example:**

```
> print(LibAddonUtils.round(3.14, 0))
3
```

[top](#libaddonutils)

### .tcount(_tbl, key, value_)

_Counts the number of entries in a table._

**Args:**
**tbl**: table to be counted.<br>**key**: only count table entries with keys that match this paramater.<br>**value**: only count table entries with values that match this paramater.

**Returns:**
_count_ as an integer.

[top](#libaddonutils)

### .tpairs(_tbl, callback, duration, key, value, sorting_)

_Throttles iterations over a table to one table entry per duration seconds._

**Args:**
**tbl**: table to be iterated.<br>**callback**: function to be called at each iteration.<br>**duration**: number of seconds between each iteration, as an integer.<br>**key**: only iterate table entries with keys that match this paramater.<br>**value**: only iterate table entries with values that match this paramater.<br>**sorting**: custom sort func.

**Returns:**
_tbl_ and _key_ are returned to the callback function.

**Example:**

```
>local myTable = {key1 = "specialValue", key2 = "value", key3 = "value", key4 = "specialValue"}
>LibAddonUtils.tpairs(myTable, function(tbl, key)
>     print(key, tbl[key])
> end, 0.01, nil, "specialValue")
key1, specialValue
key4, specialValue
```

[top](#libaddonutils)

### .unpack(_tbl, default_)

_Unpacks tables with or without indexes (unlike the default behavior of unpack, which only accepts non-indexed tables) and allows you to specify a default table to return if tbl cannot be unpacked._

**Args:**
**tbl**: table to be unpacked.<br>**default**: table to unpack if _tbl_ is invalid.

**Example:**

```
> db.style = "minimal"
> local styles = {
>     ["default"] = {
>         rgba = {1, 1, 1, 1}
>     },
>     ["minimal"] = {
>     },
> }
> texture:SetColorTexture(unpack(styles[db.style].rgba))
bad argument #1 to 'unpack' (table expected, got nil)
> texture:SetColorTexture(LibAddonUtils.unpack(styles[db.style].rgba, {0, 0, 0, .75}))
>
```

[top](#libaddonutils)
