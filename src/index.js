import React, {Component} from 'react';
import {NativeModules} from 'react-native';

import {
	StyleSheet,
	Text,
	TouchableOpacity,
	View
} from 'react-native';

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

const {MyModule} = NativeModules;

console.log ('MyModule', MyModule);

export default class ReactNativeModulePlayground extends Component {

	onRunPress = () => {

		MyModule
			.MyMethod ()
			.then ((result) => {
				console.log ('result', result);
			})
			.catch ((err) => {
				console.error ('error', err);
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