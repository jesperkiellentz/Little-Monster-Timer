//
//  CountdownTimer.swift
//  Little Monster Timer
//
//  Created by Jesper Lentz on 10/05/2019.
//  Copyright © 2019 Jesper Lentz. All rights reserved.
//

import UIKit

protocol CountdownTimerDelegate:class {
    func countdownTimerDone()
    func countdownTime(totalsecondsReturn: Int)
}




class CountdownTimer {
    weak var delegate: CountdownTimerDelegate?
    
    fileprivate var totalSecond: Int = 0
    var totalS = 0
    
    lazy var timer: Timer = {
        let timer = Timer()
        return timer
    }()
    
    public func setTimer(seconds:Int){
        totalSecond = seconds
        print("total second sat in class to", totalSecond)
        
    }
    
    public func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CountdownTimer.countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown (){
        totalSecond -= 1
        print(totalSecond)
        delegate?.countdownTime(totalsecondsReturn: totalSecond)
    }
    
        
    }
    
   
