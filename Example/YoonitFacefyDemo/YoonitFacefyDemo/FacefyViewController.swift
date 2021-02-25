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
import YoonitCamera
import YoonitFacefy

class FacefyViewController:
    UIViewController,
    CameraEventListenerDelegate
{
    var facefy: Facefy? = nil
    var faceImage: UIImage?
            
    @IBOutlet var cameraView: CameraView!
    @IBOutlet var graphicView: GraphicView!
    @IBOutlet var faceImageView: UIImageView!
    @IBOutlet var leftEyeLabel: UILabel!
    @IBOutlet var rightEyeLabel: UILabel!
    @IBOutlet var smillingLabel: UILabel!
    @IBOutlet var leftRightMovementeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.facefy = Facefy()
                
        self.cameraView.cameraEventListener = self
        self.cameraView.startPreview()
        self.cameraView.setSaveImageCaptured(true)
        self.cameraView.setTimeBetweenImages(300)
        self.cameraView.startCaptureType("frame")
    }        
        
    func onImageCaptured(
        _ type: String,
        _ count: Int,
        _ total: Int,
        _ imagePath: String
    ) {
        let subpath = imagePath.substring(from: imagePath.index(imagePath.startIndex, offsetBy: 7))
        let image = UIImage(contentsOfFile: subpath)
        
        self.facefy?.detect(image!) {
            faceDetected in
                         
            if let rightEyeOpenProbability = faceDetected.rightEyeOpenProbability {
                self.rightEyeLabel.text = rightEyeOpenProbability.toLabel()
            }
            if let leftEyeOpenProbability = faceDetected.leftEyeOpenProbability {
                self.leftEyeLabel.text = leftEyeOpenProbability.toLabel()
            }
            if let smilingProbability = faceDetected.smilingProbability {
                self.smillingLabel.text = smilingProbability.toLabel()
            }
            if let headEulerAngleY = faceDetected.headEulerAngleY {
                var headPosition = ""
                if headEulerAngleY < -36 {
                    headPosition = "Super Right"
                } else if -36 < headEulerAngleY && headEulerAngleY < -12 {
                    headPosition = "Right"
                } else if -12 < headEulerAngleY && headEulerAngleY < 12 {
                    headPosition = "Normal"
                } else if 12 < headEulerAngleY && headEulerAngleY < 36 {
                    headPosition = "Left"
                } else if headEulerAngleY > 36 {
                    headPosition = "Super Left"
                }
                self.leftRightMovementeLabel.text = headPosition
            }
                        
            if let cgImage = image?.cgImage {
                
                // Draw face detection box and the face contours.
//                self.graphicView.handleDraw(
//                    image: cgImage,
//                    faceBoundingBox: faceDetected.boundingBox,
//                    faceContours: faceDetected.contours
//                )
                                
                // Crop the face image.
                self.faceImageView.image = UIImage(
                    cgImage: cgImage.cropping(to: faceDetected.boundingBox)!
                ).withHorizontallyFlippedOrientation()
            }
        } onMessage: { message in
            self.handleMessage(message: message)
        }
        
        self.faceImage = image!
    }
    
    func handleMessage(message: String) {
        switch message {
        case "FACE_UNDETECTED":
            print("Face Undetected.")
        default:
            print(message)
        }
                    
        self.graphicView.clear()
    }
    
    func onFaceDetected(
        _ x: Int,
        _ y: Int,
        _ width: Int,
        _ height: Int
    ) {
        
    }
    
    func onFaceUndetected() {
        
    }
    
    func onEndCapture() {
        
    }
    
    func onError(_ error: String) {
        
    }
    
    func onMessage(_ message: String) {
        
    }
    
    func onPermissionDenied() {
        
    }
    
    func onQRCodeScanned(_ content: String) {
        
    }
}

extension CGFloat {
    func toLabel() -> String {
        return "\(String(format: "%.2f", self * 100))%"
    }
}
