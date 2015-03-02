//
//  ViewController.m
//  Mapa
//
//  Created by Patricia Machado de Abreu on 28/02/15.
//  Copyright (c) 2015 Patricia Machado de Abreu. All rights reserved.
//

#import "ViewController.h"
#import "PontoNoMapa.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapa, locationManager, mapaTap, pontosRota, antigaLinha;

PontoNoMapa *pm;
CLLocationCoordinate2D loc;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [mapa setDelegate:self];
    
    pontosRota = [[NSMutableArray alloc]init];
    
//    alocanção de memória para a variavel locationManager
    locationManager = [[CLLocationManager alloc]init];
    
//    mostra a locationManager quão exata deve ser a localização encontrada
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
//    informa que a propriedade delegate do locationManager deve ser a instancia de ViewController
    [locationManager setDelegate:self];
   
//    usado para tocar na tela e adicionar o PIN
    mapaTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tocar:)];
    
    [self.mapa addGestureRecognizer:mapaTap];
    
//    sinaliza a localização no mapa (circulo azul)
    self.mapa.showsUserLocation = YES;
    
//    informa que o delegate é o View Controller
    [locationManager setDelegate:self];
    
    
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

#pragma mark

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
   
    location = locations;
    
     NSLog(@"%@", [locations lastObject]);
    
//    encontra as coordenadas da localização atual
    loc = [[locations lastObject]coordinate];
    
//    determina a regiao da localização atual e delimita o zoom
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    
//    muda a região atual para a visualização de modo animado
    [mapa setRegion:region animated:YES];
    
    [pontosRota addObject:[locations lastObject]];
//    desenha rota atraves do método
    [self drawRoute: pontosRota];
    
//     pm = [[PontoNoMapa alloc] initWithCoordinate:loc title:@"I`m here!"];
    
//    [mapa addAnnotation:pm];
    
//    [locationManager stopUpdatingLocation];

}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"Error");

}

// botão para atualizar a localização no mapa
- (IBAction)atualizar:(id)sender {
    [locationManager startUpdatingLocation];
    [self drawRoute:pontosRota];
}

- (IBAction)marcarLocalizacao:(id)sender {
    
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D loc = [[location lastObject] coordinate];
    
    //Instanciar o MKPointAnnotation
    MKPointAnnotation *pm = [[MKPointAnnotation alloc]init];
    
    //Outra forma de Determinar a localização do MKPointAnnotation
    [pm setCoordinate: loc];
    
    [pm setTitle:@"You're here! 😁"];
    
    //Adicionar pm ao mapa
    [mapa addAnnotation:pm];
}

// método que implementa o PIN quando a tela é tocada
-(void) tocar:(UITapGestureRecognizer *)gestureRecognizer
{
//    identifica o ponto em que a tela foi tocada
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapa];
    
//    converte o ponto para coordenadas (latitude e longitude)
    CLLocationCoordinate2D toque = [self.mapa convertPoint:touchPoint toCoordinateFromView:self.mapa];

    NSLog(@"Localização do mapa: %f %f", toque.latitude, toque.longitude );
    
//    instancia PIN
    MKPointAnnotation *pm = [[MKPointAnnotation alloc] init];
    
//    atribui as coordenadas de onde a tela foi tocada para o PIN
    pm.coordinate = toque;
    
//    acrescenta o PIN na tela
    [mapa addAnnotation:pm];
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


-(void) drawRoute:(NSMutableArray *) pontos
{
    if (nil != antigaLinha) {
        [mapa removeOverlay:antigaLinha];
    }
    CLLocationCoordinate2D coordenadas[pontos.count];
    for (int i = 0; i < pontos.count; i++){
        CLLocation *local = [pontos objectAtIndex:i];
        CLLocationCoordinate2D coordenada = local.coordinate;
        
        coordenadas[i] = coordenada;
    }
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordenadas count:pontos.count];
    antigaLinha = polyLine;
    [mapa addOverlay:polyLine];
}

-(MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        
        renderer.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        renderer.lineWidth = 3;
        
        return renderer;
    }
    return nil;
}

@end
