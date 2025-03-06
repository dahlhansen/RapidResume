//
//  ResumeViewModel.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 26/02/2025.
//

import Foundation


class ResumeViewModel: ObservableObject {
    @Published var resume = Resume(
        name: "",
        phone: "",
        email: "",
        linkedin: "",
        github: "",
        education: [],
        skills: [],
        projects: [],
        experiences: [],
        activities: []
    )
    
    
    
    func submitResume(resume: Resume) {
        
        let url = URL(string: "https://rapidresume-ki73.onrender.com/submit_resume/")!
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
            let jsonData = try JSONEncoder().encode(resume)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status: \(httpResponse.statusCode)")
            }
            
            
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "No response data")")
            }
        }
        
        task.resume()
    }
    

}
