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

public class Facefy {
    
    private var facefyController = FacefyController()
    
    public init() {}
    
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
