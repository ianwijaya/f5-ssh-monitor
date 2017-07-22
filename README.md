# f5-ssh-monitor

To monitor your SSH server at service level. 
It provides more accurate check than L4 / TCP / TCP-half-open monitor. 



######################################################################################
1. You need to modify several parameters before you can use it.

   user="testf5"   # SSH username that is eligible to do monitoring and to access $dir_to_check directory. 
   cert="/home/admin/my-openssh-key" # you need to generate new ssh key (using ssh-keygen command or puttygen), and upload the PUBLIC key to F5 under this defined directory .
   dir_to_check="~" # Directory to check, which "user" has access to. 
   command="ls -l $dir_to_check | wc -l" # linux command to check the directory. 


2. AFTER changing above parameters, then upload the script into F5 though GUI. 
   (if you are using windows, please do DOS to UNIX conversion make it work) 
   you can upload it via system -> File Management -> External Monitor Program File List 
          
3. Create new monitor (Local traffic -> Monitor) , type “external”. 
   Set interval to 5 seconds, dan timeout 16 seconds.
   You customize it, the rule of thumb is "Timeout = interval * 3 + 1"
    
4. Assign the newly created monitor into SSH pool (Local traffic -> pools)


