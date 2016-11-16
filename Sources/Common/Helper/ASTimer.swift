//
//  TimerHelper.swift
//  ASKit
//
//  Created by AntScript on 27/10/2016.
//
//

import Foundation

public class ASTimer {
    
    public typealias Task = (_ cancel:Bool) -> ()
    
    
    public static func delayedCall(_ time:TimeInterval, task:@escaping ()->()) -> Task? {
        func dispatch_later(_ block:@escaping ()->()) {
            DispatchQueue.main.asyncAfter(
                deadline: DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
                execute: block)
        }
        
        var closure: (()->())? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure);
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result
    }
    
    public static func cancelDelayedCall(_ task:Task?) {
        task?(true)
    }
    
    
    
    private typealias TimerObj = (timer:Timer?, seconds:Int, timeInterval:Int, completeAction:()->Void, updateAction:((Int)->Void)?)
    static private var timersObj = [String:TimerObj]()
    
    static public func setupTimer(id:String, seconds:Int, completeAction:@escaping(()->Void), updateAction:@escaping((Int)->Void), autoStart:Bool = true) -> Void {
        
        if timersObj[id] != nil {
            timersObj[id]!.seconds = seconds
            timersObj[id]!.completeAction = completeAction
            timersObj[id]!.timer?.invalidate()
            timersObj[id]!.timer = nil
        } else {
            timersObj[id] = TimerObj(timer:nil, seconds:seconds, timeInterval:0, completeAction:completeAction, updateAction:updateAction)
        }
        
        if autoStart {
            startTimer(id: id)
        }
    }
    
    @objc static func timerUpdate(timer:Timer) {
        if let id = (timer.userInfo as! Dictionary<String,AnyObject>)["id"] {
            if timersObj[id as! String] != nil {
                timersObj[id as! String]?.seconds -= 1
                if timersObj[id as! String]?.updateAction != nil {
                    timersObj[id as! String]?.updateAction!((timersObj[id as! String]?.seconds)!)
                }

                if (timersObj[id as! String]?.seconds)! <= 0 {
                    timersObj[id as! String]?.timer?.invalidate()
                    timersObj[id as! String]?.timer = nil
                    timersObj[id as! String]?.completeAction()
                    stopTimer(id: id as! String)
                }
            }
        }
    }
    
    static public func startTimer(id:String) {
        
        if timersObj[id] != nil {
            if timersObj[id]!.timer != nil {
                stopTimer(id: id)
            }
            timersObj[id]!.timeInterval = Int(Date().timeIntervalSince1970) + timersObj[id]!.seconds
            timersObj[id]!.timer = Timer.scheduledTimer(timeInterval: 1, target: ASTimer.self, selector: #selector(timerUpdate), userInfo: ["id":id], repeats: true)
        }
    }
    
    static public func stopTimer(id:String) {
        if timersObj[id] != nil {
            timersObj[id]!.timer?.invalidate()
            timersObj[id]!.timer = nil
        }
        timersObj.removeValue(forKey: id)
    }
    
    static public func add(id:String, seconds: Int) {
        if timersObj[id] != nil {
            timersObj[id]!.timeInterval += seconds
            timersObj[id]!.seconds += seconds
        }
    }

    
}
