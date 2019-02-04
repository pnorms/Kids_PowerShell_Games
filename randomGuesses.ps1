cls
$objects = @("Komodo Dragon","Lion","Tiger","Bear","Shark")
$colors = @("Red","Green","Gray","Cyan","Yellow","Magenta")

$peopleCount = Read-Host "How many people are playing?"
$target = 1000

cls
$guesses = @()
for ($i=1; $i -le $peopleCount; $i++){
    $curGuess = "" | Select-Object person,color,object,wins
    $curGuess.wins = 0
    $curGuess.person = Read-Host "Enter your name"
    $curGuess.object = Read-Host "$($curGuess.person) : Pick one: $($objects -join ', ')"
    $curGuess.color = Read-Host "$($curGuess.person) : Enter a color: $($colors -join ', ')"
    $guesses += $curGuess
}

Write-Host "Get ready to play!" -ForegroundColor Yellow
sleep -Seconds 3
$run = $true
while($run)
{
    Clear
    $color = Get-Random $colors
    $object = Get-Random $objects
    Write-Host "$color $object" -ForegroundColor $color
    $winner = $null
    foreach ($guess in $guesses)
    {
        if (($guess.color -ieq $color) -and ($guess.object -ieq $object))
        {
            $guess.wins += 1
            if ($guess.wins -ge $target)
            {
                Write-Host "$($guess.person) WON! Total wins: $($guess.wins), game over" -ForegroundColor Yellow
                $run = $false
            }
            else
            {
                Write-Host "$($guess.person) WON! Total wins: $($guess.wins)" -ForegroundColor Yellow
            }
            $winner+=1
        }
    }
    if ($winner -eq $null)
    {
       Write-Host "No one guessed $object $color, trying again"
    }
    "+"*50
    $guesses | Sort-Object -Property wins -Descending | %{Write-host "$($_.person) : $($_.object); Wins: $($_.wins)" -ForegroundColor $_.color}
    if ($winner)
    {
        sleep -Seconds 2
    }
    else
    {
        sleep -Milliseconds 200
    }
}
