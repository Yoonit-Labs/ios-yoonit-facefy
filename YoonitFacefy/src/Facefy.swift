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

var facefyOptions: FacefyOptions = FacefyOptions()

@objc
public class Facefy: NSObject {
    
    var facefyController = FacefyController()
    
//    public var facefyEventListener: FacefyEventListener? = nil {
//        didSet {
//            self.facefyController.facefyEventListener = facefyEventListener
//        }
//    }
    
    public init(facefyEventListener: FacefyEventListener) {
        self.facefyController.facefyEventListener = facefyEventListener
    }
    
    // Detect face classification.
    public var faceClassification: Bool = facefyOptions.classification {
        didSet {
            facefyOptions.classification = self.faceClassification
        }
    }
    
    // Detect face contours.
    public var faceContours: Bool = facefyOptions.contours {
        didSet {
            facefyOptions.contours = self.faceContours
        }
    }
    
    // Detect face bounding box.
    public var faceBoundingBox: Bool = facefyOptions.boundingBox {
        didSet {
            facefyOptions.boundingBox = self.faceBoundingBox
        }
    }
    
    public func detect(_ sampleBuffer: CMSampleBuffer, _ orientation: UIImage.Orientation) {
        self.facefyController.detect(sampleBuffer: sampleBuffer, orientation: orientation)
    }
}
