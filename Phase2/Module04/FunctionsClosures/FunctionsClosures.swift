// ============================================================
// MODULE 4: Swift Programming Fundamentals
// Exercises — Functions, Closures, and OOP in Swift
// Enterprise Mobile Application Development Bootcamp
// ============================================================
//
//
// The exercises in the next exercise (OOP) build directly on the types
// you define in this exercise (Functions). Work in order.
// ============================================================

import Foundation


// ============================================================
// EXERCISE 1: Labeled Parameters
// Estimated time: 15 minutes
//
// This is the feature most likely to surprise you.
// In Python: transfer(500, "Checking", "Savings")
// In Swift:  transfer(amount: 500, from: "Checking", to: "Savings")
//
// The labels at the call site are part of the function signature.
// They make call sites read like sentences.
// ============================================================

// TODO 1a: Write a function named calculateInterest that takes:
//   - principal: Double
//   - rate: Double
//   - years: Int
// Returns the simple interest as a Double: principal * rate * Double(years)
// Then call it and print the result for:
//   principal = 10_000, rate = 0.035, years = 5


// TODO 1b: Write a function named formatCurrency that:
//   - Takes a single parameter: amount of type Double
//   - Returns a String formatted as "$1,234.56"
//   - Hint: use String(format: "$%.2f", amount)
//     (for a full thousands-comma format use NumberFormatter, but
//      String(format:) is fine for this exercise)
// Call it with several values and print the results.


// TODO 1c: External vs. internal parameter labels
// Write a function named authenticate that:
//   - External label for first param: _ (suppressed)
//   - Internal name for first param: username
//   - External label for second param: with
//   - Internal name for second param: password
//   - Returns Bool: true if username == "jsmith" AND password == "pass123"
//
// The call site should look like:
//   authenticate("jsmith", with: "pass123")


// TODO 1d: Default parameter values
// Write a function named fetchTransactions that takes:
//   - accountId: String
//   - limit: Int with default value 50
//   - offset: Int with default value 0
// Returns a String: "Fetching \(limit) transactions from account \(accountId) starting at offset \(offset)"
//
// Call it three ways:
//   fetchTransactions(accountId: "acc_001")
//   fetchTransactions(accountId: "acc_001", limit: 20)
//   fetchTransactions(accountId: "acc_001", limit: 20, offset: 40)


// TODO 1e: Multiple return values with tuples
// Write a function named validateTransfer that takes:
//   - amount: Double
//   - availableBalance: Double
// Returns a named tuple: (isValid: Bool, errorMessage: String?)
//
// Rules:
//   amount <= 0          → (false, "Amount must be greater than zero")
//   amount > availableBalance → (false, "Insufficient funds")
//   otherwise            → (true, nil)
//
// Call it with at least three cases and print the results.


// ============================================================
// EXERCISE 2: Closures
// Estimated time: 20 minutes
//
// Closures are functions without a name. In Python you know them
// as lambdas. In JS, as arrow functions. Swift closures are more
// powerful than Python lambdas (they can be multi-line) and feel
// very similar to JS arrow functions.
//
// Swift closures evolve through several shorthand forms.
// You'll see all of them in real codebases.
// ============================================================

// TODO 2a: Assign a closure to a variable
// Create a closure named square that takes an Int and returns Int: $0 * $0
// Print square(7)    → 49
// Print square(12)   → 144


// TODO 2b: Higher-order functions — map, filter, reduce
// You have this array of account balances:
let balances = [3_250.00, 12_000.00, 450.75, 8_900.00, 125.50, 22_450.00]

// TODO: Use .filter to get only balances above 5_000.00
// Store result in highBalances and print it.

// TODO: Use .map to multiply each balance by 1.035 (apply 3.5% interest)
// Store result in balancesWithInterest and print it.

// TODO: Use .reduce to get the total of all balances
// Hint: balances.reduce(0) { $0 + $1 }  or  balances.reduce(0, +)
// Store result in totalBalance and print it formatted as currency.


// TODO 2c: Sorting with closures
// You have this array of transaction amounts (some negative = debits):
let amounts = [250.00, -45.67, 1_200.00, -890.00, 75.00, -12.50, 3_400.00]

// Sort by absolute value, ascending. Store in sortedBySize.
// Hint: .sorted { abs($0) < abs($1) }
// Print sortedBySize.


// TODO 2d: Chaining higher-order functions
// Using the balances array above, in a single chain:
//   1. Filter to balances above 1_000
//   2. Map each to add 3.5% interest
//   3. Reduce to get the total
// Store in premiumTotal and print it.


// TODO 2e: Closure that captures its environment
// Write a function named makeAccountLogger that takes a String accountId
// and returns a closure of type (String) -> Void
// The returned closure should print: "[accountId] EVENT: [message]"
// where [accountId] is captured from the outer function.
//
// Usage:
//   let checkingLog = makeAccountLogger(accountId: "ACC-001")
//   checkingLog("Deposit received")    → "[ACC-001] EVENT: Deposit received"
//   checkingLog("Balance checked")     → "[ACC-001] EVENT: Balance checked"
