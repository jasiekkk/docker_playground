APP_ORIGIN_TOKEN = JWT.encode('MainDirectAPP', AppConfig.jwt.secret, 'HS256').freeze
