class Account
    
    @@accounts = 0
    
    attr_reader :balance, :account_number
    
    def initialize(deposit)
        @@accounts += 1
        @number = @@accounts
        @balance = deposit
        @pin = rand(0..9999)
    end
    
    def withdraw(amount)
        if amount <= @balance
            @balance -= amount
            return true
        else
            return false
        end
    end
    
    def deposit(amount)
        @balance += deposit
    end
    
    def check_pin(pin)
        @pin == pin
    end
    
end

class Bank
    
    def initialize(name)
        @name = name
        @accounts = {}
    end
    
    def open_account(initial_deposit)
        account = Account.new(initial_deposit)
        @accounts[account.number] = account
        return account
    end
    
    def close_account(account_number)
        account = @accounts[account_number]
        if account
            @accounts.delete(account.number)
            return account.balance
        else
            return nil
        end
    end
    
    def get_account(account_number)
        return @accounts[account_number]
    end
    
end

class ATM
    
    def initialize(local_bank, *foreign_banks)
        @local_bank = local_bank
        @foreign_banks = foreign_banks
    end
    
    def run
        running = true
        while running
            puts "Welcome to the #{name} ATM"
            puts "Please select an option:"
            puts "1. Log In"
            puts "2. Open a new account"
            puts "3. Leave"
            puts
            input = gets.chomp.to_i
            
            case input
            when 1
                puts "Please enter your account number:"
                account_number = gets.chomp.to_i
                account = @local_bank.get_account(account_number)
                
                foreign_account = false
                
                @foreign_banks.each do |bank|
                    account = bank.get_account(account_number)
                    if account
                        foreign_account = true
                        break
                    end
                end
                
                if account
                    puts "Please enter your PIN"
                    pin = gets.chomp.to_i
                    
                    if account.check_pin(pin)
                        puts "Welcome, your account balance is #{balance}"
                        puts "Please make a selection"
                        puts "1. Withdrawl"
                        puts "2. Deposit"
                        puts "3. Log out"
                        input = gets.chomp.to_i
                        
                        case input
                        when 1
                            puts "How much would you like to withdraw?"
                            amount = gets.chomp.to_i
                            if account.withdraw(amount)
                                puts "Despensing $#{amount}"
                                puts "Your New balance is #{account.balance}"
                            else
                                puts "Not enough funds"
                            end
                        when 2
                        when 3
                        else
                        end
                    end
                else
                    "No account found for #{account_number}"
                end
            when 2
            when 3
                running = false
            else
                puts "Please make a valid selection"
            end
        end
        
    end
    
end


puts account