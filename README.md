# PoshWebFramework
I want to create a new and simple tool to be able to create Web GUI for Powershell.
HTML files are using Semantic-UI framework, actually.

## Local Web Server
First idea is to create a simple local webserver, using the Tiberriver256 tool:
http://tiberriver256.github.io/powershell/gui/html/PowerShell-HTML-GUI-Pt3/

## Tag format to build HTML files that powershell can use understand
Adding to it a system to read some HTML files with a new tag format that can be understand by the Powershell.

Like twig file, HTML can include some tag, actually two only:
- {% Get-content assets\header.html -Raw %} --> {% <code> %} can be understand by the powershell main script as "okay so you whant that I execute that command"
- {{ $env:computername }} --> That tag means "Okay so display that var value bro".

Main script execute in live the tags. With the switch system in the main code, we can use more than one page, the HTML form redirect to another etc.
Each page must be set up in the main code, that's not cool I know, I'm thinking about it to find a solution. If you have one and you can help me, just send me a message.
Some features could be added to that project, I'm available to all of your ideas.
