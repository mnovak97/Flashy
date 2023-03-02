//
//  CustomShape.swift
//  Flashy
//
//  Created by Martin Novak on 16.02.2023..
//

import SwiftUI

struct CustomShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 30, height: 30))
        
        return Path(path.cgPath)
    }
}
