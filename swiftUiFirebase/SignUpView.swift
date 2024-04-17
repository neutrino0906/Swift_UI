//
//  SignUpView.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 16/04/24.
//

import SwiftUI

enum Error{
    case emptyNameError
    case emptyEmailError
    case emptyPassError
    case emptyConfirmPassError
    case passNotMatchingError
    case firebaseError
}

struct SignUpView: View {
    
    @State var alertErrorType: Error?
    @State var nameTextField = ""
    @State var emailTextField = ""
    @State var passTextField = ""
    @State var confirmPassTextField = ""
    
    @State var showAlertOnSignUp = false
    @State var canNavigateToDataView = false
    @State var FirebaseErrorMessage = ""
    @State var canNavigateToSignIn = false
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                Image("SpvFinservIcon", bundle: nil)
                    .padding(.top, 118)
                    .padding(.leading, 16)
                    .frame(width: screenWidth, alignment: .leading)
                
                Text("Create your account")
                    .font(.custom("Lato-Bold", size: 25))
                    .padding()
                    .frame(width: screenWidth, alignment: .leading)
                    .padding(.top, 16)
                
                
                Text("Please fill up your details")
                    .font(.custom("Lato-Bold", size: 14))
                    .padding(.leading, 16)
                    .frame(width: screenWidth, alignment: .leading)
                    .padding(.top, 10)
                
                
                    TextField("Username", text: $nameTextField)
                        .font(.custom("Lato-Bold", size: 15))
                        .padding(.leading, 8)
                        .frame(width: screenWidth-32, height: 42, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                        .padding(.top, 32)
                        
                
                
                
                TextField("Email", text: $emailTextField)
                    .font(.custom("Lato-Bold", size: 15))
                    .padding(.leading, 8)
                    .frame(width: screenWidth-32, height: 42, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                    
                    .padding(.top, 32)
                
                
                
                    SecureField("Password", text: $passTextField)
                        .font(.custom("Lato-Bold", size: 15))
                        .padding(.leading, 8)
                        .frame(width: screenWidth-32, height: 42, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                        .padding(.top, 32)
                
                
                SecureField("Confirm Password", text: $confirmPassTextField)
                    .font(.custom("Lato-Bold", size: 15))
                    .padding(.leading, 8)
                    .frame(width: screenWidth-32, height: 42, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("ButtonColor", bundle: nil), lineWidth: 1))
                    .padding(.top, 32)
                
                
                
                
                
                HStack(alignment: .center, spacing: 10) {
                    Text("Sign in")
                      .font(Font.custom("Roboto", size: 14))
                      .foregroundColor(.white)
                      .frame(width: 311, height: 18)
                }
                .keyboardType(.emailAddress)
                .padding(.vertical, 12)
                .frame(width: screenWidth - 32)
                .background(Color(red: 0, green: 0.29, blue: 0.53))
                .cornerRadius(4)
                .padding(.top, 32)
                .navigationDestination(isPresented: $canNavigateToDataView, destination: {
                    DataView()
                        .navigationBarBackButtonHidden(true)
                })
                .onTapGesture {
                    if(nameTextField.isEmpty){
                        alertErrorType = .emptyNameError
                        showAlertOnSignUp.toggle()
                        return
                    }
                    if(emailTextField.isEmpty){
                        alertErrorType = .emptyEmailError
                        showAlertOnSignUp.toggle()
                        return
                    }
                    if(passTextField.isEmpty){
                        alertErrorType = .emptyPassError
                        showAlertOnSignUp.toggle()
                        return
                    }
                    if(confirmPassTextField.isEmpty){
                        alertErrorType = .emptyConfirmPassError
                        showAlertOnSignUp.toggle()
                        return
                    }
                    if(passTextField.description != confirmPassTextField.description){
                        alertErrorType = .passNotMatchingError
                        showAlertOnSignUp.toggle()
                        return
                    }
                    FirebaseFunctions().FirebaseSignUp(emailTextField.description, passTextField.description, nameTextField.description, ""){
                        success, message in
                        if success{
                            canNavigateToDataView.toggle()
                        }
                        else{
                            alertErrorType = .firebaseError
                            FirebaseErrorMessage = message!
                        }
                    }
                    
                }
                .alert(isPresented: $showAlertOnSignUp){
                    switch alertErrorType {
                    case .emptyNameError:
                        Alert(title: Text("Warning!"), message: Text("Please enter your Name!"))
                    case .emptyEmailError:
                        Alert(title: Text("Warning!"), message: Text("Please enter your Email!"))
                    case .emptyPassError:
                        Alert(title: Text("Warning!"), message: Text("Please enter your Password!"))
                    case .emptyConfirmPassError:
                        Alert(title: Text("Warning!"), message: Text("Please confirm your password!"))
                    case .passNotMatchingError:
                        Alert(title: Text("Warning!"), message: Text("Confirm password not matching!"))
                    case .some(.firebaseError):
                        Alert(title: Text("Warning!"), message: Text(FirebaseErrorMessage))
                    case nil:
                        Alert(title: Text("Warning!"), message: Text("Something went Wrong!"))
                    }
                }
                
                
                
                
                
                
                
                
                HStack{
                    Text("Already have an account?")
                        .foregroundColor(.black.opacity(0.6))
                        Text("Sign in")
                            .onTapGesture {
                                
                                    canNavigateToSignIn.toggle()
                                
                            }
                            .navigationDestination(isPresented: $canNavigateToSignIn, destination: {
                                
                                ContentView()
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
    SignUpView()
}
