# Hidush

Something new happens

## Install

### Flutter installation

* Download `flutter` from official site.
* Put in `/Users/emanuel/tools` folder (or any other desired folder).
* Add to your `~/.zshrc` the command `export PATH="$PATH:/Users/emanuel/tools/flutter/bin"`.

### Android Settings

* Install android studio
* Go to android studio. Preferences | Appearance & Behavior | System Settings | Android SDK. in SDK Tools tab, install Andriod SDK Command-line tools.
* Run `flutter doctor --android-licenses`

### iOS Settings

* Install Xcode from app store.


### Install Firebase

* Run the following commands in the hidush working directory
* `curl -sL https://firebase.tools | bash`
* `dart pub global activate flutterfire_cli`
* Add `export PATH="$PATH":"$HOME/.pub-cache/bin"` to `~/.zshrc`
* Run `flutterfire configure`
* Make sure to move `firebase_options.dart` to `lib/common`
* Integrate google play console with firebase (App integrity SHA1/SHA256)
* Make sure to update `build.gradle` based on firebase `SDK instructions`
* Run `./gradlew signingReport` from `andriod` directory and copy the SHA1 to firestorm.
* In the end make sure to do `flutter clean`


## Deploying Google Functions

Run the following command in the directory that contains the `main.py` file

```
gcloud beta functions deploy cms-upsert-hidush \
--gen2 \
--runtime python39 \
--trigger-http \
--entry-point main_upsert_hidush \
--memory 128Mi \
--set-env-vars CMS_API_KEY=XXXXXXX \
--source . \
--allow-unauthenticated
```

### Test the function

```
gcloud beta functions describe cms-upsert-hidush --gen2
```

## Test on Physical Phone

Run `flutter run --release`

## Release

Follow this guide https://docs.flutter.dev/deployment/android#signing-the-app and create `key.properties` etc.