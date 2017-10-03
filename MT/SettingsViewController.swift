//
//  SettingsViewController.swift
//  MT
//
//  Created by Dinkar Khattar on 8/6/17.
//  Copyright © 2017 Dinkar Khattar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var easyMode: UISwitch!
    @IBOutlet weak var darkMode: UISwitch!
    @IBOutlet weak var speechMode: UISwitch!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var game1: UILabel!
    @IBOutlet weak var game2: UILabel!
    @IBOutlet weak var speechLabel: UILabel!
    
    var isEasyMode = false
    var isDarkMode = true
    var isSpeechMode = false

    @IBOutlet weak var speed: UISlider!
    @IBAction func easyMode(_ sender: UISwitch) {
        if sender.isOn {
            isEasyMode = true
        }
        if !sender.isOn {
            isEasyMode = false
        }
    }
    @IBAction func darkMode(_ sender: UISwitch) {
        if sender.isOn {
            isDarkMode = true
            changeColor(flag: 0)
        }
        
        if !sender.isOn {
            isDarkMode = false
            changeColor(flag: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEasyMode == false {
            easyMode.isOn = false
            
        }
        
        if isDarkMode == false {
            darkMode.isOn = false
            changeColor(flag: 1)
        }
        else {
            darkMode.isOn = true
            changeColor(flag: 0)
        }
        // Do any additional setup after loading the view.
    }
    
    func changeColor(flag: Int) {
        
        var color1:UIColor
        var color2:UIColor
        if flag==0
        {
            color1 = UIColor.black
            color2 = UIColor.white
            
        }
        
        else
        {
            color1 = UIColor.white
            color2 = UIColor.black
        }
        
        self.view.backgroundColor = color1
        self.settingLabel.textColor = color2
        self.label1.textColor = color2
        self.label2.textColor = color2
        self.label3.textColor = color2
        self.game1.textColor = color2
        self.game2.textColor = color2
        self.speechLabel.textColor = color2

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBack" {
            let vc = segue.destination as! InitialViewController
            vc.isEasyMode = self.isEasyMode
            vc.isDarkMode = self.isDarkMode
        }
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
