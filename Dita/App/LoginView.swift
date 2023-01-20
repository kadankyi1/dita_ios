//
//  LoginView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/20/23.
//

import SwiftUI
import SwiftyJSON

struct LoginView: View {
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    @State private var name = Array<String>.init(repeating: "", count: 3)

    @State private var username: String = ""
    @State private var password: String = ""
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager_HttpGetLoginCode = HttpGetLoginCode()
    @ObservedObject var manager_HttpVerifyLoginCode = HttpVerifyLoginCode()
    @Binding var currentStage: String
    @State private var networking: Bool = false
        
        
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
            Image("CAW-app-Login-2")
                .resizable()
                .scaleEffect(x: 1, y: 0.95, anchor: .top)
            
            if manager_HttpGetLoginCode.requestMade {
                if !manager_HttpGetLoginCode.authenticated {
                    Text(manager_HttpGetLoginCode.message)
                    .font(.headline)
                    .foregroundColor(.red)
                        .onAppear(perform: {
                                networking = false;
                        })
                } else {
                    Text("Login Successful")
                    .font(.headline)
                    .foregroundColor(.green)
                    .onAppear(perform: {
                        //saveTextInStorage("user_accesstoken", manager.accessToken)
                        //saveTextInStorage("user_firstname", manager.userFirstName)
                        //saveTextInStorage("user_lastname", manager.userLastName)
                        self.currentStage = "LoggedInView"
                        print("currentStage: \(self.currentStage)")
                    })
                }
            } // MARK - if manager.requestMade
 
            
            TextField("Email", text: $username).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .center)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
                .background(GeometryGetter(rect: $kGuardian.rects[0]))
                //.position(x: 1, y: 1)
            
            
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle.init())
                .scaleEffect(x: 1, y: 1, anchor: .top)
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
                .background(GeometryGetter(rect: $kGuardian.rects[1]))
            
            if manager_HttpGetLoginCode.showLoginButton {
                Button(action: {
                    print("\(self.username) and \(self.password)")
                    if networking == false {
                        networking = true;
                        manager_HttpGetLoginCode.checkDetails(user_phone_number: self.username, password: self.password)
                    }
                    
                }) {
                    HStack (spacing: 8) {
                        Text("LOGIN")
                            .foregroundColor(Color("ColorAccentOppBlack"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .foregroundColor(Color("ColorYellowButton"))
                } //: BUTTON
                .accentColor(Color("ColorYellowButton"))
                .background(Color("ColorYellowButton"))
                .cornerRadius(20)
                .padding(.bottom, 50)
                
            } // MARK - if manager.showLoginButton
            else {
                ProgressView()
            }
            
             
             Text("Not A Member? Join Here")
                 .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                 .padding(.bottom, 10)
                 .onTapGesture {
                     self.currentStage = "SignupView"
                 }
            
            if manager_HttpVerifyLoginCode.showProgress {
                ProgressView().onDisappear(perform: {
                    networking = false;
                    if manager_HttpVerifyLoginCode.values_set {
                         self.currentStage = "LoggedInView"
                    }
                })
            } else {
             Text("Proceed As A Guest")
                .foregroundColor(.gray)
                 .padding(.bottom, 150)
                 .onTapGesture {
                    
                    if networking == false {
                        networking = true;
                        manager_HttpVerifyLoginCode.update_content();
                        if manager_HttpVerifyLoginCode.values_set {
                             self.currentStage = "LoggedInView"
                        }
                    }
                 }
            }
            
        } // MARK - VSTACK
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentStage: .constant("LoginView"))
    }
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


class HttpGetLoginCode: ObservableObject {

    @Published var authenticated = false
    @Published var requestMade = false
    @Published var showLoginButton = true
    @Published var message = ""
    @Published var accessToken = ""
    @Published var userFirstName = ""
    @Published var userLastName = ""

    func checkDetails(user_phone_number: String, password: String) {
        showLoginButton = false
        guard let url = URL(string: "https://thegloryhub.fishpott.com/api/v1/member/login") else { return }

        let body: [String: String] = ["user_phone_number": user_phone_number, "password": password]

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print(data)
            
            do {
                let json = try JSON(data: data)
                if let status = json["status"].int {
                  //Now you got your value
                    print(status)
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        if status == 1 {
                            print(status)
                            self.authenticated = true
                            if let thisaccesstoken = json["access_token"].string {
                                //Now you got your value
                                self.accessToken = thisaccesstoken
                                print("access_token: \(self.accessToken)")
                              }
                            if let firstname = json["user"]["user_firstname"].string {
                                //Now you got your value
                                self.userFirstName = firstname
                                print("userFirstName: \(self.userFirstName)")
                              }
                            if let surname = json["user"]["user_surname"].string {
                                //Now you got your value
                                self.userLastName = surname
                                print("surname: \(self.userLastName)")
                              }
                            
                            
                            
                        } else {
                            self.authenticated = false;
                            self.showLoginButton = true
                            if let message = json["message"].string {
                                //Now you got your value
                                  print(status)
                                  
                                  DispatchQueue.main.async {
                                      self.message = message
                                  }
                              }
                        }
                    }
                }
            } catch  let error as NSError {
                DispatchQueue.main.async {
                    self.requestMade = true
                    self.message = "Login failed"
                    self.authenticated = false
                    self.showLoginButton = true
                }
            }
            
            /*
            let resData = try! JSONDecoder().decode(ServerMessage.self, from: data)
            print(resData)
            if resData.res == "correct" {
                DispatchQueue.main.async {
                    self.authenticated = true
                }
            }
             */
            
        }.resume()
    }
}


class HttpVerifyLoginCode: ObservableObject {

    @Published var requestMade = false
    @Published var values_set = false
    @Published var showProgress = false

    func update_content() {
        self.showProgress = true
        guard let url = URL(string: "https://thegloryhub.fishpott.com/api/v1/member/guest") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue(auth_pass, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data")
            print(data)
            do {
                let json = try JSON(data: data)
                if let status = json["status"].int {
                  //Now you got your value
                    print("UPDATED CONTENT")
                    print(status)
                    
                    DispatchQueue.main.async {
                        self.requestMade = true
                        if status == 1 {
                            print(status)
                            
                            if let thisaccesstoken = json["access_token"].string {
                                //Now you got your value
                                //saveTextInStorage("user_accesstoken", thisaccesstoken)
                                print("GUEST access_token: \(thisaccesstoken)")
                              }
                            if let firstname = json["user"]["user_firstname"].string {
                                //Now you got your value
                                //saveTextInStorage("user_firstname", firstname)
                                print("GUEST userFirstName: \(firstname)")
                              }
                            if let surname = json["user"]["user_surname"].string {
                                //Now you got your value
                                saveTextInStorage("user_lastname", surname)
                                print("GUEST surname: \(surname)")
                              }
                            
                        }
                    }
                }
            } catch  let error as NSError {
                
                    DispatchQueue.main.async {
                    self.values_set = false
                    self.showProgress = false
                    }
            }
            
        }.resume()
    }
}
