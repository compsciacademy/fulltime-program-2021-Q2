class User
    attr_reader :username, :email

    def initialize(username, email)
        @username, @email = username, email
    end

    def save(environment='production')
        File.open("#{environment}_user", 'a') do |file|
            file.write("#{@username}, #{@email}\n")
        end
        self
    end

    def self.all(environment='production')
        begin
            File.open("#{environment}_user", 'r') do |file|
                file.map do |line|
                    username, email = line.split(', ')
                    User.new(username, email.chomp)
                end
            end
        rescue StandardError => e
            # we could implement a Log module or class
            # that makes a record of errors that are
            # handled:
            # Log.message("Handled Error: #{e.message}")
            system("touch #{environment}_user")
            self.all(environment)
        end
    end
end
