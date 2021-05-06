module MyTest
    def self.expect_equal(actual, expected)
        if actual == expected
            puts "PASS"
        else
            puts "FAIL Expected: #{expected}, Actual: #{actual}"
        end
    end
end
