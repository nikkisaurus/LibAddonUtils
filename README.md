# LibAddonUtils
*This library was created by **Niketa** (Nikketa-Hyjal-US) as a collection of useful tools for any addon.*

## Table of Contents
1. [Getting Started](#getting-started)
   - [Embedding the library](#embedding-the-library)
     - [Creating the .xml file](#creating-the-xml-file)
     - [Updating your .toc](#updating-your-toc)
   - [Creating an addon object](#creating-an-addon-object)
2. [API](#api)
   - [Core Methods](#core-methods)
   - [Other Methods](#other-methods)

## Documentation
### Getting Started
#### Embedding the library
##### Creating the .xml file
Create an embeds.xml file. This file should look something like this:

```
<Ui xmlns="http://www.blizzard.com/wow/ui/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\FrameXML\UI.xsd">
    <Script file="LibAddonUtils\LibStub\LibStub.lua"/>
    <Script file="LibAddonUtils\LibAddonUtils.lua"/>
</Ui>
```

The sample code above assumes your embeds file is in the same directory as LibAddonUtils's directory. If your embeds file is in a different directory, update the path to correctly point to LibAddonUtils.lua.

[top](#table-of-contents)

##### Updating your .toc
Call your embeds file after your metadata but before any addon files.

```
## Interface: 80200
## Title: ExampleAddon
## Notes: This addon does cool stuff!
## Author: Me
## Version: 1.0

embeds.xml

Core.lua
```

[top](#table-of-contents)

#### Creating an addon object
For each file you want to use this library on, create an object to reference LibAddonUtils. You can then use this object to reference any library methods.

```local U = LibStub("LibAddonUtils")```

[top](#table-of-contents)

## API
### Core Methods

#### U.count(tbl)
*Counts the number of entries in a table.*

**tbl**: table to be counted.<br>**Returns** count as integer.

[top](#table-of-contents)

#### U.pairs(tbl, func)

*Iterates through a table based on keys.*

**tbl**: table to be iterated.<br>**func**: custom sort function.

[top](#table-of-contents)

#### U.printt(tbl, cond)

*Prints out table keys/values.*

**tbl**: table to be printed.<br><br>**cond**:<br>&nbsp;&nbsp;&nbsp;&nbsp;***1*** - print only keys.<br>&nbsp;&nbsp;&nbsp;&nbsp;***2*** - print only values.<br>&nbsp;&nbsp;&nbsp;&nbsp;***nil*** - print key/value pairs.


[top](#table-of-contents)

#### U.round(num, decimals)

*Rounds a number to x decimals.*

**num**: integer to be rounded.<br>**decimals**: the number of decimal places to round to.

[top](#table-of-contents)

#### U.unpack(tbl, default)

*Enhanced unpack function that will unpack tables with integer and string indexes and allows you to return a default table if your supplied table can't be unpacked.*

**tbl**: table to be unpacked.<br>**default**: table to unpack and return if *tbl* is invalid.

**Example**

```
db.style = "minimal"
local styles = {
    ["default"] = {
        rgba = {1, 1, 1, 1}
    },
    ["minimal"] = {
    },
}

texture:SetColorTexture(unpack(styles[db.style].rgba))
```
The above example will cause a lua error because SetColorTexture expects the arguments (r, g, b, [a]) and the table that's being unpacked will return nil. Instead, we can pass it a default value in case this happens.

```texture:SetColorTexture(U.unpack(styles[db.style].rgba, {0, 0, 0, .75}))```

[top](#table-of-contents)

### Other Methods

#### U.CacheItems(*itemID*, *callback*, *args*)

*Cache an item ID to make the info table available when it hasn't already been cached. You can supply a callback to run whatever code you need to with the returned item info table.*

**itemID**: valid item ID, as a string.<br>**callback**: function to be called when item has successfully been cached.<br>**args**: arguments to be sent to your callback function, as a vararg (not a table).

[top](#table-of-contents)