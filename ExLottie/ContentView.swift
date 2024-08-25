//
//  ContentView.swift
//  ExLottie
//
//  Created by 김종권 on 2024/08/24.
//

import SwiftUI
import Lottie

struct ContentView: View {
    let text = "iOS 앱 개발 알아가기, 긴 텍스트가 있고 문자 마지막에 Lottie 애니메이션을 붙일 수 있는 방법을 알아봅시다. 예제 텍스트입니다."
    let maxWidth: CGFloat = 200
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                buildTextLines(from: text, maxWidth: maxWidth, availableWidth: geometry.size.width)
            }
            .padding()
        }
    }
    
    func buildTextLines(
        from text: String,
        maxWidth: CGFloat,
        availableWidth: CGFloat
    ) -> some View {
        let words = text.split(separator: " ").map(String.init)
        var currentLine = ""
        var lines: [String] = []
        
        for word in words {
            let potentialLine = currentLine.isEmpty ? word : "\(currentLine) \(word)"
            let textWidth = potentialLine.width(usingFont: .systemFont(ofSize: 17))
            
            if textWidth <= maxWidth {
                currentLine = potentialLine
            } else {
                lines.append(currentLine)
                currentLine = word
            }
        }
        
        lines.append(currentLine)
        
        return ForEach(lines.indices, id: \.self) { index in
            let line = lines[index]
            if index == lines.count - 1 {
                HStack(spacing: 0) {
                    Text(line)
                    
                    LottieView(animation: .named("sample"))
                        .playing(loopMode: .loop)
                        .frame(width: 30, height: 30)
                        .offset(x: -5)
                }
                .offset(y: -3) // 글자 간격을 맞추기 위한 임의의 값
            } else {
                Text(line)
                    .frame(maxWidth: availableWidth, alignment: .leading)
            }
        }
    }
}

extension String {
    func width(usingFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}

#Preview {
    ContentView()
}
