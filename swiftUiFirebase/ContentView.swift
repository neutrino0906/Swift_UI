//
//  ContentView.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 04/04/24.
//

import SwiftUI
import CoreData

enum AlertType{
    case emptyEmailAlert
    case emptyPassAlert
    case errorAlert
    case emptyMobileAlert
    case firebaseError
}
//let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

struct ContentView: View {
    @Environment(\.managedObjectContext) var ctx
    //    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    var items: FetchedResults<Item>
    
    @State var emailTextField: String = ""
    @State var passTextField: String = ""
    @State var mobileTextField : String = ""
    @State var isEmailOrPhone = true
    @State var isAlertPresentedOnMobile = false
    @State var canSignInEmail = false
    @State var showAlertOnEmail = false
    @State var canNavigateToOtpView = false
    @State var canNavigateToSignUp = false
    
    @State var alertType : AlertType?
    var isValid = false
    @State var alertMessage = "Error"
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 0) {
                Image("SpvFinservIcon", bundle: nil)
                    .padding(.top, 118)
                    .padding(.leading, 16)
                    .frame(width: screenWidth, alignment: .leading)
                
                Text("Sign in to your account")
                    .font(.custom("Lato-Bold", size: 25))
                    .padding()
                    .frame(width: screenWidth, alignment: .leading)
                    .padding(.top, 16)
                
                
                Text("Enter your Username to sign in")
                    .font(.custom("Lato-Bold", size: 14))
                    .padding(.leading, 16)
                    .frame(width: screenWidth, alignment: .leading)
                    .padding(.top, 10)
                
                if isEmailOrPhone{
                    TextField("Username", text: $emailTextField)
                        .font(.custom("Lato-Bold", size: 15))
                        .padding(.leading, 8)
                        .frame(width: screenWidth-32, height: 42, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                        
                        .padding(.top, 32)
                        
                }
                
                
                if isEmailOrPhone{
                    SecureField("Password", text: $passTextField)
                        .font(.custom("Lato-Bold", size: 15))
                        .padding(.leading, 8)
                        .frame(width: screenWidth-32, height: 42, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                        .padding(.top, 32)
                }
                
                if !isEmailOrPhone{
                    TextField("Mobile", text: $mobileTextField)
                        .font(.custom("Lato-Bold", size: 15))
                        .padding(.leading, 8)
                        .frame(width: screenWidth-32, height: 42, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                        .padding(.top, 32)
                        .alert(isPresented: $isAlertPresentedOnMobile, content: {
                            Alert(title: Text("Warning"), message: Text("Please enter your mobile number!"))
                        })
                }
                
                HStack(){
                    Button("Forget password?") {
                        
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color("ButtonColor", bundle: nil))
                    .padding()
                    
                    Spacer()
                    Button("Change Domain") {
                        
                    }
                    .padding()
                    .foregroundColor(Color("ButtonColor", bundle: nil))
                    .font(.system(size: 14))
                    
                    
                }
                HStack(alignment: .center, spacing: 10) {
                    Text("Sign in")
                      .font(Font.custom("Roboto", size: 14))
                      .foregroundColor(.white)
                      .frame(width: 311, height: 18)
                }
                .keyboardType(.emailAddress)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(red: 0, green: 0.29, blue: 0.53))
                .cornerRadius(4)
                .onTapGesture {
                    if emailTextField.isEmpty && isEmailOrPhone{
                        alertType = .emptyEmailAlert
                        showAlertOnEmail.toggle()
                        return
                    }
                    if passTextField.isEmpty && isEmailOrPhone{
                        alertType = .emptyPassAlert
                        showAlertOnEmail.toggle()
                        return
                    }
                    if mobileTextField.isEmpty && !isEmailOrPhone{
                        alertType = .emptyMobileAlert
                        showAlertOnEmail.toggle()
                        return
                    }
                    
                    if(isEmailOrPhone){
                        signInUsingEmail()
                    }
                    else{
                        signInUsingMobile()
                    }
                    
                }
                .navigationDestination(isPresented: $canSignInEmail) {
                    DataView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $canNavigateToOtpView) {
                    OtpLoginView(mobileNumber: mobileTextField.description)
                }
                .alert(isPresented: $showAlertOnEmail) {
                    switch alertType {
                    case .emptyEmailAlert:
                        Alert(title: Text("Warning!"), message: Text("Please enter your Email !"))
                    case .emptyPassAlert:
                        Alert(title: Text("Warning!"), message: Text("Please enter your Password !"))
                    case .errorAlert:
                        Alert(title: Text("Warning!"), message: Text("Some Error Occured !"))
                    case .emptyMobileAlert:
                        Alert(title: Text("Warning!"), message: Text("Please enter your Phone number !"))
                    case .some(.firebaseError):
                        Alert(title: Text("Warning!"), message: Text(alertMessage))
                    case nil:
                        Alert(title: Text("Warning!"), message: Text(alertMessage))
                    }
                }
                
                
                
                
                
                Text("Or Sign in with")
                    .font(.custom("Lato-Bold", size: 13))
                    .padding(.top, 24)
                    .foregroundColor(Color(white: 0, opacity: 0.6))
                           
                
                HStack(alignment: .center, spacing: 8) {
                    Image(!isEmailOrPhone ? "Icon1" : "IcOtp")
                      .frame(width: 14.5, height: 14.5)
                      .foregroundColor(.black)
                    
                    Text(!isEmailOrPhone ? "Username" : "Mobile")
                      .font(Font.custom("Lato-Regular", size: 14))
                      .foregroundColor(.black.opacity(0.8))
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 127.5)
                .background(Color(red: 0.95, green: 0.96, blue: 0.98))
                .cornerRadius(4)
                .padding(.vertical, 12)
                .onTapGesture {
                    withAnimation{
                        isEmailOrPhone.toggle()
                    }
                }
                
                
                HStack{
                    Text("Don't have an account?")
                        .foregroundColor(.black.opacity(0.6))
                        
                    Text("Sign up")
                        .onTapGesture {
                            canNavigateToSignUp.toggle()
                        }
                        .navigationDestination(isPresented: $canNavigateToSignUp, destination: {
                            SignUpView()
                                .navigationBarBackButtonHidden()
                        })
                    .foregroundColor(Color("ButtonColor", bundle: nil))
                }
                .font(.system(size: 14))
                .padding(.leading, 16)
                .padding(.top, 42)
                .frame(width: screenWidth, alignment: .leading)
                
                Spacer()
            }
            
        }
    }

    
}

#Preview {
    ContentView()
}
