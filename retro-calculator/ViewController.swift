//
//  ViewController.swift
//  retro-calculator
//
//  Created by Jeremiah on 10/29/16.
//  Copyright © 2016 Yaheard. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Clear = "Clear"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var spaceBG: UIImageView!
    @IBOutlet weak var groundImg: UIImageView!
    @IBOutlet weak var backgroundCountStackView: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var launchGround: UIImageView!
    @IBOutlet weak var retroCalc: UIImageView!
    @IBOutlet weak var robotImg: UIImageView!
    @IBOutlet weak var playNowButton: UIButton!
    
    @IBOutlet weak var launchBg: UIImageView!
    @IBAction func playBtn(sender: AnyObject) {
        outputLbl.hidden = false
        spaceBG.hidden = false
        groundImg.hidden = false
        backgroundCountStackView.hidden = false
        buttonsStackView.hidden = false
        launchGround.hidden = true
        retroCalc.hidden = true
        robotImg.hidden = true
        self.playNowButton.hidden = true
        launchBg.hidden = true
        
        btnSound.play()
        
    }
    
    func  startCalc() {
        outputLbl.hidden = true
        spaceBG.hidden = true
        groundImg.hidden = true
        backgroundCountStackView.hidden = true
        buttonsStackView.hidden = true
        launchGround.hidden = false
        retroCalc.hidden = false
        robotImg.hidden = false
        launchBg.hidden = false
    }
    
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    var leftVarStr1 = ""
    var x = false
    var y = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startCalc()
        
        
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch is NSError {
            print(debugDescription)
            
        }
        
        
    }
    
    
    @IBAction func numberPressed(btn: UIButton!) {
        btnSound.play()
        
       
        if x {
            runningNumber = ""
            runningNumber = "\(btn.tag)"
            outputLbl.text = runningNumber
        } else {
            if y {
            runningNumber += "\(btn.tag)"
            leftValStr = runningNumber
            outputLbl.text = result
                y = false
                x = false
            
            } else {
                runningNumber += "\(btn.tag)"
                leftValStr = runningNumber
                outputLbl.text = runningNumber
            }
        }
       
    }
    
    @IBAction func onClearPressed(btn: AnyObject) {
        btnSound.play()
        
        runningNumber = ""
        leftValStr = "0"
        outputLbl.text = leftValStr
        x = true
        y = false
    }
    
    

    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    
    @IBAction func onMultiplePressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
   
    
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
   }
    
    
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    

    
    
    func processOperation (op: Operation) {
        playsound()
        if currentOperation != Operation.Empty {
           // Run some math
            
            // A user selected an operator and then selected another operator without
            // first selecting a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    y = true
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    y = true
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    y = true
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    y = true
                }
                
               
               
            
            leftValStr = result
            outputLbl.text = result
        
                
            }
            
            currentOperation = op
            
            
    } else {
            // The is first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            y = false
            
            
        }
    }
        func playsound(){
            if btnSound.playing {
                btnSound.stop()
            }
            btnSound.play()
        }
    }
    


