def welcome
    puts "Welcome to the guessing game! Enter your name?\n"
    name = gets.strip
    puts "\n\n"
    puts "Lets get started, #{name}!"
    name
  end
  
  def level
    puts "Choose your level\n"
    puts "(1) Very easy (2) Easy (3) Intermediate (4) Hard (5) I'm crazy"
    level_chosen = gets.to_i
  end
  
  def scret_number(level_chosen)
      case level_chosen
      when 1
          max = 30
      when 2
          max = 60
      when 3
          max = 100
      when 4
          max = 150
      else
          max = 200
      end
      puts "Choosing between 1 and #{max}..."
      number = rand(max) + 1
      puts "Try to guess!"
      number
  end
  
  def ask_number(attempts, attempt, max_attemp)
      puts "\n\n"
      puts "Attempt #{attempt} of #{max_attemp}\n"
      puts "Tell me your number"
      attempt = gets.strip
      puts "You said #{attempt}"
      attempt.to_i
  end
  
  def won
    puts "YOU GOT IT, congrats!"
  end
  
  def verify_answer(secret_number, attempt)
      right_answer = secret_number == attempt
      if right_answer
          won
          return true
      end
      bigger = secret_number > attempt
      if bigger
          puts "My number is bigger!"
      else
          puts "Your number is bigger than mine..."
      end
      false
  end
  
  def game(name, level_chosen)
      secret_number = scret_number level_chosen
  
      max_attemp = 5
      attempts = []
      points = 1000
  
      for attempt in 1..max_attemp
          attempt = ask_number attempts, attempt, max_attemp
          attempts << attempt
  
          points_to_lose = (attempt - secret_number).abs / 2.0
          points = points - points_to_lose
          if verify_answer secret_number, attempt
              break
          end
      end
  
      puts "Score: #{points}"
  end
  
  def dont_wanna_play?
      puts "Wanna play again? (Y/N)"
      answer = gets.strip
      no = answer.upcase == "N"
  end
  
  name = welcome
  level_chosen = level
  
  loop do
      game name, level_chosen
      break if dont_wanna_play?
  end