# Creme Share plugin

A Flutter plugin to share content from your Flutter app to social apps.

## Platform Support

| Android (WIP) | iOS |
| :-----------: | :-: |
|      ❌       | ✔️  |

## Usage

To use this plugin, add `creme_share` as a dependency in your pubspec.yaml file.

```yaml
creme_sharing:
  git:
    url: https://github.com/creme-tech/creme-sharing.git
    ref: <commit id or branch name>
```

## Initial Requirements

Bellow are the obligatory requirements that your app must meet to use awesome_notifications:

### Android

WIP

### iOS

You need to add two fields in the `info.plist` file:

1. [Allow Listing Facebook's Custom URL Scheme](https://developers.facebook.com/docs/sharing/sharing-to-stories/ios-developers), twitter and whatsapp that's just add the text below on `info.plist`:

```plist
...
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>whatsapp</string>
		<string>twitter</string>
		<string>instagram</string>
		<string>instagram-stories</string>
	</array>
...
```

2. Add NSPhotoLibraryUsageDescription field on `info.plist` seems like:

```plist
...
<key>NSPhotoLibraryUsageDescription</key>
	<string>for storage temporary images before share to Instagram</string>
...
```

You can see that configuration on the example app on [commit fab7671f21ed8eb8998c589b7423dbc36374da82](https://github.com/creme-tech/creme-sharing/commit/fab7671f21ed8eb8998c589b7423dbc36374da82).

## Example Apps

<br>

With the examples bellow, you can check all the features and how to use the Creme Sharing in your app.

https://github.com/creme-tech/creme-sharing/tree/main/example <br>
Complete example with all the features available

To run the [examples](https://github.com/creme-tech/creme-sharing/tree/main/example), follow the steps bellow:

1. Clone the [project](https://github.com/creme-tech/creme-sharing) to your local machine
2. Open the [project](https://github.com/creme-tech/creme-sharing) with Android Studio or any other IDE
3. Sync the [project](https://github.com/creme-tech/creme-sharing) dependencies running `flutter pub get`
4. On iOS, run `pod install` to sync the native dependencies
5. Debug the application with a real device or emulator

<br>
