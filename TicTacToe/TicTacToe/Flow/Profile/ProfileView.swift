import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                Spacer()
                Button {
                    viewModel.handleXmarkTap()
                } label: {
                    Move.GameFigure.xmark.image
                        .resizable()
                        .frame(width: 12.0, height: 12.0)
                        .foregroundColor(Asset.Colors.Standard.white)
                        .padding(14.0)
                }
            }
            .padding(.bottom, 12.0)
            List {
                VStack(alignment: .leading) {
                    Text(L10n.Profile.List.gameType)
                        .font(.title2)
                    Picker("", selection: $viewModel.gameType) {
                        ForEach(GameType.allCases) { gameType in
                            Text(gameType.rawValue)
                                .tag(gameType)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            GeometryReader { geometry in
                Button {
                    viewModel.handleRestartTap()
                } label: {
                    Text(L10n.Profile.List.restart)
                        .frame(width: geometry.size.width, height: 50.0)
                        .foregroundColor(Asset.Colors.Standard.white)
                        .font(.headline)
                        .background(Asset.Colors.Specific.boardItem.color)
                }
            }
            .frame(height: 50.0)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ProfileView(viewModel: .init(diContainer: .preview))
                .preferredColorScheme(.dark)
        }
    }
}
