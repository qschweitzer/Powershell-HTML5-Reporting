Function New-PWFCarouselItem {
    <#
.SYNOPSIS
Create a new Carousel item.
.DESCRIPTION
Create a new Carousel item to add into New-PWFCarouselContainer.
.PARAMETER Content
Add what you want in the content. Image, charts...
.EXAMPLE

.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$ImgURL,
        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$ActiveFirstItem,
        [string]$CaptionH5,
        [string]$CaptionText
    )
    if ($ImgURL -notmatch "/|\\") {
        $Alt = "alt='$ImgURL'"
    }
    else {
        $Alt = ""
    }
    $output = @"
        <div class="carousel-item$(if($ActiveFirstItem){" active"})">
            <img class="d-block w-100" src="$(try{$ImgURL}catch{$_.Exception.Message})" $Alt>
        </div>
"@

    return $output
}
