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
import MLKit

public class FacefyController {
                       
    private let faceDetector: FaceDetector
    
    init() {
        let options: FaceDetectorOptions = FaceDetectorOptions()
        options.performanceMode = .fast
        options.landmarkMode = .all
        options.contourMode = .all
        options.classificationMode = .all
        
        self.faceDetector = FaceDetector.faceDetector(options: options)
    }
    
    public func detect(
        image: UIImage,
        onSuccess: @escaping (FaceDetected?) -> Void,
        onError: @escaping (String) -> Void
    ) {
        let visionImage: VisionImage = VisionImage(image: image)

        weak var weakSelf = self
        self.faceDetector.process(visionImage) {
            faces, error in
            
            guard weakSelf != nil else {
                onSuccess(nil)
                return
            }

            guard error == nil, let faces = faces, !faces.isEmpty else {
                onSuccess(nil)
                return
            }
                                    
            // The closest face.
            let face: Face = faces.sorted {
                return $0.frame.width > $1.frame.width
            }[0]
                                                                                   
            // Get face contours.
            var faceContours: [CGPoint] = []
            if !face.contours.isEmpty {
                for faceContour in face.contours {
                    for point in faceContour.points {
                        faceContours.append(CGPoint(x: point.x, y: point.y))
                    }
                }
            }
         
            onSuccess(
                FaceDetected(
                    boundingBox: face.frame,                    
                    leftEyeOpenProbability: Float(face.rightEyeOpenProbability),
                    hasLeftEyeOpenProbability: face.hasRightEyeOpenProbability,
                    rightEyeOpenProbability: Float(face.leftEyeOpenProbability),
                    hasRightEyeOpenProbability: face.hasLeftEyeOpenProbability,
                    smilingProbability: Float(face.smilingProbability),
                    hasSmilingProbability: face.hasSmilingProbability,
                    headEulerAngleX: Float(face.headEulerAngleX),
                    hasHeadEulerAngleX: face.hasHeadEulerAngleX,
                    headEulerAngleY: Float(face.headEulerAngleY),
                    hasHeadEulerAngleY: face.hasHeadEulerAngleY,
                    headEulerAngleZ: Float(face.headEulerAngleZ),
                    hasHeadEulerAngleZ: face.hasHeadEulerAngleZ,
                    contours: faceContours
                )
            )
        }
    }
}
