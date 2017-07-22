# f5-ssh-monitor

To monitor your SSH server at service level. 
It provides more accurate check than L4 / TCP / TCP-half-open monitor. 



######################################################################################
1. You need to modify several parameters before you can use it.

   user="testf5"   # SSH username that is eligible to do monitoring and to access $dir_to_check directory. 
   
   cert="/home/admin/my-openssh-key" # you need to generate new ssh key (using ssh-keygen command or puttygen), and upload the PUBLIC key to F5 under this defined directory. while the PRIVATE KEY has to be planted to all "to-be-monitored" SSH servers. 
 
 
   dir_to_check="~" # Directory to check, which "user" has access to. 
   
   command="ls -l $dir_to_check | wc -l" # linux command to check the directory. 


2. AFTER changing above parameters, upload this script into BIG-IP through GUI. 
   (if you are using windows, please do DOS to UNIX conversion to make it work) 
   you can upload it via system -> File Management -> External Monitor Program File List 
          
3. Create new monitor (Local traffic -> Monitor) , type “external”, choose the uploaded script.
   Set interval to 5 seconds, dan timeout 16 seconds.
   You can customize it tho, the rule of thumb is "Timeout = interval * 3 + 1"
    
4. Assign your newly modified monitor to SSH pool monitor (Local traffic -> pools)


