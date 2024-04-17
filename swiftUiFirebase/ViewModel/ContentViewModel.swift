//
//  ContentViewModel.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 05/04/24.
//

import Foundation
import SwiftUI
import CoreData

extension ContentView{
        
    func signInUsingEmail(){
        if fetchUser(emailTextField.description, passTextField.description){
            print("Fetching from Database...")
            canSignInEmail = true
        }
        else{
            print("Fetching from Firebase...")
            FirebaseFunctions().FirebaseSignIn(emailTextField, passTextField){success, error in
                if(success){
                    
                    canSignInEmail = true
                }
                else{
                    alertType = .firebaseError
                    alertMessage = error!
                    showAlertOnEmail = true
                }
            }
        }
    }
    
    func signInUsingMobile(){
        FirebaseFunctions().sendVerificationCode(to: "+91\(mobileTextField.description)"){success in
            print(success)
            if(success){
                canNavigateToOtpView = true
            }else{
                alertType = .errorAlert
                showAlertOnEmail = true
            }
        }
    }
    
    
        
    func showAlert(_ message: String) -> Alert{
            return Alert(title: Text("Failed"), message: Text(message))
    }

    
    private func addUser(_ email: String, _ password: String) {
            let newItem = UserEntityTable(context: ctx)
            newItem.email = email
            newItem.password = password

            do {
                try ctx.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
    
    private func fetchUser(_ email: String, _ password: String) -> Bool{
        do {
            let fetchRequest : NSFetchRequest<UserEntityTable> = UserEntityTable.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@ && password == %@", email, password)
            
            let items = try ctx.fetch(fetchRequest)
            
            for _ in items{
                return true
            }
        }
        catch{
            print("error-Fetching User")
            return false
        }
        
        return false
    }
    
    

    private func deleteUser(offsets: IndexSet) {
            

            do {
                try ctx.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}

