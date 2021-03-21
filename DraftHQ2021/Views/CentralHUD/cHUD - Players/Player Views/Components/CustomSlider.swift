//
//  CustomSlider.swift
//  DraftHQ2021
//
//  Created by Taylor Pubins on 5/21/20.
//  Copyright © 2020 trpubz. All rights reserved.
//

import SwiftUI

struct CustomSlider: View {
    @State var xOffset: CGFloat = 6
    @State var lastOffset: CGFloat = 0
    @Binding var value: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 30)
                    .foregroundColor(.gray)
                HStack {
                    Circle()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)
                        .offset(x: self.xOffset)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    if abs(value.translation.width) < 0.1 {
                                        self.lastOffset = self.xOffset
                                    }
                                    
                                    let sliderPos = max(6, min(self.lastOffset + value.translation.width, geometry.size.width - 6 - 22))
                                    self.xOffset = sliderPos
                                    let sliderVal = sliderPos.map(from: 6...(geometry.size.width - 6 - 22), to: 1...100)
                                    self.value = Int(sliderVal)
                                }
                        )
                    Spacer()
                }
            }
        }
        
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(value: .constant(69))
    }
}
