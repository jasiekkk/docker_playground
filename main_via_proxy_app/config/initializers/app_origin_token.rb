APP_ORIGIN_TOKEN = JWT.encode('MainViaProxyOneAPP', AppConfig.jwt.secret, 'HS256').freeze
