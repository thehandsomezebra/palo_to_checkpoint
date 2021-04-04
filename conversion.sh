#####################################################
## created by https://github.com/thehandsomezebra/ ##
##     v1   April 3, 2021     new.                 ##   
#####################################################
## This script takes in a csv export from palo     ##
## and outputs something that could potentially    ##
## be used by checkpoint.                          ##
## This script should work in bash environments    ##
## and also powershell.                            ##
## I have commented nearly every line, just in     ##
## case you would like to alter it for your own    ##
## usages.  I hope this helps you out!!            ##
#####################################################
#!/bin/bash

echo "Enter your csv file with full location (example \"input.txt\" or \"~/location/input.txt\"):"
read csvinput
echo "Enter in the location of your secret (example \"secret.txt\" or \"~/location/secret.txt\"):"
echo "(hit enter if you do not want to append your secret)"
read secret
echo "Enter where you'd like the output (example \"output.txt\" or \"~/location/output.txt\"):"
read outputfile
printf -- "running"
printf -- "..."
printf -- "...\n"

#send in with the string to split first and what to split it as second
function SplitWithPrefix() {
    tosplit=$1  #this is the input stuff to split
    prefixword=$2 #this is the prefix we're going to return it with
    splitup=$(echo $tosplit | tr \; \\n | tr -d \") #so we're just replacing the ; with a linebreak...and then we are also going to remove the " character, too
    howmany=$(echo "$splitup" | wc -l) #and we'll count the lines, because that is what will determine if we use "word" or "word.0 word.1" etc
    counter=0 #start the counter at zero
    theconcat=""  #empty it out before we begin
    echo $splitup |  #so we're echoing it..
        while IFS=$'\n' read -r one; do #but we're actually using the special variable Input Field Seperator of a newline to break it up and do stuff with it
            if (( $howmany > 1 )) ; then  #so check if it's a list
                theconcat="${theconcat}${prefixword}.${counter} \"${one}\" "
                counter=$(($counter + 1))
            else  #or if it's just one
                theconcat="${prefixword} \"${one}\" "
            fi
        done
        #in the case for the services + applications, it might output a dupe.. but we know about it, so let's eliminate it.
        #this could be improved to either be placed at the beginning to count how many instances of "any" and just remove them.. and then add just the one "any" back in there
        #not doing it now, because I don't have enough test cases to be comfortable that I wouldn't accidentally screw up "any any" as an input and oops on something like "anymore botany lanyards"
        # theconcat="service.0 \"any\" service.1 \"any\""
        # echo $theconcat
        if [[ $theconcat == "service.0 \"any\" service.1 \"any\"" ]] ; then
            theconcat="service \"any\""
        fi
        printf -- "$theconcat"
        # return "$theconcat"
}

cat $csvinput | tail -n +2 |  #so cat it out.. but skip the first line and start on the second line by tail num +2
                #Headers from the Palo Export are in this order... and IFS is going to read across the csv, putting it all into kind of a 2d array....
    while IFS=$',' read -r empty Name Location Tags Type Source_Zone Source_Address Source_User Source_Device Destination_Zone Destination_Address Destination_Device Application Service Action Profile Options Target Rule_Usage_Rule_Usage Rule_Usage_Apps_Seen Days_With_No_New_Apps Modified Created; do
        #we're going to start composing our lines... printf means it's going to do on one line, unless we do somethin like \n
        #also note, if we need to add in any double quotes, we should escape em

        printf -- "mgmt_cli add access-rule layer \"Network\" "
        printf -- "name $Name "
        #now let's use our SplitWithPrefix function
        sourceoutput=$(SplitWithPrefix $Source_Address "source")
        printf -- "$sourceoutput"
        destinationoutput=$(SplitWithPrefix $Destination_Address "destination")
        printf -- "$destinationoutput"
        #service & application will be concatonated and sent over as "service"
        #also, because of how the service is, we're just going to strip out all application-default
        service_and_application="$Application;${Service/application-default/""}" #so we're concatonating it.. but in the Service, we're replacing instances of application-default with nothing
        #echo $service_and_application
        serviceoutput=$(SplitWithPrefix $service_and_application "service")
        printf -- "$serviceoutput"

        printf -- "position.above \"Cleanup\" "
        if [ $secret ] ; then
            printf -- "-s $secret"
        fi
        printf -- "\n"
    done > $outputfile

echo "Done!  Please see $outputfile"

