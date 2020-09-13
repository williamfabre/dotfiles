#!/usr/bin/env bash

whichOrFail(){
    if ! which $1; then
        echo "Program $1 not found !"
        exit 1
    else
        which $1
    fi
}

if [ -f "/etc/debian_version" ]; then
    echo "Debian-like detected"
    echo "Installing basic tools to install the rest"
    sudo apt-get install --yes zsh wget curl gzip p7zip-full gpg tree
    echo "Done"
elif [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
    echo "RHEL-like detected"
    echo "Installing basic tools to install the rest"
    sudo yum install --yes zsh wget curl gzip p7zip-full gpg tree
    echo "Done"
else
    echo "Distro not found, please specify a packet manager"
    exit 1
fi

echo "This needs to run sudo many times for installs"
sudo echo "Sudo unlocked successfuly"


echo "Installing oh-my-zsh using the automatic installer:"
echo -e "\tBackuping original .zshrc"
mv $HOME/.zshrc $HOME/.zshrc_while_installing_ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $HOME/.zshrc_while_installing_ohmyzsh $HOME/.zshrc 

echo "Installing pyenv using the automatic pyenv installer:"
curl https://pyenv.run | bash
pyenv --version

echo -n "Installing tldr (go client)... "
wget -O /tmp/tldr.tar.gz "https://github.com/pranavraja/tldr/releases/download/v1/tldr_linux_amd64.tar.gz" -q
tar -xzf /tmp/tldr.tar.gz -C /tmp
sudo mv /tmp/tldr_linux_amd64/tldr /usr/bin/tldr
rm -rf /tmp/tldr.tar.gz /tmp/tldr_linux_amd64
echo "Done"
tldr

echo -n "Installing fdfind... "
wget -O /tmp/fd.tar.gz "https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-v8.1.1-x86_64-unknown-linux-musl.tar.gz" -q
tar -xzf /tmp/fd.tar.gz -C /tmp
sudo mv /tmp/fd-v8.1.1-x86_64-unknown-linux-musl/fd /usr/bin/fd
rm -rf /tmp/fd.tar.gz /tmp/fd-v8.1.1-x86_64-unknown-linux-musl
echo "Done"
fd --version

echo -n "Installing exa... "
wget -O /tmp/exa.zip "https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip" -q
unzip /tmp/exa.zip -d /tmp > /dev/null 2>&1
sudo mv /tmp/exa-linux-x86_64 /usr/bin/exa
rm -rf /tmp/exa.zip
echo "Done"
exa --version

echo -n "Installing bat... "
wget -O /tmp/bat.tar.gz "https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-v0.15.4-x86_64-unknown-linux-gnu.tar.gz" -q
tar -xzf /tmp/bat.tar.gz -C /tmp
sudo mv /tmp/bat-v0.15.4-x86_64-unknown-linux-gnu/bat /usr/bin/bat
rm -rf /tmp/bat.tar.gz /tmp/bat-v0.15.4-x86_64-unknown-linux-gnu
echo "Done"
bat --version

echo -n "Installing ripgrep... "
wget -O /tmp/ripgrep.tar.gz "https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz" -q
tar -xzf /tmp/ripgrep.tar.gz -C /tmp
sudo mv /tmp/ripgrep-12.1.1-x86_64-unknown-linux-musl/rg /usr/bin/rg
rm -rf /tmp/ripgrep.tar.gz /tmp/ripgrep-12.1.1-x86_64-unknown-linux-musl
echo "Done"
rg --version

echo -n "Installing python libs... "
pip3 install -U numpy Pillow scikit-image scikit-learn pandas opencv-python opencv-contrib-python black h5py ipywidgets jupyter jupyterlab tqdm requests poetry flask jsonschema beautifulsoup4 ipaddress urllib3 paramiko matplotlib tensorflow torch spacy statsmodels numpydoc keras
echo "Done"

echo "Everything done installing"
echo -n "Changing shell to zsh... "
sudo chsh -s $(which zsh) $USER
echo "Done"
