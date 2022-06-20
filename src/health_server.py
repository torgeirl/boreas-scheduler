#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import logging
from threading import Thread

log = logging.getLogger(__name__)


class HealthServer(Thread):
    '''Simple HTTP server that runs in the background, answering health requests.'''

    def __init__(self, port):
        Thread.__init__(self)
        self.port = port

    class HealthRequestHandler(BaseHTTPRequestHandler):
        '''Simple HTTP handler that answers readiness and liveness probes.'''

        def do_GET(self):
            if self.path == '/health':
                self.send_response(200)
                self.send_header('Content-type','text/html')
                self.end_headers()
                self.wfile.write(b'OK\n')

        def log_message(self, format, *args):
            log.debug("%s - - [%s] %s\n" % (self.address_string(),
                      self.log_date_time_string(), format%args))

    def run(self):
        server = HTTPServer(('', self.port), self.HealthRequestHandler)
        print('Starting HTTP server on port {}'.format(self.port))
        server.serve_forever()
