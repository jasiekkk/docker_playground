APP_ORIGIN_TOKEN = JWT.encode('ProxyAPP', AppConfig.jwt.secret, 'HS256').freeze
