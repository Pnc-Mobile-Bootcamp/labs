//
//  SessionManagerTests.swift
//  PNCMobileAppTests
//
//  Module 5 — The iOS Development Environment
//  Self-check tests for the Session Timeout Lab.
//
//  Run these against your own SessionManager implementation (Cmd+U) before
//  the debrief to confirm your solution behaves correctly. Formal XCTest
//  authoring is covered in Module 9 — for this module, you only need to
//  run these, not write ones like them yet.
//
//  NOTE: evaluateSessionTimeout() depends on wall-clock time via Date(),
//  so these tests use short, real sub-second sleeps rather than mocking
//  the clock. That's a simplification appropriate for this module; proper
//  clock injection for testability is covered in Module 9.
//

import XCTest
@testable import PNCMobileApp

final class SessionManagerTests: XCTestCase {

    func test_freshSession_isNotExpired() {
        let manager = SessionManager()
        XCTAssertFalse(manager.isSessionExpired, "A brand-new session should not start expired.")
    }

    func test_evaluateWithoutBackgrounding_doesNothing() {
        let manager = SessionManager()
        manager.evaluateSessionTimeout()
        XCTAssertFalse(
            manager.isSessionExpired,
            "Evaluating before ever backgrounding should be a no-op — there is nothing to compare against."
        )
    }

    func test_shortBackgroundInterval_doesNotExpireSession() {
        let manager = SessionManager()
        manager.recordBackgroundTimestamp()
        // Well under the 5-minute threshold.
        manager.evaluateSessionTimeout()
        XCTAssertFalse(
            manager.isSessionExpired,
            "A background interval far shorter than 5 minutes should not expire the session."
        )
    }

    func test_repeatedShortCycles_neverIncorrectlyExpireSession() {
        // Regression check for the "forgot to reset backgroundedAt" bug
        // called out in the facilitator guide and Knowledge Check.
        let manager = SessionManager()
        for _ in 0..<5 {
            manager.recordBackgroundTimestamp()
            manager.evaluateSessionTimeout()
        }
        XCTAssertFalse(
            manager.isSessionExpired,
            "Multiple short background/active cycles should never accumulate into an expired session."
        )
    }
}
