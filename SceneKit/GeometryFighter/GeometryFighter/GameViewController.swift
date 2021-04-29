import UIKit
import SceneKit

class GameViewController: UIViewController {
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var spawnTime: TimeInterval = 0
    var game = GameHelper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        setupHUD()
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
        scnView.showsStatistics = false
        // 2
        scnView.allowsCameraControl = false
        // 3
        scnView.autoenablesDefaultLighting = true
        scnView.delegate = self
        scnView.isPlaying = true
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
        let color = UIColor.random()
        geometry.materials.first?.diffuse.contents = color
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
        let trailEmitter = createTrail(color: color, geometry: geometry)
        geometryNode.addParticleSystem(trailEmitter)
        if color == UIColor.black {
            geometryNode.name = "BAD"
        } else {
            geometryNode.name = "GOOD"
        }
        scnScene.rootNode.addChildNode(geometryNode)
    }
    
    // 1
    func createTrail(color: UIColor, geometry: SCNGeometry) -> SCNParticleSystem {
        // 2
        let trail = SCNParticleSystem(named: "Trail.scnp", inDirectory: nil)!
        // 3
        trail.particleColor = color
        // 4
        trail.emitterShape = geometry
        // 5
        return trail
    }
    
    func setupHUD() {
        game.hudNode.position = SCNVector3(x: 0.0, y: 10.0, z: 0.0)
        scnScene.rootNode.addChildNode(game.hudNode)
    }
    
    private func explodeNode(_ node: SCNNode) {
        createExplosion(geometry: node.geometry!, position: node.presentation.position, rotation: node.presentation.rotation)
        node.removeFromParentNode()
    }
    
    func handleTouchFor(node: SCNNode) {
        if node.name == "GOOD" {
            game.score += 1
            explodeNode(node)
        } else if node.name == "BAD" {
            game.lives -= 1
            explodeNode(node)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1
        let touch = touches.first!
        // 2
        let location = touch.location(in: scnView)
        // 3
        let hitResults = scnView.hitTest(location, options: nil)
        // 4
        if let result = hitResults.first {
            // 5
            handleTouchFor(node: result.node)
        }
    }
    
    // 1
    func createExplosion(geometry: SCNGeometry, position: SCNVector3,
      rotation: SCNVector4) {
        // 2
        let explosion = SCNParticleSystem(named: "Explode.scnp", inDirectory: nil)!
        explosion.emitterShape = geometry
        explosion.birthLocation = .surface
        // 3
        let rotationMatrix = SCNMatrix4MakeRotation(rotation.w, rotation.x, rotation.y, rotation.z)
        let translationMatrix = SCNMatrix4MakeTranslation(position.x, position.y, position.z)
        let transformMatrix = SCNMatrix4Mult(rotationMatrix, translationMatrix)
        // 4
        scnScene.addParticleSystem(explosion, transform: transformMatrix)
    }
    
    func cleanScene() {
        // 1
        for node in scnScene.rootNode.childNodes {
            // 2
            if node.presentation.position.y < -2 {
                // 3
                node.removeFromParentNode()
            }
        }
    }
    
}

// 1
extension GameViewController: SCNSceneRendererDelegate {
    // 2
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // 1
        if time > spawnTime {
            spawnShape()
            // 2
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
        }
        cleanScene()
        game.updateHUD()
    }
}
