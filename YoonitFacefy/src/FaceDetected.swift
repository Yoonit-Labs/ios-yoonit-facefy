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

import UIKit

public class FaceDetected {
        
    public var leftEyeOpenProbability: CGFloat? = nil
    public var rightEyeOpenProbability: CGFloat? = nil
    public var smilingProbability: CGFloat? = nil
    public var headEulerAngleX: CGFloat? = nil
    public var headEulerAngleY: CGFloat? = nil
    public var headEulerAngleZ: CGFloat? = nil
    public var contours: [CGPoint] = []
    public var boundingBox: CGRect = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
    
    init(
        leftEyeOpenProbability: CGFloat?,
        rightEyeOpenProbability: CGFloat?,
        smilingProbability: CGFloat?,
        headEulerAngleX: CGFloat?,
        headEulerAngleY: CGFloat?,
        headEulerAngleZ: CGFloat?,
        contours: [CGPoint],
        boundingBox: CGRect
    ) {
        self.leftEyeOpenProbability = leftEyeOpenProbability
        self.rightEyeOpenProbability = rightEyeOpenProbability
        self.smilingProbability = smilingProbability
        self.headEulerAngleX = headEulerAngleX
        self.headEulerAngleY = headEulerAngleY
        self.headEulerAngleZ = headEulerAngleZ
        self.contours = contours
        self.boundingBox = boundingBox
    }
}
