#!/usr/bin/env python

# Add following to /etc/apache2/conf.d/mod_wsgi.conf
#WSGIScriptAlias /sample /var/www/webpy/sample/code.py

import web

class index:

    def GET(self, name):
        i = web.input(name=None)
        return render.index(i.name)

urls = (
    '/(.*)', 'index'
)

#application = web.application(urls, globals())
application = web.application(urls, globals()).wsgifunc()

render = web.template.render('/var/www/webpy/sample/templates/')

if __name__ == "__main__":
    application.run()
