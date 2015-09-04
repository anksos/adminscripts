# Enable RDP on Core server 2012 deployment:
1. We have a CMD by default -> cmd> cscript scregedit.wsf /AR /v
if it is 1 is not enabled RDP
2. we run again cmd> cscript scregedit.wsf /AR 0

# Install/Enabled server manager on Core Server deployment
1. on cmd> powershell
2. PS> Import-Module ServerManager
3. PS> Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell -Restart

# Uninstall Server Gui Shell to have minimal windows server 2012 deployment
PS> Uninstall-WindowsFeature Server-Gui-Shell -Restart
# Install Server Gui Shell to have Full GUI
PS> Install-WindowsFeature Server-Gui-Shell -Restart

# Configure Static IP address on Server Core deployment
cmd> netsh interface ipv4 show interfaces
cmd> netsh interface ipv4 set address name=<ethernet> source=static address=10.0.0.1 mask=255.255.255.0 gateway 10.0.0.10
cmd> netsh interface ipv4 add dnsserver name=<ethernet> address=8.8.8.8 index=1 (1 for the primary dns server)

# Change computer name on Server Core deployment
cmd> netdom renamecomputer %computername% /newname:VMPokopikos /userd:Administrator /password:<the_pass> /reboot:0

# Add to the domain on Server Core deployment
cmd> netdom join %computername% /domain:interworks.eu /userd:Administrator /password:<the_pass> /reboot:5

# Create account on Server Core deployment
cmd> net user Ankso /add *

# Add to Localadmin accounts on Server Core deployment
cmd> net localgroup Administrators /add Trainer

# Disable firewall on Core Server deployment
cmd> netsh advfirewall set allprofiles state off

# Take IP address from Hyper-V for all the VMs
PS> Get-VM | select -ExpandProperty networkadapters| select vmname, ipaddresses

# How to get the Vlan id from a specific VM
PS> Get-VM 'Name of the VM' | Get-VMNetworkAdapterVlan | fl *

# Get Mac address for all network adapters on Windows Server 2012 R2
PS> Get-NetAdapter

# Get the .NET Framework that is instlled
PS> Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse | Get-ItemProperty -name Version -EA 0 | Where { $_.PSChildName -match '^(?!S)\p{L}'} | Select PSChildName, Version

# Add target to Trusted Hosts List for managing Non-Domain Joined computers
PS> Set-Item wsman:\localhost\Client\TrustedHosts fqdn.domain.net -Concatenate -Force  

# Install ADDS (Active Directory Domain Services)  
PS> Install-WindowsFeature -name AD-Domain-Services

# Install ADDS Forest
PS> Install-ADDSForest -domainname "domain1.com"

# Uninstall ADDS Domain Controller
PS> Uninstall-addsdomaincontroller

# Restore SRV records after deletion
cmd> nltest /dsregdns

# Common IPv4 Ports
80 tcp HTTP, 443 tcp HTTPS, 20/21 tcp FTP, 110 tcp POP, 25 tcp SMTP, 23 tcp Telnet, 162 tcp SNMP Trap, 161 udp SNMP, 143 tcp/udp IMAP, 53 tcp/udp DNS

# IPv6  
Loopback/localhost ::1, Default gateway ::/0 (ping :: or ping ::1)

# Powershell session
Enter-PSSesion -ComputerName <ServerName> eg PS> Enter-PSSession -ComputerName web01

# How to find the computers that restarted in the last 2 weeks
PS> Get-ADComputer "virtual1" -Properties lastlogondate

