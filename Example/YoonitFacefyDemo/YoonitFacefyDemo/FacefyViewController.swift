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
//import YoonitCamera
import YoonitFacefy

class FacefyViewController: UIViewController, FacefyEventListener {

    var facefy: Facefy? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.facefy = Facefy(facefyEventListener: self)
    }
    
    func onFaceAnalysis(
        _ leftEyeOpenProbability: CGFloat,
        _ rightEyeOpenProbability: CGFloat,
        _ smilingProbability: CGFloat
    ) {
        
    }
    
    func onContoursDetected(_ faceContours: [CGPoint]) {
        
    }
    
    func onFaceDetected(_ boundingBox: CGRect) {
        
    }
}
