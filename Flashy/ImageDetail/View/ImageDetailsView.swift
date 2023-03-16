//
//  ImageDetails.swift
//  Flashy
//
//  Created by Martin Novak on 23.12.2022..
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ImageDetailsView: View {
    @State var picture: Picture
    @StateObject private var viewModel = ImageDetailViewModel()
    @State private var selectedFilterName: String?
    @State private var saveAlertShown = false
    @State private var hashtags = ""
    @State private var description = ""
    @EnvironmentObject var authView: AuthViewModel
    var body: some View {
        ZStack {
            VStack(alignment:.leading) {
                HStack {
                    Text(picture.author)
                        .font(.title)
                        .bold()
                        .padding(.leading,10)
                    Spacer()
                    if authView.userSession?.uid == picture.userID {
                        Button {
                            viewModel.update(pictureURL: picture.imageUrl, description: description, hashtags: hashtags)
                        } label: {
                            Text("Update")
                        }
                        .padding(.trailing,10)
                    }
                }
                if let image = viewModel.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .border(.gray)
                        .padding(.leading,10)
                        .padding(.trailing,10)
                } else {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .frame(height:250)
                }
                if authView.userSession?.uid == picture.userID {
                    HStack {
                        Text("Description")
                            .fontWeight(.bold)
                            .font(.custom("Futura-MediumItalic", fixedSize: 16))
                        Spacer()
                    }
                    .padding(.leading,10)
                    HStack {
                        TextField("Enter description", text: $description)
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.bottom)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                } else {
                    HStack {
                        Text("\(picture.author) ")
                            .bold()
                            .font(.title3) +
                            Text("\(picture.description)")
                    }
                    .padding(.leading, 10)
                }
                if authView.userSession?.uid == picture.userID {
                    HStack {
                        Text("Hashtags")
                            .fontWeight(.bold)
                            .font(.custom("Futura-MediumItalic", fixedSize: 16))
                        Spacer()
                    }
                    .padding(.leading,10)
                    HStack {
                        Text("#")
                            .padding(5)
                            .fontWeight(.bold)
                            .font(.custom("Futura-MediumItalic", fixedSize: 16))
                            .border(.black)
                            .foregroundColor(.gray)
                            .cornerRadius(3)
                        
                        TextField("Enter hashtags", text: $hashtags)
                                    .textFieldStyle(.roundedBorder)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                } else {
                    Text(picture.hashtags)
                        .padding(.top, 10)
                        .padding(.leading,10)
                }
                
                HStack {
                    Text("Date:")
                        .font(.title3)
                        .bold()
                    Text(picture.dateString)
                }
                .padding(.leading,10)
                .padding(.top,1)
                
                HStack {
                    Picker("Filter", selection: $selectedFilterName) {
                        Text("None").tag(nil as String?)
                        ForEach(viewModel.filters, id: \.self) { filterName in
                            Text(filterName).tag(filterName as String?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    Spacer()
                    Button("Save", action: save)
                }
                .padding(10)
                .onAppear {
                    viewModel.loadImage(from: picture.imageUrl)
                }
                .onChange(of: selectedFilterName) { newValue in
                    viewModel.selectedFilterName = newValue
                    viewModel.applySelectedFilter()
                }
            }
            if saveAlertShown {
                VStack {
                    Spacer()
                    Text("Saved")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.black.opacity(0.9))
                        .cornerRadius(10)
                    Spacer()
                }
            }
        }
        .onAppear{
            if authView.userSession?.uid == picture.userID {
                description = picture.description
                hashtags = picture.hashtags
            }
        }
    }
    func save() {
        viewModel.saveToPhotoAlbum()
        saveAlertShown = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            saveAlertShown = false
        }
    }
}


struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView(picture: Picture(documentID: "A1s0u6SfttWfrNDdTjti", date: Date(), descritpion: "descasodnaosdnaosdnaosdnaosdnoad naodnaosdnaosdnaodn", author: "author", hashtags: "#dvije#vodopad#ludooo", imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/flashy-d36a3.appspot.com/o/pictures%2FE1A217C3-0F2B-4E07-9BA5-2D4130E48473?alt=media&token=72e1c189-f8ff-4cba-9739-476dff208d01", user: "5o8UbGKOwLQmScoS2vm1JSYuLlp1")).environmentObject(AuthViewModel())
    }
}
