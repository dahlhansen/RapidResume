import SwiftUI
import PDFKit

struct ViewResume: View {
    @State private var pdfDocument: PDFDocument?
    let pdfURL = URL(string: "https://rapidresume-ki73.onrender.com/get_pdf")!

    var body: some View {
        ZStack {
            Color.customDarkGray
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                
                Spacer()
                
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.white)
                
                Text("Your Resume is Ready")
                    .font(.custom("SF Pro", size: 36))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)

                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.customDark)
                    .frame(width: 375, height: 470)
                    .overlay(
                        VStack {
                            if let document = pdfDocument {
                                PDFKitView(pdfDocument: document)
                                    .frame(width: 320, height: 410)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } else {
                                Text("Loading PDF...")
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                
                HStack(spacing: 20) {
                    NavigationLink(destination: ContentView()) {
                        Text("Edit")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 160)
                            .background(Color.black)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    
                    Button(action: {
                        downloadPDF()
                    }) {
                        Text("Save")
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 160)
                            .background(Color.customLightBlue)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .onAppear {
                getPDF()
            }
        }
    }

    private func getPDF() {
        URLSession.shared.dataTask(with: pdfURL) { data, response, error in
            if let data = data, let document = PDFDocument(data: data) {
                DispatchQueue.main.async {
                    self.pdfDocument = document
                }
            } else {
                print("Failed to load PDF:", error?.localizedDescription ?? "Unknown error")
            }
        }.resume()
    }

    private func downloadPDF() {
        let task = URLSession.shared.downloadTask(with: pdfURL) { location, response, error in
            guard let location = location else {
                print("Download failed:", error?.localizedDescription ?? "Unknown error")
                return
            }

            let fileManager = FileManager.default
            let downloadsDirectory = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first!
            let destinationURL = downloadsDirectory.appendingPathComponent("resume.pdf")

            do {
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                try fileManager.moveItem(at: location, to: destinationURL)
                print("PDF downloaded to: \(destinationURL.path)")
            } catch {
                print("Error saving PDF:", error.localizedDescription)
            }
        }
        task.resume()
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfDocument: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}

#Preview {
    ViewResume()
}
