//
//  PhotoCalendarView.swift
//  training
//

import SwiftUI
import PhotosUI

struct PhotoCalendarView: View {
    @State private var selectedImage: UIImage?
    @State private var gallerySelection: PhotosPickerItem?
    @State private var showingCamera = false
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Group {
                    if let selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.secondary)
                            .padding(40)
                    }
                }
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))

                Button("Take Photo") {
                    showingCamera = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))

                PhotosPicker("Choose from Gallery", selection: $gallerySelection, matching: .images)
                    .buttonStyle(.bordered)

                Button {
                    withAnimation {
                        showingDatePicker.toggle()
                    }
                } label: {
                    HStack {
                        Text(selectedDate.formatted(date: .long, time: .omitted))
                            .foregroundStyle(.primary)
                        Spacer()
                        Image(systemName: "calendar")
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(.quaternary, in: RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .navigationTitle("Photo & Calendar")
        .sheet(isPresented: $showingCamera) {
            CameraPicker(image: $selectedImage)
        }
        .sheet(isPresented: $showingDatePicker) {
            WeekdayOnlyDatePickerSheet(selectedDate: $selectedDate)
                .presentationDetents([.medium])
        }
        .onChange(of: gallerySelection) { _, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                }
            }
        }
    }
}

struct CameraPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct WeekdayOnlyDatePickerSheet: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss
    @State private var displayedMonth: Date

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        self._displayedMonth = State(initialValue: selectedDate.wrappedValue)
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    changeMonth(by: -1)
                } label: {
                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text(displayedMonth.formatted(.dateTime.month(.wide).year()))
                    .font(.headline)

                Spacer()

                Button {
                    changeMonth(by: 1)
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            HStack {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(Array(daysInMonth.enumerated()), id: \.offset) { _, day in
                    if let day {
                        let isWeekend = calendar.isDateInWeekend(day)
                        let isSelected = calendar.isDate(day, inSameDayAs: selectedDate)

                        Button {
                            selectedDate = day
                            dismiss()
                        } label: {
                            Text("\(calendar.component(.day, from: day))")
                                .frame(maxWidth: .infinity, minHeight: 36)
                                .background(isSelected ? Color.accentColor : Color.clear, in: Circle())
                                .foregroundStyle(
                                    isWeekend ? Color.secondary.opacity(0.4) : (isSelected ? .white : .primary)
                                )
                        }
                        .disabled(isWeekend)
                    } else {
                        Color.clear
                            .frame(maxWidth: .infinity, minHeight: 36)
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
    }

    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) {
            displayedMonth = newMonth
        }
    }

    private var daysInMonth: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: displayedMonth),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return []
        }

        let leadingEmptyDays = (firstWeekday - calendar.firstWeekday + 7) % 7
        var days: [Date?] = Array(repeating: nil, count: leadingEmptyDays)

        var date = monthInterval.start
        while date < monthInterval.end {
            days.append(date)
            guard let next = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            date = next
        }

        return days
    }
}

#Preview {
    NavigationStack {
        PhotoCalendarView()
    }
}
