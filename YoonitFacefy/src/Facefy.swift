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
        onFaceDetected: @escaping (FaceDetected) -> Void,
        onMessage: @escaping (String) -> Void
    ) {
        self.facefyController.detect(
            image: image,
            onFaceDetected: onFaceDetected,
            onMessage: onMessage
        )
    }
}
