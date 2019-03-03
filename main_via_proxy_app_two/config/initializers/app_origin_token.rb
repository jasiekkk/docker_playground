APP_ORIGIN_TOKEN = JWT.encode('MainViaProxyTwoAPP', AppConfig.jwt.secret, 'HS256').freeze
