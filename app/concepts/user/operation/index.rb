module User::Operation
  class Index < Trailblazer::Operation

    step :valid_user?
    fail :log_error, fail_fast: true
    step :valid_role?
    fail :log_invalid_role_error
    step :load_users
    

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
