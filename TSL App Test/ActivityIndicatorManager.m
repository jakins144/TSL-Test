//
//  ActivityIndicatorManager.m
//  TSL App Test
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "ActivityIndicatorManager.h"

@interface ActivityIndicatorManager()
@property (strong,nonatomic) UIActivityIndicatorView *indicator;
@end

@implementation ActivityIndicatorManager

- (instancetype)initWithView:(UIView*)theView
{
    self = [super init];
    if (self) {
        self.indicator = [[UIActivityIndicatorView alloc]
                                                 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        self.indicator.center=theView.center;
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        //[self.indicator startAnimating];
        [theView addSubview:self.indicator];
        
    }
    return self;
}

#pragma mark - assisting custom methods

-(void)startAnimating
{
    [self.indicator startAnimating];
}

-(void)stopAnimating
{
    [self.indicator stopAnimating];
}

@end
