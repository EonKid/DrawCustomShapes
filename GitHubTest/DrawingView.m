//
//  DrawingView.m
//  GitHubTest
//
//  Created by OlDor on 2/26/16.
//  Copyright © 2016 OlDor. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

#pragma mark - Class Methods (Public)

#pragma mark - Class Methods (Private)

#pragma mark - Init & Dealloc

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self methodInitDrawingView];
    }
    return self;
}

- (void)methodInitDrawingView
{
    _thePointsArray = [NSMutableArray new];
    self.opaque = NO;
}

#pragma mark - Setters (Public)

#pragma mark - Getters (Public)

#pragma mark - Setters (Private)

#pragma mark - Getters (Private)

#pragma mark - Create Views & Variables

#pragma mark - Actions

#pragma mark - Gestures

#pragma mark - Delegates ()

#pragma mark - Methods (Public)

#pragma mark - Methods (Private)

#pragma mark - Standard Methods

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.thePointsArray.count)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
        return;
    }
    for (UIView *theView in self.subviews)
    {
        [theView removeFromSuperview];
    }
    
    CGPoint theFirstPoint = self.thePointsArray.firstObject.CGPointValue;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, theFirstPoint.x, theFirstPoint.y);
    
    for (NSUInteger theIndex = 1; theIndex < self.thePointsArray.count; theIndex++)
    {
        CGPoint theCurrentPoint = self.thePointsArray[theIndex].CGPointValue;
       
        CGContextAddLineToPoint(context, theCurrentPoint.x, theCurrentPoint.y);
        CGContextMoveToPoint(context, theCurrentPoint.x, theCurrentPoint.y);
        if (theIndex)
        {
            [self.theDelegate drawingView:self
                      didAddLineFromPoint:self.thePointsArray[theIndex - 1].CGPointValue
                                  toPoint:theCurrentPoint];
        }
        
        if (theIndex == self.thePointsArray.count - 1)
        {
            CGContextAddLineToPoint(context, theFirstPoint.x, theFirstPoint.y);
            [self.theDelegate drawingView:self
                      didAddLineFromPoint:theCurrentPoint
                                  toPoint:theFirstPoint];
        }
    }
    CGContextStrokePath(context);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (touches.count > 1)
    {
        return;
    }
    [self.thePointsArray addObject:[NSValue valueWithCGPoint:[touches.anyObject locationInView:self]]];
    
    [self setNeedsDisplay];
}

@end






























