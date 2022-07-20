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
        $Content,
        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$ActiveFirstItem
    )
    $output = @"
        <div class="carousel-item$(if($ActiveFirstItem){" active"})">
        $(try{
            .$Content
        }
        catch{
            $_.Exception.Message
        })
        </div>
"@

    return $output
}
