//
//  EBookDetailsActionButtonView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI
import SwiftyJSON

struct EBookDetailsActionButtonView: View {
    // MARK: -- PROPERTIES
    var purchased: String
    var ebook_name: String
    var ebook_pdf_url: String
    var ebook_ref: String
    var read_text: String
    @ObservedObject var payment_fullebook_http_manager = HttpTakePayment()
    
    var body: some View {
        
        if purchased == "yes" {
            
            NavigationLink(destination: DocumentView(pdfName: ebook_name, pdfUrlString: ebook_pdf_url)){
                
                Text(read_text)
                    .font(.headline)
                    .fontWeight(.bold)
                /*
                 Button(action: {
                    print("READ BOOK")
                    
                }) {
                    HStack (spacing: 8) {
                        Text("READ FULL BOOK")
                            .foregroundColor(Color("ColorAccentWhite"))
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    .foregroundColor(Color("ColorYellowButton"))
                } //: BUTTON
                .accentColor(Color("ColorDarkBlueAndDarkBlue"))
                .background(Color("ColorDarkBlueAndDarkBlue"))
                .cornerRadius(20)
                .padding(.bottom, 50)
                .frame(maxWidth: .infinity, alignment: .center)
                 */
                
            }
            
        } 
    }
}

struct EBookDetailsActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EBookDetailsActionButtonView(purchased: "yes", ebook_name: "ebook.book_title", ebook_pdf_url: "https://www.africau.edu/images/default/sample.pdf", ebook_ref: "SYS-ID-1", read_text: "READ BOOK")
    }
}


class HttpTakePayment: ObservableObject {
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
