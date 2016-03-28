//
//  TBTouchIDManger.swift
//  TouchID_Swift
//
//  Created by Pengfei_Luo on 16/1/21.
//  Copyright © 2016年 骆朋飞. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

typealias replyBlock = (success : Bool, error : NSError?)->Void

let resonStr = "验证Touch ID"

class TBTouchIDManger: NSObject {

    /// 单例
    class var shateInstance : TBTouchIDManger {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : TBTouchIDManger? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TBTouchIDManger()
        }
        
        return Static.instance!
    }
    // 这只是一行注释
    
    /// 是否支持Touch id
    internal func isSupportTouchID() -> Bool {
        if #available(iOS 8.0, *) {
            let context = LAContext()
            var error : NSError?
            let isSupport = context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error)
            if (!isSupport && (error != nil)) {
                debugPrint(error?.description)
            }
            debugPrint(isSupport)
            return isSupport
        }
        
        return false
    }
    
    internal func touchIDReply(reply : replyBlock!/*使用!不需要解包*/) {
        if #available(iOS 8.0, *) {
            let context = LAContext()
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: resonStr, reply: reply)
        }
        
    }
    
}
