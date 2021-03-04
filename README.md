<img src="https://raw.githubusercontent.com/Yoonit-Labs/ios-yoonit-facefy/development/logo_cyberlabs.png" width="300">

# ios-yoonit-facefy

A iOS library to provide:
- [Standart Google ML Kit](https://developers.google.com/ml-kit)
- Face detection
- Face contours
- Face expressions
- Face movement

<img src="https://raw.githubusercontent.com/Yoonit-Labs/ios-yoonit-facefy/development/facefy.gif" width="300">

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
| leftEyeOpenProbability | `CGFloat?` | The left eye open probability. |
| rightEyeOpenProbability | `CGFloat?` | The right eye open probability. |
| smilingProbability | `CGFloat?` | The smilling probability. |
| headEulerAngleX | `CGFloat?` | The angle in degrees that indicate the vertical head direction. See [Head Movements](#headmovements) |
| headEulerAngleY | `CGFloat?` | The angle in degrees that indicate the horizontal head direction. See [Head Movements](#headmovements) |
| headEulerAngleZ | `CGFloat?` | The angle in degrees that indicate the tilt head direction. See [Head Movements](#headmovements) |
| contours | `[CGPoint]` | List of points that represents the shape of the detected face. |
| boundingBox | `CGRect` | The face bounding box. |

#### Head Movements

Here we explaining the above gif and how reached the "results". Each "movement" (vertical, horizontal and tilt) is a state, based in the angle in degrees that indicate head direction;

| Head Direction | Attribute                  |  _v_ < -36°       | -36° < _v_ < -12° | -12° < _v_ < 12° | 12° < _v_ < 36° |  36° < _v_       | 
| -                        | -                              | -                   | -                        | -                   | -                    | -                   |
| Vertical             | `headEulerAngleX` | Super Down | Down               | Frontal          | Up             | Super Up |
| Horizontal        | `headEulerAngleY` | Super Right | Right                 | Frontal          | Left                 | Super Left    |
| Tilt                    | `headEulerAngleZ` | Super Left   | Left                   | Frontal          | Right            | Super Right |


## To contribute and make it better

Clone the repo, change what you want and send PR.

Contributions are always welcome!

---

Code with ❤ by the [**Cyberlabs AI**](https://cyberlabs.ai/) Front-End Team
