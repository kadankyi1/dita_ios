//
//  TafarriApp.swift
//  Tafarri
//
//  Created by Dankyi Anno Kwaku on 2/6/23.
//

import SwiftUI

@main
struct TafarriApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    static let app_version : String = "1"
    
    // LIVE OR TEST ENVIRONMENT
    static let app_domain : String = "https://tafarri.com"
    //static let app_domain : String = "https://test.fishpott.com"
    
    @State var currentStage = getUserFirstOpenView("user_accesstoken")
        
    var body: some Scene {
        
        WindowGroup {
            
            if(self.currentStage == "OnboardingView" || self.currentStage == ""){
                OnboardingView(currentStage: $currentStage)
            } else if(self.currentStage == "GetLoginCodeView"){
                GetLoginCodeView(currentStage: $currentStage)
            } else if(self.currentStage == "LoginView"){
                LoginView(currentStage: $currentStage)
            } else {
                MainView(currentStage: $currentStage)
            }
            
        }
      }
    }

    func getSavedString(_ index: String) -> String {
        var str = UserDefaults.standard.string(forKey: index) ?? ""
        //print("getSavedString: \(str)")
        return str
        //let str = UserDefaults.standard.object(forKey: index) as? String
        //return str == nil ? "" : str!
    }

    func getUserFirstOpenView(_ index: String) -> String {
        var str = UserDefaults.standard.string(forKey: index) ?? ""
        var user_email = UserDefaults.standard.string(forKey: "user_email") ?? ""
        var user_accesstoken = UserDefaults.standard.string(forKey: "user_accesstoken") ?? ""
        
        //print("getSavedString: \(str)")
        if(str != "" && user_email != "" && user_accesstoken != ""){
            str = "MainView"
        } else {
            str = "OnboardingView"
        }
        return str
        //let str = UserDefaults.standard.object(forKey: index) as? String
        //return str == nil ? "" : str!
    }


func saveTextInStorage(_ index: String, _ value: String) {
    UserDefaults.standard.set(value, forKey:index)
}

func saveIntegerInStorage(_ index: String, _ value: Int) {
    UserDefaults.standard.set(value, forKey:index)
}

func deleteUserData(){
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    UserDefaults.standard.synchronize()
    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
}
