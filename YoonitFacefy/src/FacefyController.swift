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
import MLKit

public class FacefyController: NSObject {
        
    public var facefyEventListener: FacefyEventListener?
    
    public func detect(sampleBuffer: CMSampleBuffer, orientation: UIImage.Orientation) {
        
        let visionImage: VisionImage = VisionImage(buffer: sampleBuffer)
        visionImage.orientation = orientation
        
        let options: FaceDetectorOptions = FaceDetectorOptions()
        options.performanceMode = .accurate
        options.landmarkMode = .all
        options.classificationMode = .all
        
        let faceDetector = FaceDetector.faceDetector(options: options)
        
        weak var weakSelf = self
        faceDetector.process(visionImage) { faces, error in
            
            guard weakSelf != nil else {
                return
            }

            guard error == nil, let faces = faces, !faces.isEmpty else {
                return
            }
            
            // The closest face.
            let face: Face = faces.sorted {
                return $0.frame.width > $1.frame.width
            }[0]
                        
            if
                facefyOptions.classification &&
                face.hasSmilingProbability &&
                face.hasLeftEyeOpenProbability &&
                face.hasRightEyeOpenProbability &&
                face.hasHeadEulerAngleX &&
                face.hasHeadEulerAngleY &&
                face.hasHeadEulerAngleZ
            {
                print("Face: \(face.headEulerAngleX) \(face.headEulerAngleY) \(face.headEulerAngleZ)")
                
                self.facefyEventListener?.onFaceAnalysis(
                    face.leftEyeOpenProbability,
                    face.rightEyeOpenProbability,
                    face.smilingProbability
                )
            }

            if facefyOptions.contours && !face.contours.isEmpty {
                var faceContours: [CGPoint] = []
                for faceContour in face.contours {
                    for point in faceContour.points {
                        faceContours.append(CGPoint(x: point.x, y: point.y))
                    }
                }
                                
                self.facefyEventListener?.onContoursDetected(faceContours)
            }

            if (facefyOptions.boundingBox) {
                self.facefyEventListener?.onFaceDetected(face.frame)
            }

        }
    }
}
