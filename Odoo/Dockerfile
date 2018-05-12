FROM xcgd/ubuntu4base:xenial
MAINTAINER alexandre.allouche@xcg-consulting.fr

ADD files /

# Add the PostgreSQL PGP key to verify their Debian packages.
RUN apt-key add /var/tmp/ACCC4CF8.asc && rm /var/tmp/ACCC4CF8.asc

RUN apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get -yqq install \
    ca-certificates \
    curl \
    postgresql-client-9.6 \
    python3-pip \
    python3-setuptools \
    python3-renderpm \
    xz-utils \
# BEGIN odoo requirements
    python3-genshi \
    python3-lxml \
    python3-six \
    python3-babel \
    python3-dateutil \
    python3-decorator \
    python3-docutils \
    python3-feedparser \
    python3-gevent \
    python3-html2text \
    python3-jinja2 \
    python3-mako \
    python3-mock \
    python3-ofxparse \
    python3-passlib \
    python3-psutil \
    python3-psycopg2 \
    python3-pydot \
    python3-pyparsing \
    python3-pypdf2 \
    python3-reportlab \
    python3-requests \
    python3-serial \
    python3-usb \
    python3-vatnumber \
    python3-werkzeug \
    python3-xlsxwriter \
    python3-yaml \
    node-less \
    python3-suds \
# END odoo requirements
    liblasso3 python-lasso \
    && curl --silent -o wkhtmltox.tar.xz -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && echo '3f923f425d345940089e44c1466f6408b9619562 wkhtmltox.tar.xz' | sha1sum -c - \
    && tar xf wkhtmltox.tar.xz \
    && cp wkhtmltox/lib/* /usr/local/lib/ \
    && cp wkhtmltox/bin/* /usr/local/bin/ \
    && cp -r wkhtmltox/share/man/man1 /usr/local/share/man/

RUN pip3 install --no-cache-dir --system --only-binary wheel --require-hashes -r /var/tmp/requirements 

# Install Odoo
ENV ODOO_VERSION 11.0
ENV ODOO_RELEASE 20180122
RUN set -x; \
        curl --silent -o odoo.deb -SL http://nightly.odoo.com/${ODOO_VERSION}/nightly/deb/odoo_${ODOO_VERSION}.${ODOO_RELEASE}_all.deb \
        && echo '56f61789bc655aaa2c014a3c5f63d80805408359 odoo.deb' | sha1sum -c - \
        && dpkg --force-depends -i odoo.deb \
        && apt-get update \
        && apt-get -y install -f --no-install-recommends \
	&& apt-get clean \
        && rm -rf /var/lib/apt/lists/* odoo.deb \
        && rm -f /etc/odoo/odoo.conf

VOLUME ["/var/lib/odoo"]
# Set the default entrypoint (non overridable) to run when starting the container
ENTRYPOINT ["/boot"]
CMD ["help"]
# Expose the odoo ports (for linked containers)
EXPOSE 8069 8072
