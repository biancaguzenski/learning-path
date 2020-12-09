class LineAnalyzer
    attr_reader :highest_wf_words, :highest_wf_count, :content, :line_number

    def initialize content, line_number
        @content = content
        @line_number = line_number
        @highest_wf_count = 0
        @highest_wf_words = []
        calculate_word_frequency
    end

    def calculate_word_frequency
        words = {}

        content.split.each do |word|
            if words.has_key? word
                words[word.downcase] += 1
            else
                words[word.downcase] = 1
            end
        end
        @highest_wf_count = words.values.sort.reverse.shift
        
        words.delete_if {|key, value| value < @highest_wf_count}
        @highest_wf_words.concat words.keys
    end
end


class Solution
    attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines 

    def initialize
        @analyzers = []
        @highest_count_across_lines = nil
    end

    def analyze_file
        line_number = 1
        text = File.open(File.dirname(__FILE__) + '/test.txt')
        text.each_line.with_index do |line, index|
          analyzers.push(LineAnalyzer.new(line, index))
          line_number += 1
        end
    end

    def calculate_line_with_highest_frequency
        @highest_count_words_across_lines = []
        temp = []
        @analyzers.each do |word|
            temp << word.highest_wf_count
        end
        @highest_count_across_lines = temp.max

        @analyzers.each do |word|
            if word.highest_wf_count == @highest_count_across_lines
                @highest_count_words_across_lines << word
            end
        end
    end

   def print_highest_word_frequency_across_lines
        
        @highest_count_words_across_lines.each do |word|
            puts "#{obj.highest_wf_words} (appears in line #{obj.line_number})"
        end
    end
end