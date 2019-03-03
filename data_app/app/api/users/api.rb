module API
  class Users::API < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |e|
      error!('Record Not Found', 404)
    end

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
        when 'MainDirectAPP'
          $prometheus.get(:total_requests_from_main_direct_app)
        when 'ProxyAPP'
          $prometheus.get(:total_requests_from_proxy_app)
        else
          $prometheus.get(:total_requests_from_unauthorized_app)
        end
      end

      def report_request_metrics!
        request_counter.increment
      end

      def verify_origin!
        return if %w[MainDirectAPP ProxyAPP].include?(origin)
        error!('Data App says: Fuck off.', 401)
      end
    end

    before { report_request_metrics! }

    resource :users do
      desc 'Returns all users'
      get  do
        verify_origin!
        render(User.all)
      end

      desc 'Returns a user'
      params do
        requires :id, type: Integer, desc: 'ID'
      end
      route_param :id do
        get do
          user = User.find(params[:id])
          render(user)
        end
      end

      desc 'Create a user'
      params do
        optional :first_name, type: String, desc: 'First Name'
        optional :last_name, type: String, desc: 'Last Name'
        optional :job, type: String, desc: 'Job'
        optional :description, type: String, desc: 'Description'
      end
      post do
        user = User.create(params)
        render(user)
      end

      desc 'Update a user'
      params do
        requires :id, type: Integer, desc: 'ID'
        optional :first_name, type: String, desc: 'First Name'
        optional :last_name, type: String, desc: 'Last Name'
        optional :job, type: String, desc: 'Job'
        optional :description, type: String, desc: 'Description'
      end
      put ':id' do
        user = User.find(params[:id])
        user.update(params)
        render(user)
      end

      desc 'Delete a user'
      params do
        requires :id, type: Integer, desc: 'ID'
      end
      delete ':id' do
        user = User.find(params[:id])
        user.destroy
        render(user)
      end
    end
  end
end
