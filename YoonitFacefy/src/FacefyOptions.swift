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

/**
 This class is a singleton used in the entire project to handle the features.
 */
public class FacefyOptions {
        
    // Detect face classification.
    var classification: Bool = false

    // Detect face contours.
    var contours: Bool = false

    // Detect face bounding box.
    var boundingBox: Bool = false
}
