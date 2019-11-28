# LibAddonUtils-1.0
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
    <Script file="LibAddonUtils-1.0\LibStub\LibStub.lua"/>
    <Script file="LibAddonUtils-1.0\LibAddonUtils-1.0.lua"/>
</Ui>
```

The sample code above assumes your embeds file is in the same directory as LibAddonUtils's directory. If your embeds file is in a different directory, update the path to correctly point to LibAddonUtils-1.0.lua.

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

```local U = LibStub("LibAddonUtils-1.0")```

[top](#table-of-contents)

## API
### Core Methods

#### U.count(tbl)
#### U.pairs(tbl, func)
#### U.printt(tbl, cond)
#### U.round(num, decimals)
#### U.unpack(tbl, default)

[top](#table-of-contents)

### Other Methods

#### U.CacheItems(*itemID*, *callback*, *args*)

**itemID**: Valid item ID, as a string.
**callback**: Function to be called when item has successfully been cached.
**args**: Arguments to be sent to your callback function, as a vararg (not a table).

[top](#table-of-contents)