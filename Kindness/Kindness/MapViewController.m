//
//  MapViewController.m
//  Kindness
//
//  Created by Ievgen Naloiko on 2/1/15.
//  Copyright (c) 2015 naloiko. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (strong) MKMapView *mapView;
@property (strong) UISlider *slider;
@property (strong) MKCircle *circle;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    {
        self.mapView = mapView;
        
        mapView.delegate = self;
        
        UITapGestureRecognizer *lpgr = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(handleGesture:)];
        lpgr.delegate = self;
        [mapView addGestureRecognizer:lpgr];
        
        [self.view addSubview:mapView];
    }
    
    UIToolbar *bottomToolBar = [UIToolbar new];
    {
        bottomToolBar.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
        [self.view addSubview:bottomToolBar];
    }
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    UISlider *slider = [UISlider new];
    {
        self.slider = slider;
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        slider.frame = CGRectMake(50, self.view.frame.size.height - 40, self.view.frame.size.width - 60, 40);
        slider.minimumValue = 100;
        slider.maximumValue = 13000;
        [self.view addSubview:slider];
    }
    
    
    [bottomToolBar setItems:@[buttonItem] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor redColor];
    circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
    return circleView;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    
    [self.mapView removeOverlay:self.circle];
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:loc.coordinate radius:self.slider.value];
    [circle setTitle:[NSString stringWithFormat:@"%.0f м.", self.slider.value]];
    self.circle = circle;
    [self.mapView addOverlay:circle];
}

- (void)sliderValueChanged:(UISlider*)slider
{
    CLLocationCoordinate2D location = self.circle.coordinate;
    [self.mapView removeOverlay:self.circle];
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:location radius:slider.value];
    [circle setTitle:[NSString stringWithFormat:@"%.0f м.", slider.value]];
    self.circle = circle;
    [self.mapView addOverlay:circle];
}

@end
