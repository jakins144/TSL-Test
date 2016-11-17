//
//  ViewController.m
//  TSL App Test
//
//  Created by Owner on 11/7/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SignUpViewController.h"
#import "AFNetworking.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    SpotifyServiceManager *sharedManager = [SpotifyServiceManager sharedManager];
    [sharedManager requestAuthorization];
}

- (void) transitionToChoiceScreen:(NSNotification *) notification
{
    [self performSegueWithIdentifier:@"toChoice" sender:self];
}
@end
