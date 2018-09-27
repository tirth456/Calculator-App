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
        var temp:Double = 0
        switch MathOperation {
        case 11:
            temp = Number1 + Number2
        case 12:
            temp = Number1 - Number2
        case 13:
            temp = Number1 * Number2
        case 14:
            temp = Number1 / Number2
        default: break
        }
        return temp
    }

    

    
    @IBAction func NumbersButton(_ sender: UIButton) {
        
        if !isInput {
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
            case 11, 12, 13, 14: //Addition, Substraction Multiplication and Division operation
                
                if !isEqual  {//isequal flag set for getting new number after pressing =
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
        isInput = false //reset new number flag
        hasDecimal = false //reset dot flag
    }
    
    @IBAction func PlusMinus(_ sender: UIButton) {
        NumberOnScreen = -Double(ResultText.text!)!
        ResultText.text = String(NumberOnScreen)
    }
    
    @IBAction func Percentage(_ sender: UIButton) {
        if(isPercentage == true)  {
            var temp:Double = 0
            temp = Double(ResultText.text!)!
            temp = temp / 100;
            temp = Firstnumber * temp
            ResultText.text = String(temp)
            isPercentage = false
        }
        else    {
            var temp:Double = 0
            temp = Double(ResultText.text!)!
            temp = temp / 100;
            ResultText.text = String(temp)
        }
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
