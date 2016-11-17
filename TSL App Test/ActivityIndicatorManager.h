//
//  ActivityIndicatorManager.h
//  TSL App Test
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ActivityIndicatorManager : NSObject

-(void)startAnimating;
-(void)stopAnimating;

- (instancetype)initWithView:(UIView*)theView;

@end
