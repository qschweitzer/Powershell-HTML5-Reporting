![My image](https://cdn.rawgit.com/qschweitzer/PoshWebFramework/dfb0010e/Header.jpg)
[Download .PS1][1]
[1]:{{ site.url }}/PWF-Functions.ps1
# Powershell Web Framework
The idea is to create a simple tool to build web GUI for your scripts.
You can run this locally.
**I've not tested it on "server mode". Don't use it in production. There is no security implemented, anybody could access it.**

## Local Web Server
Based on a simple local webserver, using the Tiberriver256 tool:
http://tiberriver256.github.io/powershell/gui/html/PowerShell-HTML-GUI-Pt3/

# How to use
1. Import the .ps1 file of the Master branch.
You can do it with an import-module. I know the common use is to use .psm1 files but with psm1 the webserver isn't working well.
Ok, importation done.

2. Start building the App
Add new lines:

```
New-PWFAppBuild -ListeningPort 8000 -PageBlocks{
  switch($Pages){
    default{
      <some code here>
    }
  }
}
```

Choose your ListeningPort ;)
Ok good, now you have the main code to build all your pages.
The Switch statement is used to manage the different pages, default is the...default page. You can't change is name to "index" or other. The default page have to stay default page, actually. Maybe in future it could be changed, actually I don't know how.

Other pages have to be declared like `"/PageTwo"{}`

**Access to your page with http://localhost:8000**

3. Build the default page

```
New-PWFPage -Title "Hello" -Container -Content {
<add some code>
}
```

4. Test a Hello

```
New-PWFPage -Title "Hello" -Container -Content {
  New-PWFHeader -HeaderText "Form Test" -Size 1
}
```

5. Building a form

```
New-PWFRow -Content {
  New-PWFColumn -Size 6 -Content {
    New-PWFHeader -HeaderText "Form Test" -Size 1
    New-PWFForm -Size 12 -ActionPage "ResultForm" -Content {
        New-PWFFormInput -Text -Label "First Name" -IDName "FirstName" -Size 6 -Required
        New-PWFFormInput -Text -Label "Name" -IDName "Name" -Size 6
        New-PWFFormInput -Email -Label "Email" -IDName "Email" -Size 12
        New-PWFFormInput -Password -Label "Password" -IDName "Password" -Size 6
        New-PWFFormSubmitButton -Label "Validate" -Size Large -IconName "start"
    }
  }
}
```

Start your web server and Wow ! :)
But if you validate your form, it will fail with a blank page because the response page isn't configured.

6. Build the response page

```
"/ResultForm" {
  Write-Host $firstName -BackgroundColor Red
  New-PWFPage -Title "ResultPage" -Container -Content {
    New-PWFRow -Content {
      New-PWFColumn -Size 6 -Content {
        New-PWFHeader -HeaderText "Hi $firstname !" -Size 1
        New-PWFFlowText -YourText "This is What I know about you"
        New-PWFCard -CardType Basic -Size 12 -CardTitle ($firstname + " " + $name) -CardContent ("Your Email: "+$email+" Your Password: nonono, I can't display that ;)")
      }
    }
  }
}
```

As you can see, we use the var $firstname that refer to the IDName on the form.
All of IDName on the URL are converted to Variable with the value associated.
Like: IDName is FirstName. You type "Peter" in the form and validate it. Then a Variable is created: $FirstName, it's value is "Peter".

7. Well, I let you testing that and tell me what you want about it :)
I will continue to add some features from Materialize.

## How to stop that?
Simply use the **Red stop** button on the bottom right corner. Each page build with New-PWFPage contain this button.
You also can stop it by using this kind of Url, with your custom port: http://localhost:8000/theend
