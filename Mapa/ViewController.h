//
//  ViewController.h
//  Mapa
//
//  Created by Patricia Machado de Abreu on 28/02/15.
//  Copyright (c) 2015 Patricia Machado de Abreu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>


// declara uma instancia da classe MKMapView
@property (weak, nonatomic) IBOutlet MKMapView *mapa;

//    CLLocationManager - classe de interface com o hardware de localização do dispositivo
@property (retain) CLLocationManager *locationManager;


// Segmented Control - botão divido que mostra os tipos de mapas
- (IBAction)tiposDeVisualizacoesDoMapa:(id)sender;

//Button para atualizar o mapa
- (IBAction)atualizar:(id)sender;


@end

