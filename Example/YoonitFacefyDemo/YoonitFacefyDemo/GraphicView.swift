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

import Foundation
import UIKit

public class GraphicView: UIView {
    
    private var image: CGImage? = nil
    private var boundingBox: CGRect? = nil
    private var faceContours: [CGPoint] = []
        
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
                
        if self.boundingBox != nil && self.image != nil {
            self.drawFaceDetectionBox(context: context)
        }
                
        if !self.faceContours.isEmpty {
            self.drawFaceContours(context: context)
        }
    }
    
    func handleDraw(
        image: CGImage,
        faceBoundingBox: CGRect?,
        faceContours: [CGPoint]
    ) {
        self.image = image
        self.boundingBox = faceBoundingBox
        self.faceContours = faceContours
        
        self.setNeedsDisplay()
    }
        
    func clear() {
        self.image = nil
        self.boundingBox = nil
        self.faceContours = []
        
        self.setNeedsDisplay()
    }
        
    func drawFaceDetectionBox(context: CGContext) {
        let faceDetectionBox: CGRect = self.getFaceDetectionBox(
            cameraInputImage: self.image!,
            boundingBox: self.boundingBox!
        )
        
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.white.cgColor)
        context.stroke(faceDetectionBox)
        
        let left = faceDetectionBox.minX
        let top = faceDetectionBox.minY
        let right = faceDetectionBox.maxX
        let bottom = faceDetectionBox.maxY
        let midY = (bottom - top) / 2.0
        
        // edge - top-left > bottom-left
        self.drawLine(
            context: context,
            from: CGPoint(x: left, y: top),
            to: CGPoint(x: left, y: bottom - (midY * 1.5))
        )
                            
        // edge - top-right > bottom-right
        self.drawLine(
            context: context,
            from: CGPoint(x: right, y: top),
            to: CGPoint(x: right, y: bottom - (midY * 1.5))
        )
        
        // edge - bottom-left > top-left
        self.drawLine(
            context: context,
            from: CGPoint(x: left, y: bottom),
            to: CGPoint(x: left, y: bottom - (midY * 0.5))
        )

        // edge - bottom-right > top-right
        self.drawLine(
            context: context,
            from: CGPoint(x: right, y: bottom),
            to: CGPoint(x: right, y: bottom - (midY * 0.5))
        )

        // edge - top-left > top-right
        self.drawLine(
            context: context,
            from: CGPoint(x: left, y: top),
            to: CGPoint(x: left + (midY * 0.5), y: top)
        )

        // edge - top-right > left-right
        self.drawLine(
            context: context,
            from: CGPoint(x: right, y: top),
            to: CGPoint(x: right - (midY * 0.5), y: top)
        )

        // edge - bottom-left > right-left
        self.drawLine(
            context: context,
            from: CGPoint(x: left, y: bottom),
            to: CGPoint(x: left + (midY * 0.5), y: bottom)
        )

        // edge - bottom-right > right-left
        self.drawLine(
            context: context,
            from: CGPoint(x: right, y: bottom),
            to: CGPoint(x: right - (midY * 0.5), y: bottom)
        )
    }
    
    func drawFaceContours(context: CGContext) {
        let size = CGSize(width: 4, height: 4)
        
        UIColor.white.set()
        
        for point in self.faceContours {
            let scaledXY: CGPoint = self.getScale(
                imageWidth: CGFloat(self.image!.width),
                imageHeight: CGFloat(self.image!.height)
            )
            let x: CGFloat = point.x * scaledXY.x
            let y: CGFloat = point.y * scaledXY.y
            
            let dot: CGRect = CGRect(
                origin: CGPoint(x: x, y: y),
                size: size
            )
            let dotPath = UIBezierPath(ovalIn: dot)
            dotPath.fill()
        }
    }
                
    func drawLine(
        context: CGContext,
        from: CGPoint,
        to: CGPoint
    ) {
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(6)
        context.setLineCap(.round)
        context.move(to: from)
        context.addLine(to: to)
        context.strokePath()
    }
    
    func getFaceDetectionBox(
        cameraInputImage: CGImage,
        boundingBox: CGRect
    ) -> CGRect {        
        let scaledXY: CGPoint = self.getScale(
            imageWidth: CGFloat(cameraInputImage.width),
            imageHeight: CGFloat(cameraInputImage.height)
        )
        
        let top: CGFloat = boundingBox.minY * scaledXY.y
        let right: CGFloat = boundingBox.maxX * scaledXY.x
        let bottom: CGFloat = boundingBox.maxY * scaledXY.y
        let left: CGFloat = boundingBox.minX * scaledXY.x
        
        return CGRect(
            x: left,
            y: top,
            width: right - left,
            height: bottom - top
        )
    }
    
    func getScale(
        imageWidth: CGFloat,
        imageHeight: CGFloat
    ) -> CGPoint {
        let viewWidth: CGFloat = self.frame.width
        let viewHeight: CGFloat = self.frame.height
        var scaleX: CGFloat
        var scaleY: CGFloat
        
        scaleX = viewHeight / imageHeight
        scaleY = viewWidth / imageWidth
        
        return CGPoint(x: scaleX, y: scaleY)
    }
}
