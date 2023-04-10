//
//  AddReviewSheet.swift
//  GoodGames
//
//  Created by Jackson Secrist on 3/13/23.
//

import SwiftUI
import Combine

struct AddReviewSheet: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    @State var review = ReviewHelper()
    
    @Binding var sheetIsPresented: Bool
    
    @State var waitingForSave = false
    
    @State var showHoursError = false
    @State var showTextError = false
    var animatedOpacity1: Double {
        showTextError ? 1.0 : 0
    }
    var animatedOpacity2: Double {
        showHoursError ? 1.0 : 0
    }
    
    var appid: Int
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    VStack(alignment: .leading){
                        Text("Please describe what you liked or disliked about this game.")
                        ZStack {
                            CustomFormTextField(placeholder: "Your thoughts...", textBinding: $review.text, keyboardType: .default)
                                .onChange(of: review.text, perform: { newValue in
                                    withAnimation {
                                        showTextError = false
                                    }
                                })
                            HStack {
                                Spacer()
                                Image(systemName: "exclamationmark.triangle.fill")
                                Text("Required")
                            }
                            .opacity(animatedOpacity1)
                            .foregroundColor(.red)
                            .padding(.trailing)
                        }
                        .padding(.bottom)
                        
                        Text("Please rate this game out of 5 stars.")
                        StarRatingInteractive(rating: $review.rating)
                            .padding(.top, 5)
                            .padding(.bottom)
                        
                        Text("How many hours have you played this game? (Approx)")
                        ZStack {
                            CustomFormTextField(placeholder: "Hours played...", textBinding: $review.hoursPlayed, keyboardType: .numberPad)
                                .onChange(of: review.hoursPlayed, perform: { newValue in
                                    withAnimation {
                                        showHoursError = false
                                    }
                                })
                            HStack {
                                Spacer()
                                Image(systemName: "exclamationmark.triangle.fill")
                                Text("Required")
                            }
                            .opacity(animatedOpacity2)
                            .foregroundColor(.red)
                            .padding(.trailing)
                        }
                        .padding(.bottom)
                    }
                    VStack {
                        Button {
                            guard review.hoursPlayed != "" && review.text != "" else {
                                if review.text == "" {
                                    withAnimation(Animation.easeOut(duration: 0.5)) {
                                        showTextError = true
                                    }
                                }
                                if review.hoursPlayed == "" {
                                    withAnimation {
                                        showHoursError = true
                                    }
                                }
                                return
                            }
                            
                            if let hoursPlayed = review.hoursPlayedInt, let game = gameVM.cachedGames[appid], let user = userVM.user {
                                let review = Review(
                                    appid: game.appid,
                                    appName: game.name,
                                    creationDate: Date(),
                                    hoursPlayed: hoursPlayed,
                                    inApp: true,
                                    rating: review.rating,
                                    ratingBool: review.rating >= 3 ? 1 : 0,
                                    text: review.text,
                                    userid: user.uid,
                                    username: user.username
                                )
                                gameVM.saveReview(review)
                                self.waitingForSave = true
                            }
                            
                        } label: {
                            Text("Post Review")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.primaryAccent)
                        .padding(.vertical)
                    }
                    .onChange(of: gameVM.reviewSavedSuccessfully) { newValue in
                        if newValue && self.waitingForSave {
                            sheetIsPresented = false
                        }
                    }
                    
                    if waitingForSave {
                        LoadingSpinner()
                    }
                }
                .padding()
                
                .navigationTitle("Write Review")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            sheetIsPresented = false
                        } label: {
                            Text("Cancel")
                        }.tint(Color.primaryAccent)
                    }
                }
                Spacer()
            }
            .background(Color.primaryBackground)
            .onTapGesture {
                self.hideKeyboard()
            }
        }
    }
}

struct CustomFormTextField: View {
    var placeholder: String
    @Binding var textBinding: String
    var keyboardType: UIKeyboardType
    
    var body: some View {
        TextField(placeholder, text: $textBinding)
            .keyboardType(keyboardType)
            .textFieldStyle(.plain)
            .tint(Color.primaryAccent)
            .padding(5)
            .background(background)
            
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.secondaryBackground)
    }
}

struct AddReviewSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewSheet(sheetIsPresented: .constant(true), appid: 1)
            .environmentObject(GameViewModel())
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
