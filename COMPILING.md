# Compiling Funkin' Laser

## Installing shit

* Install **Git** - We gonna clone repos bois
* Install **Haxe** (4.1.5 - 4.2.X) - important no forgor ok?
* Install **HaxeFlixel** - Very very important as well no forgor pls
* Install **Visual Studio Code** - best code editor :fire: :sunglasses:
* Install **Visual Studio 2019** - only used for installing components

## Install haxeflixel 

* ``haxelib install lime 7.9.0``
* ``haxelib install openfl``
* ``haxelib install flixel``
* ``haxelib install flixel-tools``
* ``haxelib install flixel-ui``
* ``haxelib install flixel-addons``
* ``haxelib run lime setup``
* ``haxelib run lime setup flixel``
* ``haxelib run flixel-tools setup``

## Install the shitty dependencies

* ``haxelib install hscript``
* ``haxelib install actuate``
* ``haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git``
* ``(OPTIONAL) haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit``
* ``haxelib git faxe https://github.com/uhrobots/faxe``
* ``haxelib git polymod https://github.com/MasterEric/polymod.git``
* ``haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc``


## Installing components

Open Visual Studio (2019), then click on "Modify"

![thing](https://cdn.discordapp.com/attachments/798150104158568448/968890348661268511/unknown.png)

After that, click on "Individual Components"

![thing2](https://cdn.discordapp.com/attachments/798150104158568448/968891539768102922/unknown.png)

Go and search for these components (Press CTRL + Q to search)

* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)

This will only take up 4GB of your storage

After you have done all of these steps, it is time for you to start installing the engine

## Installing the engine

### Very basic way

Click that green thing that says "Code"  (I know it's different for me because I am using an extension for GitHub)

Then press Download ZIP

![thing3idk](https://cdn.discordapp.com/attachments/798150104158568448/969003805352001558/unknown.png)

Once the zip file is done downloading, extract it somewhere in your system

### The cool way :sunglasses:

Open up your terminal

Type in ``git clone https://github.com/Equinoxtic/Funkin-Laser``

Wait for it to finish, then once it is finished, type in ``cd Funkin-Laser`` (if that doesn't work try: ``cd Funkin-Laser-main``)

Now type in ``lime test windows``

Wait for the engine to fully compile and you would be sent straight into the Funkin' Game!
