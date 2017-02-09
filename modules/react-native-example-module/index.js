import {NativeModules} from 'react-native';

const {ExampleModule} = NativeModules;
const noop = () => {};

if (!ExampleModule) {
    throw new Error ('ExampleModule not found');
}

class ExampleModuleBridge {

    static CACHE_DIR_PATH = ExampleModule.CACHE_DIR_PATH
    static FILES_DIR_PATH = ExampleModule.FILES_DIR_PATH

    callbackMethod (
        options = {},
        callback = noop,
        errback = noop
    ) {
        return ExampleModule
            .callbackMethod
            .call (ExampleModule, options, callback, errback);
    }

    promiseMethod (options = {}) {
        return ExampleModule
            .promiseMethod
            .call (ExampleModule, options);
    }

    nativeMethod (options = {}) {
        return ExampleModule
            .nativeMethod
            .call (ExampleModule, options);
    }

    eventMethod (options = {}) {
        return ExampleModule
            .eventMethod
            .call (ExampleModule, options);
    }

}

export default new ExampleModuleBridge ()