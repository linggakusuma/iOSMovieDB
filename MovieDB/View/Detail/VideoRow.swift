//
//  VideoRow.swift
//  MovieDB
//
//  Created by Lingga Kusuma Sakti on 25/01/22.
//

import SwiftUI

struct VideoRow: View {
    @State private var showingSheet = false
    var video: Video
    var body: some View {
        HStack {
            Button(action: {
                showingSheet = true
            }) {
                HStack {
                    Text(video.name)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $showingSheet) {
                SafariView(url: video.youtubeURL!)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 16)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(16)
    }
}
