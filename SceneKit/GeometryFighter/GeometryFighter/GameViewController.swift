import UIKit
import SceneKit

class GameViewController: UIViewController {
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupView() {
        scnView = (self.view as! SCNView)
        // 1
        scnView.showsStatistics = true
        // 2
        scnView.allowsCameraControl = true
        // 3
        scnView.autoenablesDefaultLighting = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
        scnScene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.jpg"
    }
    
    func setupCamera() {
        // 1
        cameraNode = SCNNode()
        // 2
        cameraNode.camera = SCNCamera()
        // 3
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 10)
        // 4
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        // 1
        var geometry: SCNGeometry
        // 2
        switch ShapeType.random() {
        case .box:
            // 3
            geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        case .capsule:
            geometry = SCNCapsule(capRadius: 0.5, height: 1.0)
        case .cone:
            geometry = SCNCone(topRadius: 0, bottomRadius: 0.5, height: 1.0)
        case .cylinder:
            geometry = SCNCylinder(radius: 0.5, height: 1.0)
        case .pyramid:
            geometry = SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
        case .sphere:
            geometry = SCNSphere(radius: 0.5)
        case .torus:
            geometry = SCNTorus(ringRadius: 0.5, pipeRadius: 0.25)
        case .tube:
            geometry = SCNTube(innerRadius: 0.25, outerRadius: 0.5, height: 1.0)
        }
        geometry.materials.first?.diffuse.contents = UIColor.random()
        // 4
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//        geometryNode.physicsBody?.isAffectedByGravity = false
        // 1
        let randomX = Float.random(min: -2, max: 2)
        let randomY = Float.random(min: 10, max: 18)
        // 2
        let force = SCNVector3(x: randomX, y: randomY, z: 0)
        // 3
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        // 4
        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true)
        // For future reference, applyTorque uses a SCNVector4, where the first 3 values represent the direction of the torque and the 4th represents the magnitude. Also, using asImpulse as false will not yield a constant torque, you would need to apply that torque on each simulation step, not only once.
        //geometryNode.physicsBody?.applyTorque(SCNVector4(0, 1, 1, 3), asImpulse: true)
        // 5
        scnScene.rootNode.addChildNode(geometryNode)
    }
}
