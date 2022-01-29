//
//  HeaderButtonTemplate.swift
//  Crocodile!
//
//  Created by Майлс on 10.01.2022.
//

import SwiftUI

struct HeaderButtonTemplate: View {
    
    let image: String
    let width: CGFloat
    let height: CGFloat
    let color: Color
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .foregroundColor(color)
            .padding()
    }
}

//MARK: - PREVIEW
struct HeaderButtonTemplate_Previews: PreviewProvider {
    static var previews: some View {
        HeaderButtonTemplate(image: "chevron.left", width: 15, height: 15, color: .black)
            .previewLayout(.sizeThatFits)
    }
}
