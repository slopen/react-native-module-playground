# React Native Module Playground

```
npm i ./my-dev-modulename --save
react-native link my-dev-modulename
```

Also check [npm link](https://docs.npmjs.com/cli/link)


# Example

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