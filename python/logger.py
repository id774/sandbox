# logger.py: Custom logging handler and format
#
# Description:
# Configure a logging handler with a custom format and emit every level.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 logger.py
#
# Requirements:
# - Python 3
#

from logging import getLogger, Formatter, StreamHandler, INFO
logger = getLogger(__name__)
handler = StreamHandler()
handler.setLevel(INFO)
handler.setFormatter(Formatter(fmt='%(asctime)s %(levelname)s -- %(message)s', datefmt="%Y-%m-%dT%H:%M:%S.%s+09:00"))
logger.setLevel(INFO)
logger.addHandler(handler)
logger.propagate = False

logger.debug('debug')
logger.info('info')
logger.warn('warn')
logger.error('error')
