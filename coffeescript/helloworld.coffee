# helloworld.coffee: Express greeting server in CoffeeScript
#
# Description:
# Serve Hello World from Express at the root path.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee helloworld.coffee
#
# Requirements:
# - CoffeeScript with Node.js
# - Express 2, which provides express.createServer
#

express = require 'express'
app = express.createServer()

app.get '/', (req,res) ->
  res.send 'Hello World'

app.listen 3000
