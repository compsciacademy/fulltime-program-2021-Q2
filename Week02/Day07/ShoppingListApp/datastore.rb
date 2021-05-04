module DataStore
    def self.open(data, method='r')
        File.open('shopping_list', method) do |file|
            case method
            when 'r'
                data += file.read
            when 'w'
                file.write(data)
            end
        end
        data
    end
end
