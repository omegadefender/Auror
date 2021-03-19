require 'minitest/autorun'

class StringInterpolation < String
    attr_writer :string

    def string
        @string || ''
    end

    def interpolate string='', hash={}
        new_string = ''
        counted = true
        sec_brac = false
        name = hash[:name]
        string.chars.each_with_index do |char, index|
            if char !='[' and char != ']' and counted
                new_string.concat(char)
            elsif char == '[' and counted
                counted = false
            elsif char !='[' and char != ']' and char != ' ' and !counted
            elsif char == ' ' and !counted
                new_string.concat(char)
                counted = true         
            elsif char == '[' and !counted
                new_string.concat(char)                
                sec_brac = true
                counted = true                
            elsif char == ']' and !sec_brac and !counted
                new_string.concat(name)
            elsif char == ']' and sec_brac and counted
                new_string.concat(char)
                counted = false
            elsif char == ']' and !counted
            else
                new_string.concat(name) 
            end
        end
        self.concat(new_string)
        end
end

class TestStringInterpolation < MiniTest::Test

    def setup
        @string = StringInterpolation.new('')
    end

    def test_square_bracket
        @string.interpolate 'Hello [name]', {name: 'Jim'}
        assert_equal "Hello Jim", @string
    end

    def test_double_square_brackets
        @string.interpolate 'Hello [name] [[author]]', {name: 'Jim'}
        assert_equal "Hello Jim [author]", @string
    end

end