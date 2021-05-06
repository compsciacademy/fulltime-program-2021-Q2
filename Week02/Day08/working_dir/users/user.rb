class InvalidEmailError < StandardError; end

class User
    attr_reader :name
    attr_reader :email

    def initialize(name)
        @name = name
    end

    def email=(email)
        if validate_email(email)
            @email = email
        else
            raise InvalidEmailError.new("Email format is invalid")
        end
    end

    def validate_email(email)
        true if email.count('@') + email.count('.') >= 2
    end
end
