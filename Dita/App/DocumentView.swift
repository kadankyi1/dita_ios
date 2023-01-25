//
//  DocumentView.swift
//  Dita
//
//  Created by Dankyi Anno Kwaku on 1/24/23.
//

import SwiftUI
import PDFViewer


struct DocumentView: View, DownloadManagerDelegate {
    
    @State private var viewLocalPDF = false
    @State private var viewRemotePDF = false
    @State private var loadingPDF: Bool = false
    @State private var progressValue: Float = 0.0
    @ObservedObject var downloadManager = DownloadManager.shared()
    
    //let pdfName = "sample"
    //let pdfUrlString = "https://www.africau.edu/images/default/sample.pdf"
    var pdfName: String
    var pdfUrlString: String

    var body: some View {
        //NavigationView {
            ZStack {
                VStack {
                    /*
                     NavigationLink(destination: PDFViewer(pdfName: pdfName), isActive: $viewLocalPDF) {
                        Button("View Local PDF"){
                            self.viewLocalPDF = true
                        }
                        .padding(.bottom, 20)
                    }
                     */
                    Button("Start Reading"){
                        if self.fileExistsInDirectory() {
                            self.viewRemotePDF = true
                        } else {
                            self.downloadPDF(pdfUrlString: self.pdfUrlString)
                        }
                    }
                    if self.viewRemotePDF {
                        NavigationLink(destination: PDFViewer(pdfUrlString: self.pdfUrlString), isActive: self.$viewRemotePDF) {
                            EmptyView()
                        }.hidden()
                    }
                }
                ProgressView(value: self.$progressValue, visible: self.$loadingPDF)
            }
            
        //}.navigationBarTitle("PDFViewer", displayMode: .inline)
    }
    
    private func fileExistsInDirectory() -> Bool {
        if let cachesDirectoryUrl =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first, let lastPathComponent = URL(string: self.pdfUrlString)?.lastPathComponent {
            let url = cachesDirectoryUrl.appendingPathComponent(lastPathComponent)
            if FileManager.default.fileExists(atPath: url.path) {
                return true
            }
        }
        return false
    }
    
    private func downloadPDF(pdfUrlString: String) {
        guard let url = URL(string: pdfUrlString) else { return }
        downloadManager.delegate = self
        downloadManager.downloadFile(url: url)
    }
    
    //MARK: DownloadManagerDelegate
    func downloadDidFinished(success: Bool) {
        if success {
            loadingPDF = false
            viewRemotePDF = true
        }
    }
    
    func downloadDidFailed(failure: Bool) {
        if failure {
            loadingPDF = false
            print("PDFCatalogueView: Download failure")
        }
    }
    
    func downloadInProgress(progress: Float, totalBytesWritten: Float, totalBytesExpectedToWrite: Float) {
        loadingPDF = true
        progressValue = progress
    }
}


struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(pdfName: "PDF Name", pdfUrlString: "https://www.africau.edu/images/default/sample.pdf")
    }
}
