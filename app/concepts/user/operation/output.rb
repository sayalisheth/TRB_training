module User::Operation
  class Output < Trailblazer::Operation

    step :is_admin?, Output(:failure) => Track(:member)
    step :admin_response
    step :user_response, magnetic_to: :member

    def valid_user?(ctx, **)
      true
    end

    def log_error(ctx, **)
      ctx[:errors] = 'Ivalid user'
    end

    def valid_role?(ctx, **)
      true
    end

    def log_invalid_role_error(ctx, **)
      ctx[:errors] = 'Ivalid role'
    end

    def load_users(ctx, **)
      ctx[:users] = User.all
    end
  end
end

