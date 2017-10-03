//
//  Game2ViewController.swift
//  MT
//
//  Created by Dinkar Khattar on 8/14/17.
//  Copyright © 2017 Dinkar Khattar. All rights reserved.
//

import UIKit

class Game2ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var color: UILabel!
    
    var UIcolors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.brown, UIColor.orange]
    var stringColors = ["blue", "red", "yellow", "green", "purple", "brown", "orange"]
    var randColorName = Int(arc4random_uniform(7))
    var randColor = Int(arc4random_uniform(7))
    
    var score = 0
    var isSpeech = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreLabel.text = "Score: \(String(score))"
        
        self.loadColor()

        // Do any additional setup after loading the view.
    }
    
    func loadColor() {

        self.color.textColor = UIcolors[randColor]
        self.color.text = stringColors[randColorName]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
