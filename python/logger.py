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
