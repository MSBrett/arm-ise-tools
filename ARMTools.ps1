#ARM Tools Begin
#Version: 0.1.0

#Run this to create the profile if it doesn't exist.
<#

if (!(test-path $profile )) 
{new-item -type file -path $profile -force} 
psedit $profile 

#>

function SelectSubscription()
{
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

    $objForm1 = New-Object System.Windows.Forms.Form 
    $objForm1.Text = "Select a Subscription"
    $objForm1.Size = New-Object System.Drawing.Size(300,200) 
    $objForm1.StartPosition = "CenterScreen"

    $objForm1.KeyPreview = $True
    $objForm1.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
        {$x=$objListBox1.SelectedItem;$objForm1.Close()}})
    $objForm1.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
        {$objForm1.Close()}})

    $OKButton1 = New-Object System.Windows.Forms.Button
    $OKButton1.Location = New-Object System.Drawing.Size(75,120)
    $OKButton1.Size = New-Object System.Drawing.Size(75,23)
    $OKButton1.Text = "OK"
    $OKButton1.Add_Click({$x=$objListBox1.SelectedItem;$objForm1.Close()})
    $objForm1.Controls.Add($OKButton1)

    $CancelButton1 = New-Object System.Windows.Forms.Button
    $CancelButton1.Location = New-Object System.Drawing.Size(150,120)
    $CancelButton1.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton1.Text = "Cancel"
    $CancelButton1.Add_Click({$objForm1.Close()})
    $objForm1.Controls.Add($CancelButton1)

    $objLabel1 = New-Object System.Windows.Forms.Label
    $objLabel1.Location = New-Object System.Drawing.Size(10,20) 
    $objLabel1.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel1.Text = "Please select a subscription:"
    $objForm1.Controls.Add($objLabel1) 

    $objListBox1 = New-Object System.Windows.Forms.ListBox 
    $objListBox1.Location = New-Object System.Drawing.Size(10,40) 
    $objListBox1.Size = New-Object System.Drawing.Size(260,20) 
    $objListBox1.Height = 80

    $subscriptions = Get-AzureRmSubscription
    foreach ($subscription in $subscriptions)
    {
        [void] $objListBox1.Items.Add($subscription.SubscriptionName)
    }

    $objForm1.Controls.Add($objListBox1) 
    $objForm1.Topmost = $True
    $objForm1.Add_Shown({$objForm1.Activate()})
    [void] $objForm1.ShowDialog()


    Select-AzureRmSubscription -SubscriptionName $objListBox1.SelectedItem
    $objForm1.Dispose()
}

function StartRGVMs()
{
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

    $objForm2 = New-Object System.Windows.Forms.Form 
    $objForm2.Text = "Select a Resource Group"
    $objForm2.Size = New-Object System.Drawing.Size(300,200) 
    $objForm2.StartPosition = "CenterScreen"

    $objForm2.KeyPreview = $True
    $objForm2.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
        {$x=$objListBox2.SelectedItem;$objForm2.Close()}})
    $objForm2.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
        {$objForm2.Close()}})

    $OKButton2 = New-Object System.Windows.Forms.Button
    $OKButton2.Location = New-Object System.Drawing.Size(75,120)
    $OKButton2.Size = New-Object System.Drawing.Size(75,23)
    $OKButton2.Text = "OK"
    $OKButton2.Add_Click({$x=$objListBox2.SelectedItem;$objForm2.Close()})
    $objForm2.Controls.Add($OKButton2)

    $CancelButton2 = New-Object System.Windows.Forms.Button
    $CancelButton2.Location = New-Object System.Drawing.Size(150,120)
    $CancelButton2.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton2.Text = "Cancel"
    $CancelButton2.Add_Click({$objForm2.Close()})
    $objForm2.Controls.Add($CancelButton2)

    $objLabel2 = New-Object System.Windows.Forms.Label
    $objLabel2.Location = New-Object System.Drawing.Size(10,20) 
    $objLabel2.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel2.Text = "Please select a Resource Group:"
    $objForm2.Controls.Add($objLabel2) 

    $objListBox2 = New-Object System.Windows.Forms.ListBox 
    $objListBox2.Location = New-Object System.Drawing.Size(10,40) 
    $objListBox2.Size = New-Object System.Drawing.Size(260,20) 
    $objListBox2.Height = 80

    $rgs = Get-AzureRmResourceGroup
    foreach ($rg in $rgs)
    {
        [void] $objListBox2.Items.Add($rg.ResourceGroupName)
    }

    $objForm2.Controls.Add($objListBox2) 
    $objForm2.Topmost = $True
    $objForm2.Add_Shown({$objForm2.Activate()})
    [void] $objForm2.ShowDialog()

    if(!$null -eq $objListBox2.SelectedItem)
    {
        $vms = Get-AzureRmVm -ResourceGroupName $objListBox2.SelectedItem

        foreach ($vm in $vms)
        {
            Write-host ("Starting VM " + $vm.Name)
            $vm | Start-AzureRmVM
        }
    }

    $objForm2.Dispose()
}

