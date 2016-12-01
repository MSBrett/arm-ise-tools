# arm-ise-tools
An addon for the Powershell ISE to simplify working with Azure Resource manager

##Setup:

+ Open the Powershell ISE (do not launch it as admin)
+ Run the following snippet to open the ISE profile 
```
    if (!(test-path $profile )) 
    {new-item -type file -path $profile -force} 
    psedit $profile 
```
+ Paste the contents of ARMTools.ps1 into the bottom of the ISE profile
+ Save the profile and relaunch the ISE.