//
//  LastReadView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/23/23.
//

import SwiftUI

struct LastReadView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 20){
                    Text("LastReadView")
                } //: VSTACK
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
            } //: SCROLLVIEW
            .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
    }
}

struct LastReadView_Previews: PreviewProvider {
    static var previews: some View {
        LastReadView()
    }
}
