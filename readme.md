# Palo Alto to Checkpoint Security Policy Script

This script takes in a csv export from palo and outputs something that could potentially be used by checkpoint. 
 
This script should work in bash environments and also powershell. 
 
I have commented nearly every line, just in case you would like to alter it for your own usages. 
The commenting is, hopefully, very newbie friendly - just in case you're a firewall guru and not a scripting guru.


I hope this helps you out!! 


----

## How to Use

If you are running Mac or Ubuntu, you may do this:
```
wget https://raw.githubusercontent.com/thehandsomezebra/palo_to_checkpoint/main/conversion.sh && source conversion.sh
```

This should also work if you are using PowerShell where WSL is enabled.