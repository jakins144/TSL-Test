//
//  ViewController.m
//  TSL App Test
//
//  Created by Owner on 11/7/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(transitionToChoiceScreen:)
                                                 name:@"TokensSet"
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signUpButtonAction:(id)sender {
    SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
    [sharedManager requestAuthorization];
}

- (void) transitionToChoiceScreen:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    [self performSegueWithIdentifier:@"toChoice" sender:self];
}
@end
