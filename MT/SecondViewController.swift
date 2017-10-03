//
//  SecondViewController.swift
//  MT
//
//  Created by Dinkar Khattar on 8/3/17.
//  Copyright © 2017 Dinkar Khattar. All rights reserved.
//

import UIKit
import Speech

class SecondViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score = 0
    var trigger = ""
    var generatedLetter:String = ""
    var generatedNumber:Int = 0
    var spokenInput = ""
    var rightAnswer = ""
    var UIcolors = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.brown, UIColor.orange]
    var stringColors = ["blue", "red", "yellow", "green", "purple", "brown", "orange"]
    var randColorLetter = Int(arc4random_uniform(7))
    var randColorNumber = Int(arc4random_uniform(7))
    
    let audioEngine = AVAudioEngine()
    let speechRec: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init (identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    var isDarkMode = false
    
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
        
        testLabel.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
        
        self.scoreLabel.text = "Score: \(String(score))"
        
        self.loadLetterAndNumber()
        
        self.recordAndRecSpeech()
        
        // Do any additional setup after loading the view.
    }
    
    func makeBlack() {
        self.view.backgroundColor = UIColor.black
        self.numberLabel.textColor = UIColor.white
        self.letterLabel.textColor = UIColor.white
        self.scoreLabel.textColor = UIColor.white
    }
    
    func makeWhite() {
        self.view.backgroundColor = UIColor.white
        self.numberLabel.textColor = UIColor.black
        self.letterLabel.textColor = UIColor.black
        self.scoreLabel.textColor = UIColor.black
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            let oldWord:String = String(describing: change?[.oldKey])
            let newWord:String = String(describing: change?[.newKey])
            
            let subOldWord = changeWord(word: oldWord)
            let subNewWord = changeWord(word: newWord)
            
            if subOldWord == "Label"
            {
                if trigger == "Letter"
                {
                    
                    if self.generatedLetter=="A" || self.generatedLetter=="E" || self.generatedLetter=="I" || self.generatedLetter=="O" || self.generatedLetter=="U"
                    {
                        self.rightAnswer = "vowel"
                        if self.spokenInput == "vowel"
                        {
                            self.score = self.score + 1
                            print ("RIGHT")
                        }
                        
                        else
                        {
                            performSegue(withIdentifier: "gotRekt", sender: nil)
                            print ("WRONG")
                        }
                    }
                    
                    else
                    {
                        self.rightAnswer = "consonant"
                        if self.spokenInput == "consonant"
                        {
                            self.score = self.score + 1
                            print ("RIGHT")
                        }
                            
                        else
                        {
                            performSegue(withIdentifier: "gotRekt", sender: nil)
                            print ("WRONG")
                        }
                    }
                }
                
                if trigger == "Number"
                {
                    if self.generatedNumber%2 == 0
                    {
                        self.rightAnswer = "even"
                        if self.spokenInput == "even"
                        {
                            self.score = self.score + 1
                            print ("RIGHT")
                        }
                        else
                        {
                            performSegue(withIdentifier: "gotRekt", sender: nil)
                            print ("WRONG")
                        }
                    }
                    
                    else
                    {
                        self.rightAnswer = "odd"
                        if self.spokenInput == "odd"
                        {
                            self.score = self.score + 1
                            print ("RIGHT")
                        }
                        else
                        {
                            performSegue(withIdentifier: "gotRekt", sender: nil)
                            print ("WRONG")
                        }
                    }
                }
                
                if trigger == "Color of Letter"
                {
                    self.rightAnswer = stringColors[randColorLetter]
                    if self.spokenInput == self.rightAnswer
                    {
                        self.score = self.score + 1
                        print ("RIGHT")
                    }
                    else
                    {
                        performSegue(withIdentifier: "gotRekt", sender: nil)
                        print ("WRONG")
                    }
                }
                
                if trigger == "Color of Number"
                {
                    self.rightAnswer = stringColors[randColorNumber]
                    if self.spokenInput == self.rightAnswer
                    {
                        self.score = self.score + 1
                        print ("RIGHT")
                    }
                    else
                    {
                        performSegue(withIdentifier: "gotRekt", sender: nil)
                        print ("WRONG")
                    }
                }
                
            }
            
            if subNewWord == "" {
                self.spokenInput = "oops"
                performSegue(withIdentifier: "gotRekt", sender: nil)
            }
            
            self.scoreLabel.text = "Score: \(String(score))"
        }
    }
    
    func changeWord(word: String) -> String {
        
        var subWord = ""
        
        for i in word.characters.indices {
            if word[i] == "(" {
                for j in word.characters.indices[word.index(i, offsetBy: 1)..<word.endIndex] {
                    subWord += String(word[j])
                }
                break
            }
        }
        
        subWord = subWord.substring(to: subWord.index(before: subWord.endIndex))
        
        return subWord
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToFirst" {
            self.stopRecording()
            let vc1 = segue.destination as! ViewController
            vc1.score = self.score
            vc1.isDarkMode = self.isDarkMode
            if self.spokenInput == "" {
                self.spokenInput = "oops"
                if trigger == "Letter" {
                    if self.generatedLetter=="A" || self.generatedLetter=="E" || self.generatedLetter=="I" || self.generatedLetter=="O" || self.generatedLetter=="U" {
                        self.rightAnswer = "Vowel"
                    }
                    else {
                        self.rightAnswer = "Consonant"
                    }
                    
                }
                else if trigger == "Number" {
                    if self.generatedNumber%2==0 {
                        self.rightAnswer = "Even"
                    }
                    else {
                        self.rightAnswer = "Odd"
                    }
                }
                else if trigger == "Color of Letter" {
                    self.rightAnswer = stringColors[randColorLetter]
                }
                else {
                    self.rightAnswer = stringColors[randColorNumber]
                }
                performSegue(withIdentifier: "gotRekt", sender: nil)
            }
        }
        
        if segue.identifier == "gotRekt" {
            let vc2 = segue.destination as! ThirdViewController
            vc2.givenInput = self.spokenInput
            vc2.rightInput = self.rightAnswer
            vc2.finalScore = self.score
            vc2.isDarkMode = self.isDarkMode
        }
    }
    
    func recordAndRecSpeech(){
        
        guard let node = audioEngine.inputNode else {return}
        let recordingFormat = node.outputFormat (forBus:0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in self.request.append(buffer)}
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRec = SFSpeechRecognizer() else {return}
        if !myRec.isAvailable {
            return
        }
        
        var firstWord:String = " "
        
        recTask = speechRec?.recognitionTask(with: request, resultHandler: {result, error in
            if let result = result {
                
                
                let bestString:String = result.bestTranscription.formattedString
                
                firstWord = bestString.components(separatedBy: " ").first!
                
                self.spokenInput = firstWord.lowercased()
                
                self.fixWord()
                
                self.testLabel.text = self.spokenInput
                
            } else if let error = error {
                print(error)
            }
            
        })
    }
    
    func stopRecording() {
        DispatchQueue.main.async {
            if(self.audioEngine.isRunning){
                self.audioEngine.stop()
                self.recTask?.cancel()
                self.recTask = nil;
            }
        }
    }
    
    func loadLetterAndNumber() {
        
        let arrayOfLetters:[String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        let randLetter = Int(arc4random_uniform(26))
        
        self.generatedLetter = arrayOfLetters[randLetter]
        
        letterLabel.text = arrayOfLetters[randLetter]
        
        letterLabel.textColor = UIcolors[randColorLetter]
        
        let x = Int(arc4random_uniform(10))
        let y = Int(arc4random_uniform(10))
        
        let num = String(x + 10*y)
        
        self.generatedNumber = x + 10*y
        
        numberLabel.text = num
        
        numberLabel.textColor = UIcolors[randColorNumber]

    }
    
    func fixWord()
    {        
        if self.spokenInput == "vowel" || self.spokenInput == "volvo" || self.spokenInput == "val" || self.spokenInput == "wall" || self.spokenInput == "valval" || self.spokenInput == "valve" || self.spokenInput == "hello" || self.spokenInput == "wow" || self.spokenInput == "well" {
            self.spokenInput = "vowel"
        }
        
        if self.spokenInput == "consonant" || self.spokenInput == "continent" || self.spokenInput == "confident" || self.spokenInput == "constant" || self.spokenInput == "concerning" || self.spokenInput == "counselling" || self.spokenInput == "counseling" || self.spokenInput == "considering" || self.spokenInput == "constonent" {
            self.spokenInput = "consonant"
        }
        
        if self.spokenInput == "odd" || self.spokenInput == "or" || self.spokenInput == "would" || self.spokenInput == "hard" || self.spokenInput == "ordered" || self.spokenInput == "our" || self.spokenInput == "on" || self.spokenInput == "old" || self.spokenInput == "are" || self.spokenInput == "i" || self.spokenInput == "it" || self.spokenInput == "god" {
            self.spokenInput = "odd"
        }
        
        if self.spokenInput == "read" {
            self.spokenInput = "red"
        }
        
        if self.spokenInput == "do" || self.spokenInput == "brew" || self.spokenInput == "will" || self.spokenInput == "boo" {
            self.spokenInput = "blue"
        }
        
        if self.spokenInput == "that" {
            self.spokenInput = "red"
        }
        
        if self.spokenInput == "bubba" || self.spokenInput == "bubble" || self.spokenInput == "puppet" || self.spokenInput ==
            "bopple" {
            self.spokenInput = "purple"
        }
        
    }
    
    func pageChange() {
        
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "goToFirst", sender: self)
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
