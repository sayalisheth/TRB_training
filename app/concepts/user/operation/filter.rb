module User::Operation
  class Filter < Trailblazer::Operation

    step :get_records
    step :request_from_web_app?, Output(:failure) => Track(:mobile_app)                                 
    step :filter_with_time_interval
    step :filter_with_status
    step :set_response_for_web
    step :order_by_created_at, magnetic_to: :mobile_app
    step :set_response_for_mobile, magnetic_to: :mobile_app
    
    def get_records(ctx, **)
      ctx[:users] = User.all
    end

    def request_from_web_app?(ctx, params:, **)
      params[:app] == 'web_app'
    end

    def filter_with_time_interval(ctx, **)
      ctx[:time_interval] = 'Users filter by time interval'
    end

    def filter_with_status(ctx, params:, users:, **)
      # ctx[:users] = users.where(status: params[:status])
      ctx[:status] = 'Users filter by status'
    end

    def set_response_for_web(ctx, users:, **)
      ctx[:response_from_web] = 'Users list for web app'
    end

    def order_by_created_at(ctx, users:, **)
      # ctx[:users] = users.order(:desc, :crated_at)
      ctx[:order_by] = 'Users ordered by created at'
    end

    def set_response_for_mobile(ctx, users:, **)
      ctx[:response_from_mobile] = 'Users list for mobile app'
    end
  end
end

