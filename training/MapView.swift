//
//  MapView.swift
//  training
//

import SwiftUI
import MapKit

struct MapView: View {
    let name: String

    private let jakartaCoordinate = CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
    private let bandungCoordinate = CLLocationCoordinate2D(latitude: -6.9175, longitude: 107.6191)
    private let puncakCoordinate = CLLocationCoordinate2D(latitude: -6.7320, longitude: 106.9896)

    @State private var showingBandung = false
    @State private var routeToPuncak: MKRoute?
    @State private var routeToBandung: MKRoute?
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    )

    var body: some View {
        VStack(spacing: 16) {
            Text("Hello, \(name)!")
                .font(.title)

            Map(position: $cameraPosition) {
                Marker("Jakarta, Indonesia", coordinate: jakartaCoordinate)

                if showingBandung {
                    Marker("Puncak, Bogor", coordinate: puncakCoordinate)
                    Marker("Bandung, Indonesia", coordinate: bandungCoordinate)

                    if let routeToPuncak {
                        MapPolyline(routeToPuncak.polyline)
                            .stroke(.blue, lineWidth: 4)
                    }

                    if let routeToBandung {
                        MapPolyline(routeToBandung.polyline)
                            .stroke(.blue, lineWidth: 4)
                    }
                }
            }

            Button(showingBandung ? "Back to Jakarta" : "Go to Bandung") {
                Task {
                    await toggleDestination()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Map")
    }

    private func toggleDestination() async {
        showingBandung.toggle()

        if showingBandung {
            await calculateRoute()
            withAnimation {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: -6.56, longitude: 107.13),
                        span: MKCoordinateSpan(latitudeDelta: 1.2, longitudeDelta: 1.6)
                    )
                )
            }
        } else {
            routeToPuncak = nil
            routeToBandung = nil
            withAnimation {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: jakartaCoordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                    )
                )
            }
        }
    }

    private func calculateRoute() async {
        async let puncakLeg = route(from: jakartaCoordinate, to: puncakCoordinate)
        async let bandungLeg = route(from: puncakCoordinate, to: bandungCoordinate)

        routeToPuncak = await puncakLeg
        routeToBandung = await bandungLeg
    }

    private func route(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) async -> MKRoute? {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        do {
            let directions = MKDirections(request: request)
            let response = try await directions.calculate()
            return response.routes.first
        } catch {
            return nil
        }
    }
}

#Preview {
    NavigationStack {
        MapView(name: "Jane")
    }
}
