![My image](https://github.com/qschweitzer/Powershell-HTML5-Reporting/blob/v2/docs/2021-10-24%2023_40_09-Clipboard.jpg)
# Powershell Web Framework 2.0
The new version have a new CSS framework: PicoCSS. Why ? Lightweight !
And much more important, this new version include....charts ! Based on Charts.JS.
The local web server option have been deprecated. I concentrate the effort on reporting features on static page (.html). These new functions are always compatible with a web server like the old version.

# How to use
1. Import the .ps1 file of the Master branch like a module (think to delete example part before so), or simply edit the script and build your own report !

# What to know ?
The framework has been optimized to be easily used.
All the functions are commented.
All arguments for each of them are explained.
The most interesting is that (almost) all functions are concatainable.
All functions were having a Content argument can contain some other functions and code.

# Grid system
Like a web page, grid system is used.
With the New-PWFRow you create a new row of a grid.
With the New-PWFColumn you create a new object, autosized, on the row. More column you have, less larger they are. If you have two, they will do 50/50 of the total width.
Like:
New-PWFRow {
  New-PWFColumn {
    ...some code...
  }
  New-PWFColumn {
    ...some code...
  }
}

# Card system
Cards can now contains what you want. No limit. A table ? A chart ? No prob.

![My image](https://github.com/qschweitzer/Powershell-HTML5-Reporting/blob/v2/docs/All_Functions.jpg)
