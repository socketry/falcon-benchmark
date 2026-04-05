#!/bin/sh
exec unicorn -E production -c config.rb
