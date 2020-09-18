module User::Operation
  class Create < Trailblazer::Operation

    step ->(ctx, **) { ctx[:params][:email].present? }
    fail :log_error, fail_fast: true
    step :valid_password?#, Output(:failure) => Track(:success)
    fail :log_password_error 
    step :save_user
    step :address_present?,Output(:failure) => Id(:send_mail)
    step :create_address
    step :send_mail

    # def valid_email?(ctx, **)
    #   ctx[:params][:email].present?
    # end

    def log_error(ctx, **)
      ctx[:errors] = 'Email can not be blank'
    end

    def valid_password?(ctx, **)
      ctx[:params][:password] == ctx[:params][:password_confirmation]
    end

    def log_password_error(ctx, **)
      ctx[:errors] = 'Password and Confirm password should match'
    end

    def save_user(ctx, **)
      User.create(ctx[:params])
    end

    def address_present?(ctx, **)
      ctx[:params][:address].present?
    end

    def create_address(ctx, **)
      ctx[:address_message] = 'Address created'
    end

    def send_mail(ctx, **)
      ctx[:email_message] = 'Email send'
    end
  end
end

