# TaskManager

A SwiftUI habit tracker for iPhone and iPad. Add a habit with a color, the weekdays it repeats on, how many times per day, and an optional daily reminder. Habits are stored with Core Data, and reminders are local notifications (`UNCalendarNotificationTrigger`, repeating weekly per selected day).

Built in October 2022 with Xcode 14.0.1.

## Requirements

- Xcode 14 or newer
- iOS / iPadOS 16.0+ (simulator or device)

## Run it

1. Clone the repo and open `TaskManager.xcodeproj` in Xcode.
2. Select the **TaskManager** target, open **Signing & Capabilities**, and choose your own Team. The project carries the original author's team ID, so builds to a device fail until you change it. If Xcode reports the bundle ID is taken, change `com.tylerdev.TaskManager` to your own.
3. Pick a simulator (or your device) and press **Run** (Cmd+R).
4. Allow notifications when prompted, or reminders will not fire.

No third-party packages or API keys are needed.

## Project layout

| File | Purpose |
|---|---|
| `TaskManagerApp.swift` | App entry point |
| `ContentView.swift` | Custom tab bar: Home (habit list), Add, Profile (placeholder) |
| `AddTaskView.swift` | New-habit form: title, description, color, weekdays, per-day count, reminder |
| `TaskDetailView.swift` | Habit detail with delete |
| `EditTaskView.swift` | Stub edit screen (not linked from any view yet) |
| `HabitCardView.swift` | Card shown in the Home list |
| `TaskViewModel.swift` | Core Data CRUD (its own `NSPersistentContainer`) and notification scheduling |
| `CustomTabBar*.swift`, `TabBarItem*.swift` | The custom tab bar |
| `Persistence.swift` | Xcode's Core Data template; the app does not use it (`TaskViewModel` loads the store) |
| `TaskManager.xcdatamodeld` | `Task` entity |
