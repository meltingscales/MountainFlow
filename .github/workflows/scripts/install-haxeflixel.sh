#!/usr/bin/env bash

sudo apt update
sudo apt-get install haxe -y
haxelib setup ~/haxelib
echo "Installing lime, openfl, and flixel..."

haxelib install lime 2>&1 > limelog.txt
cat limelog.txt

haxelib install openfl 2>&1 > openfllog.txt
cat openfllog.txt

haxelib install flixel 2>&1 > flixellog.txt
cat flixellog.txt

haxelib run lime setup flixel 2>&1 > limesetupflixellog.txt
cat limesetupflixellog.txt

echo "Done downloading."
echo -ne 'y\n' | haxelib run lime setup
echo "Done!"
