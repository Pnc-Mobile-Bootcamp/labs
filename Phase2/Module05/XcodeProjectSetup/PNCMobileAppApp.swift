//
//  PNCMobileAppApp.swift
//  PNCMobileApp
//
//  Module 5 — The iOS Development Environment
//  Section 5.3, Step 7: Implement lifecycle-aware behavior
//
//  This is the @main entry point for the app. It observes scenePhase and
//  reacts to background/active transitions, laying the groundwork for the
//  session-timeout requirement built out fully in the Session Timeout Lab
//  (see 02_Session_Timeout_Lab/).
//

import SwiftUI

@main
struct PNCMobileApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .background:
                session.recordBackgroundTimestamp()
            case .active:
                session.evaluateSessionTimeout()
            default:
                break
            }
        }
    }
}

/// Placeholder root view. Replace with real navigation starting in Module 6.
struct RootView: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        VStack(spacing: 16) {
            Text("PNC Mobile")
                .font(.largeTitle.bold())
            Text("Environment: \(AppEnvironment.label)")
                .font(.footnote)
                .foregroundStyle(.secondary)
            if session.isSessionExpired {
                Text("Session expired — please log in again")
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}
