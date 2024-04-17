//
//  OtpView.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 11/04/24.
//

import SwiftUI

enum FocusPin{
    case pin1, pin2, pin3, pin4, pin5, pin6
}


struct OtpView: View{
    let otpFieldWidth : CGFloat
    
    @FocusState var pinFocusState : FocusPin?
    @State var currFocus = 0
    
    @State var pinList = ["","","","","",""]
    @State var pinCase = [FocusPin.pin1, .pin2, .pin3,.pin4,.pin5,.pin6]
    
    var body: some View {
        
        HStack(spacing: 16){
            
            //Textfield 1
            TextField("", text: $pinList[0])
                .frame(width: otpFieldWidth, height: otpFieldWidth)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinList[0], initial: true) { oldValue, newValue in
                    
                    if(newValue.count > 1 && newValue != oldValue) {
                        var temp = newValue
                        for i in 0...5{
                            if(temp.count > 0){
                                pinList[i] = String(temp.prefix(1))
                                temp.removeFirst(1)
                                if(i != 0){
                                    currFocus = i
                                }
                            }
                        }
                        pinFocusState = pinCase[currFocus]
                    }
                    
                }
                .onKeyPress(characters: CharacterSet(charactersIn: "0123456789"), action: { keyPress in
                    pinList[0] = keyPress.characters
                    pinFocusState = pinCase[1]
                    return .handled
                })
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(named: "ButtonColor")!), lineWidth: pinList[0].count == 0 ? 0 : 2.0))
                .background(Color(white: 0, opacity: 0.03))
                .focused($pinFocusState, equals: pinCase[0])
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .allowsHitTesting(pinFocusState == pinCase[0])
            
            
            
            //Textfield 2
            TextField("", text: $pinList[1])
                .frame(width: otpFieldWidth, height: otpFieldWidth)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinList[1], initial: true) { oldValue, newValue in
                    
                    if(newValue.count == 0){
                        pinFocusState = .pin1
                    }
                    
                    if(newValue.count > 1 && newValue != oldValue) {
                        var temp = newValue
                        for i in 1...5{
                            if(temp.count > 0){
                                pinList[i] = String(temp.prefix(1))
                                temp.removeFirst(1)
                                if(i != 1){
                                    currFocus = i
                                }
                            }
                        }
                        pinFocusState = pinCase[currFocus]
                    }
                    
                }
                .onKeyPress(characters: CharacterSet(charactersIn: "0123456789"), action: { keyPress in
                    pinList[1] = keyPress.characters
                    pinFocusState = pinCase[2]
                    return .handled
                })
                .onKeyPress(.delete){
                    pinList[1] = ""
                    pinFocusState = pinCase[0]
                    return .handled
                }
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(named: "ButtonColor")!), lineWidth: pinList[1].count == 0 ? 0 : 2.0))
                .background(Color(white: 0, opacity: 0.03))
                .focused($pinFocusState, equals: pinCase[1])
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .allowsHitTesting((pinFocusState == pinCase[1]))
            
            
            
            //Textfield 3
            TextField("", text: $pinList[2])
                .frame(width: otpFieldWidth, height: otpFieldWidth)
                .multilineTextAlignment(.center)
            
                .keyboardType(.numberPad)
                .onChange(of: pinList[2], initial: true) { oldValue, newValue in
                    
                    if(newValue.count > 1 && newValue != oldValue) {
                        var temp = newValue
                        for i in 2...5{
                            if(temp.count > 0){
                                pinList[i] = String(temp.prefix(1))
                                temp.removeFirst(1)
                                if(i != 2){
                                    currFocus = i
                                }
                            }
                        }
                        pinFocusState = pinCase[currFocus]
                    }
                    
                }
                .onKeyPress(characters: CharacterSet(charactersIn: "0123456789"), action: { keyPress in
                    pinList[2] = keyPress.characters
                    pinFocusState = pinCase[3]
                    return .handled
                })
                .onKeyPress(.delete){
                    pinList[2] = ""
                    pinFocusState = pinCase[1]
                    return .handled
                }
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(named: "ButtonColor")!), lineWidth: pinList[2].count == 0 ? 0 : 2.0))
                .background(Color(white: 0, opacity: 0.03))
                .focused($pinFocusState, equals: pinCase[2])
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .allowsHitTesting((pinFocusState == pinCase[2]))
            
            
            //Textfield 4
            TextField("", text: $pinList[3])
                .frame(width: otpFieldWidth, height: otpFieldWidth)
                .multilineTextAlignment(.center)
            
                .keyboardType(.numberPad)
                .onChange(of: pinList[3], initial: true) { oldValue, newValue in
                    
                    if(newValue.count > 1 && newValue != oldValue) {
                        var temp = newValue
                        for i in 3...5{
                            if(temp.count > 0){
                                pinList[i] = String(temp.prefix(1))
                                temp.removeFirst(1)
                                if(i != 3){
                                    currFocus = i
                                }
                            }
                        }
                        pinFocusState = pinCase[currFocus]
                    }
                    
                }
                .onKeyPress(characters: CharacterSet(charactersIn: "0123456789"), action: { keyPress in
                    
                    pinList[3] = keyPress.characters
                    pinFocusState = pinCase[4]
                    return .handled
                })
                .onKeyPress(.delete){
                    pinList[3] = ""
                    pinFocusState = pinCase[2]
                    return .handled
                }
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(named: "ButtonColor")!), lineWidth: pinList[3].count == 0 ? 0 : 2.0))
                .background(Color(white: 0, opacity: 0.03))
                .focused($pinFocusState, equals: pinCase[3])
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .allowsHitTesting((pinFocusState == pinCase[3]))
            
            
            
            
            //Textfield 5
            TextField("", text: $pinList[4])
                .frame(width: otpFieldWidth, height: otpFieldWidth)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinList[4], initial: false) { oldValue, newValue in
                    
                    if(newValue.count > 1 && newValue != oldValue) {
                        var temp = newValue
                        for i in 4...5{
                            if(temp.count > 0){
                                pinList[i] = String(temp.prefix(1))
                                temp.removeFirst(1)
                                if(i != 4){
                                    currFocus = i
                                }
                            }
                        }
                        pinFocusState = pinCase[currFocus]
                    }
                    
                }
                .onKeyPress(characters: CharacterSet(charactersIn: "0123456789"), action: { keyPress in
                    pinList[4] = keyPress.characters
                    pinFocusState = pinCase[5]
                    return .handled
                })
                .onKeyPress(.delete){
                    pinList[4] = ""
                    pinFocusState = pinCase[3]
                    return .handled
                }
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(named: "ButtonColor")!), lineWidth: pinList[4].count == 0 ? 0 : 2.0))
                .background(Color(white: 0, opacity: 0.03))
                .focused($pinFocusState, equals: pinCase[4])
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .allowsHitTesting((pinFocusState == pinCase[4]))
            
            
            
            
            //Textfield 6
            TextField("", text: $pinList[5])
                .frame(width: otpFieldWidth, height: otpFieldWidth)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .onChange(of: pinList[5], initial: false) { oldValue, newValue in
                    
                    
                    if(newValue.count > 1 && oldValue != String(newValue.prefix(1))){
                        pinList[5] = String(pinList[5].prefix(1))
                    }
                    else if(newValue.count > 1){
                        pinList[5].removeFirst(1)
                        pinList[5] = String(pinList[5].prefix(1))
                    }
                }
                .onKeyPress(characters: CharacterSet(charactersIn: "0123456789"), action: { keyPress in
                    pinList[5] = keyPress.characters
                    pinFocusState = pinCase[5]
                    return .handled
                })
                .onKeyPress(.delete){
                    pinList[5] = ""
                    pinFocusState = pinCase[4]
                    return .handled
                }
                .background(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(UIColor(named: "ButtonColor")!), lineWidth: pinList[5].count == 0 ? 0 : 2.0))
                .background(Color(white: 0, opacity: 0.03))
                .focused($pinFocusState, equals: pinCase[5])
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .allowsHitTesting(pinFocusState == pinCase[5])
            
        }
        .padding(.leading, 16)
        .padding(.top, 16)
    }
}

#Preview {
    OtpView(otpFieldWidth: 44)
}

