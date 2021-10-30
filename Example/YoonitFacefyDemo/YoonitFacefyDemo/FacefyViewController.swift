/*
 * ██╗   ██╗ ██████╗  ██████╗ ███╗   ██╗██╗████████╗
 * ╚██╗ ██╔╝██╔═══██╗██╔═══██╗████╗  ██║██║╚══██╔══╝
 *  ╚████╔╝ ██║   ██║██║   ██║██╔██╗ ██║██║   ██║
 *   ╚██╔╝  ██║   ██║██║   ██║██║╚██╗██║██║   ██║
 *    ██║   ╚██████╔╝╚██████╔╝██║ ╚████║██║   ██║
 *    ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝
 *
 * https://yoonit.dev - about@yoonit.dev
 *
 * iOS Yoonit Facefy
 * The face detection's module for iOS with a lot of awesome features
 *
 * Haroldo Teruya @ 2020-2021
 */

import UIKit
import YoonitCamera
import YoonitFacefy

class FacefyViewController:
    UIViewController,
    CameraEventListenerDelegate
{
    var facefy: Facefy? = nil
    @IBOutlet var cameraView: CameraView!
    @IBOutlet var graphicView: GraphicView!
    @IBOutlet var faceImageView: UIImageView!
    @IBOutlet var boundingBox: UILabel!
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
        _ imagePath: String,
        _ darkness: NSNumber?,
        _ lightness: NSNumber?,
        _ sharpness: NSNumber?
    ) {
        let subpath = imagePath.substring(from: imagePath.index(imagePath.startIndex, offsetBy: 7))
        var image = UIImage(contentsOfFile: subpath)!
        image = self.flipImageLeftRight(image)!
        
        self.facefy?.detect(image) {
            faceDetected in

            if let faceDetected: FaceDetected = faceDetected {
                let x: Int = Int(faceDetected.boundingBox.minX)
                let y: Int = Int(faceDetected.boundingBox.minY)
                let width: Int = Int(faceDetected.boundingBox.width)
                let height: Int = Int(faceDetected.boundingBox.height)
                self.boundingBox.text = "(x: \(x), y: \(y), w: \(width), h: \(height))"

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

                if let angle = faceDetected.headEulerAngleX {
                    var text = ""
                    if angle < -36 {
                        text = "Super Down"
                    } else if -36 < angle && angle < -12 {
                        text = "Down"
                    } else if -12 < angle && angle < 12 {
                        text = "Frontal"
                    } else if 12 < angle && angle < 36 {
                        text = "Up"
                    } else if 36 < angle {
                        text = "Super Up"
                    }
                    self.verticalMovementLabel.text = text
                }

                if let angle = faceDetected.headEulerAngleY {
                    var text = ""
                    if angle < -36 {
                        text = "Super Left"
                    } else if -36 < angle && angle < -12 {
                        text = "Left"
                    } else if -12 < angle && angle < 12 {
                        text = "Frontal"
                    } else if 12 < angle && angle < 36 {
                        text = "Right"
                    } else if 36 < angle {
                        text = "Super Right"
                    }
                    self.horizontalMovementLabel.text = text
                }

                if let angle = faceDetected.headEulerAngleZ {
                    var text = ""
                    if angle < -36 {
                        text = "Super Right"
                    } else if -36 < angle && angle < -12 {
                        text = "Right"
                    } else if -12 < angle && angle < 12 {
                        text = "Frontal"
                    } else if 12 < angle && angle < 36 {
                        text = "Left"
                    } else if 36 < angle {
                        text = "Super Left"
                    }
                    self.tiltMovementLabel.text = text
                }

                if let cgImage = image.cgImage {

                    self.graphicView.handleDraw(
                        image: cgImage,
                        faceBoundingBox: faceDetected.boundingBox,
                        faceContours: faceDetected.contours
                    )

                    // Crop the face image.
                    self.faceImageView.image = UIImage(
                        cgImage: cgImage.cropping(to: faceDetected.boundingBox)!
                    )
                }
            } else {
                print("Face Undetected.")
                self.faceImageView.image = nil
                self.graphicView.clear()
            }
        } onError: { message in
            print(message)
        }
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
        _ height: Int,
        _ leftEyeOpenProbability: NSNumber?,
        _ rightEyeOpenProbability: NSNumber?,
        _ smilingProbability: NSNumber?,
        _ headEulerAngleX: NSNumber?,
        _ headEulerAngleY: NSNumber?,
        _ headEulerAngleZ: NSNumber?
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
    
    func flipImageLeftRight(_ image: UIImage) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        
        context.translateBy(x: image.size.width, y: image.size.height)
        context.scaleBy(x: -image.scale, y: -image.scale)
        context.draw(image.cgImage!, in: CGRect(origin:CGPoint.zero, size: image.size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return newImage
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
