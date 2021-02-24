//
//  ViewController.swift
//  CatchKenny
//
//  Created by Ruveyda Hilal Inan on 23/02/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    var imageName :	String!
    var image : UIImage!
    var imageView : UIImageView!
    var counter:Int!
    var timer:Timer!
    var score:Int!
    var storedScore:Int!
    var gestureRecognizer: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageName = "kenny.png"
        image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 70)
        counter = 10
        score = 0
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateKenny), userInfo: nil, repeats: true)
        
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gestureRecognizer)
        containerView.addSubview(imageView)
        
        storedScore = UserDefaults.standard.integer(forKey: "score")

        if let newScore = storedScore {
            print("new score = \(newScore)")
            highestScoreLabel.text = "Highest score: \(newScore)"
        }
        else {
            print("new score = 0")

            highestScoreLabel.text = "Highest score: 0"

        }
        
    
    }
    
    @objc func increaseScore() {
        
        score = score + 1
        scoreLabel.text = "Score: \(score!)"
    }
    
    @objc func updateKenny() {
        
        if counter != 0 {
            
            let widthKenny = Int(self.imageView.frame.size.width)
            let heightKenny = Int(self.imageView.frame.size.height)
            
            let widthContainer = Int(self.containerView.frame.size.width)
            let heightContainer = Int(self.containerView.frame.size.height)
            
            print("widthKenny \(widthKenny)")
            print("heightKenny \(heightKenny)")
            
            print("widthContainer \(widthContainer)")
            print("heightContainer \(heightContainer)")
            
            timeLabel.text = "Time: \(counter!)"
            let randomX = Int.random(in: 0..<(widthContainer-widthKenny))
            let randomY = Int.random(in: 0..<(heightContainer-heightKenny))
            
            print("randomx \(randomX)")
            print("randomy \(randomY)")
            
/*
            print("containerView.bounds.minX \(containerView.bounds.minX)")
            print("containerView.bounds.maxX \(containerView.bounds.maxX)")
            print("containerView.bounds.minY \(containerView.bounds.minY)")
            print("containerView.bounds.maxY \(containerView.bounds.maxY)")
*/
            /*var randomY = Int.random(in: (Int(view.frame.minY) + 80 + Int(stackView.heightAnchor))..<(Int(view.frame.maxY)-Int(highestScoreLabel.heightAnchor)))*/
                                     
            imageView.frame = CGRect(x: randomX, y: randomY, width: 50, height: 70)
            

        }
        else {
            timer.invalidate()
            
            if score > storedScore {
                highestScoreLabel.text = "Highest score: \(score!)"
                UserDefaults.standard.set(score, forKey: "score")

            }
            
            let alert = UIAlertController(title: "Score = \(score!)", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateKenny), userInfo: nil, repeats: true)
                self.counter = 10
                self.scoreLabel.text = "Score: \(self.score!)"
                self.score = 0
                self.imageView.addGestureRecognizer(self.gestureRecognizer)

            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.imageView.removeGestureRecognizer(self.gestureRecognizer)
               
                
            }

            alert.addAction(okButton)
            alert.addAction(cancelButton)
            
            self.present(alert, animated: true, completion: nil)
        }
        counter -= 1
        
        
    }


}

