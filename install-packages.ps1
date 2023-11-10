# Define the directory
$packageDir = "\packages"

# Get all the package files
$packageFiles = Get-ChildItem -Path $packageDir -Filter "*.txt"

# Display the package files and ask the user to select which ones to install or choose to install all
Write-Host "Please select the packages to install (or enter 'all' to install all):"
for ($i=0; $i -lt $packageFiles.Count; $i++) {
    Write-Host "$i. $($packageFiles[$i].Name)"
}
$userInput = Read-Host "Enter the numbers of the packages to install (separated by commas), or 'all'"

if ($userInput -eq 'all') {
    # Install all packages
    $selectedPackages = $packageFiles
} else {
    # Convert the selected indices to an array and get the corresponding package files
    $selectedIndices = $userInput.Split(',') | ForEach-Object { [int]$_ }
    $selectedPackages = $selectedIndices | ForEach-Object { $packageFiles[$_] }
}

# Loop through the selected package files
foreach ($package in $selectedPackages) {
    # Install the package
    choco install $package.FullName -y
}
