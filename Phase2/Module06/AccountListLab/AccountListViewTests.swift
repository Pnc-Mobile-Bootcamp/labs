//
//  AccountListViewTests.swift
//  PNCMobileAppTests
//
//  Module 6 — Building iOS User Interfaces
//  Self-check tests for the Accounts List Lab.
//
//  These are illustrative for the debrief, not something participants are
//  expected to write themselves yet — full UI/view testing technique is
//  covered formally in Module 9. Use during debrief to show that the
//  requirements in the lab prompt are independently checkable, not just
//  matters of taste.
//
//  NOTE: These are logic-level checks on the Account model and formatting,
//  which don't require rendering SwiftUI views. Verifying accessibility
//  behavior (requirement 4) and Dynamic Type behavior (requirement 5) in
//  an automated way requires UI testing tools introduced in Module 9 —
//  for this module, those two requirements are checked by manual
//  VoiceOver and larger-text-size testing instead, as described in the
//  facilitator guide.
//

import XCTest
@testable import PNCMobileApp

final class AccountModelTests: XCTestCase {

    func test_accountsAreUniquelyIdentifiable() {
        let ids = Set(sampleAccounts.map(\.id))
        XCTAssertEqual(
            ids.count, sampleAccounts.count,
            "Every Account must have a unique id — this is what List(accounts) relies on."
        )
    }

    func test_negativeBalanceAccountIsRepresented() {
        // Rewards Credit Card carries a negative balance in the sample data —
        // confirms the model doesn't assume all balances are positive.
        let creditCard = sampleAccounts.first { $0.name == "Rewards Credit Card" }
        XCTAssertNotNil(creditCard)
        XCTAssertLessThan(
            creditCard?.balance ?? 0, 0,
            "Sample data should include at least one negative balance to exercise formatting edge cases."
        )
    }

    func test_maskedNumberDoesNotExposeFullAccountNumber() {
        for account in sampleAccounts {
            XCTAssertTrue(
                account.maskedNumber.contains("\u2022"),
                "\(account.name)'s number should be masked, not shown in full, per standard banking UI conventions."
            )
        }
    }
}
