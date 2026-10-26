// app.js: authorization comparison app
//
// Description:
// Supplies an isolated Express route with injected test identity and data.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import express from 'express';

export function createApp({ authenticatedUserId, users, enforceOwnership }) {
  const app = express();

  app.get('/users/:userId', (req, res) => {
    if (authenticatedUserId == null) return res.sendStatus(401);
    if (enforceOwnership && authenticatedUserId !== req.params.userId) {
      return res.sendStatus(403);
    }

    const user = users.get(req.params.userId);
    if (!user) return res.sendStatus(404);
    return res.json(user);
  });

  return app;
}
