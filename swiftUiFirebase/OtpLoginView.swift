//
//  OtpLoginView.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 11/04/24.
//

import SwiftUI


enum OtpAlertType{
    case shortOtpAlert
    case errorAlert
}


struct OtpLoginView: View {
    let mobileNumber : String
    
    let screenWidth = UIScreen.main.bounds.size.width
    let numberOfDigits = 6
    @State private var otp: String = ""
    @State private var isEditing = false
    @State var canNavigateToDataView = false
    @State var otpAlertType : OtpAlertType?
    
    
    
    @State var showAlertOnOtpSignIn = false
    @State var remainingTime = 30
    @State var timer : Timer?
    @State var timerShowing = true
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
 
    
    var body: some View {
        let otpFieldWidth = (screenWidth - 112)/6
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 0){
                Image("IcMobileOTP", bundle: nil)
                    .padding(.top, 66)
                    .padding(.leading, 16)
                    .frame(width: screenWidth, alignment: .leading)
                
                Text("Enter Code")
                    .font(.custom("Lato-Bold", size: 28
                                 ))
                    .padding(.leading, 16)
                    .padding(.top, 16)
                
                HStack(spacing: 0){
                    Text("We've sent verification code to ")
                        .font(.custom("Lato-Regular", size: 15))
                        .padding(.leading, 16)
                    Text(mobileNumber)
                        .fontWeight(.bold)
                }
                .padding(.top, 16)
                
                
                OtpView(otpFieldWidth: otpFieldWidth)
                
                HStack(spacing: 0){
                    Text("Didn't receive it? ")
                        .padding(.leading, 16)
                        .font(.custom("Lato-Regular", size: 15))
                    if timerShowing{
                        Text("\(String(format: "00:%02d", remainingTime))")
                            .onReceive(timer2, perform: { _ in
                                if remainingTime > 0{
                                    remainingTime -= 1
                                }
                                if remainingTime == 0{
                                    timerShowing = false
                                }
                                
                                
                            })
//                            .onAppear {
//                                startTimer()
//                            }
                            .foregroundStyle(Color("ButtonColor", bundle: nil))
                                                .font(.custom("Lato-Regular", size: 15))
                    }
                    else{
                        Text("Resend Code")
                            .foregroundStyle(Color("ButtonColor", bundle: nil))
                            .font(.custom("Lato-Regular", size: 15))
                            .onTapGesture {
//                                startTimer()
                                remainingTime = 30
                                timerShowing = true
                                
                            }
                    }
                        
                        
                }
                .padding(.top, 36)
                
                HStack(alignment: .center, spacing: 10) {
                    Text("Sign in")
                        .font(Font.custom("Lato-Regular", size: 15))
                        .foregroundColor(.white)
                        .frame(width: 311, height: 18)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(red: 0, green: 0.29, blue: 0.53))
                .cornerRadius(4)
                .frame(width: screenWidth)
                .padding(.top, 36)
                .onTapGesture {
//                    let code = "\(pin1.description)\(pin2.description)\(pin3.description)\(pin4.description)\(pin5.description)\(pin6.description)"
                    let code = "123456"
                    
                    if(code.count < 6){
                        otpAlertType = .shortOtpAlert
                        showAlertOnOtpSignIn = true
                        return
                    }
                    
                    verifyOtpCode(code)
                }
                .navigationDestination(isPresented: $canNavigateToDataView) {
                    DataView()
                        .navigationBarBackButtonHidden(true)
                }
                .alert(isPresented: $showAlertOnOtpSignIn){
                    switch otpAlertType {
                    case .shortOtpAlert:
                        Alert(title: Text("Warning!"), message: Text("Otp is too Short!"))
                    case .errorAlert:
                        Alert(title: Text("Warning!"), message: Text("Something went Wrong!"))
                    case nil:
                        Alert(title: Text("Warning!"), message: Text("Something went Wrong!"))
                    }
                }
                
                
                
                
                
                Spacer()
            }
        }
    }
}


#Preview {
    OtpLoginView(mobileNumber: "9140990110")
}
