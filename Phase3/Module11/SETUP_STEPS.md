# Setup Steps: Configure PNC Mobile Android for Enterprise Delivery
### Module 11, Lab Exercise — copy-reference version

Complete each step in Android Studio as you read. This file mirrors the lab exactly
and exists so you don't have to hand-transcribe code from a slide.

---

## Step 1: Create the project

1. Android Studio \u2192 **New Project**.
2. Choose the **Empty Activity** template under the **Compose** category.
3. Configure:
   - Name: `PNC Mobile`
   - Package name: `com.pnc.mobileapp`
   - Minimum SDK: **API 26 (Android 8.0)**
   - Build configuration language: **Kotlin DSL (build.gradle.kts)**
4. Let the initial Gradle sync complete before continuing.

## Step 2: Set SDK versions

Confirm in the module-level `build.gradle.kts` (see `app_build.gradle.kts` in this
folder for the complete reference):

- `compileSdk = 34`     <!-- could be up to 37 -->
- `minSdk = 26`
- `targetSdk = 34`      <!-- could be up to 37 -->

## Step 3: Add the required permissions

Open `app/manifests/AndroidManifest.xml` and add the `<uses-feature>` and 
the two `<uses-permission>` entries from `AndroidManifest.xml` in this folder, 
above the `<application>` tag.

## Step 4: Configure three product flavors

In the module-level `build.gradle.kts`, inside the `android { }` block, add:

```kotlin
flavorDimensions += "environment"
productFlavors {
    create("dev") {
        dimension = "environment"
        applicationIdSuffix = ".dev"
        buildConfigField("String", "BASE_URL", "\"https://api-dev.pncmobile.com\"")
    }
    create("staging") {
        dimension = "environment"
        applicationIdSuffix = ".staging"
        buildConfigField("String", "BASE_URL", "\"https://api-staging.pncmobile.com\"")
    }
    create("prod") {
        dimension = "environment"
        buildConfigField("String", "BASE_URL", "\"https://api.pncmobile.com\"")
    }
}

buildFeatures {
    buildConfig = true      <!-- merge this into the existing buildFeatures -->
}
```

Note the `buildFeatures { buildConfig = true }` block — recent Android Gradle Plugin
versions require this to be explicitly enabled before `buildConfigField` values are
generated into `BuildConfig`.

## Step 5: Add a dependency via the version catalog

1. Open `gradle/libs.versions.toml`.
2. Add the entries from `libs.versions.toml` in this folder under `[versions]` and
   `[libraries]`.
3. In the module-level `build.gradle.kts`, add to the `dependencies { }` block:
   ```kotlin
   implementation(libs.retrofit)
   ```
4. Sync the project.

## Step 6: Verify across all three flavors

1. Open **Build > Select Build Variant** (or the Build Variants panel).
2. Switch between `devDebug`, `stagingDebug`, and `prodDebug`.
3. For each, run the app and confirm (e.g. via a `Log.d` call printing
   `BuildConfig.BASE_URL`) that the correct base URL is active.
4. Confirm all three flavors build without errors.

You now have an Android project configured the way an enterprise Android team
actually configures one — before a single meaningful feature has been built.
