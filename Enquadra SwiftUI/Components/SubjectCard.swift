import SwiftUI

struct SubjectCard: View {
    let subjectName: String
    let subjectIcon: SubjectIcon
    let onEdit: () -> Void

    var body: some View {
        HStack {
            HStack(spacing: 16){
                VStack {
                    Image(systemName: subjectIcon.rawValue)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.sol)
                        .frame(width: 35, height: 35)
                }
                .frame(width: 58, height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.grafite)
                )

                Text(subjectName)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.grafite)
            }

            Spacer()

            VStack {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 28)
                    .foregroundStyle(.nublado)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 24).weight(.bold))
            }
            .onTapGesture {
                onEdit()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.ceuLimpo.opacity(0.8))
        )
        .shadow(color: .black.opacity(0.10), radius: 8, x: 0, y: 4)
    }
}
