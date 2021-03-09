//
// +-+-+-+-+-+-+
// |y|o|o|n|i|t|
// +-+-+-+-+-+-+
//
// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// | Yoonit Facefy lib for iOS applications                          |
// | Haroldo Teruya @ Cyberlabs AI 2021                              |
// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//

import Foundation
import UIKit
import Vision

@objc
public class Facefy: NSObject {
    
    var facefyController = FacefyController()
    
    public func detect(
        _ image: UIImage,
        onSuccess: @escaping (FaceDetected?) -> Void,
        onError: @escaping (String) -> Void
    ) {
        self.facefyController.detect(
            image: image,
            onSuccess: onSuccess,
            onError: onError
        )
    }
}
