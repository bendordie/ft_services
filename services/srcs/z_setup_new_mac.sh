pc_name=$HOSTNAME
echo "Запускаем установку minikube для $pc_name\n" | sed 's/.kzn.21-school.ru//'
if brew ls --versions > /dev/null; then
	echo "Homebrew установлен\n"
	cd ~
else
	echo "Homebrew не установлен. Запускаем установку...\n"
	curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh
	cd ~
fi
minikube delete
rm -rf ~/.minikube
rm -rf ~/goinfre/.minikube
brew remove minikube
brew install minikube
cd ~
brew unlink minikube
brew link minikube
mkdir -p .minikube
mv .minikube ./goinfre
ln -s ./goinfre/.minikube .minikube
