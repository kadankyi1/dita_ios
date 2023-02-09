//
//  SummariesView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/23/23.
//

import SwiftUI
import SwiftyJSON


struct SummariesMessage: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}

enum SummariesSearchScope: String, CaseIterable {
    case inbox, favorites
}

struct SummariesView: View {
    @State private var summariesmessages = [SummariesMessage]()
    @State private var the_received_ebooks = [EBookModel]()

    @State private var searchText = ""
    @State private var summariessearchScope = SummariesSearchScope.inbox
    @State private var showText = true
    // MARK: - PROPERTIES
    
    var ebooksData: [EBookModel] = EBooksData
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    var ebooks: [EBookModel] = EBooksData
    @State private var keyword: String = ""
    var access_token: String = getSavedString("user_accesstoken")
    @ObservedObject var model: SummariesMyModel = SummariesMyModel()
    @ObservedObject var summaries_ebooks_http_manager = SummariesHttpGetEBooks()

    var body: some View {
        NavigationView {
            List {
                    ForEach(the_received_ebooks) { item in
                        NavigationLink(destination: SummaryDetailView(ebook: item)){
                            EbookListItemRowView(ebook: item)
                                .padding(.vertical, 4)
                                .onAppear(perform: {
                                    showText = false
                                })
                        }
                    }
                }
            .navigationTitle("Summaries")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .searchable(text: $searchText)
        .onAppear(perform: runSearch)
        .onSubmit(of: .search, runSearch)
        .onChange(of: summariessearchScope) { _ in runSearch() }
        if showText {
            ProgressView()
                .padding(.horizontal, 150)
        }
    }

    var filteredSummariesMessages: [SummariesMessage] {
        if searchText.isEmpty {
            return summariesmessages
        } else {
            return summariesmessages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func runSearch() {
        //Task {
            
            //guard let url = URL(string: "https://hws.dev/\(summariessearchScope.rawValue).json") else { return }

            //let (data, _) = try await URLSession.shared.data(from: url)
            //summariesmessages = try JSONDecoder().decode([SummariesMessage].self, from: data)
            
        //}
        print("searchText")
        print($searchText)
        print("$searchText.wrappedValue")
        print($searchText.wrappedValue)
        var requestMade = "0" // no change
        var received_ebooks: [EBookModel] = []
        
        requestMade = "1" // started
        guard let url = URL(string: TafarriApp.app_domain + "/api/v1/user/get-books-summaries")
        else {
            print("Request failed 1")
            return
            
        }
        let auth_pass = "Bearer " + getSavedString("user_accesstoken")

        let body: [String: String] = ["kw": $searchText.wrappedValue, "app_type": "ios", "app_version_code": TafarriApp.app_version]
        print(body)

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(auth_pass, forHTTPHeaderField: "Authorization")
        print("auth_pass:  \(auth_pass)")
        
        print("About to start request")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data: \(data)")
            
    do {
    let json = try JSON(data: data)
    if let status = json["status"].string {
    //Now you got your value
    print("status: \(status)")
        
    DispatchQueue.main.async {
        if status == "success" {
            requestMade = "2" // success
            if let items = json["data"].array {
                for item in items {
                    if let the_book_id = item["book_id"].int {
                        print(the_book_id)
                        
                        if let the_book_cover_photo = item["book_cover_photo"].string {
                            print(the_book_cover_photo)
                            
                            if let  the_book_sys_id = item["book_sys_id"].string {
                                print(the_book_sys_id)
                                
                                if let the_book_title = item["book_title"].string {
                                        print(the_book_title)
                                    
                                        if let the_book_author = item["book_author"].string {
                                            print(the_book_author)
                                            
                                        if let the_book_pdf = item["book_pdf"].string {
                                            print(the_book_pdf)
                                            
                                            if let the_book_cost_usd = item["book_cost_usd"].string {
                                                print(the_book_cost_usd)
                                                
                                                
                                                if let the_book_ratings = item["book_ratings"].int {
                                                    print(the_book_ratings)
                                                    
                                                    if let the_book_description_short = item["book_description_short"].string {
                                                        print(the_book_description_short)
                                                        
                                                        if let the_book_description_long = item["book_description_long"].string {
                                                            print(the_book_description_long)
                                                            
                                                            
                                                            if let the_book_pages = item["book_pages"].int {
                                                                print(the_book_pages)
                                                                
                                                                if let the_book_summary_pdf = item["book_summary_pdf"].string {
                                                                    print(the_book_summary_pdf)
                                                                    
                                                                    
                                                                    if let the_book_summary_cost_usd = item["book_summary_cost_usd"].string {
                                                                        print(the_book_summary_cost_usd)
                                                                        
                                                                        if let the_book_summary_pdf = item["book_summary_pdf"].string {
                                                                            print(the_book_summary_pdf)
                                                                            
                                                                            if let the_book_full_purchased = item["book_full_purchased"].string {
                                                                                print(the_book_full_purchased)
                                                                                
                                                                                if let the_book_summary_purchased = item["book_summary_purchased"].string {
                                                                                    print(the_book_summary_purchased)
                                                                                    
                                                                                    received_ebooks.append(EBookModel(
                                                                                        book_id: the_book_id,
                                                                                        book_sys_id: the_book_sys_id,
                                                                                        book_title: the_book_title,
                                                                                        book_author: the_book_author,
                                                                                        book_ratings: the_book_ratings,
                                                                                        book_description_short: the_book_description_short,
                                                                                        book_description_long: the_book_description_long,
                                                                                        book_pages: the_book_pages,
                                                                                        book_cover_photo: the_book_cover_photo,
                                                                                        book_pdf: the_book_pdf,
                                                                                        book_summary_pdf: the_book_summary_pdf,
                                                                                        book_audio: "",
                                                                                        book_summary_audio: "",
                                                                                        book_cost: the_book_cost_usd,
                                                                                        book_summary_cost: the_book_summary_cost_usd,
                                                                                        book_full_purchased: the_book_full_purchased,
                                                                                        book_summary_purchased: the_book_summary_purchased,
                                                                                        created_at: "",
                                                                                        updated_at: ""
                                                                                    ))
                                                                                    the_received_ebooks = received_ebooks
                                                                                    
                                                                                        print("Book Added")
                                                                                }
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                             }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if let summariesmessage = json["summariesmessage"].string {
                //Now you got your value
                  print(status)
                  DispatchQueue.main.async {
                      requestMade = "3" // fail
                  }
              }
            }
          }
         }
        } catch  let error as NSError {
            DispatchQueue.main.async {
            requestMade = "3" // fail
            print("Request failed 3")
            }
    }
            
            /*
            let resData = try! JSONDecoder().decode(ServerSummariesMessage.self, from: data)
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

class SummariesMyModel: ObservableObject {
    @Published var isValid: Bool = false

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.isValid = true
        }
    }
}

// MARK: - PREVIEW
struct SummariesView_Previews: PreviewProvider {
    static var previews: some View {
        SummariesView(ebooks: EBooksData)
    }
}


class SummariesHttpGetEBooks: ObservableObject {

    @Published var requestMade = "0" // no change
    @Published var received_ebooks: [EBookModel] = []

    func getEBooks(user_accesstoken: String, keyword: String) {
        requestMade = "1" // started
        guard let url = URL(string: TafarriApp.app_domain + "/api/v1/user/get-books")
        else {
            print("Request failed 1")
            return
            
        }
        let auth_pass = "Bearer " + user_accesstoken

        let body: [String: String] = ["kw": "", "app_type": "ios", "app_version_code": TafarriApp.app_version]
        print(body)

        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(auth_pass, forHTTPHeaderField: "Authorization")
        print("auth_pass:  \(auth_pass)")
        
        print("About to start request")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            print("data: \(data)")
            
    do {
    let json = try JSON(data: data)
    if let status = json["status"].string {
    //Now you got your value
    print("status: \(status)")
        
    DispatchQueue.main.async {
        if status == "success" {
            self.requestMade = "2" // success
            if let items = json["data"].array {
                for item in items {
                    if let the_book_id = item["book_id"].int {
                        print(the_book_id)
                        
                        if let the_book_cover_photo = item["book_cover_photo"].string {
                            print(the_book_cover_photo)
                            
                            if let  the_book_sys_id = item["book_sys_id"].string {
                                print(the_book_sys_id)
                                
                                if let the_book_title = item["book_title"].string {
                                        print(the_book_title)
                                    
                                        if let the_book_author = item["book_author"].string {
                                            print(the_book_author)
                                            
                                        if let the_book_pdf = item["book_pdf"].string {
                                            print(the_book_pdf)
                                            
                                            if let the_book_cost_usd = item["book_cost_usd"].string {
                                                print(the_book_cost_usd)
                                                
                                                
                                                if let the_book_ratings = item["book_ratings"].int {
                                                    print(the_book_ratings)
                                                    
                                                    if let the_book_description_short = item["book_description_short"].string {
                                                        print(the_book_description_short)
                                                        
                                                        if let the_book_description_long = item["book_description_long"].string {
                                                            print(the_book_description_long)
                                                            
                                                            
                                                            if let the_book_pages = item["book_pages"].int {
                                                                print(the_book_pages)
                                                                
                                                                if let the_book_summary_pdf = item["book_summary_pdf"].string {
                                                                    print(the_book_summary_pdf)
                                                                    
                                                                    
                                                                    if let the_book_summary_cost_usd = item["book_summary_cost_usd"].string {
                                                                        print(the_book_summary_cost_usd)
                                                                        
                                                                        if let the_book_summary_pdf = item["book_summary_pdf"].string {
                                                                            print(the_book_summary_pdf)
                                                                            
                                                                            if let the_book_full_purchased = item["book_full_purchased"].string {
                                                                                print(the_book_full_purchased)
                                                                                
                                                                                if let the_book_summary_purchased = item["book_summary_purchased"].string {
                                                                                    print(the_book_summary_purchased)
                                                                                    
                                                                                    self.received_ebooks.append(EBookModel(
                                                                                        book_id: the_book_id,
                                                                                        book_sys_id: the_book_sys_id,
                                                                                        book_title: the_book_title,
                                                                                        book_author: the_book_author,
                                                                                        book_ratings: the_book_ratings,
                                                                                        book_description_short: the_book_description_short,
                                                                                        book_description_long: the_book_description_long,
                                                                                        book_pages: the_book_pages,
                                                                                        book_cover_photo: the_book_cover_photo,
                                                                                        book_pdf: the_book_pdf,
                                                                                        book_summary_pdf: the_book_summary_pdf,
                                                                                        book_audio: "",
                                                                                        book_summary_audio: "",
                                                                                        book_cost: the_book_cost_usd,
                                                                                        book_summary_cost: the_book_summary_cost_usd,
                                                                                        book_full_purchased: the_book_full_purchased,
                                                                                        book_summary_purchased: the_book_summary_purchased,
                                                                                        created_at: "",
                                                                                        updated_at: ""
                                                                                    ))
                                                                                    
                                                                                        print("Book Added")
                                                                                }
                                                                                
                                                                            }
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                             }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if let summariesmessage = json["summariesmessage"].string {
                //Now you got your value
                  print(status)
                  DispatchQueue.main.async {
                      self.requestMade = "3" // fail
                  }
              }
            }
          }
         }
        } catch  let error as NSError {
            DispatchQueue.main.async {
            self.requestMade = "3" // fail
            print("Request failed 3")
            }
    }
            
            /*
            let resData = try! JSONDecoder().decode(ServerSummariesMessage.self, from: data)
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

/*
 
 //
 //  SummariesView.swift
 //  Dita
 //
 //  Created by Dankyi Anno Kwaku on 1/23/23.
 //

 import SwiftUI
 import SwiftyJSON

 struct SummariesView: View {
     // MARK: - PROPERTIES
     
     @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
     var ebooks: [EBookModel] = EBooksData
     @State private var keyword: String = ""
     var access_token: String = getSavedString("user_accesstoken");
     @ObservedObject var model: SummariesMyModel = SummariesMyModel()
     @ObservedObject var summaries_ebooks_http_manager = SummariesHttpGetEBooks()
     

     // MARK: - BODY
     var body: some View {
         NavigationView {
             
             if summaries_ebooks_http_manager.requestMade == "0" {
                 ProgressView()
                 .onAppear(perform: {
                     print("getEBooks started")
                     summaries_ebooks_http_manager.getEBooks(user_accesstoken: access_token, keyword: "")
                 })
             } else if summaries_ebooks_http_manager.requestMade == "1" {
                 ProgressView()
                 
             } else if summaries_ebooks_http_manager.requestMade == "2" {
                 //print("Access Token request starting")
                 List {
                         ForEach(summaries_ebooks_http_manager.received_ebooks) { item in
                             NavigationLink(destination: EBookDetailView(ebook: item)){
                                 EbookListItemRowView(ebook: item)
                                     .padding(.vertical, 4)
                             }
                         }
                     }
             } else {
                 VStack {}
                     .alert(isPresented: $model.isValid, content: {
                     Alert(title: Text("Oops"),
                           summariesmessage: Text("Something went awry"),
                           dismissButton: .default(
                             Text("Okay"))
                             {
                                 //print("do something")
                                 
                             })
                 })
             }
             
         } // NAVIGATION
     }
 }

 class SummariesMyModel: ObservableObject {
     @Published var isValid: Bool = false

     init() {
         DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
             self.isValid = true
         }
     }
 }

 // MARK: - PREVIEW
 struct SummariesView_Previews: PreviewProvider {
     static var previews: some View {
         SummariesView(ebooks: EBooksData)
     }
 }

 class SummariesHttpGetEBooks: ObservableObject {

     @Published var requestMade = "0" // no change
     @Published var received_ebooks: [EBookModel] = []

     func getEBooks(user_accesstoken: String, keyword: String) {
         requestMade = "1" // started
         guard let url = URL(string: TafarriApp.app_domain + "/api/v1/user/get-books")
         else {
             print("Request failed 1")
             return
             
         }
         let auth_pass = "Bearer " + user_accesstoken

         let body: [String: String] = ["kw": "", "app_type": "ios", "app_version_code": TafarriApp.app_version]
         print(body)

         let finalBody = try! JSONSerialization.data(withJSONObject: body)

         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.httpBody = finalBody
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.setValue(auth_pass, forHTTPHeaderField: "Authorization")
         print("auth_pass:  \(auth_pass)")
         
         print("About to start request")
         URLSession.shared.dataTask(with: request) { (data, response, error) in
             guard let data = data else { return }
             print("data: \(data)")
             
     do {
     let json = try JSON(data: data)
     if let status = json["status"].string {
     //Now you got your value
     print("status: \(status)")
         
     DispatchQueue.main.async {
         if status == "success" {
             self.requestMade = "2" // success
             if let items = json["data"].array {
                 for item in items {
                     if let the_book_id = item["book_id"].int {
                         print(the_book_id)
                         
                         if let the_book_cover_photo = item["book_cover_photo"].string {
                             print(the_book_cover_photo)
                             
                             if let  the_book_sys_id = item["book_sys_id"].string {
                                 print(the_book_sys_id)
                                 
                                 if let the_book_title = item["book_title"].string {
                                         print(the_book_title)
                                     
                                         if let the_book_author = item["book_author"].string {
                                             print(the_book_author)
                                             
                                         if let the_book_pdf = item["book_pdf"].string {
                                             print(the_book_pdf)
                                             
                                             if let the_book_cost_usd = item["book_cost_usd"].string {
                                                 print(the_book_cost_usd)
                                                 
                                                 
                                                 if let the_book_ratings = item["book_ratings"].int {
                                                     print(the_book_ratings)
                                                     
                                                     if let the_book_description_short = item["book_description_short"].string {
                                                         print(the_book_description_short)
                                                         
                                                         if let the_book_description_long = item["book_description_long"].string {
                                                             print(the_book_description_long)
                                                             
                                                             
                                                             if let the_book_pages = item["book_pages"].int {
                                                                 print(the_book_pages)
                                                                 
                                                                 if let the_book_summary_pdf = item["book_summary_pdf"].string {
                                                                     print(the_book_summary_pdf)
                                                                     
                                                                     
                                                                     if let the_book_summary_cost_usd = item["book_summary_cost_usd"].string {
                                                                         print(the_book_summary_cost_usd)
                                                                         
                                                                         if let the_book_summary_pdf = item["book_summary_pdf"].string {
                                                                             print(the_book_summary_pdf)
                                                                             
                                                                             if let the_book_full_purchased = item["book_full_purchased"].string {
                                                                                 print(the_book_full_purchased)
                                                                                 
                                                                                 if let the_book_summary_purchased = item["book_summary_purchased"].string {
                                                                                     print(the_book_summary_purchased)
                                                                                     
                                                                                     self.received_ebooks.append(EBookModel(
                                                                                         book_id: the_book_id,
                                                                                         book_sys_id: the_book_sys_id,
                                                                                         book_title: the_book_title,
                                                                                         book_author: the_book_author,
                                                                                         book_ratings: the_book_ratings,
                                                                                         book_description_short: the_book_description_short,
                                                                                         book_description_long: the_book_description_long,
                                                                                         book_pages: the_book_pages,
                                                                                         book_cover_photo: the_book_cover_photo,
                                                                                         book_pdf: the_book_pdf,
                                                                                         book_summary_pdf: the_book_summary_pdf,
                                                                                         book_audio: "",
                                                                                         book_summary_audio: "",
                                                                                         book_cost: the_book_cost_usd,
                                                                                         book_summary_cost: the_book_summary_cost_usd,
                                                                                         book_full_purchased: the_book_full_purchased,
                                                                                         book_summary_purchased: the_book_summary_purchased,
                                                                                         created_at: "",
                                                                                         updated_at: ""
                                                                                     ))
                                                                                     
                                                                                         print("Book Added")
                                                                                 }
                                                                                 
                                                                             }
                                                                             
                                                                         }
                                                                         
                                                                     }
                                                                     
                                                                 }
                                                                 
                                                             }
                                                             
                                                         }
                                                         
                                                     }
                                                     
                                                 }
                                              }
                                         }
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         } else {
             if let summariesmessage = json["summariesmessage"].string {
                 //Now you got your value
                   print(status)
                   DispatchQueue.main.async {
                       self.requestMade = "3" // fail
                   }
               }
             }
           }
          }
         } catch  let error as NSError {
             DispatchQueue.main.async {
             self.requestMade = "3" // fail
             print("Request failed 3")
             }
     }
             
             /*
             let resData = try! JSONDecoder().decode(ServerSummariesMessage.self, from: data)
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


 
 */

