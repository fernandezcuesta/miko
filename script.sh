# Add EPEL repository
yum install -y epel-release

# Install git and clone remote repositories
# Moved this to early stages to avoid nw outage due to reconfigurations
yum install -y git
git clone https://github.com/robbyrussell/oh-my-zsh.git /usr/share/oh-my-zsh
git clone https://github.com/fernandezcuesta/dotfiles.git

# Install missing packages
yum install -y htop vim nano tmux setroubleshoot-server bash-completion python-psutil zsh
yum groupinstall -y "Basic Web Server"

# Enable serial line output
echo "GRUB_TERMINAL=\"console serial\"" >> /etc/default/grub
grubby --update-kernel=ALL --args="console=ttyS0"

# Add user for vagrant
useradd vagrant -G wheel
echo -e 'vagrant\nvagrant' | passwd vagrant

# Put dotfiles in place
mv dotfiles/nanorc/* /usr/share/nano/
git clone https://github.com/gmarik/Vundle.vim.git dotfiles/.vim/bundle/Vundle.vim
cp -R dotfiles/.vim /root
cp -R dotfiles/.vim /home/vagrant
mv dotfiles/*.tmux /usr/local/bin
for file in dotfiles/.*; do [[ -f $file ]] && cp $file . && cp $file /home/vagrant; done
chown -R vagrant:vagrant /home/vagrant
rm -Rf dotfiles

# Set zsh as default shell
chsh -s `which zsh`
chsh -s `which zsh` vagrant

# Required by vagrant (http://docs.vagrantup.com/v2/boxes/base.html)
sed -i 's/^\(Defaults[[:space:]]\+requiretty\)/#&\t# required by vagrant/' /etc/sudoers
sed -i 's/!visiblepw/visiblepw\t# required by vagrant/' /etc/sudoers
sed -i '/#\+\s*Same thing without a password/a vagrant ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
