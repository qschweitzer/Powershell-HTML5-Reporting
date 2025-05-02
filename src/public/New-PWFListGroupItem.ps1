Function New-PWFListGroupItem {
    <#
.SYNOPSIS
Create a new ListGroup Item.
.DESCRIPTION
Create a new ListGroup Item.
.PARAMETER ItemContent
The primary text in the Item.
.PARAMETER SubHeading
Add a header title on the item.
.PARAMETER BadgeContent
Add a badge and set the text on it.
.PARAMETER BadgeColor
Select the color of the badge.
.PARAMETER ContextualColor
Select the color of the Item.
.EXAMPLE
New-PWFListGroupItem -ItemContent "Test 3" -SubHeading "SubHeading 3" -BadgeContent "156"
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
  param(
      [Parameter(Mandatory = $true, Position = 0)]
      $ItemContent,
      [Parameter(Mandatory = $false, Position = 1)]
      $SubHeading,
      $BadgeContent,
      [ValidateSet("default", "primary", "secondary", "success", "danger", "warning", "info", "light", "dark", IgnoreCase = $false)]
      $BadgeColor = "primary",
      [ValidateSet("default", "primary", "secondary", "success", "danger", "warning", "info", "light", "dark", IgnoreCase = $false)]
      $ContextualColor = "default"
  )

  $output = @"
  <li class='list-group-item d-flex justify-content-between align-items-start $(if($ContextualColor){"list-group-item-$($ContextualColor)"})'>
    <div class='ms-2 me-auto'>
      $(if($SubHeading){
        "<div class='fw-bold'>$SubHeading</div>"
      })
      $($ItemContent)
    </div>
    $(if($BadgeContent){
      "<span class='badge bg-$($BadgeColor) rounded-pill'>$BadgeContent</span>"
    })
  </li>
"@

  return $output
}