//
//  SessionManager_Starter.swift
//  PNCMobileApp
//
//  Module 5 — The iOS Development Environment
//  Lab Exercise: Session Timeout Manager
//
//  SCENARIO
//  Banking apps are required to automatically log a user out after a period
//  of inactivity for security compliance. Your task is to implement a
//  SessionManager that uses the app lifecycle concepts from this module to
//  enforce a session timeout, without relying on any UI code or third-party
//  library.
//
//  REQUIREMENTS
//  1. SessionManager must be an ObservableObject so SwiftUI views can react
//     to its published state.
//  2. It must record a timestamp the moment the app enters the .background
//     scene phase.
//  3. When the app returns to .active, it must compare the current time to
//     the recorded background timestamp.
//  4. If more than 5 minutes have elapsed, it must set a published
//     isSessionExpired flag to true.
//  5. If less than 5 minutes have elapsed, the session remains valid and no
//     flag changes.
//  6. The timeout threshold (5 minutes) must be a named constant, not a
//     magic number, per the Phase 01 clean code conventions.
//
//  Implement both TODO methods below. 
//

import Foundation

class SessionManager: ObservableObject {
    @Published var isSessionExpired: Bool = false

    // TODO: implement recordBackgroundTimestamp()
    // Called when the app's scenePhase transitions to .background.
    // Should record "now" somewhere the class can compare against later.

    // TODO: implement evaluateSessionTimeout()
    // Called when the app's scenePhase transitions to .active.
    // Should compare "now" to the recorded background timestamp, and set
    // isSessionExpired = true if more than 5 minutes have elapsed.
}
