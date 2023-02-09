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
    
    @State private var email_address: String = ""
    @State private var passcode: String = ""
    //@State private var showLoginButton: Bool = true
    @ObservedObject var manager_HttpGetLoginCode = HttpGetLoginCode()
    @ObservedObject var manager_HttpVerifyLoginCode = HttpVerifyLoginCode()
    @Binding var currentStage: String
    @State private var networking: Bool = false
        
        
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
            Text(" Tafarri ")
                .foregroundColor(Color("ColorDarkBlueAndDarkBlue"))
                .font(.custom("Awal Ramadhan", size: 100))
                .padding(.bottom, 150)
            
            if (manager_HttpVerifyLoginCode.requestMade == "0") {
                Text("A code has been sent to your inbox/spam. Enter the code to login")
                .padding(.horizontal, 10)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("ColorLightGrayAndWhite"))
                
                TextField("Login Code", text: $passcode).textFieldStyle(RoundedBorderTextFieldStyle.init())
                    .scaleEffect(x: 1, y: 1, anchor: .center)
                    .padding(.horizontal, 50)
                    .padding(.bottom, 10)
                    .background(GeometryGetter(rect: $kGuardian.rects[0]))
                
                
                    Button(action: {
                        print("\(self.email_address)")
                        manager_HttpVerifyLoginCode.verifyLoginCode(user_email: self.email_address, user_passcode: self.passcode)
                    }) {
                        HStack (spacing: 8) {
                            Text("Login")
                                .foregroundColor(Color("ColorLightGrayAndWhite"))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .foregroundColor(Color("ColorLightGrayAndWhite"))
                    } //: BUTTON
                    .accentColor(Color("ColorDarkBlueAndDarkBlue"))
                    .background(Color("ColorDarkBlueAndDarkBlue"))
                    .cornerRadius(20)
                    .padding(.bottom, 50)
                
                
                    Text("Did not get code")
                        .foregroundColor(Color("ColorDarkBlueAndDarkBlue"))
                        .padding(.bottom, 10)
                        .onTapGesture {
                            self.currentStage = "GetLoginCodeView"
                        }
            }
            else if (manager_HttpVerifyLoginCode.requestMade == "1") {
                    ProgressView()
            }
            
            else if (manager_HttpVerifyLoginCode.requestMade == "2") {
                ProgressView()
                    .onAppear(perform: {
                        self.currentStage = "MainView"
                    })
            }
           
            
        } // MARK - VSTACK
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(currentStage: .constant("LoginView"))
    }
}


class HttpVerifyLoginCode: ObservableObject {
    @Published var requestMade = "0" // no change
    
    func verifyLoginCode(user_email: String, user_passcode: String) {
        requestMade = "1" // started
        guard let url = URL(string: TafarriApp.app_domain + "/api/v1/user/verify-login-code") else { return }

        let body: [String: String] = ["user_email": getSavedString("user_email"), "user_passcode": user_passcode, "app_type": "ios", "app_version_code": TafarriApp.app_version]
        print(body)

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
                if let status = json["status"].string {
                  //Now you got your value
                    print("UPDATED CONTENT")
                    print(status)
                    
                    DispatchQueue.main.async {
                        print(status)
                        if status == "success" {
                            self.requestMade = "2" // success
                            if let thisaccesstoken = json["access_token"].string {
                                //Now you got your value
                                saveTextInStorage("user_accesstoken", thisaccesstoken)
                                //print("GUEST access_token: \(thisaccesstoken)")
                              }
                            
                        } else {
                            self.requestMade = "3" // fail
                        }
                    }
                }
            } catch  let error as NSError {
                
                    DispatchQueue.main.async {
                        self.requestMade = "3" // fail
                    }
            }
            
        }.resume()
    }
}
