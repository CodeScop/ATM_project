#Create a program that is an ATM using classes

#Create at least a Customer class and an ATM class

#Think about other classes we might want to include like an account class etc

#have fun with it! Make sure all classes and objects are able to interact

#REMEMBER: Classes are our nouns and methods are our verbs!
require_relative 'customer'

puts "Welcome to Fidelity Fiduciary Bank! To create your account, please enter your name."
name = gets.chomp
puts "Please enter your password."
password = gets.chomp
puts "Please enter the amount you wish to enter into your savings account. There is a minimum balance of $25."
savebal = gets.chomp.to_f
puts "Please enter the amount you wish to enter into your checking account. There is no minimum balance."
checkbal = gets.chomp.to_f
sav1 = Savings.new(savebal)
check1 = Checking.new(checkbal)
customer1 = Customer.new(name, password, check1, sav1)
puts "Would you like to interact with your savings account, checking account, or transfer money between them? Please choose \"savings\", \"checking\",\"transfer\", or \"exit\" to leave the program."
response = gets.chomp
until response == "exit"
	if response == "savings"
		sav1.transaction
	elsif response == "checking"
		check1.transaction
	elsif response == "transfer"
		customer1.transfer
	else
		puts "I'm sorry, that is not a valid command."
	end
	puts "Would you like to interact with your savings account, checking account, or transfer money between them? Please choose \"savings\", \"checking\",\"transfer\", or \"exit\" to leave the program."
	response = gets.chomp
end
puts "Goodbye! Have a good day."
