//
//  ImageUploadView.swift
//  Flashy
//
//  Created by Martin Novak on 24.12.2022..
//

import SwiftUI

struct ImageUploadView: View {
    @State private var isVisible = false
    @State private var isButtonVisible = false
    @State private var selectedPicture: UIImage?
    @State private var uploadPicture: Image?
    @State private var description = ""
    @State private var hashtags = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @StateObject var pictureViewModel = ImageUploadViewModel()
    var body: some View {
        VStack {
            Text("Upload picture")
                .fontWeight(.bold)
                .font(.custom("Futura-MediumItalic", fixedSize: 28))
                .padding(.bottom)
            HStack(alignment: .top) {
                Button {
                    isVisible.toggle()
                } label: {
                    if let uploadPicture = uploadPicture {
                        uploadPicture
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(3)
                            .shadow(radius: 7)
                            .frame(width: 350, height: 250)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(3)
                            .shadow(radius: 7)
                            .frame(width: 350, height: 250)
                    }
                }
                .padding(.bottom)
            }
            //Descritpion section
            Divider()
                .background(Color.black)
            HStack {
                Text("Description")
                    .fontWeight(.bold)
                    .font(.custom("Futura-MediumItalic", fixedSize: 16))
                Spacer()
            }
            .padding()
            HStack {
                TextField("Enter description", text: $description, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .padding(.bottom)
            }
            .padding(.leading)
            .padding(.trailing)
            
            //Hashtags section
            Divider()
                .background(Color.black)
            
            HStack {
                Text("Hashtags")
                    .fontWeight(.bold)
                    .font(.custom("Futura-MediumItalic", fixedSize: 16))
                Spacer()
            }
            .padding()
            HStack {
                Text("#")
                    .padding(5)
                    .fontWeight(.bold)
                    .font(.custom("Futura-MediumItalic", fixedSize: 16))
                    .border(.black)
                    .foregroundColor(.gray)
                    .cornerRadius(3)
                
                TextField("Enter hashtags", text: $hashtags, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
            }
            .padding(.leading)
            .padding(.trailing)
            Spacer()
            
            //Button section
            if let selectedPicture = selectedPicture {
                Button {
                    pictureViewModel.uploadPicture(selectedPicture, description: description, author: viewModel.currentUser!.username, hashtags: hashtags)
                    
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Post picture")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 10, x:0.0, y:2)
                        .padding(.horizontal, 20)
                        .opacity(!description.isEmpty && !hashtags.isEmpty && uploadPicture != nil ? 1.0 : 0.4)
                }
                .disabled(description.isEmpty || hashtags.isEmpty || uploadPicture == nil)
            }
        }
        .sheet(isPresented: $isVisible, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedPicture)
        }
    }
    func loadImage() {
        guard let selectedPicture = selectedPicture else {
            return
        }
        uploadPicture = Image(uiImage: selectedPicture)
        
    }
}


struct ImageUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploadView()
    }
}
