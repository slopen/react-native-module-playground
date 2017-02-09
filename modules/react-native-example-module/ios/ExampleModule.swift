import Foundation

@objc(ExampleModule)
class ExampleModule: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var bridge: RCTBridge!

    var activityPromiseResolver: RCTPromiseResolveBlock?
    var activityPromiseRejecter: RCTPromiseRejectBlock?

    @objc func constantsToExport () -> NSDictionary {
        return [
            "FILES_DIR_PATH": Bundle.main.bundlePath,
            "CACHE_DIR_PATH": NSTemporaryDirectory ()
        ]
    }


    @objc func callbackMethod (
        _ options: NSDictionary,
        callback: RCTResponseSenderBlock,
        errback: RCTResponseSenderBlock
    ) {
        do {
            try callback (["hello from callback"])
        }
        catch {
            errback ([Thread.callStackSymbols])
        }
    }


    @objc func promiseMethod (
        _ options: NSDictionary,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) {
        let result: NSDictionary = [
            "message": "hello from promise"
        ]

        do {
            try resolve (result)
        }
        catch {
            let error: Error = NSError (domain: "promise.error", code: 0, userInfo: nil)
            let errorCode: String = "0"

            reject (errorCode, Thread.callStackSymbols.joined (), error)
        }
    }

    @objc func eventMethod (
        _ options: NSDictionary
    ) {
        let result: NSDictionary = [
            "message": "hello from event"
        ]

        self.bridge
            .eventDispatcher ()
            .sendAppEvent (
                withName: "example-module:event",
                body: result
            )
    }

    @objc func nativeMethod (
        _ options: NSDictionary,
        resolver resolve: @escaping RCTPromiseResolveBlock,
        rejecter reject: @escaping RCTPromiseRejectBlock
    ) {

        DispatchQueue.main.async {
            let controller: UIImagePickerController = UIImagePickerController ()

            controller.delegate = self;
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            controller.allowsEditing = false;

            self.getRootViewController ()
                .present (controller, animated: true, completion: nil)

            self.activityPromiseResolver = resolve
            self.activityPromiseRejecter = reject
        }

    }

    internal func getRootViewController () -> UIViewController {
        var root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController

        if root?.presentedViewController != nil {
            root = root!.presentedViewController
        }

        return root!
    }

    internal func imagePickerController (
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : Any]
    ) {
        let pickedImage: UIImage = info [UIImagePickerControllerOriginalImage] as! UIImage
        let mediaType: String = info [UIImagePickerControllerMediaType] as! String
        let imageUrl: NSURL = info [UIImagePickerControllerReferenceURL] as! NSURL
        let path = imageUrl.absoluteString

        self.activityPromiseResolver! ([
            "path": path,
            "type": mediaType,
            "message": "hello from native method"
        ])

        picker.dismiss (animated: true, completion:nil)

        self.activityPromiseResolver = nil
        self.activityPromiseRejecter = nil

    }

    internal func imagePickerControllerDidCancel (
        _ picker: UIImagePickerController
    ) {
        let error: Error = NSError (domain: "native.method.error", code: 0, userInfo: nil)
        let errorCode: String = "0"

        self.activityPromiseRejecter! (errorCode, "CANCELLED", error)

        picker.dismiss (animated: true, completion:nil)

        self.activityPromiseResolver = nil
        self.activityPromiseRejecter = nil
    }
}
