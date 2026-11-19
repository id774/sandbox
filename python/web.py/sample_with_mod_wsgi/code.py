#!/usr/bin/env python
# code.py: web.py application served through mod_wsgi
#
# Description:
# Expose a web.py application as a WSGI callable for Apache mod_wsgi,
# rendering templates from /var/www/webpy/sample/templates/. The comment below
# gives the WSGIScriptAlias setting.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - Python 3
# - web.py
# - Apache with mod_wsgi
#

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
