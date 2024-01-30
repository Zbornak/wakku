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
    
    var body: some View {
        VideoListView(selectedVideo: $selectedVideo)
            .toolbar {
                Button("Add video", systemImage: "video.fill.badge.plus", action: addVideo)
            }
    }
    
    func addVideo() {
        let video = Video()
        selectedVideo = video
        modelContext.insert(video)
    }
}

#Preview {
    VideosView()
}
