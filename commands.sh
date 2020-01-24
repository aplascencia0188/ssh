# ------------------------------------------------
# Server configuration
# ------------------------------------------------
    /etc/ssh/sshd_config


# ------------------------------------------------
# Server Authentication
# ------------------------------------------------
- The public key of the server can be used to authenticate to the client
- /etc/ssh/ssh_host_rsa_key.pub
- It is down to the client to check the key: StrichostkeyChecking
- Server public keys are stored in: 
    /etc/ssh/ssh_known_hosts
    ~/.ssh/known_hosts


# ------------------------------------------------
# Configuring an OpenSSH [SERVER]
# ------------------------------------------------    
# Check the listening TPC ports
netstat -antl
netstat -atl            # without "n" means like without name


grep ssh /etc/services


ss -alt                 # ss --> socket


# See open ports
lsof -i
lsof -i | grep ssh


vim /etc/ssh/sshd_config
    # * modified 
    [AddressFamily Any]     to [AddressFamily inet] # inet = Only IPv4
    [LoginGraceLogin 2m]    to [LoginGraceLogin 1m]
    [PermitRootLogin yes]   to [PermitRootLogin no]

# See the status of the service
systemctl status sshd
systemctl start sshd
systemctl restart sshd


# find some previous command
!ls
!ssh


# ------------------------------------------------
# Configuring an OpenSSH [CLIENT]
# ------------------------------------------------    
# Configuration and Authentication
    /etc/ssh/ssh_config
    StricHostKeyChecking
    ssh_keygen
    ssh-copy-id
    ssh-agent
    PuTTY # Windows

# Client Authentication
- Client public keys are stored in:
    ~/.ssh/authorized_keys      # Copy the public keys and added them


# ------------------------------------------------
#   Server Authentication Using StrictHostKeyCehecking
# ------------------------------------------------    
id

pwd

ls
ls -a

# Create a directory
ssh user@ip-x-x-x-x # and it will create a /.ssh folder

# you can see the public keys
cat ~/.ssh/known_hosts

grep StricHostKeyChecking /ect/ssh/ssh_config


# ------------------------------------------------
#   Public Key Authentication (how to use and generate it)
# ------------------------------------------------    
# Generating a new SSH key
#                           https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# -------------------------
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"


# SSH private key file format must be PEM (for example, use ssh-keygen -m PEM to convert the OpenSSH key into the PEM format)
ssh-keygen -p -m PEM -f ~/.ssh/id_rsa
openssl rsa -in ~/.ssh/id_rsa -outform pem > id_rsa.pem


# How can I change the comment field of an RSA key (SSH)?
ssh-keygen -c -C "my new comment" -f ~/.ssh/my_ssh_key



# Adding your SSH key to the ssh-agent
#   Start the ssh-agent in the background.
eval "$(ssh-agent -s)"  # --> Agent pid 59566

# to the ssh-agent and store your passphrase in the keychain.
ssh-add -K ~/.ssh/id_rsa


# Checking for existing SSH keys
# -------------------------
ls -al ~/.ssh


# Copy the SSH key to your clipboard. Adding a new SSH key to your GitHub account
#                           https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
# -------------------------
pbcopy < ~/.ssh/id_rsa.pub


#  One active SSH key in the ssh-agent at a time
#                           https://www.freecodecamp.org/news/manage-multiple-github-accounts-the-ssh-way-2dadc30ccaca/
# -------------------------
# List all the SSH keys attached to the ssh-agent
ssh-add -l

ssh-add -D                # removes all ssh entries from the ssh-agent
ssh-add ~/.ssh/id_rsa     # Adds the relevant ssh key

    # don't forget to change your local configs like name and email

# We need to copy the public key across to the user that we want to connect to
ssh-copy-id -i ssh-test.pub user-name@ip-192-168-3-3

# We can see the authorized keys in the server
cd ~/.ssh/

cat authorized_keys


# Fire up a new bash shell
ssh-agent bash

# Add into the environment. The private key
ssh-add .ssh/id_rsa   # <-- private key

# List the identities that I have added
ssh-add -l
ssh-add -L


# ------------------------------------------------
#   SSH Tunnels
# ------------------------------------------------    
ssh -f -N -L 80:localhost:80 user@s1.com

# -f    --> we run the command, but we run it in the background
# -N    --> we are not running any commands on the remote host
# -L    --> Specifying that we are going to listen on Port 80.
#           We will be listening on the local host and forwarding to Port 80 on the remote host
            













