#PD2 EZ Reporter

###About:
PD2 EZ Reporter is program I've written in AutoHotkey (AHK) to collect troubleshooting data for the game PAYDAY 2.

It is intended to be a free contribution to the community.
It is open source and is non-profit. Anyone can use this program to help gather PAYDAY 2 troubleshooting data for posting to forums such as Steam, Reddit, etc.

I've given Overkill express permission to distribute this program however they'd like and would be happy to work with them to modify it in any way that might help.


###How to use:
It's fairly simple.
Run the exe.
Click "Generate Report".
The text should pop up in your default text editor. Copy and paste it wherever you want.

All data sources can be toggled with the check boxes.
Default data collected includes the following:
Info about the last crash that happened
renderer_settings.xml info
Checks for the presence of IPHLPAPI.dll as mods are responsible for a majority of problems

###Non-default choices:
The full crash log that contains all recorded crashes can also be submitted. This is not checked by default as it's not needed often and it helps reduce the amount of text to be copy and pasted.


###Safety:
This program creates a text file in your temp folder.
This program will not add, remove, or modify anything from your system other than that text file.
In other words, it's completely safe.


###.ahk vs .exe:
The .exe I've provided is just a compiled version of the .ahk file. It's done so you don't have to install AutoHotkey to run the .ahk file.
If you're uncomfortable running my compiled .exe, please feel free to download the .ahk file. You can then see the source before running it.
To run it, you'll need the free program AutoHotkey.

AutoHotkey can be downloaded at https://autohotkey.com


###Motivation:
As an avid fan of PAYDAY 2, this is the second script I've written strictly for this game. The first was an awesome but very short lived script that allowed pasting of text while inside the game. Very shortly after I developed it, pasting was implemented into the game.
After taking a break from PD2, I came back post update-100. I've been having a horrendous time with crashing. After uninstalling all mods, doing a full reinstall, and wasting hours and hours reading different posts, I finally found a post from a PD2 mod named Manager of the Melons that had the exact solution I was looking for. (I'm going somewhere with this. Keep reading.)
One thing I noticed in my searches is that certain logs were constantly requested by people trying to help those having problems.
I decided to give back by making an all-in-one, simple program that helps the end user get that info to those wanting to help.
