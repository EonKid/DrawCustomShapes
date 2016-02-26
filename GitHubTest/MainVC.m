//
//  MainVC.m
//  GitHubTest
//
//  Created by OlDor on 2/25/16.
//  Copyright © 2016 OlDor. All rights reserved.
//

#import "MainVC.h"

#import "DrawingView.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainVC () <MKMapViewDelegate, DrawingViewDelegate>

@property (nonatomic, strong, nonnull) MKMapView *theMainMapView;
@property (nonatomic, strong, nonnull) DrawingView *theMainDrawingView;

@end

@implementation MainVC

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

#pragma mark - Setters (Public)

#pragma mark - Getters (Public)

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Lifecycle

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    MKMapView *theMainMapView = [MKMapView new];
    self.theMainMapView = theMainMapView;
    theMainMapView.delegate = self;
    [self.view addSubview:theMainMapView];
    theMainMapView.frame = theMainMapView.superview.frame;
    
    DrawingView *theMainDrawingView = [DrawingView new];
    self.theMainDrawingView = theMainDrawingView;
    theMainDrawingView.theDelegate = self;
    [self.view addSubview:theMainDrawingView];
    theMainDrawingView.frame = theMainDrawingView.superview.frame;
    
    UIButton *theSaveButton = [UIButton new];
    [self.view addSubview:theSaveButton];
    theSaveButton.frame = CGRectMake(0, 0, 200, 50);
    theSaveButton.backgroundColor = [UIColor redColor];
    [theSaveButton setTitle:@"SAVE" forState:UIControlStateNormal];
    [theSaveButton addTarget:self action:@selector(actionSave:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Create Views & Variables

#pragma mark - Actions

- (void)actionSave:(UIButton *)theButton
{
    NSUInteger theCount = self.theMainDrawingView.thePointsArray.count;
    CLLocationCoordinate2D theLocationCoordinatesArray[theCount];
    for (NSUInteger theIndex = 0; theIndex < theCount; theIndex++)
    {
        CGPoint thePoint = self.theMainDrawingView.thePointsArray[theIndex].CGPointValue;
        CLLocationCoordinate2D theLocationCoordinate2D = [self.theMainMapView convertPoint:thePoint toCoordinateFromView:self.theMainDrawingView];
        theLocationCoordinatesArray[theIndex] = theLocationCoordinate2D;
    }
    MKPolygon *thePolygon = [MKPolygon polygonWithCoordinates:theLocationCoordinatesArray count:theCount];
    [self.theMainMapView addOverlay:thePolygon];
    
    [self.theMainDrawingView removeFromSuperview];
    [theButton removeFromSuperview];
}

#pragma mark - Gestures

#pragma mark - Delegates (MKMapViewDelegate)

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if (![overlay isKindOfClass:[MKPolygon class]])
    {
        return nil;
    }
    MKPolygonView *thePolygonView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
    thePolygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
    thePolygonView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
    thePolygonView.lineWidth = 4;
    return thePolygonView;
}

#pragma mark - Delegates (DrawingViewDelegate)

- (void)drawingView:(DrawingView * _Nonnull)theDrawingView didAddLineFromPoint:(CGPoint)theStartPoint toPoint:(CGPoint)theEndPoint
{
    CLLocationCoordinate2D theStartLocationCoordinate2D = [self.theMainMapView convertPoint:theStartPoint toCoordinateFromView:self.theMainDrawingView];
    CLLocationCoordinate2D theEndLocationCoordinate2D = [self.theMainMapView convertPoint:theEndPoint toCoordinateFromView:self.theMainDrawingView];
    
    CLLocation *theStartLocation = [[CLLocation alloc] initWithLatitude:theStartLocationCoordinate2D.latitude longitude:theStartLocationCoordinate2D.longitude];
    CLLocation *theEndLocation = [[CLLocation alloc] initWithLatitude:theEndLocationCoordinate2D.latitude longitude:theEndLocationCoordinate2D.longitude];
    
    UILabel *theLabel = [UILabel new];
    [theDrawingView addSubview:theLabel];
    theLabel.text = [NSString stringWithFormat:@"%.1f km", [theStartLocation distanceFromLocation:theEndLocation]/1000];
    [theLabel sizeToFit];
    theLabel.textColor = [UIColor blackColor];
    theLabel.center = CGPointMake(theStartPoint.x/2 + theEndPoint.x/2, theStartPoint.y/2 + theEndPoint.y/2);
}

#pragma mark - Methods (Public)

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

@end






























