//
//  FinalizeResumeView.swift
//  RapidResume
//
//  Created by Frederik Dahl Hansen on 27/02/2025.
//

import SwiftUI

struct FinalizeResumeView: View {
    
    @StateObject private var vm = ResumeViewModel()
    
    var body: some View {
        
        Button("Create Resume"){
            vm.submitResume(resume: vm.resume)
        }
    }
}

#Preview {
    FinalizeResumeView()
}
