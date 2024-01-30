//
//  EditVideoView.swift
//  wakku
//
//  Created by Mark Strijdom on 30/01/2024.
//

import SwiftUI

struct EditVideoView: View {
    @Bindable var video: Video
    @State private var newKeywordName = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $video.title)
            DatePicker("Date", selection: $video.date)
            
            Section("Tags") {
                ForEach(video.keywords) { keyword in
                    Text(keyword.title)
                }
                
                HStack {
                    TextField("Add a new keyword for \(video.title)", text: $newKeywordName)
                    
                    Button("Add", action: addKeyword)
                }
            }
        }
        .navigationTitle("Edit")
    }
    
    func addKeyword() {
        guard !newKeywordName.isEmpty else { return }
        
        withAnimation {
            let keyword = Keyword(title: newKeywordName)
            video.keywords.append(keyword)
            newKeywordName = ""
        }
    }
}
