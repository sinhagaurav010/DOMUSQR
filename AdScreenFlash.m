//
//  AdScreenFlash.m
//  daqri
//
//  Created by gaurav on 19/06/11.
//  Copyright 2011 dhillon. All rights reserved.
//

#import "AdScreenFlash.h"


@implementation AdScreenFlash
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)startFlashAnimation
{
    self.alpha = 0.3;
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)]; //call when animation finished
    self.alpha = 1.0;
    [UIView commitAnimations];
}

- (void)animationFinished 
{   
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endOfFlashAnimation)];
    self.alpha = 0.0;    
    [UIView commitAnimations];
}

- (void)endOfFlashAnimation
{
    [self.delegate removeViewFlash];
}

- (void)dealloc
{
    [super dealloc];
}

@end
