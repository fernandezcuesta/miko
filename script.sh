# Add EPEL repository
yum install -y epel-release

# Install missing packages
yum install -y htop vim nano tmux setroubleshoot-server bash-completion 
yum groupinstall -y "Basic Web Server"

# Enable serial line output
echo "GRUB_TERMINAL=\"console serial\"" >> /etc/default/grub
grubby --update-kernel=ALL --args="console=ttyS0"

# Enable tmux loading
cat >> /root/.bashrc << EOT
if [[ $EUID -ne 0 ]] && [[ -z "$TMUX" ]] ;then
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux -2 new-session
    else
        tmux -2 attach-session -t "$ID" # if available attach to it
    fi
fi
EOT
