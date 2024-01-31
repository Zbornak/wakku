//
//  VideosView.swift
//  wakku
//
//  Created by Mark Strijdom on 30/01/2024.
//

import SwiftUI

struct VideosView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedVideo: Video?
    @State private var deletedVideo: Video?
    @State private var sortDescriptor = SortDescriptor(\Video.title)
    @State private var searchText = ""
    
    var body: some View {
        VideoListView(sortDescriptor: sortDescriptor, searchText: searchText, selectedVideo: $selectedVideo, deletedVideo: $deletedVideo)
            .toolbar {
                Button("Add video", systemImage: "video.fill.badge.plus", action: addVideo)
                
                Menu("Menu", systemImage: "arrow.up.arrow.down.square") {
                    Picker("Sort", selection: $sortDescriptor) {
                        Text("Title")
                            .tag(SortDescriptor(\Video.title))
                        
                        Text("Date")
                            .tag(SortDescriptor(\Video.date, order: .reverse))
                    }
                }
            }
            .onChange(of: deletedVideo) { _, newValue in
                guard let video = newValue else { return }
                delete(video)
            }
            .searchable(text: $searchText)
    }
    
    func addVideo() {
        let video = Video()
        selectedVideo = video
        modelContext.insert(video)
    }
    
    func delete(_ video: Video) {
        modelContext.delete(video)
    }
}

#Preview {
    VideosView()
}
