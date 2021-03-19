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
                #puts "1st Condition char is: #{char}\nnew_string = #{new_string}"
            #If char is [ then set counted is true, turn it to false. Other conditions to determine if it is a double [] or not
            elsif char == '[' and counted
                counted = false
                last_char = char
               # puts "2nd Condition char is: #{char}\nnew_string = #{new_string}"
            elsif char !='[' and char != ']' and char != ' ' and counted == false
               # puts "3rd Condition char is: #{char}\nnew_string = #{new_string}"
            elsif char == ' ' and counted == false
                new_string.concat(char)
                counted = true 
               # puts "4th Condition char is: #{char}\nnew_string = #{new_string}"          
            elsif char == '[' and counted == false                
                sec_square_brac = true
                counted = true
                last_char = char
                new_string.concat(char)
            #    puts "5th Condition char is: #{char}\nnew_string = #{new_string}"
            elsif char == ']' and sec_square_brac == false and counted == false
                new_string.concat(hash[:name])
                puts "6th Condition char is: #{char}\nnew_string = #{new_string}\n\n"
            elsif char == ']' and sec_square_brac == true and counted == true
                new_string.concat(char)
                counted = false
                puts "7th Condition char is: #{char}\nnew_string = #{new_string}\n\n"
            elsif char == ']' and counted == false
                puts "8th Condition char is: #{char}\nnew_string = #{new_string}\n\n"
            else
                new_string.concat(hash[:name]) 
                puts "ELSE Condition char is: #{char}\nnew_string = #{new_string}"
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