class Customer
	attr_reader :name
	attr_accessor :password, :checkbal, :savebal
	def initialize(name, password, checkbal, savebal)
		@name = name
		@password = password
		@checkbal = checkbal
		@savebal = savebal
	end
	def transfer
		puts "Which account would you like to transfer from?"
		acctfrom = gets.chomp.downcase
		puts "Which account would you like to transfer to?"
		acctto = gets.chomp.downcase
		if (acctfrom == "checking" && acctto == "savings")
			puts "How much would you like to transfer?"
			amt = gets.chomp.to_f
			@checkbal.transferout(amt, @savebal)
		elsif (acctfrom == "savings" && acctto == "checking")
			puts "How much would you like to transfer?"
			amt = gets.chomp.to_f
			@savebal.transferout(amt, @checkbal)
		elsif (acctfrom == "exit" || acctto == "exit")
			puts "You have chosen not to transfer. No change."
		else
			puts "Sorry, that is not a valid response. Please try again."
			transfer
		end
		puts "Your transaction is complete."
	end
end
class Account
	attr_accessor :balance
	def initialize(balance)
		@balance = balance
	end
	def check
		puts "Your current balance is $#{sprintf('%.2f', @balance)}"
	end
	def deposit
		puts "How much would you like to deposit?"
		dep_amt = gets.chomp.to_f
		@balance += dep_amt
		puts "You have successfully deposited $#{sprintf('%.2f', dep_amt)}"
	end
	def transaction
		puts "Would you like to check your balance, deposit, withdraw, or exit to the main menu?"
		entry = gets.chomp
		until entry == "exit"
			if entry == "check"
				check
			elsif entry == "deposit"
				deposit
			elsif entry == "withdraw"
				withdraw
			else
				puts "I'm sorry, that is not a valid command."
			end
			puts "Would you like to check, deposit, withdraw, or exit?"
			entry = gets.chomp
		end
		puts "Thank you!"	
	end
	def transferout(amt, destination)
		if @balance < amt
			puts "Sorry, your transfer amount exceeds your current balance. Please try again."
		else
		self.balance -= amt
		destination.balance += amt
		end
	end
	def withdraw
		puts "How much would you like to withdraw?"
		withdraw_amt = gets.chomp.to_f
		if withdraw_amt > 200
			puts "Sorry, that exceeds the maximum allowable amount of $200.00."
			withdraw
		elsif withdraw_amt > @balance
			puts "Sorry, that amount exceeds your current balance."
			check
			withdraw
		elsif withdraw_amt%20 != 0
			puts "Sorry, your withdrawal must be a multiple of $20.00."
			withdraw
		else
			puts "Please take your money from the dispenser."
			@balance -= withdraw_amt
		end
	end
end
class Savings < Account
	attr_accessor :balance
	def initialize(balance)
		super(balance)
	end
		def withdraw
		puts "How much would you like to withdraw?"
		withdraw_amt = gets.chomp.to_f
		if withdraw_amt > @balance
			puts "Sorry, that amount exceeds your current balance."
			check
			withdraw
		elsif withdraw_amt > (@balance - 25)
			puts "Sorry, you must maintain a minimum balance of $25.00 for all automated transactions."
			withdraw
		elsif withdraw_amt%20 != 0
			puts "Sorry, your withdrawal must be a multiple of $20.00."
			withdraw
		else
			puts "Please take your money from the dispenser."
			@balance -= withdraw_amt
		end
	end
		def transferout(amt, destination)
		if @balance < (amt + 25)
			puts "Sorry, you must maintain a minimum balance of $25.00 at all times. You only have $#{sprintf('%.2f', (@balance - 25))} available to transfer at this time."
		else
		self.balance -= amt
		destination.balance += amt
		end
	end
end
class Checking < Account
	attr_accessor :balance
	def initialize(balance)
		super(balance)
	end
end