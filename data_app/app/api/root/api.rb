module API
  class Root::API < Grape::API
    format :json
    formatter :json, Grape::Formatter::JSONAPIResources

    mount Users::API
    add_swagger_documentation
  end
end
