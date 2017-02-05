import React, {Component} from 'react';
import {NativeModules, DeviceEventEmitter} from 'react-native';

import {
	StyleSheet,
	Text,
	TouchableOpacity,
	View
} from 'react-native';

import ExampleModule from 'react-native-example-module';

console.log (NativeModules);

export default class ReactNativeModulePlayground extends Component {

	componentDidMount () {

		DeviceEventEmitter.addListener ('example-module:event', (data) => {
			console.log ('example module event', data);
		});

	}

	onRunPress = () => {

		ExampleModule
			.eventMethod ();

		ExampleModule
			.callbackMethod ({},
				(result) => {
					console.log ('callback result:', result);
				},
				(err) => {
					console.log ('callback error:', err);
				}
			);

		ExampleModule
			.promiseMethod ()
			.then ((result) => {
				console.log ('promise result:', result);
			})
			.catch ((err) => {
				console.log ('promise error:', err);
			});

		ExampleModule
			.nativeMethod ()
			.then ((result) => {
				console.log ('native result', result);
			})
			.catch ((err) => {
				console.log ('native error', err);
			});

	}

	render () {
		const {onRunPress} = this;

		return (
			<View style={styles.container}>
				<Text>
					Welcome to React Native!
				</Text>

				<TouchableOpacity
					style={styles.button}
					onPress={onRunPress}>
					<Text>RUN</Text>
				</TouchableOpacity>

			</View>
		);
	}
}

const styles = StyleSheet.create ({
	container: {
		flex: 1,
		justifyContent: 'center',
		alignItems: 'center',
		backgroundColor: '#FFF'
	},
    button: {
        margin: 30,
        padding: 30,
        backgroundColor: '#EEE'
    }
});
