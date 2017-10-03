//
//  ViewController.swift
//  MT
//
//  Created by Dinkar Khattar on 8/3/17.
//  Copyright © 2017 Dinkar Khattar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var NumberOrLetter: UILabel!
    
    var isDarkMode = false
    var isEasyMode = false
    
    var rand = 10
    var score = 0
    var levelUp = false
    
    var pageChangeTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDarkMode {
            makeBlack()
        }
        else {
            makeWhite()
        }
        
        pageChangeTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(pageChange), userInfo: nil, repeats: true)
        
        if self.score > 3 {
            pageChangeTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(pageChange), userInfo: nil, repeats: true)
        }
        
        if self.score > 5 {
            pageChangeTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(pageChange), userInfo: nil, repeats: true)
        }
        
        if self.score > 7 {
            pageChangeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pageChange), userInfo: nil, repeats: true)
        }
        
        if isEasyMode {
            self.rand = Int(arc4random_uniform(2))
        }
        
        else {
            self.rand = Int(arc4random_uniform(4))
        }
        
        self.loadLabel()
        
        self.scoreLabel.text = "Score: \(String(score))"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func makeBlack() {
        self.view.backgroundColor = UIColor.black
        self.scoreLabel.textColor = UIColor.white
        self.NumberOrLetter.textColor = UIColor.white
    }
    
    func makeWhite() {
        self.view.backgroundColor = UIColor.white
        self.scoreLabel.textColor = UIColor.black
        self.NumberOrLetter.textColor = UIColor.black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SecondViewController
        vc.trigger = NumberOrLetter.text!
        vc.score = self.score
        vc.isDarkMode = self.isDarkMode
    }
    
    func loadLabel() {
        
        
        if self.rand == 0 {
            NumberOrLetter.text = "Letter"
        }
            
        else if rand == 1 {
            NumberOrLetter.text = "Number"
        }
            
        else if rand == 2{
            NumberOrLetter.text = "Color of Letter"
        }
        
        else {
            NumberOrLetter.text = "Color of Number"
        }

        
    }
    
    func pageChange() {
        
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "goToSecond", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

