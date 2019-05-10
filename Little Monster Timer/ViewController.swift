//
//  ViewController.swift
//  Little Monster Timer
//
//  Created by Jesper Lentz on 10/05/2019.
//  Copyright © 2019 Jesper Lentz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CountdownTimerDelegate{
    
    func countdownTimerDone() {
        print("done")
    }
    
    func countdownTime(totalsecondsReturn: Int) {
        let test = totalsecondsReturn
        print(test)
        
    }
    
    
   
    
  
    
    
    //Outlets & actions
    @IBOutlet weak var ProgressBarTimer: ProgressBar!
    @IBOutlet weak var InputLabet: UITextField!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var sec: UILabel!
    @IBAction func startStop(_ sender: Any) {
        ProgressBarTimer.start()
        countdownTimer.startTimer()
    
    }
    
    //VAR & LETS
    let timerPicker = UIPickerView()
    let toolbar = UIToolbar()
    
    var seconds = 0
    var minutes = 0
    var totalSeconds:Int = 0
    
    lazy var countdownTimer: CountdownTimer = {
        let countdownTimer = CountdownTimer()
        return countdownTimer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //PickerWheel loades her
        InputLabet.inputView = timerPicker
        InputLabet.inputView = toolbar
        createTimePicker()
        createToolBar()
    }
 
    
    
//MARK - PICKERVIEW
    func createTimePicker(){
    timerPicker.delegate = self
    InputLabet.inputView = timerPicker

    //Laver titler
    let height = CGFloat(20)
    let offsetX = timerPicker.frame.size.width / 3
    let offsetY = timerPicker.frame.size.height / 2 - height/2
    let marginX = CGFloat(56)
    let width = offsetX - marginX

    let minsLabel = UILabel(frame: CGRect(x: marginX + offsetX, y: offsetY, width: width, height: height))
    minsLabel.text = "min"
    //        minsLabel.textColor = .green
    timerPicker.addSubview(minsLabel)

    let secsLabel = UILabel(frame: CGRect(x: marginX + offsetX + offsetX + 30, y: offsetY, width: width, height: height))
    secsLabel.text = "sec"
    //        secsLabel.textColor = .green
    timerPicker.addSubview(secsLabel)
    }

    //toolbar til datepicker
    func createToolBar (){

    toolbar.sizeToFit()
    //toolbar.barTintColor = .black
    //toolbar.tintColor = .green

    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ViewController.doneInTimePickerPressed))

    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))

    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil);

    toolbar.setItems([doneButton, flexibleSpace, cancelButton], animated: true)
    toolbar.isUserInteractionEnabled = true
    InputLabet.inputAccessoryView = toolbar

    }

        //Done i timerPicker er pressed
         @objc func doneInTimePickerPressed (){
            calculateTotalSeconds()
            countdownTimer.setTimer(seconds: totalSeconds)
            ProgressBarTimer.setProgressBar(seconds: totalSeconds)
            dismissKeyboard()
        }

        //Sætter totale sekunder
       func calculateTotalSeconds(){
            let minToSeconds = minutes * 60
            totalSeconds = minToSeconds + seconds
            print("total seconds is:" ,totalSeconds)
        }

        //Fjerner pickerview
        @objc func dismissKeyboard(){
            view.endEditing(true)
        }

        //Laver værdier og returnerer dem
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0,1:
            return 60
            
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
           minutes = row
            
        case 1:
            seconds = row
            
        default:
            break;
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let width = pickerView.frame.size.width/3
        return width;
    }
}

