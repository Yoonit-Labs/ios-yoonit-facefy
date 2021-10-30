<h1 align="center">iOS Yoonit Facefy</h1>

<p align="center">
    <img src="https://img.shields.io/github/v/tag/Yoonit-Labs/ios-yoonit-facefy?color=lightgrey&label=version&style=for-the-badge" />
    <img src="https://img.shields.io/github/license/Yoonit-Labs/ios-yoonit-facefy?color=lightgrey&style=for-the-badge" />  
</p>

<div align="center">
    <table>
        <tbody>
            <tr>
                <td align="left" valign="middle">
                    <p>◻ <a href="https://developers.google.com/ml-kit">Google MLKit</a> integration</p>                    
                    <p>◻ Face detection</p>
                    <p>◻ Face contours</p>
                    <p>◻ Face expressions</p>
                    <p>◻ Face movement</p>
                </td>
                <td align="center" valign="middle">                    
                    <img src="https://raw.githubusercontent.com/Yoonit-Labs/ios-yoonit-facefy/development/facefy.gif" width="300" />
                </td>
            </tr>
        <tbody>
    </table>
</div>

<div align="center">
    <h3>Sponsors</h3>
    <table>
        <tbody>
            <tr>
                <td>
                    <b>Platinum</b>
                </td>
            </tr>
            <tr>
                <td align="center" valign="middle">
                    <a 
                        href="https://cyberlabs.ai"
                    >
                        <img 
                            src="https://raw.githubusercontent.com/Yoonit-Labs/ios-yoonit-facefy/main/sponsor_cyberlabs.png"
                            width="300" 
                        />
                    </a>
                </td>
            </tr>
        </tbody>
    </table>
    <h5><a href="mailto:about@yoonit.dev">Become a sponsor!</a></h5>
</div>

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [API](#api)
  * [Methods](#methods)
  * [FaceDetected](#facedetected)
    * [Head Movements](#head-movements)
* [To contribute and make it better](#to-contribute-and-make-it-better)

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

self.facefy.detect(image!) { faceDetected in                                      
    if let faceDetected: FaceDetected = faceDetected {
        
        if let leftEyeOpenProbability = faceDetected.leftEyeOpenProbability {
            print(String(format: "%.2f", leftEyeOpenProbability))
        }
        if let rightEyeOpenProbability = faceDetected.rightEyeOpenProbability {
            print(String(format: "%.2f", rightEyeOpenProbability))
        }
        if let smilingProbability = faceDetected.smilingProbability {
            print(String(format: "%.2f", faceDetected.smilingProbability))
        }
        if let hasHeadEulerAngleX = faceDetected.hasHeadEulerAngleX {
            print(String(format: "%.2f", hasHeadEulerAngleX))
        }
        if let hasHeadEulerAngleY = faceDetected.hasHeadEulerAngleY {
            print(String(format: "%.2f", hasHeadEulerAngleY))
        }                
        if let hasHeadEulerAngleZ = faceDetected.hasHeadEulerAngleZ {
            print(String(format: "%.2f", hasHeadEulerAngleZ))
        }
                    
        if let cgImage = image?.cgImage {                                                        
            
            // Crop the face image from the camera frame.
            let faceImage = UIImage(
                cgImage: cgImage.cropping(to: faceDetected.boundingBox)!
            ).withHorizontallyFlippedOrientation()
        }
    }
} onError: { message in
    print(message)
}
```

## API

### Methods

| Function | Parameters                                                                                                                                                                                               | Return Type | Description |
| -              | -                                                                                                                                                                                                                | -                   | -                 |
| detect     |  `image: UIImage, onSuccess: @escaping (FaceDetected?) -> Void, onError: @escaping (String) -> Void` | void             | Detect a face from image and return the result in the [`FaceDetected`](#facedetected) as a closure. |

### FaceDetected

| Attribute | Type | Description |
| -             | -        | -                  |
| boundingBox | `CGRect` | The face bounding box related to the image input. |
| leftEyeOpenProbability | `Float?` | The left eye open probability. |
| rightEyeOpenProbability | `Float?` | The right eye open probability. |
| smilingProbability | `Float?` | The smiling probability. |
| headEulerAngleX | `Float?` | The angle in degrees that indicate the vertical head direction. See [Head Movements](#headmovements). |
| headEulerAngleY | `Float?` | The angle in degrees that indicate the horizontal head direction. See [Head Movements](#headmovements). |
| headEulerAngleZ | `Float?` | The angle in degrees that indicate the tilt head direction. See [Head Movements](#headmovements). |
| contours | `[CGPoint]` | List of points that represents the shape of the detected face. |

#### Head Movements

Here we explaining the above gif and how reached the "results". Each "movement" (vertical, horizontal and tilt) is a state, based in the angle in degrees that indicate head direction;

| Head Direction | Attribute         |  _v_ < -36° | -36° < _v_ < -12° | -12° < _v_ < 12° | 12° < _v_ < 36° |  36° < _v_  |
| -              | -                 | -           | -                 | -                | -               | -           |
| Vertical       | `headEulerAngleX` | Super Down  | Down              | Frontal          | Up              | Super Up    |
| Horizontal     | `headEulerAngleY` | Super Left  | Left              | Frontal          | Right           | Super Right |
| Tilt           | `headEulerAngleZ` | Super Right | Right             | Frontal          | Left            | Super Left  |


## To contribute and make it better

Clone the repo, change what you want and send PR. For commit messages we use <a href="https://www.conventionalcommits.org/">Conventional Commits</a>.

Contributions are always welcome!

<a href="https://github.com/Yoonit-Labs/ios-yoonit-facefy/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Yoonit-Labs/ios-yoonit-facefy" />
</a>

---

Code with ❤ by the [**Yoonit**](https://yoonit.dev/) Team
