//
//  PokeDetailsVC.swift
//  Pokedex
//
//  Created by Mike Milord on 20/12/2017.
//  Copyright © 2017 First Republic. All rights reserved.
//

import UIKit

class PokeDetailsVC: UIViewController , CAAnimationDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    
    @IBOutlet weak var speedLbl: UILabel!
    
    @IBOutlet weak var attackLbl: UILabel!
    
    
    @IBOutlet weak var heightView: UIView!
    
    @IBOutlet weak var weightView: UIView!
    
    @IBOutlet weak var speedView: UIView!
    
    @IBOutlet weak var attackView: UIView!
    
    
    
    var pokemonDetails : Pokemon!

    var maxValueHeight : CGFloat = 90.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        imgView.image = UIImage(named: "\(pokemonDetails.pokedex)")
        nameLbl.text = pokemonDetails.name.capitalized
        
        //Let hide all the labels before receiving the data
        heightLbl.isHidden = true
        weightLbl.isHidden = true
        speedLbl.isHidden = true
        attackLbl.isHidden = true
        
        
        pokemonDetails.downloadPokemonDetail {
            self.updateUI()
            

        }
        
        
    }
    
    func updateUI() {
        
        weightLbl.text = "\(pokemonDetails.weight)"
       // heightLbl.text = "\(pokemonDetails.height)"
        
        self.circularProgressBar()
        self.numberProgress(val: self.pokemonDetails.height)
        
        heightLbl.isHidden = false
        weightLbl.isHidden = false
    }
    
    
    func circularProgressBar() {
        
        //Colors
        let veryLightRedish = UIColor(red:0.95, green:0.84, blue:0.89, alpha:0.7)
        let redisheColor = UIColor(red:0.91, green:0.28, blue:0.62, alpha:1.0)
        let yellowMellow = UIColor(red:1.00, green:0.90, blue:0.00, alpha:0.4)
        let orange = UIColor(red:1.00, green:0.48, blue:0.00, alpha:1.0)
        
        
        
        let lineWidth : CGFloat = 5
        

        //Height Shape Layer
        heightView.backgroundColor = UIColor.clear
        let point1 = heightLbl.center
        let radius1 = heightView.frame.width / 2

        
        //The track layer for height
        let mHeightLayer = MLayer(centerPoint: point1, radius: radius1, lineWidth: lineWidth, trackColour: veryLightRedish)
        heightView.layer.insertSublayer(mHeightLayer.makeLayer(), below: heightLbl.layer)
        
        
        //Shape layer for Height
        let shapelayer = MLayer(centerPoint: point1, radius: radius1, lineWidth: lineWidth, trackColour: redisheColor)
        let heightShapelayer = shapelayer.makeLayer()
        
        
        //To soften the line cap - The begining of the circular
        heightShapelayer.lineCap = kCALineCapRound
        
        //This is where the animation will end
        heightShapelayer.strokeEnd = 0
        
        heightView.layer.insertSublayer(heightShapelayer, below: heightLbl.layer)
        
        let heightVal = CGFloat(pokemonDetails.height)
        let maxHeightVal : CGFloat = 90.00
        
        animate(shapeLayer: heightShapelayer, numerator: heightVal, maxVal: maxHeightVal)
        
        
        //---------- Create the track and shape layer for Weight
        let point2 = weightLbl.center
        let radius2 = weightView.frame.width / 2
        let mWeightLayer = MLayer(centerPoint: point2, radius: radius2, lineWidth: lineWidth, trackColour: yellowMellow)
        let trackWeightlayer = mWeightLayer.makeLayer()
        weightView.layer.insertSublayer(trackWeightlayer, below: weightLbl.layer)
        
        //shape layer for weight
        let shapelayer2 = MLayer(centerPoint: point2, radius: radius2, lineWidth: lineWidth, trackColour: orange)
        let weightShapelayer = shapelayer2.makeLayer()
        
        weightShapelayer.lineCap = kCALineCapRound
        weightShapelayer.strokeEnd = 0
        
        weightView.layer.insertSublayer(weightShapelayer, below: weightLbl.layer)
        
        //Add animation
        let weightVal = CGFloat(pokemonDetails.weight)
        let maxWeightVal : CGFloat = 5000.00
        animate(shapeLayer: weightShapelayer, numerator: weightVal, maxVal: maxWeightVal)
        
        
        
    }
    
    
    func animate(shapeLayer: CAShapeLayer , numerator : CGFloat , maxVal : CGFloat) {
        
        print("You animating ...")
        
        let val = numerator / maxVal
        
        // print("the val is : \(val)")
        
        
        //let animate with basic animation
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = val
        basicAnimation.duration = 1.0
        
        //To make the animation stays
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        
        //Let add the animation to the shape layer
        shapeLayer.add(basicAnimation, forKey: "animBasic")
        
        
    }
    

    
    
    func numberProgress (val: Int) {
        
        UIView.animate(withDuration: 3, animations: { () -> Void in
           self.heightLbl.text = "\(val)"
        })
    }
    
    



    @IBAction func dismissBtn(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    

}
