def draw_hangman(errors)
	head = "   "
	body = " "
	legs = "   "
	arms = "   "
	if errors >= 1
		head = "(_)"
	end
	if errors >= 2
		arms = " | "
		body = "|"
	end
	if errors >= 3
		arms = "\\|/"
	end
	if errors >= 4
		legs = "/ \\"
	end

	puts "  _______       "
	puts " |/      |      "
	puts " |      #{head}  "
	puts " |      #{arms}  "
	puts " |       #{body}     "
	puts " |      #{legs}   "
	puts " |              "
	puts "_|___           "
	puts 
 
end

def welcome()
	puts "/****************/"
	puts "/* HANGMAN GAME */"
	puts "/****************/"
	puts "What is your name?"
	nome = gets.strip
	puts "\n\n"
	puts "Let's get started, #{nome}\n"
	nome
end

def attempt()
	puts "Type letter/word:"
	answer = gets.strip.downcase
	puts "You typed #{answer}."
	answer
end

def attempts(attempts, errors, mask)
	puts "\n\n"
	puts "Secret word: #{mask}"
	puts "Attempts: #{attempts}"
	draw_hangman(errors)
end

def dont_wanna_play?()
	puts "Do you wanna pay again? (Y/N)"
	answer = gets.strip
	no = answer.upcase == "N"
end

def choose_word()
	puts "Picking random word..."
end

def choosed(word)
	puts "Picked one word with #{word.size} letters... Good luck!"
	word
end

def repeated_answer(answer)
	puts "#{answer} can't be picked twice"
end

def wrong_answer()
	puts "Wrong letter/word!"
end
def found_letter()
	puts "Letter found!"
end

def won(name)
		puts "\nAnd the winner is....#{name}!"
		puts
 
		puts "       ___________      "
		puts "      '._==_==_=_.'     "
		puts "      .-\\:      /-.    "
		puts "     | (|:.     |) |    "
		puts "      '-|:.     |-'     "
		puts "        \\::.    /      "
		puts "         '::. .'        "
		puts "           ) (          "
		puts "         _.' '._        "
		puts "        '-------'       "
		puts
end
def lost()
	puts "Sorry... You lost this time."
end

def final_score(score)
	puts "You scored #{score} points."
end
