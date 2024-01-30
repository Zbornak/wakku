//
//  VideoListView.swift
//  wakku
//
//  Created by Mark Strijdom on 30/01/2024.
//

import SwiftData
import SwiftUI

struct VideoListView: View {
    @Query var videos: [Video]
    @Binding var selectedVideo: Video?
    
    var body: some View {
        List {
            ForEach(videos) { video in
                    cell(video)
                    .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
            }
        }
        .sheet(item: $selectedVideo) { video in
            NavigationStack {
                EditVideoView(video: video)
            }
        }
    }
    
    func cell(_ video: Video) -> some View {
        VStack {
            VStack(alignment: .leading) {
                Text(video.title).bold()
                Text(video.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(video.keywords) { keyword in
                        Text(keyword.title)
                            .font(.caption2)
                            .foregroundStyle(.background)
                            .bold()
                            .padding(6)
                            .background {
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundStyle(.gray.opacity(0.4))
                            }
                            .padding(.horizontal, 4)
                    }
                }
            }
        }
    }
}
