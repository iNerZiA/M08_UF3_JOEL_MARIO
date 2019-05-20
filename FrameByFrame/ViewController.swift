import UIKit

class ViewController: UIViewController {
    //Viper
    var viperImageView = UIImageView()
    var viper = Viper(speed: 10, center: CGPoint(x: 200, y: 600), size: CGSize(width: 100, height: 100))
    
    //Asteroids
    let ASTEROIDS_IMAGES_NAMES = ["Asteroid_A", "Asteroid_B", "Asteroid_C"]
    var asteroids = [Asteroid]()
    var asteroidsViews = [UIImageView]()
    var asteroidsToBeRemoved = [Asteroid]()
    
    //Game Logic
    var gameRunning = false //to control game state
    var stepNumber = 0 //Used in asteroids generation: every 5s an asteroid will be created
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set up Viper
        viperImageView.image = UIImage(named: "viper")
        viperImageView.frame.size = viper.size
        viperImageView.center = viper.center
        self.view.addSubview(viperImageView)
        
        
        
        //allow user tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(sender:)))
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
 
        //allow user pan
        //let panGesture  = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(sender:)))
        //self.viperImageView.addGestureRecognizer(panGesture)
       // self.viperImageView.isUserInteractionEnabled = true

        
        
        //set game running
        self.gameRunning = true
        
        
        
        //initialize timer
        let dislayLink = CADisplayLink(target: self, selector: #selector(self.updateScene))
        dislayLink.add(to: .current, forMode: .default)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            let tapPoint = sender.location(in: self.view)
            //update the model
            self.viper.moveToPoint = tapPoint
        }
    }
    
    @objc func updateScene(){
        if gameRunning{
            //create an asterior every 5s
            if (stepNumber%(60*5)==0){
                /*INSERT CODE HERE*/
               randomAsteroids()
            }
            stepNumber+=1
            
            //update location viper
            self.viper.step() //update the model
            self.viperImageView.center = self.viper.center //update the view from the model
            
            //update location asteroids
            /*INSERT CODE HERE*/
            
            //check viper screen collision
            /*INSERT CODE HERE*/
            
            //check asteroids collision between viper and screen
            /*INSERT CODE HERE*/
            
            //remove from scene asteroids
            /*INSERT CODE HERE*/

        }
    }
    
    private func randomAsteroids(){
        let randomspeed = Double.random(in: 1 ..< 5)
        let randomSize = randomWidth(minRange: 10, maxRange: 100)
        let asteroid = Asteroid(speed: CGFloat(randomspeed), center: CGPoint(x: randomX(minRange: 0, range: 300), y: 140), size: randomSize)
        self.asteroids.append(asteroid)
        let randomN = Int.random(in: 0 ..< ASTEROIDS_IMAGES_NAMES.count)
        let asteroidView = UIImageView(image: UIImage(named: ASTEROIDS_IMAGES_NAMES[randomN]))
        asteroidView.center = asteroid.center
        asteroidView.frame.size = asteroid.size
        self.view.addSubview(asteroidView)
        self.asteroidsViews.append(asteroidView)
    }
    
    private func randomWidth(minRange: Int , maxRange: Int) -> CGSize{
        let size = randomN(minRange: minRange, maxRange: maxRange)
        return CGSize(width: size, height: size)
    }
    private func randomN (minRange: Int , maxRange: Int) -> Int{
        return Int.random(in: minRange ... maxRange)
    }
    
    private func randomX(minRange: Int , range: Int) -> Int{
        return randomN(minRange: minRange, maxRange: range)
    }
    

}

