import React from 'react'
import GoogleMapReact from 'google-map-react'
import './map.css'
import LocationPin from "./Location";


const Map = ({location, zoomLevel}) => (
    <div className="map">
        <h2 className="map-h2">Come Visit Us At Our Campus</h2>

        <div className="google-map">
            <GoogleMapReact
                bootstrapURLKeys={{key: 'AIzaSyDnCTnF3Ntds-6mXbfhayJK2Bqm3afVXa8'}}
                defaultCenter={{
                    address: '1600 Amphitheatre Parkway, Mountain View, california.',
                    lat: 37.42216,
                    lng: -122.08427
                }}
                defaultZoom={17}
            >
                <LocationPin
                    lat={37.42216}
                    lng={-122.08427}
                    text={'1600 Amphitheatre Parkway, Mountain View, california.'}
                />
            </GoogleMapReact>
        </div>
    </div>
)

export default Map
