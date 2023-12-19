# PowerShell Script

# Temporarily change the execution policy to Bypass for this session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Check if .clang-format file exists in the current directory
if (-not (Test-Path .\.clang-format)) {
    Write-Host ".clang-format file not found in the base directory."
    exit
}

# Define the script block with the Format-File function inside it
$jobScriptBlock = {
    param ([string]$filePath)
    
    function Format-File {
        param ([string]$filePath)
        Write-Host "Formatting $filePath"
        clang-format -i $filePath
    }
    
    Format-File -filePath $filePath
}

# Find and format all .h files
Get-ChildItem -Recurse -Include "*.h" | ForEach-Object {
    $job = Start-Job -ScriptBlock $jobScriptBlock -ArgumentList $_.FullName
    Wait-Job $job | Out-Null
    Receive-Job $job
    Remove-Job $job
}

# Find and format all .c files
Get-ChildItem -Recurse -Include "*.c" | ForEach-Object {
    $job = Start-Job -ScriptBlock $jobScriptBlock -ArgumentList $_.FullName
    Wait-Job $job | Out-Null
    Receive-Job $job
    Remove-Job $job
}

Write-Host "Formatting complete."

# The execution policy will revert back to its original state after the PowerShell session ends

