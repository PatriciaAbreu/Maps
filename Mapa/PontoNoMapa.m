//
//  PontoNoMapa.m
//  Mapa
//
//  Created by Patricia Machado de Abreu on 28/02/15.
//  Copyright (c) 2015 Patricia Machado de Abreu. All rights reserved.
//

#import "PontoNoMapa.h"
#import "ViewController.h"

@implementation PontoNoMapa

@synthesize coordinate, title;

//implementação do construtor com coordenada e titulo
-(id) initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}

@end
