require_relative 'ui_hangman'

def secret_word()
	choose_word()
	text = File.read("words_hangman.txt")
	words = text.split("\n")
	rand_number = rand(words.size)
	word = words[rand_number].downcase
	choosed(word)
end


def valid_attempt(attempts, errors, mask)
	attempts(attempts, errors, mask)
	loop do
		answer = attempt()
		if attempts.include?(answer)
			repeated_answer(answer)
		else
			return answer
		end
	end
end

def mask_word(attempts, word)
	mask = ""
	for word in word.chars
		if attempts.include?(word)
			mask += word
		else
			mask += "_"
		end
	end
	mask
end

def game(name)
	word = secret_word()

	errors = 0
	attempts = []
	score = 1000

	while errors < 5
		mask = mask_word(attempts, word)
		answer = valid_attempt(attempts, errors, mask)
		attempts << answer

		letter = (answer.size == 1)
		if letter
			right_answer = word.count(answer[0])
			if right_answer == 0
				wrong_answer()
                errors += 1
                score -= 100
			else
                found_letter()
                score += 100
			end
		else
			right = answer == word
			if right
				won(name)
				score += 100
				break
			else
				lost()
				score -= 30
				errors += 1
			end
        end
        final_score(score)

	end
end

def hangman()
	name = welcome()

	loop do
		game(name)
		break if dont_wanna_play?()
	end
end