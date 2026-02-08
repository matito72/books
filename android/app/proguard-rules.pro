# Regole per sopprimere gli avvisi di ML Kit Text Recognition
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**

# Mantieni le classi di ML Kit per evitare il crash all'avvio
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.internal.ml.** { *; }

# Preserva le interfacce dei plugin Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Specifico per path_provider e pigeon (che appare nell'errore)
-keep class dev.flutter.pigeon.** { *; }
-keep class com.baseflow.pathprovider.** { *; }

# Impedisce l'offuscamento dei nomi dei metodi dei plugin
-keepclassmembers class * extends io.flutter.plugin.common.MethodChannel$MethodCallHandler {
    <fields>;
    <methods>;
}

# Sopprime gli avvisi per le classi del Play Store (Deferred Components)
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# Se l'errore persiste su singole classi citate nel log, puoi aggiungere:
-keep class com.google.android.play.core.** { *; }