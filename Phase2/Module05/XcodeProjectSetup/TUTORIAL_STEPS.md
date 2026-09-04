# Tutorial: Configuring PNCMobileApp for Enterprise Development
### Module 5, Section 5.3 — copy-reference version

Complete each step in Xcode as you read. This file exists so you 
don't have to hand-transcribe code from a slide.

---

## Step 1: Create the project

1. Open Xcode → **Create a New Xcode Project**.
2. Choose **iOS** → **App**.
3. Configure:
   - Product Name: `PNCMobileApp`
   - Team: your development team
   - Organization Identifier: `com.pnc`
   - Bundle Identifier (auto-generated): `com.pnc.mobileapp`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Include Tests: checked
4. Save to a local Git repository.

## Step 2: Set the deployment target

1. Select the project → the `PNCMobileApp` target → **General** tab.
2. Under **Minimum Deployments**, set **iOS 16.0**.

## Step 3: Create three schemes for three environments

1. **Product > Scheme > Manage Schemes**. (menu)
2. Duplicate the default scheme twice: `PNCMobileApp-Dev`, `PNCMobileApp-Staging`,
   `PNCMobileApp-Prod`.
3. For each scheme: **Edit Scheme > Run > Arguments** → add environment variable
   `API_ENVIRONMENT` with value `dev`, `staging`, or `prod`. (use the Manage Schemes button to go back)

## Step 4: Read the environment at runtime

Add `AppEnvironment.swift` (provided in this folder) to your project.

## Step 5: Configure Info.plist

Add the keys from `PNCMobileApp_Info_Additions.plist.xml` (provided in this folder)
to your project's Info.plist.

## Step 6: Add a Swift Package dependency

1. **File > Add Package Dependencies**.
2. URL: `https://github.com/Alamofire/Alamofire.git`
3. Rule: **Up to Next Major Version**, starting at `5.8.0`.
4. Add the `Alamofire` product to the `PNCMobileApp` target.

## Step 7: Implement lifecycle-aware behavior

Replace your generated `PNCMobileAppApp.swift` with the version provided in this
folder (it references `SessionManager`, built in the lab exercise — add a stub or
complete the lab first).

## Step 8: Verify across simulators

1. **Window > Devices and Simulators** (`Cmd+Shift+2`). Confirm you have an
   iPhone SE, an iPhone 15 Pro, and an iPad simulator available.
2. Build and run (`Cmd+R`) against each, switching device in the toolbar.
3. Confirm no crash on any of the three, and that the correct `API_ENVIRONMENT`
   value prints for each active scheme.

You now have a project configured the way an enterprise iOS team actually
configures one — before a single meaningful feature has been built.
