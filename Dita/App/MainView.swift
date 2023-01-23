//
//  MainView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/20/23.
//

import SwiftUI

import SwiftyJSON

struct MainView: View {
    @Binding var currentStage: String
    //@ObservedObject var notificationManager : NotificationManager
    //var thisDeviceToken : String?
    //@ObservedObject var setDeviceTokenFetchHttpAuth = SetDeviceTokenFetchHttpAuth()
    
    //init(currentStage: Binding<String>, notificationManager: NotificationManager, deviceToken: String) {
    init(currentStage: Binding<String>) {
         self._currentStage = .constant("MainView")
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
        //self.notificationManager = notificationManager
        //self.thisDeviceToken = deviceToken
        //print("3SNMDT thisDeviceToken: \(thisDeviceToken)")
        /*
         for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
         */
    }
    
    //var access_token: String = getSavedString("user_accesstoken");
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    @State var now = Date()
    
    let tabBarImageNames = ["suggestions", "finder", "investments", "persona", "profile" ]
    let tabBarMenuNames = ["Suggestions", "Finder", "Investments", "Persona", "Profile"]
    
    var body: some View {
        
        /*
        var timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {
            (_) in
            updateContent.update_content(user_accesstoken: getSavedString("user_accesstoken"));
        }
         */
        VStack(spacing: 0) {
            
        Text("FishPott ")
            .foregroundColor(Color(.black))
            .font(.custom("SweetSensationsPersonalUse", size: 30))
            .padding(.top, 5)
            
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action: {shouldShowModal.toggle()}, label: {
                            Text("Fullscreen cover")
                        })
                    
                })
                
                switch selectedIndex {
                case 0:
                    LastReadView()
                    /*
                    if (notificationManager.currentNotificationText == nil || notificationManager.currentNotificationText == "") {
                        SuggestionView()
                            .onAppear(perform: {
                                print("2SNMDT thisDeviceToken: \(thisDeviceToken)")
                                //if (notificationManager.currentNotificationText != nil && notificationManager.currentNotificationText != "") {
                                setDeviceTokenFetchHttpAuth.sendRequest(app_version: FishPottApp.app_version, device_token: thisDeviceToken ?? "")
                                //}
                            })

                    } else {
                        VStack{
                            VStack{
                            Text("NOTIFICATION")
                                .font(.system(size: 20))
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .shadow(radius: 8 )
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            VStack{
                                Text(self.notificationManager.currentNotificationText ?? "NO NOTIFICATION")
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 50)
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 500, idealHeight: 500, maxHeight: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            //.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            VStack{
                                Button(action: {
                                    self.notificationManager.currentNotificationText = ""
                                    //print("currentNotificationText: " + self.notificationManager.currentNotificationText ?? "")
                                }) {
                                    HStack (spacing: 8) {
                                        Text("Close")
                                            .foregroundColor(Color("ColorWhiteAccent"))
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .foregroundColor(Color("ColorWhiteAccent"))
                                } //: BUTTON
                                .accentColor(Color("ColorBlackPrimary"))
                                .background(Color("ColorBlackPrimary"))
                                .cornerRadius(5)
                                .padding(.bottom, 50)
                                    
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(Color.white)
                        .navigationTitle("My Mobile App")
                        .overlay(NavigationLink(destination: MyView(text: notificationManager.currentNotificationText ?? ""), isActive: notificationManager.navigationBindingActive, label: {
                            EmptyView()
                        }))
                        
                    }
                     */
                case 1:
                    EBooksView()
                case 2:
                    SummariesView()
                case 3:
                    ContactDitaView()
                    
                default:
                    NavigationView {
                        Text("Remaining tabs")
                        
                    }
                }
                
            }
            
//            Spacer()
            
            Divider()
                .padding(.bottom, 8)
                .background(Color.white)
            
            HStack {
                ForEach(0..<4) { num in
                    Button(action: {
                        
                        /*
                        if num == 2 {
                            shouldShowModal.toggle()
                            return
                        }
                        */
                        
                        selectedIndex = num
                        
                    }, label: {
                        Spacer()
                        
                        VStack {
                                 Image(tabBarImageNames[num])
                                    .renderingMode(.template)
                                    .colorMultiply(.init(white: 0.8))
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                Text(tabBarMenuNames[num])
                                    .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                                    .font(.system(size: 12))
                            Spacer()
                        } // MARK: - VSTACK
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 55)
                    })
                    
                }
            } // MARK: - HSTACK
            
            .background(Color.white)
            
            
        }
        .background(Color.white)
    }
}

struct MyView: View {
    var text : String
    
    var body: some View {
        Text("Notification text is: " + text)
    }
}
