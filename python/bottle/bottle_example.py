# bottle_example.py: Templated greeting route with Bottle
#
# Description:
# Serve a templated greeting route with Bottle.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 bottle_example.py
#
# Requirements:
# - Python 3
# - Bottle
#

from bottle import route, run, template

@route('/hello/:name')
def index(name='World'):
    return template('<b>Hello {{name}}</b>!', name=name)

run(host='localhost', port=3002)
