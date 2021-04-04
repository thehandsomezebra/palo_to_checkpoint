# Palo Alto to Checkpoint Security Policy Script

This script takes in a csv export from palo and outputs some command lines that could potentially be used by checkpoint. 

I have commented nearly every line, just in case you would like to alter it for your own usages. 
The commenting is, hopefully, very newbie friendly - just in case you're a firewall guru and not a scripting guru.


I hope this helps you out!! 


----

## How to Use

If you are running Mac or Ubuntu, you may do this:
```
wget https://raw.githubusercontent.com/thehandsomezebra/palo_to_checkpoint/main/conversion.sh && source conversion.sh
```

### What it does when you run it:  `source conversion.sh`

It will give you *3* prompts.
1. *It will ask you for the csv that was exported from Palo.* You can enter it in if it's local `the_exported_file.csv` or point to the specific location `~/Users/YourName/Downloads/the_exported_file.csv`
2. *It will ask you if you'd like to include a secret (-s).*  If your secret is in a txt file enter that `id.txt`.  If your secret is a token sitting somewhere else, you can also use `~/.ssh/token`.  I would also say, you could enter in `password` because it _technically could_ work.. but that's totally *not* encrypted, so I will be the first to scold you for dropping your password into a text file! 
3. *It will ask you where to output the file with all your commands.* Typing in just `output.txt` will drop the file from whereever you are running the script from.

#### *This will NOT run the commands. That's up to you to double-check everything and run them!*

_Note: There isn't any error handling for the inputs.. but also, it won't automatically run your commands..so you can just keep re-running it as necessary with `source conversion.sh`._

----

### Notes for Windows Users:

## Option 1: Using Git for Windows (which provides bash!)  *RECOMMENDED*
Make sure you have [Git for Windows](https://gitforwindows.org/) installed. The default settings will give you bash! This is SUPER easy, and it's the method that I'd recommend.


### Option 2: Using WSL & Powershell
This _should_ also work if you are using PowerShell where WSL is enabled.  
If you're running windows (and you can't use wget), [you can download the script by right clicking here and choosing Save File.](https://raw.githubusercontent.com/thehandsomezebra/palo_to_checkpoint/main/conversion.sh)
From there, you should be able to just jump into your [bash-enabled PowerShell environment](https://itsfoss.com/install-bash-on-windows/) and run it. 

I haven't specifically tested Option 2, because in my Windows environments, I went with Option 1 with _Git for Windows_ installed and it just *works*.  I know that this might not be typical in your circumstance (due to security/policy/etc).. so I may investigate other methods in the future.

----
