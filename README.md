![cannot access S3](https://s3.amazonaws.com/lambci-buildresults-1hwrcockds8l7/gh/sgluss/hugoSite/branches/master/a018f06c26962bd9adc429756dfb09ad.svg "LambCI Build State")

# HugoSite
This repo is deployed to S3 via LambCI!

# dependencies
## theme: after-dark
git submodule add https://codeberg.org/vhs/after-dark.git samHomePage/themes

## theme: fractal-forest
npm i fractal-forest
cp -r node_modules/fractal-forest/ themes/
rm -rf node_modules/
rm package-lock.json 

## CSSBox
wget https://raw.githubusercontent.com/TheLastProject/CSSBox/master/cssbox.css -O samHomePage/themes/after-dark/assets/css/cssbox.css
