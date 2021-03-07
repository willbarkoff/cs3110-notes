#!/bin/zsh
bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}Removing existing site!${normal}"
rm -rf ./3110
mkdir ./3110
echo "done!"

echo ""
echo "${bold}Generating notebook html pages${normal}"

weeks=(week*)
for i in "${weeks[@]}"; do
	:
	mkdir -p 3110/$i
done

notebooks=(week*/*.ipynb)
for i in "${notebooks[@]}"; do
	:

	touch 3110/${i/ipynb/html}
	jupyter nbconvert --to html $i --stdout >>"3110/${i/ipynb/html}"
done
echo "done!"
echo ""

echo "${bold}Would you like to upload these notes to the server?${normal}"
while true; do
	read input\?"Type y or n for yes or no> "

	case $input in
	[yY][eE][sS] | [yY])
		break
		;;
	[nN][oO] | [nN])
		exit 0
		;;
	*)
		echo "Invalid input. Type y or n."
		;;
	esac
done

scp -r ./3110 wserve:/var/www/notes/cs
echo "done!"
