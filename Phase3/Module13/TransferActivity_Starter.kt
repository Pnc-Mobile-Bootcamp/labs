//
// TransferActivity_Starter.kt
// Module 13 — Android Architecture Patterns
// Lab Exercise: Refactor TransferActivity
//
// SCENARIO
// The Activity below is a Massive Activity: it mixes networking, validation,
// and UI update logic in one class. Your task is to refactor it using the
// patterns from this module.
//
// REQUIREMENTS
// 1. Extract a TransferViewModel with ZERO Android framework imports beyond
//    androidx.lifecycle.
// 2. Extract a TransferFundsUseCase encapsulating the eligibility check and
//    the transfer call.
// 3. Inject the Repository and UseCase via Hilt (@Inject constructor,
//    @HiltViewModel) — no manual construction, no singletons.
// 4. The refactored ViewModel must be unit-testable using a fake repository,
//    with no real network or Hilt container required.
//
// Read through BeforeMassiveTransferActivity below first — really read it,
// don't skim. Naming what's wrong with it is part of the exercise. Then
// fill in the TODOs in the scaffolding beneath it.
//

import android.app.Activity
import android.widget.Toast

// MARK: - BEFORE: the Massive Activity (do not edit — refactor FROM this)

class BeforeMassiveTransferActivity : Activity() {
    lateinit var fromAccount: Account
    lateinit var toAccount: Account

    fun onTransferButtonClicked(amountText: String) {
        val amount = amountText.toDoubleOrNull()
        if (amount == null || amount <= 0) {
            Toast.makeText(this, "Please enter a valid amount", Toast.LENGTH_SHORT).show()
            return
        }
        if (fromAccount.balance < amount) {
            Toast.makeText(this, "Insufficient funds", Toast.LENGTH_SHORT).show()
            return
        }

        // Imagine a raw HTTP call inline here:
        // httpClient.post("/transfer", body = ...)
        // followed by manually updating a TextView, dismissing a dialog,
        // and navigating back — all mixed into this one function.
    }
}

// MARK: - Model (complete — no changes needed)

data class Account(
    val id: String,
    val name: String,
    val maskedNumber: String,
    val balance: Double
)

// MARK: - TODO 1: AccountsRepository interface

interface AccountsRepository {
    // TODO: declare a suspend function to perform a transfer between two
    // accounts for a given amount. Think about what parameters and return
    // type make sense given how it will be called from the UseCase.
}

// MARK: - TODO 2: TransferEligibilityService and TransferFundsUseCase

class TransferEligibilityService {
    fun canTransfer(amount: Double, from: Account): Boolean {
        return amount > 0 && from.balance >= amount
    }
}

class TransferFundsUseCase {
    // TODO: inject AccountsRepository and TransferEligibilityService via
    // an @Inject constructor. Implement operator fun invoke(amount, from, to)
    // as a suspend function returning Result<Unit> — check eligibility
    // first, then call the repository if eligible.
}

// MARK: - TODO 3: TransferViewModel

sealed class TransferUiState {
    object Idle : TransferUiState()
    object Success : TransferUiState()
    data class Error(val message: String) : TransferUiState()
}

class TransferViewModel {
    // TODO: no Android framework import anywhere in this file below this
    // point, other than androidx.lifecycle. Annotate the class with
    // @HiltViewModel and inject TransferFundsUseCase via an @Inject
    // constructor. Expose a StateFlow<TransferUiState>. Implement
    // attemptTransfer(amount, from, to) that launches a coroutine in
    // viewModelScope, calls the use case, and updates the state.
}
