# Збереження класів SQLCipher від обфускації
-keep class net.sqlcipher.** { *; }

# Правила для збереження класів, використовуваних у Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Збереження класів для плагінів, використовуваних у додатку
-keep class com.yourplugin.** { *; }

# Інші правила ProGuard, якщо вони потрібні для вашого додатка

# Збереження аналітичних та логувальних класів, якщо використовуються
-keepattributes *Annotation*
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.view.View
-keep public class * extends java.util.ListResourceBundle
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.appwidget.AppWidgetProvider
-keep public class * extends android.inputmethodservice.InputMethodService
-keep public class * extends android.accessibilityservice.AccessibilityService
-keep public class * extends android.accounts.AbstractAccountAuthenticator
-keep public class * extends android.media.browse.MediaBrowserService
-keep public class * extends android.service.notification.NotificationListenerService
-keep public class * extends android.service.dreams.DreamService
-keep public class * extends android.service.wallpaper.WallpaperService
-keep public class * extends android.service.textservice.SpellCheckerService
-keep public class * extends android.service.voice.VoiceInteractionService
-keep public class * extends android.test.ServiceTestCase
-keep public class * extends android.test.InstrumentationTestCase
-keep public class * extends android.test.ApplicationTestCase
-keep public class * extends android.test.ActivityInstrumentationTestCase2
-keep public class * extends android.test.suitebuilder.annotation.LargeTest
-keep public class * extends android.test.suitebuilder.annotation.MediumTest
-keep public class * extends android.test.suitebuilder.annotation.SmallTest
-keep public class * extends android.location.LocationListener
-keep public class * extends android.media.AudioManager$OnAudioFocusChangeListener
-keep public class * extends android.view.View$OnClickListener
-keep public class * extends android.view.View$OnCreateContextMenuListener
-keep public class * extends android.view.View$OnDragListener
-keep public class * extends android.view.View$OnFocusChangeListener
-keep public class * extends android.view.View$OnGenericMotionListener
-keep public class * extends android.view.View$OnHoverListener
-keep public class * extends android.view.View$OnKeyListener
-keep public class * extends android.view.View$OnLayoutChangeListener
-keep public class * extends android.view.View$OnLongClickListener
-keep public class * extends android.view.View$OnSystemUiVisibilityChangeListener
-keep public class * extends android.view.View$OnTouchListener
