#!/usr/bin/env bash

echo "Welcome to the automatic utility installer !"

if [ -f "/etc/debian_version" ]; then
	echo "Debian-like detected"
	echo "Installing basic tools to install the rest"
	sudo apt-get install --yes zsh wget curl gzip p7zip-full gpg tree neofetch
	echo "Done"
elif grep -q -Ei 'fedora|redhat' /etc/*release; then
	echo "RHEL-like detected"
	echo "Installing basic tools to install the rest"
	sudo yum install --yes zsh wget curl gzip p7zip-full gpg tree neofetch
	echo "Done"
else
	echo "Distro not found, please specify a packet manager"
	exit 1
fi

echo "This needs to run sudo many times for installs"
sudo echo "Sudo unlocked successfuly"

echo "#####################################################"
echo "Installing oh-my-zsh using the automatic installer:"
echo -e "\tBackuping original .zshrc"
mv $HOME/.zshrc $HOME/.zshrc_while_installing_ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv $HOME/.zshrc_while_installing_ohmyzsh $HOME/.zshrc

echo "#####################################################"
echo -n "Changing default shell to zsh... "
sudo chsh -s $(which zsh) $USER
echo "Done"

echo "#####################################################"
echo "Installing pyenv using the automatic pyenv installer:"
curl https://pyenv.run | bash
pyenv --version

echo "#####################################################"
echo -n "Installing tldr (go client)... "
wget -O /tmp/tldr.tar.gz "https://github.com/pranavraja/tldr/releases/download/v1/tldr_linux_amd64.tar.gz" -q
tar -xzf /tmp/tldr.tar.gz -C /tmp
sudo mv /tmp/tldr_linux_amd64/tldr /usr/bin/tldr
rm -rf /tmp/tldr.tar.gz /tmp/tldr_linux_amd64
echo "Done"
tldr

echo "#####################################################"
echo -n "Installing fdfind v8.1.1... "
wget -O /tmp/fd.tar.gz "https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-v8.1.1-x86_64-unknown-linux-musl.tar.gz" -q
tar -xzf /tmp/fd.tar.gz -C /tmp
sudo mv /tmp/fd-v8.1.1-x86_64-unknown-linux-musl/fd /usr/bin/fd
rm -rf /tmp/fd.tar.gz /tmp/fd-v8.1.1-x86_64-unknown-linux-musl
echo "Done"
fd --version

echo "#####################################################"
echo -n "Installing exa v0.9.0... "
wget -O /tmp/exa.zip "https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip" -q
unzip /tmp/exa.zip -d /tmp >/dev/null 2>&1
sudo mv /tmp/exa-linux-x86_64 /usr/bin/exa
rm -rf /tmp/exa.zip
echo "Done"
exa --version

echo "#####################################################"
echo -n "Installing bat v0.15.4... "
wget -O /tmp/bat.tar.gz "https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-v0.15.4-x86_64-unknown-linux-gnu.tar.gz" -q
tar -xzf /tmp/bat.tar.gz -C /tmp
sudo mv /tmp/bat-v0.15.4-x86_64-unknown-linux-gnu/bat /usr/bin/bat
rm -rf /tmp/bat.tar.gz /tmp/bat-v0.15.4-x86_64-unknown-linux-gnu
echo "Done"
bat --version

echo "#####################################################"
echo -n "Installing ripgrep v12.1.1... "
wget -O /tmp/ripgrep.tar.gz "https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz" -q
tar -xzf /tmp/ripgrep.tar.gz -C /tmp
sudo mv /tmp/ripgrep-12.1.1-x86_64-unknown-linux-musl/rg /usr/bin/rg
rm -rf /tmp/ripgrep.tar.gz /tmp/ripgrep-12.1.1-x86_64-unknown-linux-musl
echo "Done"
rg --version

echo "#####################################################"
echo -n "Installing shfmt v3.1.2... "
wget -O /tmp/shfmt "https://github.com/mvdan/sh/releases/download/v3.1.2/shfmt_v3.1.2_linux_amd64" -q
sudo mv /tmp/shfmt /usr/bin/shfmt
echo "Done"
echo "shfmt $(shfmt --version)"

echo "#####################################################"
echo -n "Installing shellcheck v0.7.1... "
wget -O /tmp/shellcheck.tar.xz "https://github.com/koalaman/shellcheck/releases/download/v0.7.1/shellcheck-v0.7.1.linux.x86_64.tar.xz" -q
tar -xf /tmp/shellcheck.tar.xz -C /tmp
sudo mv /tmp/shellcheck-v0.7.1/shellcheck /usr/bin/shellcheck
rm -rf /tmp/shellcheck.tar.xz /tmp/shellcheck-v0.7.1
echo "Done"
shellcheck --version

echo "#####################################################"
echo "Upgrading pip... "
pip3 install -U pip3

echo "#####################################################"
echo "Installing python libs... "
pip3 install -U numpy Pillow scikit-image scikit-learn pandas opencv-python opencv-contrib-python black h5py ipywidgets jupyter jupyterlab tqdm requests poetry flask jsonschema beautifulsoup4 ipaddress urllib3 paramiko matplotlib tensorflow torch spacy statsmodels numpydoc keras
echo "Done"

echo "#####################################################"
echo "Everything done installing"
