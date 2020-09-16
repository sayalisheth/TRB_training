module User::Operation
  class Create < Trailblazer::Operation

    step :valid_email?
    fail :log_error, fail_fast: true
    step :valid_password?
    fail :log_password_error
    step :save_user
    

    def valid_email?(ctx, **)
      ctx[:params][:email].present?
    end

    def log_error(ctx, **)
      ctx[:errors] = 'Email can not be blank'
    end

    def valid_password?(ctx, **)
      ctx[:params][:password] == ctx[:params][:password_confirmation]
    end

    def log_password_error(ctx, **)
      ctx[:errors] = 'Password and Confirm password not match'
    end

    def save_user(ctx, **)
      User.create(ctx[:params])
    end
  end
end

