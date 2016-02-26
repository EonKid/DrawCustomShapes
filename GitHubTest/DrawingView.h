//
//  DrawingView.h
//  GitHubTest
//
//  Created by OlDor on 2/26/16.
//  Copyright © 2016 OlDor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawingView;

@protocol DrawingViewDelegate <NSObject>

- (void)drawingView:(DrawingView * _Nonnull)theDrawingView didAddLineFromPoint:(CGPoint)theStartPoint toPoint:(CGPoint)theEndPoint;

@end

@interface DrawingView : UIView

@property (nonatomic, strong, nonnull) NSMutableArray<NSValue *> *thePointsArray;
@property (nonatomic, weak, nullable) id<DrawingViewDelegate> theDelegate;

@end






























