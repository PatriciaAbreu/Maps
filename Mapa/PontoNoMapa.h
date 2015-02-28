//
//  PontoNoMapa.h
//  Mapa
//
//  Created by Patricia Machado de Abreu on 28/02/15.
//  Copyright (c) 2015 Patricia Machado de Abreu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface PontoNoMapa : NSObject <MKAnnotation>

// Novo construtor
-(id) initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;

@end
