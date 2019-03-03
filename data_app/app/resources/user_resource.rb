class UserResource < JSONAPI::Resource
  attributes :first_name, :last_name, :job, :description, :current_time

  def current_time
    DateTime.current
  end
end
