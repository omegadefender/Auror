require 'minitest/autorun'

class StringInterpolation < String
    attr_writer :string

    def string
        @string || ''
    end

    def interpolate string='', hash={}
        chars_array = string.chars
        new_string = ''
        last_char = ''
        counted = true
        sec_square_brac = false
        chars_array.each_with_index do |char, index|
            #The first statement checks if char is any char other than [ and ], and puts char in string.
            if char !='[' and char != ']' and counted
                new_string.concat(char)
                last_char = char
                puts "1st Condition char is: #{char}"
            #If char is [ then set counted is true, turn it to false. Other conditions to determine if it is a double [] or not
            elsif char == '[' and counted
                counted = false
                last_char = char
                puts "2nd Condition char is: #{char}"
            elsif char !='[' and char != ']' and counted == false
                puts "Skipped"           
            elsif char == '[' and counted == false                
                sec_square_brac = true
                counted = true
                last_char = char
                new_string.concat(char)
                puts "3rd Condition char is: #{char}"
            elsif char != '[' and last_char == '[' and sec_square_brac
                new_string.concat(char)
                last_char = char
                not_counted = 1
                puts "4th Condition char is: #{char}"
            elsif char == ']' and last_char != ']' and not_counted == 0
                last_char = char
                not_counted == 1
                puts "5th Condition char is: #{char}"
            elsif char == ']' and last_char == ']'
                new_string.concat(char)
                not_counted = 1
                puts "6th Condition char is: #{char}"
            else
                new_string.concat(hash[:name]) 
                puts "ELSE"
            end
        end
        self.insert(0, new_string)
        end
end

class TestStringInterpolation < MiniTest::Test

    def setup
        @string = StringInterpolation.new('')
    end

    def test_square_bracket
        @string.interpolate 'Hello [name]', {name: 'Jim'}
        puts "String= #{@string}"
        assert_equal "Hello Jim", @string
    end

    def test_double_square_brackets
        @string.interpolate 'Hello [name] [[author]]', {name: 'Jim'}
        p "String= #{@string}"
        assert_equal "Hello Jim [author]", @string
    end

end