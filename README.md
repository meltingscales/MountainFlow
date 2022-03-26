# MountainFlow

Some factory game... :P

A successor to <https://github.com/HenryFBP/LithicRivers>, an unfinished ASCII game.

# Play the game

Visit this page to play the latest commit from the branch `release` in your browser:

- <https://henryfbp.github.io/MountainFlow/>
- Please note you can press `F12` to see extra debug information in your browser.

Visit this page to download a Windows/OSX/Linux binary release file:

- <https://github.com/HenryFBP/MountainFlow/releases>

## Releasing

### HTML5

    lime build html5
    pushd ./export/html5/bin
    python3 -m http.server & # We do this due to CORS issues if opening HTML files locally
    echo "Visit http://localhost:8000/"
    popd

### Windows

    lime build windows
    ./export/windows/bin/MountainFlow.exe

# Setup

<https://haxeflixel.com/documentation/getting-started/>
<https://haxeflixel.com/documentation/install-haxeflixel/>
<https://haxe.org/download/>

Run these one at a time. Some need your input.

    haxelib install lime
    haxelib install openfl
    haxelib install flixel
    haxelib install hxcpp-debug-server

    haxelib run lime setup flixel
    haxelib run lime setup

    haxelib install flixel-tools
    haxelib run flixel-tools setup

    haxelib update flixel # (To update)

# Developing

Read <https://haxeflixel.com/documentation/visual-studio-code/>

## Tiling/Maps/Entities

- <https://ogmo-editor-3.github.io/>

## Sprites

- <https://www.pyxeledit.com/>
  - <https://www.pyxeledit.com/learn.php>
- <https://itch.io/game-assets/free/tag-tileset>


<!--
- <https://www.aseprite.org/trial/>
- <https://www.gimp.org/>
- <https://www.piskelapp.com/>
-->

## Sound

- <https://www.bfxr.net/>

# Running

Run > "Run and Debug" in VSCode. (or press `F5`)

You can also press `F2` during a game to debug.

Make sure to change the target:

![](media/debug.png)

I recommend "Windows/Debug". This is the only setting I've found that works with VSCode breakpoints.

Or,

    lime test html5
    lime test neko
    lime test flash

# Issues

## `64bit is not automatically supported for this version of VC. Set HXCPP_MSVC_CUSTOM and manually configure the executable, library and include paths`

You need MSVC... <https://community.haxe.org/t/how-to-fix-error-set-hxcpp-msvc-custom-manually/2934>

SPECIFICALLY:

- MSVC v143
- Windows SDK (10.x)
- Windows Universal CRT SDK

<https://code.visualstudio.com/docs/cpp/config-msvc>

# Resources

- <https://haxeflixel.com/documentation/>
- <https://haxeflixel.com/documentation/cheat-sheet/>
- <https://haxeflixel.com/documentation/getting-started/>
- <https://haxeflixel.com/documentation/groundwork/>
- <https://haxe.org/manual/introduction.html>
- <https://github.com/HaxeFlixel/flixel-demos> Demos:
  - <https://haxeflixel.com/demos/RPGInterface/>
  - <https://haxeflixel.com/demos/BSPMapGen/>
  - <https://haxeflixel.com/demos/TileMap/>
  - <https://haxeflixel.com/demos/FlxCaveGenerator/>
- <https://github.com/HaxeFlixel/snippets.haxeflixel.com/blob/master/demos/tiles/ray/source/PlayState.hx>
- <https://github.com/Beeblerox/Simplest-Heaps-Examples>
- <https://kinocreates.io/tutorials/haxeflixel-object-pooling/>
