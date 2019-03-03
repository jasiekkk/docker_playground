module API
  class Root::API < Grape::API
    format :json

    mount Direct::API
    add_swagger_documentation
  end
end
