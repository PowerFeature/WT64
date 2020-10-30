## WT64
![alt text](https://github.com/KillerFeature/WT64/raw/master/WT64_hero.png)
A Commodore 64 Experience for Windows Terminal

![Video](https://github.com/KillerFeature/WT64/raw/master/video.gif "Video")

### Features
- Native C64 style commands like LOAD "$",8
- Native C64 LIST layout for directory listing with size reporting and Blocks free indication.
- Startup screen with actual PowerShell version and memory reporting

### Supported commands:
1. LIST <path> [Lists the files in local or path directory in C64 disk style]
2. LOAD "$",8 [Shows the classic loading sequence]
3. SYS64738 [Shows the opening prompt]
4. EDIT <filename> [Shorthand for nano]

### PREREQUISITES
1. [Windows Terminal](https://aka.ms/terminal) © Microsoft
2. [PowerShell 7](https://github.com/PowerShell/PowerShell/releases/latest) © Microsoft
3. [C64 font](https://www.dafont.com/commodore-64.font) © Devin Cook

### INSTALLATION
1. Clone the repo
2. Open Profile.json and cut paste the list item and colorschemen into your Windows Terminal Settings file
3. Change the places in your WT Settings where it says [INSERT YOUR REPO PATH HERE]
4. Start Windows Terminal open the WT64 teminal

### BACKGROUND
The standard background doesn't always scale properly, you can use the `P64_bg.svg` to create a new background that will have a 75px border and fit your screenresolution by followin these steps:
**1. Edit SVG**
Open the SVG in any text-editor and edit the width and height on the first in the viewBox & third line in the width and height attributes
It should be your screen width and your screen height minus taskbar (40px) and window header (36px)
If you don't use the taskbar or have it on the side of your screen adjust the height and width in the SVG accordingly
**2. Convert the SVG to PNG**
Open the SVG in an SVG capable photo-editor and save as P64_bg.png.
I use photopea.com for this, online, easy & free!
* Drag SVG onto center area or use `File > Open...`
* Select `File > Export as > PNG`
* Click `Save`
* If necessary rename the PNG-file to P64_bg.png

**3. Replace the background**
Replace the current background with this newly created one by overwriting the current one in the location you have stored WT64
**4. Done!**
Restart Windows Terminal and see the new background in action