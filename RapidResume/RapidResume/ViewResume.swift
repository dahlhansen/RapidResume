import SwiftUI
import PDFKit

struct ViewResume: View {
    @State private var pdfDocument: PDFDocument?
    let pdfURL = URL(string: "http://0.0.0.0:8000/get_pdf")!

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.mediumBlue, Color.darkBlue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Your Resume is ready!")
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundColor(.electricYellow)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                    
                    .font(.custom("Poppins-Bold", size: 36))
                    .padding(.bottom, 5)

                if let document = pdfDocument {
                    PDFKitView(pdfDocument: document)
                        .frame(maxWidth: .infinity, maxHeight: 500)
                } else {
                    Text("Loading PDF...")
                        .foregroundColor(.gray)
                }

                Button(action: {
                    downloadPDF()
                }) {
                    Text("Download")
                        .padding()
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: 200)
                        .background(Color.electricYellow)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding()
                }
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
