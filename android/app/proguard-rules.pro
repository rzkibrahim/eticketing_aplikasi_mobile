# ==============================================================================
# Flutter ProGuard Rules
# ==============================================================================

# Keep Flutter engine
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep annotations
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Keep Google Fonts (used in this project)
-keep class com.google.android.gms.** { *; }

# Keep classes that use reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Suppress warnings
-dontwarn io.flutter.embedding.**
-dontwarn android.content.**

# Keep Kotlin metadata
-keepclassmembers class kotlin.Metadata { *; }
