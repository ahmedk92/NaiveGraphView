//
//  GraphView.swift
//  Graph
//
//  Created by Ahmed Khalaf on 4/11/21.
//

import UIKit

class GraphView: UIView {
    var points: [CGPoint] = [] {
        didSet {
            updateLayers()
        }
    }
    
    var fillColor: UIColor = .gray {
        didSet {
            areaUnderCurveLayer.fillColor = fillColor.cgColor
        }
    }
    
    var strokeColor: UIColor = .black {
        didSet {
            curveStrokeLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    var strokeWidth: CGFloat = 3 {
        didSet {
            curveStrokeLayer.lineWidth = strokeWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutCurveStrokeLayer()
        layoutAreaUnderCurveLayer()
        updateLayers()
    }
    
    private let areaUnderCurveLayer = CAShapeLayer()
    private let curveStrokeLayer = CAShapeLayer()
    
    private func commonInit() {
        clipsToBounds = true
        setupCurveStrokeLayer()
        setupAreaUnderCurveLayer()
        applyDefaults()
    }
    
    private func setupCurveStrokeLayer() {
        curveStrokeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(curveStrokeLayer)
    }
    
    private func setupAreaUnderCurveLayer() {
        layer.addSublayer(areaUnderCurveLayer)
    }
    
    private func applyDefaults() {
        fillColor = { fillColor }()
        strokeColor = { strokeColor }()
        strokeWidth = { strokeWidth }()
    }
    
    private func layoutCurveStrokeLayer() {
        curveStrokeLayer.frame = layer.bounds
    }
    
    private func layoutAreaUnderCurveLayer() {
        areaUnderCurveLayer.frame = layer.bounds
    }
    
    private func updateLayers() {
        let curvePath = UIBezierPath()
        defer {
            areaUnderCurveLayer.path = curvePath.cgPath
        }
        
        curvePath.move(to: .init(x: 0, y: bounds.maxY))
        
        guard let maxPoint = points.max(by: { point1, point2 in
            point1.x < point2.x && point1.y < point2.y
        }) else {
            return
        }
        
        for point in points {
            let scaledX = point.x * bounds.maxX / maxPoint.x
            let scaledY = point.y * bounds.maxY / maxPoint.y
            let flippedY = bounds.maxY - scaledY
            
            curvePath.addLine(to: .init(x: scaledX, y: flippedY))
        }
        
        curveStrokeLayer.path = curvePath.cgPath
        
        curvePath.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
        curvePath.close()
    }
}
