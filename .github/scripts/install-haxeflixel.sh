#!/usr/bin/env bash

sudo apt update
sudo apt-get install haxe -y
haxelib setup ~/haxelib
echo "Installing lime, openfl, and flixel..."

haxelib install lime > limelog.txt 2>&1
cat limelog.txt

haxelib install openfl > openfllog.txt 2>&1 
cat openfllog.txt

haxelib install flixel > flixellog.txt 2>&1
cat flixellog.txt

haxelib run lime setup flixel > limesetupflixellog.txt 2>&1 
cat limesetupflixellog.txt

echo "Done downloading."
echo -ne 'y\n' | haxelib run lime setup
echo "Done!"

haxe --version
lime --version
haxelib version
