
Function Invoke-AsyncAudit
    {
        Param(
        [Parameter( Position = 0, Mandatory = $true )]
        [string]
        $Out)
		
		$PowerlinePath = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
		Write-Host $PowerlinePath
		
		$a = { 
			param($Out,$PowerlinePath); 
			$outPath = "$($Out)\$($env:computername)-sysinfo.txt"
			& "sysinfo" | Out-File -Append $outPath 
		}
		Start-Job $a -ArgumentList $Out,$PowerlinePath
		
		$b = { 
			param($Out,$PowerlinePath);
			$outPath = "$($Out)\$($env:computername)-Sherlock-Find-AllVulns.txt"
			"Sherlock Started" | Out-File -Append $outPath
			& "$($PowerlinePath)" Sherlock Find-AllVulns | Out-File -Append $outPath
			"Sherlock Finished" | Out-File -Append $outPath
		}
		Start-Job $b -ArgumentList $Out,$PowerlinePath
		
		$c = { 
			param($Out,$PowerlinePath);
			$outPath = "$($Out)\$($env:computername)-PowerUp-Invoke-AllChecks.txt"
			"PowerUp Invoke-AllChecks Started" | Out-File -Append $outPath
			& "$($PowerlinePath)" PowerUp Invoke-AllChecks | Out-File -Append $outPath
			"PowerUp Invoke-AllChecks Finished" | Out-File -Append $outPath
		}
		Start-Job $c -ArgumentList $Out,$PowerlinePath
		
		$d = { 
			param($Out,$PowerlinePath);
			$outPath = "$($Out)\$($env:computername)-jaws-enum.txt"
			"jaws-enum Started" | Out-File -Append $outPath
			& "$($PowerlinePath)" jaws-enum | Out-File -Append $outPath
			"jaws-enum Finished" | Out-File -Append $outPath
			
		}
		Start-Job $d -ArgumentList $Out,$PowerlinePath
		
		$e = { 
			param($Out,$PowerlinePath);
			$outPath = "$($Out)\$($env:computername)-WindowsEnum.txt"
			"WindowsEnum Started" | Out-File -Append $outPath
			& "$($PowerlinePath)" WindowsEnum | Out-File -Append $outPath
			"WindowsEnum Finished" | Out-File -Append $outPath
			
		}
		Start-Job $e -ArgumentList $Out,$PowerlinePath
		
		
		Get-Job | Wait-Job
		
		#{ Write-Host "Sherlock Started" | Out-File -Append "$Out\Sherlock-Find-AllVulns.txt" }.Invoke()
		#{ & start /b .\powerline.exe Sherlock Find-AllVulns | Out-File -Append "$Out\Sherlock-Find-AllVulns.txt" }.Invoke()
		
	}