# React Native Module Playground

```
npm i ./my-dev-modulename --save
react-native link my-dev-modulename
```

Check `src/components/index.js`

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