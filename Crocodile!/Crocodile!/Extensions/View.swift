//
//  View.swift
//  Crocodile!
//
//  Created by Майлс on 09.01.2022.
//

import SwiftUI

//Border modifier for View
extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
    
 }
