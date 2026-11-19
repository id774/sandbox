# app.py: Two Bottle routes, one with a regex path filter
#
# Description:
# Serve two Bottle routes, one matching its path parameter by regex.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 app.py
#
# Requirements:
# - Python 3
# - Bottle
#

from bottle import (
    run,
    route,
    default_app
)

@route('/')
def home():
    return 'Hello Bottle.'

@route('/hello/<param:re:[a-zA-Z]+>')
def hello(param):
    return 'Hello {0}.'.format(param)

if __name__ == "__main__":
    run(host="localhost", port=3001, debug=True, reloader=True)
else:
    application = default_app()
