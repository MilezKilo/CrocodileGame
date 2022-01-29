//
//  ButtonTemplate.swift
//  Crocodile!
//
//  Created by Майлс on 10.01.2022.
//

import SwiftUI

struct ButtonTemplate: View {
    
    let title: String
    let width: CGFloat
    let height: CGFloat
    let font: Font
    let color: Color
    
    var body: some View {
            Text(title)
                .font(font)
                .fontWeight(.heavy)
                .frame(height: height)
                .frame(maxWidth: width)
                .background(color.cornerRadius(10).brightness(-0.1))
                .addBorder(Color.colorsTheme.buttonForegroundColor, width: 3.5, cornerRadius: 10)
                .foregroundColor(Color.colorsTheme.buttonForegroundColor)
                .padding(5)
    }
}

//MARK: - PREVIEW
struct ButtonTemplate_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonTemplate(title: "Играть!", width: 200, height: 60, font: .title, color: Color.colorsTheme.buttonColor)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            ButtonTemplate(title: "Играть!", width: 200, height: 60, font: .title, color: Color.colorsTheme.buttonColor)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
