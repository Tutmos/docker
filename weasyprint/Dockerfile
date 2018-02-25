FROM alpine:3.7
MAINTAINER Vesel Karastoyanov "VeselK@gmail.com"

ENV WEASYPRINT_VERSION=0.42
ENV PANDAS_VERSION=0.22.0

RUN apk add --update cairo cairo-gobject pango gdk-pixbuf py3-lxml py3-cffi py3-pillow && \
	apk add --no-cache python3-dev && \
	apk add --no-cache --virtual .build-deps g++ && \
	ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    # Nice library for graphic widgets in html
	# pip3 install jupyter && \
    pip3 install numpy==1.14.0 && \
    pip3 install pandas==$PANDAS_VERSION && \
    pip3 install jinja2 && \
    pip3 install xlrd && \ 
    pip3 install weasyprint==$WEASYPRINT_VERSION && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* /tmp/* /root/.cache/pip && find /usr/lib/python3.6 -name '*.pyc' -delete

# ADD rootfs /

CMD [ "weasyprint" ]
# ... save this file as Dockerfile then in same dir issue following
#
# docker build --tag weasyprint .   # creates image stens_ubuntu
#
# docker run -d  stens_ubuntu  sleep infinity # launches container 
#
# docker ps     #   show running containers
#
# 
# ... find CONTAINER ID from above and put into something like this
#
# docker exec -ti 3cea1993ed28 bash   #  login to running container