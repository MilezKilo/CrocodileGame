//
//  AddTeamView.swift
//  Crocodile!
//
//  Created by Майлс on 13.01.2022.
//

import SwiftUI

struct AddTeamView: View {
    
    //PLAYERS VIEW MODEL
    @EnvironmentObject private var playersVM: TeamVM
    //BINDING STATE FOR CLOSE AND OPEN ADD TEAM VIEW
    @Binding var showAddTeamView: Bool
    
    //STATES FOR ADD NEW TEAM
    @State private var textFieldText: String = ""
    @State private var currentImage: String = "lion"
    @State private var showImagePicker: Bool = false
    let images = ["lion", "pig", "koala", "cat", "fox", "hen"]
    
    //STATE THAT SHOW ALERT FOR TEXTFIELD
    @State private var showAlert: Bool = false
    
    //COLORS
    let textFieldColor: UIColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    let backgroundColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
    var body: some View {
        VStack {
            HStack {
                hideButton
                Spacer()
            }.padding(.horizontal)
            textField
            imagePicker
            addTeamButton
            
            Spacer()
        }
        .onTapGesture {
            withAnimation(.spring()) {
                showImagePicker = false
            }
        }
        .frame(height: 325)
        .background(Color(backgroundColor).cornerRadius(10))
        .shadow(color: Color.black.opacity(0.7), radius: 10)
    }
}

extension AddTeamView {
    
    //BUTTONS
    private var hideButton: some View {
        HeaderButtonTemplate(image: "xmark", width: 10, height: 10, color:  Color.colorsTheme.buttonForegroundColor)
            .onTapGesture {
                showAddTeamView = false
            }
    }
    private var addTeamButton: some View {
        ButtonTemplate(title: "ДОБАВИТЬ!", width: UIScreen.main.bounds.width, height: 65, font: .title2, color: Color.colorsTheme.buttonColor)
            .padding(.horizontal)
            .onTapGesture {
                guard textFieldText.count >= 3 else { showAlert.toggle(); return }
                playersVM.addTeam(name: textFieldText, image: currentImage)
                showAddTeamView = false
                UIApplication.shared.endEditing()
            }
            .alert(isPresented: $showAlert) { myAlert() }
    }

    //VIEWS
    private var textField: some View {
        TextField("Название", text: $textFieldText)
            .padding()
            .background(Color(textFieldColor).cornerRadius(10))
            .foregroundColor(.black)
            .padding()
    }
    private var imagePicker: some View {
        HStack {
            Image(currentImage)
                .resizable()
                .frame(width: 65, height: 65)
                .onTapGesture {
                    withAnimation(.spring()) {
                        showImagePicker.toggle()
                    }
                }
                .overlay(overlayForImagePicker.offset(x: 10), alignment: .bottomTrailing)
            Text("ВЫБЕРИТЕ АВАТАР")
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    //OVERLAYS
    private var overlayForImagePicker: some View {
        VStack(alignment: .leading) {
            ForEach(images, id: \.self) { image in
                VStack(spacing: 0) {
                    Image(image)
                        .resizable()
                        .frame(width: 65, height: 65)
                        .onTapGesture {
                            currentImage = image
                            showImagePicker.toggle()
                        }
                }
            }
        }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 3, y: 3)
            .opacity(showImagePicker ? 1 : 0)
    }
    
    //METHODS
    private func myAlert() -> Alert {
        let alert = Alert(title: Text("Введите больше 2 символов"), message: nil, dismissButton: .default(Text("Хорошо")))
        return alert
    }
}

//MARK: - PREVIEW
struct AddTeamView_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamView(showAddTeamView: .constant(false))
            .environmentObject(TeamVM())
    }
}
