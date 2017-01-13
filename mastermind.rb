class Mastermind

	def initialize 
		instructions
		@code = Array.new
		@hint = Array.new(4)
		@hintsUsed = Array.new(4)
		hintsUsedInit
		puts "Guess or Create (g or c)"
		gOrC = gets.chomp.downcase
		if gOrC == 'g'
			@guessOrC = true;
		elsif gOrC == 'c'
			@correct = ["", "", "", ""]
			@outOfPosition = Array.new
			@guessOrC = false;
		end
		@turn = 0;
		@colors = ["red", "blue", "green", "yellow", "orange", "white", "black"]
		@winner = false;
		createCode
	end

	def hintsInit
		for i in 0...@hint.size
			@hint[i] = 'X'
		end
	end

	def hintsUsedInit
		for i in 0...@hintsUsed.size
			@hintsUsed[i] = false
		end
	end

	def createCode
		if (@guessOrC)
			colorSize = @colors.size
			@code = [@colors[rand(colorSize)], @colors[rand(colorSize)], @colors[rand(colorSize)], @colors[rand(colorSize)]]
		else
			puts "Enter the first color"
			@code.push(gets.chomp)
			puts "Enter the second color"
			@code.push(gets.chomp)
			puts "Enter the third color"
			@code.push(gets.chomp)
			puts "Enter the fourth color"
			@code.push(gets.chomp)
			puts "\n"
		end
	end

	def printCode
		for i in 0..@code.size
			puts @code[i]
		end
	end

	def guessCode
		hintsInit
		hintsUsedInit
		@turn += 1;
		@guess = Array.new
		if (@guessOrC)
			puts "Enter the first color"
			@guess.push(gets.chomp)
			puts "Enter the second color"
			@guess.push(gets.chomp)
			puts "Enter the third color"
			@guess.push(gets.chomp)
			puts "Enter the fourth color"
			@guess.push(gets.chomp)
		else	
			computerGuess
		end
	end

	def computerGuess
		colorSize= @colors.size
		for i in 0...4
			if (@correct[i] == "")
				if (@outOfPosition.size == 0)
					@guess[i] = @colors[rand(colorSize)]
					puts @guess[i]
				else
					@guess[i] = @outOfPosition[rand(colorSize)]
					puts @guess[i]
				end
			else
				@guess[i] = @correct[i]
				puts @guess[i]
			end
		end
		puts "Computer Guesses..."
		printGuesses
	end

	def printGuesses
		for i in 0...@guess.size
			puts @guess[i]
		end
	end

	def checkAndHint
		checkCorrect
		checkPartiallyCorrect
	end

	def checkCorrect
		for i in 0...@guess.size
			if (@guess[i] == @code[i])
				@hint[i] = 'C' #C for correct
				@hintsUsed[i] = true;
				if (!@guessOrC)
					@correct[i] = @guess[i];
					@outOfPosition -= [@guess[i]]
				end
			end
		end
	end

	def checkPartiallyCorrect
		for i in 0...@guess.size
			j = 0
			lookingForMatch = true;
			while (lookingForMatch)
				if (j >= @code.size)
					lookingForMatch = false;
				elsif (@code[j] == @guess[i] && @hintsUsed[j] == false)
					@hint[i] = 'P' #P for position incorrect
					@hintsUsed[j] = true;
					if (!@guessOrC)
						@outOfPosition.push(@guess[i])
					end
					lookingForMatch = false;
				end
				j += 1;
			end
		end
	end

	def printHints
		puts "\n"
		for i in 0...@hint.size
			print @hint[i]
		end
		puts "\n\n"
	end

	def winner?
		for i in 0...@hint.size
			if (@hint[i] != 'C')
				return false
			end
		end
		return true;
	end

	def gameOver?
		if (winner?)
			puts "Winner"
			printCode
		elsif (@turn == 12)
			puts "Ran out of turns. Better luck next time."
			printCode
			return true;
		end
	end
	def instructions
		puts "\nWelcome to Mastermind! You can either guess or create the code. Hints are given after each guess. A 'C' represents a correct guess of color and position. A 'P' represents a correct color but incorrect position. A 'X' means the color and position are incorrect. Have fun!\n"
	end

end

game = Mastermind.new
while (!game.gameOver?) 
	game.guessCode
	game.checkAndHint
	game.printHints
end



