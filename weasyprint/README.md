# Docker Image - PDF printing & excel generator
Can be used in any kind of report engine as export option for data in report.


##  Weasyprint 
Image does not contain fonts. You should use fonts from your linux distribution,
or it would not print report correcty 

Без шрифт не работи като хората, задължително трябва да мапнеш директория, 
На страницата на weasypring пише коит тулове се използват за да се намерия конфигурацията на шрифтовете
/usr/share/fonts/truetype/dejavu/
работната ми дир: /home/vesel/weasyprint

## How to run docker container

docker run -d --name=weasyprint \
    -v /etc/localtime:/etc/localtime \
    -v /home/vesel/weasyprint:/home/root \
    -v /usr/share/fonts/:/root/.fonts \
    -it weasyprint /bin/sh 