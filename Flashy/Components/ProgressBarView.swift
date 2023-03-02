//
//  ProgressBarView.swift
//  Flashy
//
//  Created by Martin Novak on 16.02.2023..
//

import SwiftUI

struct ProgressBarView: View {
    var width: CGFloat = 150
    var height: CGFloat = 20
    var percent: CGFloat = 100000
    var packageSpace: CGFloat = 500000
    var color1 = Color(.red)
    var color2 = Color(.orange)
    
    var body: some View {
        var multiplier = width / packageSpace
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height,style: .continuous)
                .frame(width: width,height: height)
                .foregroundColor(Color.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: height,style: .continuous)
                .frame(width: percent * multiplier, height: height)
                .background(
                    LinearGradient(gradient: Gradient(colors: [color1,color2]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: height,style: .continuous))
                )
                .foregroundColor(.clear)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
