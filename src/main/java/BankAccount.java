public class BankAccount {

    private String accountNumber;
    private double balance;

    // Constructor to create a new account
    public BankAccount(String accountNumber, double initialBalance) {
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
    }

    // Method to get the account number
    public String getAccountNumber() {
        return accountNumber;
    }

    // Method to get the current balance
    public double getBalance() {
        return balance;
    }

    // Method to deposit money into the account
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("Deposit successful. New balance is $" + balance);
        } else {
            System.out.println("Deposit amount must be greater than zero.");
        }
    }

    // Method to withdraw money from the account
    public void withdraw(double amount) {
        if (amount <= balance) {
            balance -= amount;
            System.out.println("Withdrawal successful. New balance is $" + balance);
        } else {
            System.out.println("Insufficient funds. Withdrawal not allowed.");
        }
    }
}

