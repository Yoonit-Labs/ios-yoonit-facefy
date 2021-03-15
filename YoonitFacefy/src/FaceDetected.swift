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
    public var leftEyeOpenProbability: Float
    public var hasLeftEyeOpenProbability: Bool
    public var rightEyeOpenProbability: Float
    public var hasRightEyeOpenProbability: Bool
    public var smilingProbability: Float
    public var hasSmilingProbability: Bool
    public var headEulerAngleX: Float
    public var hasHeadEulerAngleX: Bool
    public var headEulerAngleY: Float
    public var hasHeadEulerAngleY: Bool
    public var headEulerAngleZ: Float
    public var hasHeadEulerAngleZ: Bool
    public var contours: [CGPoint] = []
    
    init(
        boundingBox: CGRect,
        leftEyeOpenProbability: Float,
        hasLeftEyeOpenProbability: Bool,
        rightEyeOpenProbability: Float,
        hasRightEyeOpenProbability: Bool,
        smilingProbability: Float,
        hasSmilingProbability: Bool,
        headEulerAngleX: Float,
        hasHeadEulerAngleX: Bool,
        headEulerAngleY: Float,
        hasHeadEulerAngleY: Bool,
        headEulerAngleZ: Float,
        hasHeadEulerAngleZ: Bool,
        contours: [CGPoint]
    ) {
        self.boundingBox = boundingBox
        self.leftEyeOpenProbability = leftEyeOpenProbability
        self.hasLeftEyeOpenProbability = hasLeftEyeOpenProbability
        self.rightEyeOpenProbability = rightEyeOpenProbability
        self.hasRightEyeOpenProbability = hasRightEyeOpenProbability
        self.smilingProbability = smilingProbability
        self.hasSmilingProbability = hasSmilingProbability
        self.headEulerAngleX = headEulerAngleX
        self.hasHeadEulerAngleX = hasHeadEulerAngleX
        self.headEulerAngleY = headEulerAngleY
        self.hasHeadEulerAngleY = hasHeadEulerAngleY
        self.headEulerAngleZ = headEulerAngleZ
        self.hasHeadEulerAngleZ = hasHeadEulerAngleZ
        self.contours = contours
    }
}
