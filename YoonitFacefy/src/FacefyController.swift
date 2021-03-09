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
                                           
            var faceContours: [CGPoint] = []
            
            // Get face analysis classification.
            let leftEyeOpenProbability: CGFloat? = face.hasRightEyeOpenProbability ? face.rightEyeOpenProbability : nil
            let rightEyeOpenProbability: CGFloat? = face.hasLeftEyeOpenProbability ? face.leftEyeOpenProbability : nil
            let smilingProbability: CGFloat? = face.hasSmilingProbability ? face.smilingProbability : nil
            let headEulerAngleX: CGFloat? = face.hasHeadEulerAngleX ? face.headEulerAngleX : nil
            let headEulerAngleY: CGFloat? = face.hasHeadEulerAngleY ? face.headEulerAngleY : nil
            let headEulerAngleZ: CGFloat? = face.hasHeadEulerAngleZ ? face.headEulerAngleZ : nil
            
            // Get face contours.
            if !face.contours.isEmpty {
                for faceContour in face.contours {
                    for point in faceContour.points {
                        faceContours.append(CGPoint(x: point.x, y: point.y))
                    }
                }
            }
         
            onSuccess(
                FaceDetected(
                    leftEyeOpenProbability: leftEyeOpenProbability,
                    rightEyeOpenProbability: rightEyeOpenProbability,
                    smilingProbability: smilingProbability,
                    headEulerAngleX: headEulerAngleX,
                    headEulerAngleY: headEulerAngleY,
                    headEulerAngleZ: headEulerAngleZ,
                    contours: faceContours,
                    boundingBox: face.frame
                )
            )
        }
    }
}
