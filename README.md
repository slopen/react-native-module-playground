# React Native Module Playground

## Init

```
git clone https://github.com/slopen/react-native-module-playground.git
cd react-native-module-playground
npm i

npm run android
npm run ios

```

Check `/modules/react-native-example-module`


## Link Module

```
npm link ./modules/react-native-example-module
react-native link react-native-example-module
```

[npm link](https://docs.npmjs.com/cli/link)
[swift bridging](https://gist.github.com/robertjpayne/855fdb15d5ceca12f6c5)


## Example Module

```
ExampleModule
    .callbackMethod ({},
        (result) => {
            console.log ('callback result', result);
        },
        (err) => {
            console.log ('callback error', err);
        }
    );

ExampleModule
    .promiseMethod ()
    .then ((result) => {
        console.log ('promise result', result);
    })
    .catch ((err) => {
        console.log ('promise error', err);
    });

ExampleModule
    .activityMethod ()
    .then ((result) => {
        console.log ('activity result', result);
    })
    .catch ((err) => {
        console.log ('activity error', err);
    });

ExampleModule
    .eventMethod ();

```