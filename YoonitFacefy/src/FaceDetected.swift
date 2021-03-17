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
            
    public var boundingBox: CGRect
    public var leftEyeOpenProbability: Float?
    public var rightEyeOpenProbability: Float?
    public var smilingProbability: Float?
    public var headEulerAngleX: Float?
    public var headEulerAngleY: Float?
    public var headEulerAngleZ: Float?
    public var contours: [CGPoint] = []
    
    init(
        boundingBox: CGRect,
        leftEyeOpenProbability: Float?,
        rightEyeOpenProbability: Float?,
        smilingProbability: Float?,
        headEulerAngleX: Float?,
        headEulerAngleY: Float?,
        headEulerAngleZ: Float?,
        contours: [CGPoint]
    ) {
        self.boundingBox = boundingBox
        self.leftEyeOpenProbability = leftEyeOpenProbability
        self.rightEyeOpenProbability = rightEyeOpenProbability
        self.smilingProbability = smilingProbability
        self.headEulerAngleX = headEulerAngleX
        self.headEulerAngleY = headEulerAngleY
        self.headEulerAngleZ = headEulerAngleZ        
        self.contours = contours
    }
}
