//  QRCodeShareView.swift
//  CARDinal
//
//  Presents a large QR code representing the user's card JSON.
//
//  Created by AI Assistant on 9/30/25.

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeShareView: View {
    @EnvironmentObject var store: CardStore
    @Environment(\.dismiss) private var dismiss
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    @State private var qrImage: Image? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Spacer(minLength: 20)
                if let qrImage {
                    qrImage
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 260, height: 260)
                        .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 24).stroke(store.myCard.accentColor, lineWidth: 3))
                        .shadow(color: store.myCard.accentColor.opacity(0.35), radius: 25, y: 10)
                } else {
                    ProgressView().controlSize(.large)
                }
                Text(store.myCard.fullName)
                    .font(.headline)
                Text("Let them scan this code to add your card.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, 32)
            .navigationTitle("My QR Code")
            .toolbar { ToolbarItem(placement: .cancellationAction) { Button("Done") { dismiss() } } }
            .background(LinearGradient(colors: [Color.black, Color(white: 0.12)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
            .task { await generate() }
        }
    }

    private func generate() async {
        do {
            let payload = try store.qrPayload()
            filter.setValue(Data(payload.utf8), forKey: "inputMessage")
            if let output = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 10, y: 10)) {
                if let cg = context.createCGImage(output, from: output.extent) {
                    qrImage = Image(decorative: cg, scale: 1, orientation: .up)
                }
            }
        } catch {
            // fallback
        }
    }
}

#Preview {
    QRCodeShareView().environmentObject(CardStore())
}
