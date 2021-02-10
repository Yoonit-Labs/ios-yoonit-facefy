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
        
    public init(facefyEventListener: FacefyEventListener) {
        self.facefyController.facefyEventListener = facefyEventListener
    }
    
    // Detect face classification.
    public var classification: Bool = facefyOptions.classification {
        didSet {
            facefyOptions.classification = self.classification
        }
    }
    
    // Detect face contours.
    public var contours: Bool = facefyOptions.contours {
        didSet {
            facefyOptions.contours = self.contours
        }
    }
    
    // Detect face bounding box.
    public var boundingBox: Bool = facefyOptions.boundingBox {
        didSet {
            facefyOptions.boundingBox = self.boundingBox
        }
    }
    
    public func detect(_ sampleBuffer: CMSampleBuffer, _ orientation: UIImage.Orientation) {
        self.facefyController.detect(sampleBuffer: sampleBuffer, orientation: orientation)
    }
}
