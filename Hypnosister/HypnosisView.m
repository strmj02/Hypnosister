//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Rachel Johnson on 2/1/14.
//  Copyright (c) 2014 Rachel Johnson. All rights reserved.
//

#import "HypnosisterAppDelegate.h"
#import "HypnosisView.h"

@implementation HypnosisView

@synthesize circleColor;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor lightGrayColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)dirtyRect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width/ 2.0;
    center.y = bounds.origin.y + bounds.size.height/ 2.0;
    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    CGContextSetLineWidth(ctx, 10);

    //HERE BE THE BRONZE CHALLENGE CODE
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -=20){
        //This creates a random color for each circle upon initialization. When shaken, it still becomes red.
        circleColor = [UIColor colorWithRed:(float)rand() / RAND_MAX green:(float)rand() / RAND_MAX blue:(float)rand() / RAND_MAX alpha:1.0];
        [[self circleColor] setStroke];
        CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(ctx);
    }
    
    NSString *text = @"You are getting very sleepy.";
    UIFont *font = [UIFont boldSystemFontOfSize:24];
    
    CGRect textRect;
    
    textRect.size = [text sizeWithFont:font];
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    [[UIColor blackColor] setFill];
    
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
    [text drawInRect:textRect withFont:font];
    
    //MAKING THE GREEN CROSSHAIRS:SILVER CHALLENGE
    
     /* Push a copy of the current graphics state onto the graphics state stack.
     Note that the path is not considered part of the graphics state, and is
     not saved. */
    //CGContextSaveGState(ctx); //Not sure how to use this
    
    //Set thickness for Crosshairs
    CGContextSetLineWidth(ctx, 4);
    //Make the Crosshairs green
    [[UIColor greenColor] setStroke];
    
    /* Ensure that we are drawing starting at the center of the text. */
    CGContextMoveToPoint(ctx, center.x, center.y);
    /* Draw four lines (this could be done only using 2 lines. The way this is implemented
     has a line drawing diagonally in each of the 4 quadrants starting at the origin (or 0,0) (the center).*/
    CGContextAddLineToPoint(ctx, center.x + 20, center.y + 20);
    CGContextAddLineToPoint(ctx, center.x - 20, center.y - 20);
    /* Move the point back to the center to draw the other diagonal line */
    CGContextMoveToPoint(ctx, center.x, center.y);
    CGContextAddLineToPoint(ctx, center.x - 20, center.y + 20);
    CGContextAddLineToPoint(ctx, center.x + 20, center.y - 20);
    
    CGContextStrokePath(ctx);
    
    /* Restore the current graphics state from the one on the top of the
     graphics state stack, popping the graphics state stack in the process. */
    //CGContextRestoreGState(ctx);
    
    
    
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion ==UIEventSubtypeMotionShake){
        NSLog(@"Device started shaking");
        [self setCircleColor:[UIColor redColor]];
    }
}

-(void)setCircleColor:(UIColor *)clr{
    circleColor = clr;
    //COLOR CHANGES BUT THE DISPLAY DOES NOT CHANGE
    [self setNeedsDisplay];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

@end
