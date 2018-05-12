# A *production-ready* image for Odoo 7 & 8 & 10 & 11

This image weighs just over 1.6Gb. Keep in mind that Odoo is a very extensive suite of business applications written in Python. We designed this image with built-in external dependencies and almost nothing useless. It is used from development to production on version 7.0 and 8.0 with various community addons.

Check the [BitBucket project page][2] for contributing, discussing and reporting issues.
This README is updated with regards to your questions. Thank you for your help!

# Odoo version

This docker builds with a *tested* version of Odoo (formerly OpenERP) AND related dependencies. We do not intend to *follow the git*. The packed versions of Odoo have always been tested against our CI chain and are considered as *production grade*.

This is important to do in this way (as opposed to a nightly build) because we want to ensure reliability and keep control of external dependencies.

There is several [tags on this image](https://hub.docker.com/r/xcgd/odoo/tags/), and those are the odoo version used:

* xcgd/odoo:7.0 is based on tag a0484cbe45abb5dc393d3229ee1c6d24a4dfae23 of https://github.com/odoo/odoo from branch 7.0
* xcgd/odoo:8.0 is based on tag 859fe655d295b83d86d5969e301b8f6bcc61c2d1 of https://github.com/odoo/odoo from branch 8.0
* xcgd/odoo:10.0 is based on tag 159bcf3cc23c4317313a861201b2bd8e13009641 of https://github.com/odoo/odoo from branch 10.0
* xcgd/odoo:11.0.20180122, xcgd/odoo:11.0 is based on [nightly build](http://nightly.odoo.com/11.0/nightly/deb/) 20180122 (branch 11.0)

# Prerequisites

## Postgresql

You'll need a postgresql database server. You can use [xcgd/postgresql][1] docker image or any other PostgreSQL image of your choice:

    docker run --name="pg" xcgd/postgresql:9.6

Note: read the instructions on how to use this image with data persistance.

# Start Odoo

Run Odoo in the background, assuming you named your PostgreSQL container `pg` and target Odoo version 7.0:

    docker run -p 8069:8069 --rm --name="xcgd.odoo" --link pg:db xcgd/odoo:7.0 start

WARNING: note that we aliased the PostgreSQL as `db`. This is arbitrary since we use this alias in the configuration files.

If docker starts without issues, just open your favorite browser and point it to http://localhost:8069	

The default admin password is `somesuperstrongadminpasswdYOUNEEDTOCHANGEBEFORERUNNING`.

If no configuration file exists, a default configuration file is copied.
If you want to use a specific configuration file, you can use the environment variable `ODOO_CONF`:

    docker run -e ODOO_CONF=/etc/openerp.conf --name="xcgd.odoo" -v /opt/odoo/instance1/etc:/opt/odoo/etc -p 8069:8069 --link pg:db -d xcgd/odoo:8.0 start

## Odoo 7, 8, and 10 images

The tar of odoo 7 and 8 is built with:

    tar czf ../odoo${version}.tgz *

You may use your own sources simply by binding your local Odoo folder to `/opt/odoo/sources/odoo/`.

The configuration path defaults to `/opt/odoo/etc/odoo.conf`.

The *addons path* uses `/opt/odoo/additional_addons`, custom modules are expected to be in this directory.

Local file system store defaults to `/opt/odoo/data`, this is a volume of the image.

By default the image does not chown the file in `/opt/odoo` anymore, if you need to run it, set the environment variable `ODOO_CHOWN` to `true`.

## Odoo 11 image

The configuration path defaults to `/etc/odoo/odoo.conf`. This should be readable to the odoo user.

The *addons path* uses `/mnt/extra_addons`, custom modules are expected to be in this directory. This should be readable to the odoo user, writable to have compiled python file in it.

Local file system store defaults to `/var/lib/odoo`, this is a volume of the image. This directory should be writable to the odoo user.

# Security Notes

You'll note that we did not open ports to the outside world on the PostgreSQL container. This is for security reasons, NEVER RUN your PostgreSQL container with ports open to the outside world... Just `--link` the Odoo container (single host), use an ambassador pattern (cluster), or use a local port on the machine that is protected by a firewall.

This is really important to understand. The default configuration of our PostgreSQL is configured to trust everyone so better keep it firewalled. And before yelling madness please consider this: If someone gains access to your host and is able to launch a container and open a port for himself he's got your data anyways... he's on your machine. So keep that port closed and secure your host. Your database is as safe as your host is, no more.

To prevent any data corruption during an image build, we use SHA256 algorithm to check file integrity of odoo archive and python requirement packages.

  [1]: https://registry.hub.docker.com/u/xcgd/postgresql/
  [2]: https://bitbucket.org/xcgd/odoo
