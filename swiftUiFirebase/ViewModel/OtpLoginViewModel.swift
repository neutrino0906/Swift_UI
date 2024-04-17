//
//  OtpLoginViewModel.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 15/04/24.
//

import Foundation
import SwiftUI

extension OtpLoginView{
    
    func verifyOtpCode(_ code: String){
        FirebaseFunctions().verifyCode(code) { success in
            if success{
                canNavigateToDataView = true
            }
            else{
                otpAlertType = .errorAlert
                showAlertOnOtpSignIn = true
                
            }
        }
    }
    
    func startTimer(){
        timerShowing = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                
                remainingTime -= 1
                if(remainingTime == 0){
                    timerShowing = false
                    resetTimer()
                }
            }
        
        
    }
    
    
    
    func resetTimer(){
        remainingTime = 30
        timer?.invalidate()
        timer = nil
    }
    
}

//struct TextModifier: ViewModifier {
//    let isBordered: Bool
//    
//    func body(content: Content) -> some View {
//        if isBordered {
//            return content
//                .background(RoundedRectangle(cornerRadius: 4)
//                .stroke(lineWidth: 1.0))
//        } else {
//            return content.foregroundColor(.blue)
//        }
//    }
//}
