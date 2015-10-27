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
