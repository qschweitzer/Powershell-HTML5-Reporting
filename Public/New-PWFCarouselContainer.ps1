Function New-PWFCarouselContainer {
    <#
.SYNOPSIS
Create a new Carousel container.
.DESCRIPTION
Create a new Carousel container that will contains what you want.
.PARAMETER Content
Add some slides with New-PWFCarouselItem
.EXAMPLE
New-PWFCarouselContainer -Content { New-PWFCarouselItem}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Content
    )
    $CarouselID = "Carousel$(Get-random)"
    
    $ItemsOutput = .$Content
    $ItemsCount = $ItemsOutput.count
    $output = @"
    <div id="$($CarouselID)" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
        $(for($i=0; $i -le $ItemsCount; $i++){
            "<button type='button' data-bs-target='#$($CarouselID)' data-bs-slide-to='$($i)' $(if($i=0){"class='active' aria-current='true'"}) aria-label='Slide $($i)'></button>"
        })
    </div>
    <div class="carousel-inner">
        $($ItemsOutput)
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#$($CarouselID)" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#$($CarouselID)" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
    </div>
"@

    return $output
}
