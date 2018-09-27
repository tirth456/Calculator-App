//
//  ViewController.swift
//  Calculator-App
//
//  Created by Tirthrajsinh Chauhan on 2018-09-21.
//  Copyright © 2018 Tirthrajsinh Chauhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultText.text = "0"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var isMath:Bool = false // is Math operation pressed

    var Firstnumber:Double = 0 // left side of calculations
    var SecondNumber:Double = 0 // right side of calcultions
    var NumberOnScreen: Double = 0.0//number on screen
    var CalcResult:Double = 0 // result of calculations
    var MathOperation:Int = 0 // selected ID of operation
    var hasDecimal:Bool = false//is Dot pressed
    var isEqual:Bool = false //is equals pressed
    var isInput:Bool = false //checks if input number is in progress
    
    
    
    @IBOutlet weak var ResultText: UITextField!
    
    func calculations (Number1:Double, Number2:Double) -> Double {
        var tempResult:Double = 0
        switch MathOperation {
        case 11:
            tempResult = Number1 + Number2
        case 12:
            tempResult = Number1 - Number2
        case 13:
            tempResult = Number1 * Number2
        case 14:
            tempResult = Number1 / Number2
        default: break
        }
        return tempResult
    }

    

    
    @IBAction func NumbersButton(_ sender: UIButton) {

        if(ResultText.text == "0") {
            
            if(sender.tag != -1) {
                ResultText.text = ""
                
            }
            else {
                if(hasDecimal) {
                    ResultText.text = "0"
                }
            }
            
        }
        
        if(sender.tag == -1) {
            if(!hasDecimal) {
                ResultText.text?.append(".")
                hasDecimal = true
            }
        }
        else {
            ResultText.text?.append(String(sender.tag))
            isInput = true

            
        }
        
      NumberOnScreen=Double(ResultText.text!)!

    
       
//        let temp:String = ResultTextfield.text!
//        NumberOnScreen = Double(temp)!
//    NumberOnScreen=Double(ResultTextfield.text!)!
        
    }
    
    @IBAction func ClearScreen(_ sender: UIButton) {
        ResultText.text = "0" //reset text in UI
        hasDecimal = false
        //reset all flags
        isMath = false
        isEqual = false
        isInput = false
        
        //reset calculations
        CalcResult = 0
        Firstnumber = 0
        SecondNumber = 0
        NumberOnScreen = 0
        
        //reset state of calc
        MathOperation = 0
        
    }
    
    
    @IBAction func CalFunction(_ sender: UIButton)
    {
//        NumberOnScreen=Double(String(ResultText.text!))!
        if isMath { //are we in process of calculation chain
            switch sender.tag {
            case 11, 12, 13, 14: //Adding, Multiplications, Division, Minus operations
                
                if !isEqual {// if equals not pressed continue chain otherwise restar calculations chain and wait for 2nd number
                    SecondNumber = NumberOnScreen
                    CalcResult = calculations(Number1: Firstnumber, Number2: SecondNumber)
                    Firstnumber = CalcResult
                    MathOperation = sender.tag
                    ResultText.text = String(CalcResult)
                }
                else {
                    Firstnumber = Double(ResultText.text!)!
                    MathOperation = sender.tag
                }
           
            
            default:
                ResultText.text = "Error"
            }
        }
        else {
            Firstnumber = Double(ResultText.text!)!
            MathOperation = sender.tag
            hasDecimal = false
            isMath = true
        }
        isInput = false //set flag to start input new number
        hasDecimal = false //reset dot flag for new number input
    }
    
    @IBAction func EqualButton(_ sender: UIButton) {
        if isMath { //check if there is calculations to be done
            CalcResult = calculations(Number1: Firstnumber, Number2: NumberOnScreen)
            Firstnumber = CalcResult
            ResultText.text = String(CalcResult)
            hasDecimal = false
            isEqual = true
            isInput = false
        }
    }
    
    
    
}
