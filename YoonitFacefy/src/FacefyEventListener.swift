//
// +-+-+-+-+-+-+
// |y|o|o|n|i|t|
// +-+-+-+-+-+-+
//
// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
// | Yoonit Camera lib for iOS applications                          |
// | Haroldo Teruya @ Cyberlabs AI 2020                              |
// +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//


import Foundation
import UIKit

@objc
public protocol FacefyEventListener {
        
    func onFaceAnalysis(
        _ leftEyeOpenProbability: CGFloat,
        _ rightEyeOpenProbability: CGFloat,
        _ smilingProbability: CGFloat
    )

    func onContoursDetected(_ faceContours: [CGPoint])

    func onFaceDetected(_ boundingBox: CGRect)
}

