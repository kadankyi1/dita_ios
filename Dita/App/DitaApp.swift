//
//  DitaApp.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 11/27/22.
//

import SwiftUI

@main
struct DitaApp: App {
    
    @State var currentStage = getUserFirstOpenView("user_accesstoken")
        
    var body: some Scene {
        
        WindowGroup {
            
            if(self.currentStage == "OnboardingView" || self.currentStage == ""){
                OnboardingView(currentStage: $currentStage)
            } else if(self.currentStage == "LoginView"){
                LoginView(currentStage: $currentStage)
            }  else {
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
        var user_firstname = UserDefaults.standard.string(forKey: "user_firstname") ?? ""
        var user_lastname = UserDefaults.standard.string(forKey: "user_lastname") ?? ""
        var latest_audio_image = UserDefaults.standard.string(forKey: "latest_audio_image") ?? ""
        var latest_video1_image = UserDefaults.standard.string(forKey: "latest_video1_image") ?? ""
        var latest_video2_image = UserDefaults.standard.string(forKey: "latest_video2_image") ?? ""
        //print("getSavedString: \(str)")
        if(str != "" && latest_audio_image != "" && latest_video1_image != "" && latest_video2_image != ""){
            if(user_firstname == "Guest" && user_lastname == "User"){
                str = "SignupView"
            } else {
                str = "MainView"
            }
        } else {
            str = "OnboardingView"
        }
        return str
        //let str = UserDefaults.standard.object(forKey: index) as? String
        //return str == nil ? "" : str!
    }

