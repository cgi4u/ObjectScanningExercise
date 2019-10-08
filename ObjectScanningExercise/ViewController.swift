//
//  ViewController.swift
//  ObjectScanningExercise
//
//  Created by 최광익 on 2019/10/08.
//  Copyright © 2019 최광익. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    private let pointNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.session.delegate = self
        sceneView.session.run(ARObjectScanningConfiguration())
        
        sceneView.scene.rootNode.addChildNode(pointNode)
    }
}

extension ViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        print(frame.rawFeaturePoints?.points ?? "None")
        print(frame.rawFeaturePoints?.points.count ?? "None")
        
        guard let points = frame.rawFeaturePoints?.points else {
            return
        }
        
        let stride = MemoryLayout<vector_float3>.size
        let pointData = Data(bytes: points, count: stride * points.count)
        
        // Create geometry source
        let source = SCNGeometrySource(data: pointData,
                                       semantic: SCNGeometrySource.Semantic.vertex,
                                       vectorCount: points.count,
                                       usesFloatComponents: true,
                                       componentsPerVector: 3,
                                       bytesPerComponent: MemoryLayout<Float>.size,
                                       dataOffset: 0,
                                       dataStride: stride)
        
        // Create geometry element
        let element = SCNGeometryElement(data: nil, primitiveType: .point, primitiveCount: points.count, bytesPerIndex: 0)
        element.pointSize = 0.001
        element.minimumPointScreenSpaceRadius = 12
        element.maximumPointScreenSpaceRadius = 12
        
        let pointsGeometry = SCNGeometry(sources: [source], elements: [element])
        pointsGeometry.materials = [SCNMaterial.material(withDiffuse: UIColor.red)]
        
        pointNode.geometry = pointsGeometry
    }
}

