//
//  ThumbnailView.swift
//  Flashy
//
//  Created by Martin Novak on 22.12.2022..
//

import SwiftUI
import Foundation
import Firebase
import Kingfisher

struct ThumbnailView: View {
    @State var picture: Picture
    var body: some View {
        VStack {
            HStack {
                KFImage(URL(string: picture.imageUrl))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .frame(width: 150, height: 150)
                
                VStack (alignment: .leading,spacing: 5) {
                    HStack {
                        Text("Description:")
                            .lineLimit(1)
                        Text(picture.description)
                            .lineLimit(1)
                    }
                    HStack {
                        Text("Author:")
                            .lineLimit(1)
                        Text(picture.author)
                            .lineLimit(1)
                    }
                    HStack {
                        Text("Date:")
                            .lineLimit(1)
                        Text(picture.dateString)
                            .lineLimit(1)
                        
                    }
                    HStack {
                        Text("Hashtags:")
                            .lineLimit(1)
                        Text(picture.hashtags)
                            .lineLimit(1)
                    }
                    
                }
                .frame(width:200)
                
            }
            Divider()
                .background(Color.black)
                .padding(.leading)
                .padding(.trailing)
        }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(picture: Picture(documentID: "A1s0u6SfttWfrNDdTjti", date: Date(), descritpion: "desc", author: "author", hashtags: "hashtags", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/flashy-d36a3.appspot.com/o/pictures%2FE1A217C3-0F2B-4E07-9BA5-2D4130E48473?alt=media&token=72e1c189-f8ff-4cba-9739-476dff208d01", user: "Ww2HO2eypQcDZHElwo9NI3GPNc73"))
    }
}
