# Tweaks

**A Swift framework for runtime configuration and debugging with automatic UI generation.**

Tweaks provides a property wrapper that makes any value adjustable at runtime through an automatically generated settings interface. Perfect for tweaking animations, experimenting with layouts, debugging feature flags, or quickly iterating on design values without recompiling.

## Features

- 🎛️ **Automatic UI Generation** - Every `@Tweakable` property automatically gets the appropriate control in the editor
- 💾 **Persistent Storage** - All values are stored in a single JSON blob in UserDefaults
- 🔄 **Real-time Updates** - Changes in the editor instantly update your app
- 🎨 **Type-Safe** - Supports String, Bool, Int, and Double with full type safety

## Installation

### Swift Package Manager

Add Tweakable to your project through Xcode:

1. File → Add Package Dependencies
2. Enter the repository URL
3. Select your desired version

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/raulriera/Tweaks.git", from: "1.0.0")
]
```

## Usage

### Basic Setup

1. Import Tweaks in your Swift file:

```swift
import Tweaks
```

2. Mark any property with `@Tweakable`:

```swift
struct ContentView: View {
    @Tweakable("animationDuration") private var animationDuration: Double = 0.3
    @Tweakable("maxItems") private var maxItems: Int = 10
    @Tweakable("apiEndpoint") private var apiEndpoint: String = "https://api.example.com"

    var body: some View {
        // Your UI here
    }
}
```

3. Present the `TweaksEditor` anywhere in your app:

```swift
struct SettingsView: View {
    var body: some View {
        NavigationStack {
            TweaksEditor()
        }
    }
}
```

### Generated UI Controls

Tweaks automatically creates the appropriate control for each type:

- **String** → TextField
- **Bool** → Toggle
- **Int** → Stepper
- **Double** → Number TextField

## How It Works

1. Each `@Tweakable` property automatically registers itself with the `TweakableRegistry`
2. All values are stored together in a single JSON dictionary under the key `__tweaks_storage__`
3. The `TweaksEditor` view reads the registry and generates UI controls dynamically
4. Changes are instantly synchronized across all instances via UserDefaults notifications

## Example App

Check out the contents of the `/TweaksExample` folder.

## Limitations

- Currently supports String, Bool, Int, and Double types
- Values must be JSON-serializable
- All values share a single UserDefaults storage key

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Tweakable is available under the MIT license. See the LICENSE file for more info.

## Acknowledgments

Inspired by SwiftUI's `@AppStorage` property wrapper and various runtime configuration tools from the iOS development community.
