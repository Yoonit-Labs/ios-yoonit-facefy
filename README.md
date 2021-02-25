<img src="https://raw.githubusercontent.com/Yoonit-Labs/ios-yoonit-facefy/development/logo_cyberlabs.png" width="300">

# ios-yoonit-facefy

A iOS library to provide:
- [Standart Google ML Kit](https://developers.google.com/ml-kit)
- Face detection
- Face contours
- Face expressions
- Face movement

## Install

Add the following line to your `Podfile` file:

```  
pod 'YoonitFacefy'
```

And run in the root of your project:

```
pod install
```  

## Usage

This is a basic usage to the `FacefyYoonit`.
Feel free to use the demo.

```swift
import YoonitFacefy

...

let image = UIImage(contentsOfFile: "image path")
let facefy: Facefy = Facefy()

self.facefy.detect(image!) {
    faceDetected in
                 
    if let leftEyeOpenProbability = faceDetected.leftEyeOpenProbability {
        self.leftEyeLabel.text = String(format: "%.2f", leftEyeOpenProbability)
    }
    if let rightEyeOpenProbability = faceDetected.rightEyeOpenProbability {
        self.rightEyeLabel.text = String(format: "%.2f", rightEyeOpenProbability)
    }
    if let smilingProbability = faceDetected.smilingProbability {
        self.smillingLabel.text = String(format: "%.2f", smilingProbability)
    }
    if let headEulerAngleY = faceDetected.headEulerAngleY {
        self.leftRightMovementeLabel.text = String(format: "%.2f", headEulerAngleY)
    }
                
    if let cgImage = image?.cgImage {
                                        
        // Crop the face image from.
        UIImage(
            cgImage: cgImage.cropping(to: faceDetected.boundingBox)!
        ).withHorizontallyFlippedOrientation()
    }
} onMessage: { message in
    print(message)
}
```

## API

### Methods

| Function | Parameters                                                                                                                                                                                               | Return Type | Description |
| -              | -                                                                                                                                                                                                                | -                   | -                 |
| detect     |  `image: InputImage, onFaceDetected: @escaping (FaceDetected) -> Void, onMessage: @escaping (String) -> Void` | void             | Detec a face from image and return the result in the [`FaceDetected`](#facedetected) as a closure. |

### FaceDetected

| Attribute | Type | Description |
| -             | -        | -                  |
| leftEyeOpenProbability | CGFloat | The left eye open probability. |
| rightEyeOpenProbability | CGFloat | The right eye open probability. |
| smilingProbability | CGFloat | The smilling probability. |
| headEulerAngleY | CGFloat | The angle that points the "left-right" head direction. See [HeadEulerAngleY](#headeulerangley) |
| contours | [CGPoint] | List of Points that represents the shape of the recognized face. |
| boundingBox | CGRect | The face bounding box. |

#### HeadEulerAngleY

Landmarks are points of interest within a face regarding the Euler Angle Y. 

| Euler Angle Y                       | Detectable landmarks                                      
| -                                           | -                                              
| < -36 degrees                      | left eye, left mouth, left ear, nose base, left cheek                             
| -36 degrees to -12 degrees | left mouth, nose base, bottom mouth, right eye, left eye, left cheek, left ear tip                  
| -12 degrees to 12 degrees   | right eye, left eye, nose base, left cheek, right cheek, left mouth, right mouth, bottom mouth          
| 12 degrees to 36 degrees    | right mouth, nose base, bottom mouth, left eye, right eye, right cheek, right ear tip             
| > 36 degrees                        | right eye, right mouth, right ear, nose base, right cheek       

## To contribute and make it better

Clone the repo, change what you want and send PR.

Contributions are always welcome!

---

Code with ❤ by the [**Cyberlabs AI**](https://cyberlabs.ai/) Front-End Team
