#!/bin/sh
docker build --rm -t xcgd/odoo:$(hg identify -b) .

