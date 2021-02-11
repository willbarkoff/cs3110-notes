#!/bin/zsh
bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}Removing existing site!${normal}"
rm -rf ./_site
mkdir ./_site

echo ""
echo "${bold}Generating notebook html pages${normal}"

weeks=(week*)
for i in "${weeks[@]}"; do
	:
	mkdir -p _site/$i
done

notebooks=(week*/*.ipynb)
for i in "${notebooks[@]}"; do
	:

	touch _site/${i/ipynb/html}
	jupyter nbconvert --to html $i --stdout >>"_site/${i/ipynb/html}"
done
