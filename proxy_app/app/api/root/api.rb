module API
  class Root::API < Grape::API
    format :json

    mount Proxy::API
    add_swagger_documentation
  end
end