function StopRGVMs()
{
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 

    $objForm2 = New-Object System.Windows.Forms.Form 
    $objForm2.Text = "Select a Resource Group"
    $objForm2.Size = New-Object System.Drawing.Size(300,200) 
    $objForm2.StartPosition = "CenterScreen"

    $objForm2.KeyPreview = $True
    $objForm2.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
        {$x=$objListBox2.SelectedItem;$objForm2.Close()}})
    $objForm2.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
        {$objForm2.Close()}})

    $OKButton2 = New-Object System.Windows.Forms.Button
    $OKButton2.Location = New-Object System.Drawing.Size(75,120)
    $OKButton2.Size = New-Object System.Drawing.Size(75,23)
    $OKButton2.Text = "OK"
    $OKButton2.Add_Click({$x=$objListBox2.SelectedItem;$objForm2.Close()})
    $objForm2.Controls.Add($OKButton2)

    $CancelButton2 = New-Object System.Windows.Forms.Button
    $CancelButton2.Location = New-Object System.Drawing.Size(150,120)
    $CancelButton2.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton2.Text = "Cancel"
    $CancelButton2.Add_Click({$objForm2.Close()})
    $objForm2.Controls.Add($CancelButton2)

    $objLabel2 = New-Object System.Windows.Forms.Label
    $objLabel2.Location = New-Object System.Drawing.Size(10,20) 
    $objLabel2.Size = New-Object System.Drawing.Size(280,20) 
    $objLabel2.Text = "Please select a Resource Group:"
    $objForm2.Controls.Add($objLabel2) 

    $objListBox2 = New-Object System.Windows.Forms.ListBox 
    $objListBox2.Location = New-Object System.Drawing.Size(10,40) 
    $objListBox2.Size = New-Object System.Drawing.Size(260,20) 
    $objListBox2.Height = 80

    $rgs = Get-AzureRmResourceGroup
    foreach ($rg in $rgs)
    {
        [void] $objListBox2.Items.Add($rg.ResourceGroupName)
    }

    $objForm2.Controls.Add($objListBox2) 
    $objForm2.Topmost = $True
    $objForm2.Add_Shown({$objForm2.Activate()})
    [void] $objForm2.ShowDialog()
    if(!$null -eq $objListBox2.SelectedItem)
    {
        $vms = Get-AzureRmVm -ResourceGroupName $objListBox2.SelectedItem -Status
        foreach ($vm in $vms)
        {
            if (!$vm.PowerState -match "deallocated")
            {
                Write-host ("Stopping VM " + $vm.Name)
                $vm | Stop-AzureRmVM -Force
            }
            else
            {
                Write-host ($vm.Name + " state = " + $vm.PowerState)
            }
        }
    }

    $objForm2.Dispose()
}

function StopAllVMs()
{
    $OUTPUT= [System.Windows.Forms.MessageBox]::Show("Stop ALL VMs?" , "Status" , 4) 
    if ($OUTPUT -eq "YES" ) 
    {
        $vms = Get-AzureRmVm -Status
        foreach ($vm in $vms)
        {
            if($vm.PowerState.ToString() -notmatch "deallocated")
            {
                Write-host ("Stopping VM " + $vm.Name)
                $vm | Stop-AzureRmVM -Force
            }
            else
            {
                Write-host ($vm.Name + " = " + $vm.PowerState)
            }
        }
    } 
}

$ArmRoot = $psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add("Azure Resource Manager",$null,$null) 
$ArmRoot.Submenus.Add("ARM Login",{Login-AzureRmAccount}, $null) 
$ArmRoot.Submenus.Add("Select ARM Subscription",{SelectSubscription}, $null)
$ArmRoot.Submenus.Add("Start all VM(s) in RG",{StartRGVMs}, $null) 
$ArmRoot.Submenus.Add("Stop all VM(s) in RG",{StopRGVMs}, $null) 
$ArmRoot.Submenus.Add("Stop all VM(s) in subscription",{StopAllVMs}, $null) 

#ARM Tools End