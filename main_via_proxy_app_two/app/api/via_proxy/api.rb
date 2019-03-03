module API
  class ViaProxy::API < Grape::API
    version 'v1', using: :header, vendor: 'sth'
    prefix :api

    resource :users_via_proxy_two_from_data_app do
      desc 'fetches users from data app via proxy app'
      get  do
        curl_cmd = "curl -H 'X-Origin-Auth: #{APP_ORIGIN_TOKEN}' 'proxy_app_web_link:3003/api/proxy_for_data_app'"
        response = Terrapin::CommandLine.new(curl_cmd).run
        JSON.parse(response)
      end
    end

    resource :try_users_directly_from_data_app_via_link do
      desc '(TRY TO..) fetch users from data app directly'
      get  do
        begin
          curl_cmd = "curl 'data_app_web_link:3004/api/users'"
          response = Terrapin::CommandLine.new(curl_cmd).run
          users = JSON.parse(response)
        rescue Terrapin::ExitStatusError
          'dupa...'
        end
      end
    end

    resource :try_users_directly_from_data_app_via_address do
      desc '(TRY TO..) fetch users from data app directly'
      get  do
        begin
          curl_cmd = "curl 'localhost:3004/api/users'"
          response = Terrapin::CommandLine.new(curl_cmd).run
          users = JSON.parse(response)
        rescue Terrapin::ExitStatusError
          'dupa...'
        end
      end
    end

    resource :try_users_via_direct_app do
      desc '(TRY TO..) fetch users from direct app'
      get  do
        begin
          curl_cmd = "curl 'localhost:3001/api/users_directly_from_data_app'"
          response = Terrapin::CommandLine.new(curl_cmd).run
          users = JSON.parse(response)
        rescue Terrapin::ExitStatusError
          'dupa...'
        end
      end
    end
  end
end
