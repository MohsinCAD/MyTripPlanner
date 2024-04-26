import SceneKit
import SwiftUI
import UIKit

struct LaunchScreenView: UIViewRepresentable {
    
    func updateUIView(_ uiView: SCNView, context: Context) {
    
    }
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene()
        sceneView.backgroundColor = UIColor.black
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        return sceneView
    }
    
    
    func createScene() -> SCNScene {
        let scene = SCNScene()
        
       
        let earthNode = SCNNode()
        let earthSphere = SCNSphere(radius: 1.0)
        earthNode.geometry = earthSphere
        
       
        let earthMaterial = SCNMaterial()
        earthMaterial.diffuse.contents = UIImage(named: "earthmap4k")
        earthSphere.materials = [earthMaterial]
        
       
        earthNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(earthNode)
        
       
        let rotation = CABasicAnimation(keyPath: "rotation")
        rotation.toValue = SCNVector4(x: 0, y: 1, z: 0, w: Float.pi * 2)
        rotation.duration = 60
        rotation.repeatCount = Float.infinity
        earthNode.addAnimation(rotation, forKey: "rotate the earth")
       
        return scene
    }
    
}

