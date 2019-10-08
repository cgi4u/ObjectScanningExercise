//
//  Extensions.swift
//  ObjectScanningExercise
//
//  Created by 최광익 on 2019/10/08.
//  Copyright © 2019 최광익. All rights reserved.
//

import SceneKit

extension SCNMaterial {
    
    static func material(withDiffuse diffuse: Any?, respondsToLighting: Bool = false, isDoubleSided: Bool = true) -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = diffuse
        material.isDoubleSided = isDoubleSided
        if respondsToLighting {
            material.locksAmbientWithDiffuse = true
        } else {
            material.locksAmbientWithDiffuse = false
            material.ambient.contents = UIColor.black
            material.lightingModel = .constant
        }
        return material
    }
}
