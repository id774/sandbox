#!/usr/bin/env python
# code.py: Templated page served with web.py
#
# Description:
# Serve a templated page with web.py.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 code.py
#
# Requirements:
# - Python 3
# - web.py
#

import web

class index:

    def GET(self, name):
        i = web.input(name=None)
        return render.index(i.name)

urls = (
    '/(.*)', 'index'
)

app = web.application(urls, globals())
render = web.template.render('templates/')

if __name__ == "__main__":
    app.run()
