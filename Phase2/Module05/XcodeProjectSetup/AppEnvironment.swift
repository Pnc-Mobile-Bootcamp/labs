//
//  AppEnvironment.swift
//  PNCMobileApp
//
//  Module 5 — The iOS Development Environment
//  Section 5.3, Step 4: Read the environment at runtime
//
//  Reads the API_ENVIRONMENT value set per-scheme (see Step 3) and resolves
//  the correct backend base URL with no code change required to switch
//  between Dev, Staging, and Prod.
//

import Foundation

enum AppEnvironment {
    static var baseURL: URL {
        switch ProcessInfo.processInfo.environment["API_ENVIRONMENT"] {
        case "prod":
            return URL(string: "https://api.pncmobile.com")!
        case "staging":
            return URL(string: "https://api-staging.pncmobile.com")!
        default:
            return URL(string: "https://api-dev.pncmobile.com")!
        }
    }

    /// Human-readable label, useful for a debug banner or console log
    /// so a participant can immediately confirm which scheme is active.
    static var label: String {
        switch ProcessInfo.processInfo.environment["API_ENVIRONMENT"] {
        case "prod":
            return "PRODUCTION"
        case "staging":
            return "STAGING"
        default:
            return "DEV"
        }
    }
}
