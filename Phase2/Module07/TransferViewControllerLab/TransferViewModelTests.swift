//
//  TransferViewModelTests.swift
//  PNCMobileAppTests
//
//  Module 7 — iOS Application Architecture
//  Self-check / demo tests for the Refactor TransferViewController lab.
//
//  This is the single most persuasive artifact in Module 7 for anyone
//  still skeptical of dependency injection after Block 4. Run it live
//  during the debrief if possible: point out there is no server, no
//  network call, and no singleton anywhere in this file, and the whole
//  suite still runs in well under a second.
//
//  Formal XCTest authoring technique is covered in depth in Module 9 —
//  this file is illustrative for the debrief, not something participants
//  are expected to have written unassisted yet.
//

import XCTest
@testable import PNCMobileApp

// MARK: - Fake repository — the payoff of protocol-based DI

final class FakeAccountsRepository: AccountsRepository {
    private(set) var transferCallCount = 0
    var shouldThrow = false

    func transfer(amount: Decimal, from: Account, to: Account) async throws {
        transferCallCount += 1
        if shouldThrow {
            throw TransferError.insufficientFunds
        }
    }
}

final class TransferViewModelTests: XCTestCase {

    func makeAccounts(balance: Decimal) -> (from: Account, to: Account) {
        let from = Account(name: "Checking", maskedNumber: "\u2022\u2022\u2022\u2022 4471", balance: balance)
        let to = Account(name: "Savings", maskedNumber: "\u2022\u2022\u2022\u2022 9902", balance: 0)
        return (from, to)
    }

    func test_transferBelowBalance_succeeds() async {
        let fakeRepo = FakeAccountsRepository()
        let viewModel = TransferViewModel(repository: fakeRepo)
        let (from, to) = makeAccounts(balance: 500)

        var succeeded = false
        viewModel.onSuccess = { succeeded = true }

        await viewModel.attemptTransfer(amount: 100, from: from, to: to)

        XCTAssertTrue(succeeded, "A transfer under the available balance should succeed.")
        XCTAssertEqual(fakeRepo.transferCallCount, 1, "The repository should be called exactly once.")
    }

    func test_transferAboveBalance_failsWithoutCallingRepository() async {
        let fakeRepo = FakeAccountsRepository()
        let viewModel = TransferViewModel(repository: fakeRepo)
        let (from, to) = makeAccounts(balance: 50)

        var receivedError: TransferError?
        viewModel.onError = { receivedError = $0 }

        await viewModel.attemptTransfer(amount: 100, from: from, to: to)

        XCTAssertEqual(receivedError, .insufficientFunds)
        XCTAssertEqual(
            fakeRepo.transferCallCount, 0,
            "Eligibility should be checked BEFORE the repository is ever called — no wasted network call for a doomed transfer."
        )
    }

    func test_zeroOrNegativeAmount_isRejected() async {
        let fakeRepo = FakeAccountsRepository()
        let viewModel = TransferViewModel(repository: fakeRepo)
        let (from, to) = makeAccounts(balance: 500)

        var receivedError: TransferError?
        viewModel.onError = { receivedError = $0 }

        await viewModel.attemptTransfer(amount: 0, from: from, to: to)

        XCTAssertEqual(receivedError, .invalidAmount)
    }
}
