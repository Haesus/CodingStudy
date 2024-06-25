//
//  TwirlView.swift
//  SwiftUIAnimationTest
//
//  Created by 한수빈 on 6/24/24.
//

import SwiftUI

// 메인 뷰 구조체
struct TwirlView: View {
    @State var showAvatar = true // @State 속성으로 뷰의 상태를 관리

    var body: some View {
        VStack {
            Spacer()
            if showAvatar { // showAvatar가 true일 때만 AnimalPhoto를 표시
                AnimalPhoto(image: "Penguin")
                    .frame(width: 200, height: 200) // 프레임 크기 설정
                    .clipShape(Circle()) // 이미지를 원형으로 자름
                    .transition(.twirl) // 커스텀 트랜지션 적용
            }
            Button {
                withAnimation { // 애니메이션과 함께 showAvatar 상태를 토글
                    showAvatar.toggle()
                }
            } label: {
                Text("toggle") // 버튼 라벨
            }
            Spacer()
        }
        .padding() // 전체 뷰에 패딩 추가
    }
}

// AnyTransition을 확장하여 커스텀 트랜지션 정의
extension AnyTransition {
    static var twirl: AnyTransition {
        AnyTransition.modifier(
            active: TwirlModifier(phase: .active), // active 상태에서의 modifier
            identity: TwirlModifier(phase: .identity) // identity 상태에서의 modifier
        )
    }
}

// 커스텀 ViewModifier 정의
struct TwirlModifier: ViewModifier {
    var phase: TransitionPhase // 트랜지션의 현재 상태

    func body(content: Content) -> some View {
        content
            .scaleEffect(phase == .identity ? 1 : 0.5) // 크기 조절
            .opacity(phase == .identity ? 1 : 0) // 투명도 조절
            .blur(radius: phase == .identity ? 0 : 10) // 블러 효과
            .rotationEffect(.degrees(phase == .active ? 360 : -360)) // 회전 효과
            .brightness(phase == .active ? 1 : 0) // 밝기 조절
    }
}

// 트랜지션 상태를 나타내는 열거형
enum TransitionPhase {
    case active // 활성화 상태
    case identity // 기본 상태
}

// 프리뷰 제공
#Preview {
    TwirlView()
}
