#!/bin/bash

pelican-themes --install themes/bootstrap-next
make clean
make html

