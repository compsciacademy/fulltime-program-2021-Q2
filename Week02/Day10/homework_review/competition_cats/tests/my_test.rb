module MyTest
    def self.expect_equal(actual, expected)
        if actual == expected
            puts "PASS"
        else
            puts "FAIL\nExpected: #{expected}\nActual: #{actual}\n"
        end
    end
end

