//
//  ViewController.m
//  Mapa
//
//  Created by Patricia Machado de Abreu on 28/02/15.
//  Copyright (c) 2015 Patricia Machado de Abreu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapa, locationManager;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    alocanção de memória para a variavel locationManager
    locationManager = [[CLLocationManager alloc]init];
    
//    mostra a locationManager quão exata deve ser a localização encontrada
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
//    informa que a propriedade delegate do locationManager deve ser a instancia de ViewController
    [locationManager setDelegate:self];
    
//    sinaliza a localização no mapa (circulo azul)
    self.mapa.showsUserLocation = YES;
    
    [locationManager setDelegate:self];
    
//    mapa.mapType = MKMapTypeHybrid;
//    mapa.mapType = MKMapTypeSatellite;
//    mapa.mapType = MKMapTypeStandard;
    
//    permite a autorizaçao para utilização do simulador
    if ([self->locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self->locationManager requestWhenInUseAuthorization];
    }

    
//    informa para iniciar a procura da localização imediatamente
    [locationManager startUpdatingLocation];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma master

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
   
     NSLog(@"%@", [locations lastObject]);
    
//    encontra as coordenadas da localização atual
    CLLocationCoordinate2D loc = [[locations lastObject]coordinate];
    
//    determina a regiao da localização atual e delimita o zoom
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
//    muda a região atual para a visualização de modo animado
    [mapa setRegion:region animated:YES];
    
    [locationManager stopUpdatingLocation];

}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"Error");

}

// botão para atualizar a localização no mapa
- (IBAction)atualizar:(id)sender {
    [locationManager startUpdatingLocation];
}

// botão que mostra os tipos de mapas (Padrão, Hibrido ou Satelite)
- (IBAction)tiposDeVisualizacoesDoMapa:(id)sender {
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            mapa.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapa.mapType = MKMapTypeHybrid;
            break;
        case 2:
            mapa.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}
@end
