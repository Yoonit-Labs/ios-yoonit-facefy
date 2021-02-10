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

public protocol FacefyEventListener {
        
    func onFaceAnalysis(
        _ leftEyeOpenProbability: CGFloat?,
        _ rightEyeOpenProbability: CGFloat?,
        _ smilingProbability: CGFloat?,
        _ headEulerAngleX: CGFloat?,
        _ headEulerAngleY: CGFloat?,
        _ headEulerAngleZ: CGFloat?
    )

    func onContours(_ faceContours: [CGPoint])

    func onFace(_ boundingBox: CGRect)
}

