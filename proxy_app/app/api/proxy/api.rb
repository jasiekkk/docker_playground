module API
  class Proxy::API < Grape::API
    version 'v1', using: :header, vendor: 'sth'
    prefix :api

    helpers do
      def origin
        @origin ||= begin
          token = headers['X-Origin-Auth']
          JWT.decode(token, AppConfig.jwt.secret, true, { algorithm: 'HS256'}).first
        rescue JWT::VerificationError, JWT::DecodeError
          nil
        end
      end

      def request_counter
        case origin
        when 'MainViaProxyOneAPP'
          $prometheus.get(:total_requests_from_main_via_proxy_one_app)
        when 'MainViaProxyTwoAPP'
          $prometheus.get(:total_requests_from_main_via_proxy_two_app)
        else
          $prometheus.get(:total_requests_from_unauthorized_app)
        end
      end

      def report_request_metrics!
        request_counter.increment
      end

      def verify_origin!
        return if %w[MainViaProxyOneAPP MainViaProxyTwoAPP].include?(origin)
        error!('Proxy App says: Fuck off.', 401)
      end
    end

    before do
      report_request_metrics!
      verify_origin!
    end

    resource :proxy_for_data_app do
      desc 'Proxy for fetching users from data app'
      get  do
        curl_cmd = "curl -H 'X-Origin-Auth: #{APP_ORIGIN_TOKEN}' 'data_app_web_link:3004/api/users'"
        response = Terrapin::CommandLine.new(curl_cmd).run
        users = JSON.parse(response)
        { 'source': 'PROXY APP' }.merge(users)
      end
    end
  end
end
