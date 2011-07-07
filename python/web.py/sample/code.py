#!/usr/bin/env python

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

