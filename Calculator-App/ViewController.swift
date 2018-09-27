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
        ResultText.text = ""
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var isMath:Bool = false // is Math operation pressed

    var Firstnumber:Double = 0
    var SecondNumber:Double = 0
    var NumberOnScreen: Double = 0.0
    var CalcResult:Double = 0
    var MathOperation:Int = 0
    var hasDecimal:Bool = false
    var isEqual:Bool = false
    var isInput:Bool = false
    var isPercentage:Bool = false
    
    
    
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
        
        if !isInput { //check if operation button pressed inorder to start recording new variable
            ResultText.text = String(sender.tag)
            isInput = true
        }
        else {
                        ResultText.text?.append(String(sender.tag))
        }
        NumberOnScreen = Double(ResultText.text!)!

//        if(ResultText.text == "0") {
//
//            if(sender.tag != -1) {
//                ResultText.text = ""
//
//            }
//            else {
//                if(hasDecimal) {
//                    ResultText.text = "0"
//                }
//            }
//
//        }
//
//        if(sender.tag == -1) {
//            if(!hasDecimal) {
//                ResultText.text?.append(".")
//                hasDecimal = true
//            }
//        }
//        else {
//            ResultText.text?.append(String(sender.tag))
//            isInput = true
//
//
//        }
//
//      NumberOnScreen=Double(ResultText.text!)!

    
       
//        let temp:String = ResultTextfield.text!
//        NumberOnScreen = Double(temp)!
//    NumberOnScreen=Double(ResultTextfield.text!)!
        
    }
    
    @IBAction func DotButton(_ sender: UIButton) {
        
        if !hasDecimal {
                ResultText.text?.append(".")
                hasDecimal = true
        }
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
    
    @IBAction func PlusMinus(_ sender: UIButton) {
        NumberOnScreen = -Double(ResultText.text!)!
        ResultText.text = String(NumberOnScreen)
    }
    
    @IBAction func Percentage(_ sender: UIButton) {
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
