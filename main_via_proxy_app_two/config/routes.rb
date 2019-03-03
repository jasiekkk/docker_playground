Rails.application.routes.draw do
  mount Root::API => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
end
