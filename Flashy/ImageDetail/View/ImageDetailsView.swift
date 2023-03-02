//
//  ImageDetails.swift
//  Flashy
//
//  Created by Martin Novak on 23.12.2022..
//

import SwiftUI
import Kingfisher
import FirebaseStorage

struct ImageDetailsView: View {
    @State var picture: Picture
    var body: some View {
        VStack(alignment:.leading) {
            Text(picture.author)
                .font(.title)
                .bold()
                .padding(.leading,10)
            KFImage(URL(string: picture.imageUrl))
                .resizable()
                .scaledToFit()
                .border(.gray)
                .padding(.leading,10)
                .padding(.trailing,10)
            HStack {
                Text("\(picture.author) ")
                    .bold()
                    .font(.title3) +
                Text("\(picture.description)")
            }
            .padding(.leading, 10)
            Text(picture.hashtags)
                .padding(.top, 10)
                .padding(.leading,10)
            
            HStack {
                Text("Date:")
                    .font(.title3)
                    .bold()
                Text(picture.dateString)
            }
            .padding(.leading,10)
            .padding(.top,1)
        }
    }
}


struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView(picture: Picture(documentID: "A1s0u6SfttWfrNDdTjti", date: Date(), descritpion: "descasodnaosdnaosdnaosdnaosdnoad naodnaosdnaosdnaodn", author: "author", hashtags: "#dvije#vodopad#ludooo", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/flashy-d36a3.appspot.com/o/pictures%2FE1A217C3-0F2B-4E07-9BA5-2D4130E48473?alt=media&token=72e1c189-f8ff-4cba-9739-476dff208d01", user: "Ww2HO2eypQcDZHElwo9NI3GPNc73"))
    }
}
