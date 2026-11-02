import SwiftUI

struct FlyAwayModifier: ViewModifier {
    @State private var isFlying = false
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .offset(
                x: isFlying ? 100 : 0,
                y: isFlying ? UIScreen.main.bounds.height * 1.2 : 0
            )
            .scaleEffect(isFlying ? 0.5 : 1)
            .opacity(isFlying ? 0 : 1)
            .rotationEffect(.degrees(isFlying ? 25 : 0))
            .onTapGesture {
                withAnimation(.timingCurve(0.4, 0, 0.8, 0.6, duration: 0.6)) {
                    isFlying = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    action()
                    isFlying = false
                }
            }
    }
}

extension View {
    func flyAway(action: @escaping () -> Void) -> some View {
        modifier(FlyAwayModifier(action: action))
    }
}
