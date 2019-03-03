module API
  class Root::API < Grape::API
    format :json
    formatter :json, Grape::Formatter::JSONAPIResources

    mount ViaProxy::API
    add_swagger_documentation
  end
end
