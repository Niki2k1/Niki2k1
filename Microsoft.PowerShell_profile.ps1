function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host " ($branch)" -ForegroundColor "red" -NoNewline
        }
        else {
            # we're on an actual branch, so print it
            Write-Host " ($branch)" -ForegroundColor "DarkCyan" -NoNewline
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host " (no branches yet)" -ForegroundColor "yellow" -NoNewline
    }
}

function prompt {
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = " $('→' * ($nestedPromptLevel + 1)) "

    Write-Host "$($env:UserName)" -ForegroundColor "cyan" -NoNewline
    Write-Host "@" -NoNewLine
    Write-Host "$($env:ComputerName) " -ForegroundColor "DarkRed" -NoNewLine

    if (Test-Path .git) {
        Write-Host $path -ForegroundColor "green" -NoNewLine
        Write-BranchName
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        Write-Host $path -ForegroundColor "green" -NoNewLine
    }

    return $userPrompt
}
