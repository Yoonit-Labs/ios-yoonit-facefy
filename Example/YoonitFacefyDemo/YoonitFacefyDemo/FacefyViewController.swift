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
    @IBOutlet var smilingLabel: UILabel!
    @IBOutlet var horizontalMovementLabel: UILabel!
    @IBOutlet var verticalMovementLabel: UILabel!
    @IBOutlet var tiltMovementLabel: UILabel!
    
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
                                    
            if let faceDetected: FaceDetected = faceDetected {                                
                self.handleDisplayProbability(
                    label: self.leftEyeLabel,
                    value: faceDetected.leftEyeOpenProbability,
                    validText: "Open",
                    invalidText: "Close"
                )
                self.handleDisplayProbability(
                    label: self.rightEyeLabel,
                    value: faceDetected.rightEyeOpenProbability,
                    validText: "Open",
                    invalidText: "Close"
                )
                self.handleDisplayProbability(
                    label: self.smilingLabel,
                    value: faceDetected.smilingProbability,
                    validText: "Smiling",
                    invalidText: "Not Smiling"
                )
                
                if let headEulerAngleX = faceDetected.headEulerAngleX {
                    var headPosition = ""
                    if headEulerAngleX < -36 {
                        headPosition = "Super Down"
                    } else if -36 < headEulerAngleX && headEulerAngleX < -12 {
                        headPosition = "Down"
                    } else if -12 < headEulerAngleX && headEulerAngleX < 12 {
                        headPosition = "Frontal"
                    } else if 12 < headEulerAngleX && headEulerAngleX < 36 {
                        headPosition = "Up"
                    } else if headEulerAngleX > 36 {
                        headPosition = "Super Up"
                    }
                    self.verticalMovementLabel.text = headPosition
                }

                if let headEulerAngleY = faceDetected.headEulerAngleY {
                    var headPosition = ""
                    if headEulerAngleY < -36 {
                        headPosition = "Super Right"
                    } else if -36 < headEulerAngleY && headEulerAngleY < -12 {
                        headPosition = "Right"
                    } else if -12 < headEulerAngleY && headEulerAngleY < 12 {
                        headPosition = "Frontal"
                    } else if 12 < headEulerAngleY && headEulerAngleY < 36 {
                        headPosition = "Left"
                    } else if headEulerAngleY > 36 {
                        headPosition = "Super Left"
                    }
                    self.horizontalMovementLabel.text = headPosition
                }

                if let headEulerAngleZ = faceDetected.headEulerAngleZ {
                    var headPosition = ""
                    if headEulerAngleZ < -36 {
                        headPosition = "Super Left"
                    } else if -36 < headEulerAngleZ && headEulerAngleZ < -12 {
                        headPosition = "Left"
                    } else if -12 < headEulerAngleZ && headEulerAngleZ < 12 {
                        headPosition = "Frontal"
                    } else if 12 < headEulerAngleZ && headEulerAngleZ < 36 {
                        headPosition = "Right"
                    } else if headEulerAngleZ > 36 {
                        headPosition = "Super Right"
                    }
                    self.tiltMovementLabel.text = headPosition
                }
                
                if let cgImage = image?.cgImage {
                    
                    self.graphicView.handleDraw(
                        image: cgImage,
                        faceBoundingBox: faceDetected.boundingBox,
                        faceContours: faceDetected.contours
                    )
                    
                    // Crop the face image.
                    self.faceImageView.image = UIImage(
                        cgImage: cgImage.cropping(to: faceDetected.boundingBox)!
                    ).withHorizontallyFlippedOrientation()
                }
            } else {
                print("Face Undetected.")
                self.faceImageView.image = nil
                self.graphicView.clear()
            }
        } onError: { message in
            print(message)
        }
        
        self.faceImage = image!
    }
    
    func handleDisplayProbability(
        label: UILabel,
        value: Float?,
        validText: String,
        invalidText: String
    ) {
        if let value: Float = value {
            label.text = value > 0.8 ? validText : invalidText
        }
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
        return "(\(String(format: "%.2f", self * 100))%)"
    }
    
    func toText() -> String {
        return "\(String(format: "%.2f", self))"
    }
}
