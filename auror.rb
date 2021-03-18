require 'minitest/autorun'

class StringInterpolation < String
    attr_writer :string

    def string
        @string || ''
    end

    def interpolate string='', hash={}
        new_string = ''
        last_char = ''
        not_counted = false
        string.chars.each_with_index do |char, index|
            if char == '[' and last_char == '['
                puts "2nd Square Bracket"
            elsif char == '[' and last_char != '[' and string.chars[index+1] != '['
                len = index-1
                not_counted = true
                new_string = new_string.insert(len, last_char)
                puts "New String: #{new_string}"
            elsif not_counted = false
                puts 'Skipped'
            else                
                new_string.insert(new_string.length, last_char)
                last_char = char
                puts last_char                
            end
        end
        output_string = new_string + hash[:name]
        self.insert(0, output_string)
        end
end

class TestStringInterpolation < MiniTest::Test

    def setup
        @string = StringInterpolation.new('')
    end

    def test_square_bracket
        @string.interpolate 'Hello [name]', {name: 'Jim'}
        p "String= #{@string}"
        assert_equal "Hello Jim", @string
    end

    def test_double_square_brackets
        @string.interpolate "Hello [name] [[author]]", {name: 'Jim'}
        p "String= #{@string}"
        assert_equal "Hello Jim [author]", @string
    end

end