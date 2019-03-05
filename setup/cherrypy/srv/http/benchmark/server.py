#!/usr/bin/env python

import cherrypy, time

SMALL = "Hello World\n" * 10 * 10
LARGE = "Hello World\n" * 100 * 100

class Benchmark(object):
	@cherrypy.expose
	def small(self):
		return SMALL
	
	@cherrypy.expose
	def large(self):
		return LARGE
	
	@cherrypy.expose
	def blocking(self):
		time.sleep(0.01)
		return SMALL
		
	@cherrypy.expose
	def nonblocking(self):
		time.sleep(0.01)
		return SMALL

cherrypy.config.update({
	'server.socket_host': '::',
	'server.socket_port': 80,
})

# Don't log every request:
access_log = cherrypy.log.access_log
for handler in tuple(access_log.handlers):
	access_log.removeHandler(handler)

cherrypy.quickstart(Benchmark())
