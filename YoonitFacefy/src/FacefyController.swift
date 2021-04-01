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
import MLKit

public class FacefyController {
                       
    private let faceDetector: FaceDetector
    
    init() {
        let options = FaceDetectorOptions()
        options.performanceMode = .fast
        options.landmarkMode = .none
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
            
            let rightEyeOpenProbability: Float? = face.hasRightEyeOpenProbability ? Float(face.rightEyeOpenProbability) : nil
            let leftEyeOpenProbability: Float? = face.hasLeftEyeOpenProbability ? Float(face.leftEyeOpenProbability) : nil
            let smilingProbability: Float? = face.hasSmilingProbability ? Float(face.smilingProbability) : nil
            let headEulerAngleX: Float? = face.hasHeadEulerAngleX ? Float(face.headEulerAngleX) : nil
            let headEulerAngleY: Float? = face.hasHeadEulerAngleY ? Float(face.headEulerAngleY) : nil
            let headEulerAngleZ: Float? = face.hasHeadEulerAngleZ ? Float(face.headEulerAngleZ) : nil
         
            onSuccess(
                FaceDetected(
                    boundingBox: face.frame,                    
                    leftEyeOpenProbability: leftEyeOpenProbability,
                    rightEyeOpenProbability: rightEyeOpenProbability,
                    smilingProbability: smilingProbability,
                    headEulerAngleX: headEulerAngleX,
                    headEulerAngleY: headEulerAngleY,
                    headEulerAngleZ: headEulerAngleZ,
                    contours: faceContours
                )
            )
        }
    }
}
