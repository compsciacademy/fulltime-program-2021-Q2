module MyTest
    def self.run(description, actual, expected, message=nil)
        message ||= "expected: #{expected}, got: #{actual}"
        if actual == expected
            return "PASS: #{description}"
        else
            return "FAIL: #{message}"
        end
    end
end
