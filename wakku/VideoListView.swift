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
    @Binding var deletedVideo: Video?
    
    init(sortDescriptor: SortDescriptor<Video>, searchText: String, selectedVideo: Binding<Video?>, deletedVideo: Binding<Video?>) {
        _videos = Query(filter: #Predicate {
            if searchText.isEmpty {
                return true
            } else {
                return $0.title.localizedStandardContains(searchText)
            }
        }, sort: [sortDescriptor])
        _selectedVideo = selectedVideo
        _deletedVideo = deletedVideo
    }
    
    var body: some View {
        List {
            ForEach(videos) { video in
                    cell(video)
                    .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
            }
            .onDelete(perform: delete(_:))
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
        .onTapGesture {
            selectedVideo = video
        }
    }
    
    func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            let video = videos[index]
            deletedVideo = video
        }
    }
}
