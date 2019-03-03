module API
  class Direct::API < Grape::API
    version 'v1', using: :header, vendor: 'sth'
    prefix :api

    resource :users_directly_from_data_app do
      desc 'fetches users from data app directly'
      get  do
        curl_cmd = "curl -H 'X-Origin-Auth: #{APP_ORIGIN_TOKEN}' 'data_app_web_link:3004/api/users'"
        response = Terrapin::CommandLine.new(curl_cmd).run
        users = JSON.parse(response)
      end
    end
  end
end
