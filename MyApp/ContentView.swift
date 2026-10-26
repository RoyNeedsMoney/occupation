import SwiftUI

/// 代表一種可探索的職業資訊。
struct Career: Identifiable {
    let id: UUID
    let title: String
    let iconName: String
    let description: String
    let requiredSkill: String
    let funFact: String
}

struct ContentView: View {
    /// 提供抽籤器使用的多樣化職業資料。
    private let careers: [Career] = [
        Career(
            id: UUID(),
            title: "iOS 開發者",
            iconName: "laptopcomputer",
            description: "把靈感化為流暢好用的 App，並持續優化每一次點擊體驗。",
            requiredSkill: "SwiftUI 與解決問題能力",
            funFact: "一個貼心的微動畫，常常能讓 App 感覺更有生命力。"
        ),
        Career(
            id: UUID(),
            title: "航太工程師",
            iconName: "airplane",
            description: "設計飛行器與太空任務，讓人類的視野延伸到雲端之外。",
            requiredSkill: "物理、數學與系統思考",
            funFact: "在太空中，工程師得考慮連一顆螺絲都可能漂走。"
        ),
        Career(
            id: UUID(),
            title: "精品咖啡師",
            iconName: "cup.and.saucer.fill",
            description: "從選豆、研磨到萃取，用風味說出每一杯咖啡的故事。",
            requiredSkill: "味覺敏銳度與手沖技巧",
            funFact: "咖啡豆其實是咖啡果實裡的種子，不是一般的豆類。"
        ),
        Career(
            id: UUID(),
            title: "潛水教練",
            iconName: "figure.open.water.swim",
            description: "帶領人們安全探索海底世界，也守護海洋生態的美好。",
            requiredSkill: "水域安全與溝通能力",
            funFact: "許多魚能分辨潛水員的氣泡聲，並好奇地靠近觀察。"
        ),
        Career(
            id: UUID(),
            title: "電競選手",
            iconName: "gamecontroller.fill",
            description: "在高壓賽場上磨練反應與策略，和團隊一起追逐勝利。",
            requiredSkill: "專注力、戰術分析與團隊合作",
            funFact: "頂尖選手會把自己的每場比賽錄影，像教練一樣分析細節。"
        ),
        Career(
            id: UUID(),
            title: "資深貓咪行為學家",
            iconName: "pawprint.fill",
            description: "解讀貓咪的肢體語言，協助牠們與人類室友更和諧地生活。",
            requiredSkill: "耐心觀察與動物行為知識",
            funFact: "貓咪緩慢眨眼通常是在對你表達信任與友善。"
        )
    ]

    @State private var selectedCareer: Career

    init() {
        _selectedCareer = State(initialValue: careers[0])
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                AppHeader()

                Spacer(minLength: 0)

                CareerCard(career: selectedCareer)
                    .id(selectedCareer.id)
                    .transition(.opacity.combined(with: .scale(scale: 0.92)))

                Spacer(minLength: 0)

                Button(action: drawNextCareer) {
                    Label("探索下個職業", systemImage: "shuffle")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundStyle(.indigo)
                .accessibilityHint("隨機抽出一個新的職業介紹")
            }
            .padding(24)
            .frame(maxWidth: 560)
        }
    }

    /// 從職業清單中隨機抽出下一張卡片。
    private func drawNextCareer() {
        guard let nextCareer = careers.randomElement() else { return }

        withAnimation(.spring(response: 0.5, dampingFraction: 0.72)) {
            selectedCareer = nextCareer
        }
    }
}

/// 畫面頂端的引導資訊。
private struct AppHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "sparkles")
                .font(.title)
                .foregroundStyle(.yellow)

            Text("夢想職涯抽籤器")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text("抽一張卡，遇見下一個可能的你。")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.82))
        }
        .foregroundStyle(.white)
    }
}

/// 呈現職業詳細資訊的主卡片。
private struct CareerCard: View {
    let career: Career

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                Image(systemName: career.iconName)
                    .font(.system(size: 44, weight: .semibold))
                    .frame(width: 82, height: 82)
                    .foregroundStyle(.white)
                    .background(.indigo.gradient, in: Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("今日職涯靈感")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.secondary)

                    Text(career.title)
                        .font(.title2.bold())
                        .foregroundStyle(.primary)
                }
            }

            Text(career.description)
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            CareerDetailRow(
                title: "核心技能",
                iconName: "bolt.fill",
                content: career.requiredSkill,
                tint: .orange
            )

            CareerDetailRow(
                title: "趣味冷知識",
                iconName: "lightbulb.fill",
                content: career.funFact,
                tint: .pink
            )
        }
        .padding(24)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .strokeBorder(.white.opacity(0.35), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.18), radius: 20, y: 10)
    }
}

/// 卡片內可重複使用的職業資訊列。
private struct CareerDetailRow: View {
    let title: String
    let iconName: String
    let content: String
    let tint: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .foregroundStyle(tint)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(content)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#Preview {
    ContentView()
}
