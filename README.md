# React Native Module Playground

```
npm link ./modules/my-dev-modulename
react-native link my-dev-modulename
```

# Example

check `src/index.js`

```
MyModule
    .MyMethod ()
    .then ((result) => {
        console.log ('result', result);
    })
    .catch ((err) => {
        console.error ('error', err);
    });
```

# Example Module boilerplate

Android / iOS Obj-C

```
git checkout example-module-android-iosobjc
```

Android / iOS Swift

```
git checkout example-module-android-iosswift
```

boilerplate files are in `modules/react-native-example-module`
uses [react-native-example-module](https://github.com/slopen/react-native-example-module) but with XCode setup