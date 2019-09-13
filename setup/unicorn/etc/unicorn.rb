
require 'etc'
worker_processes Etc.nprocessors

timeout 60

preload_app true
