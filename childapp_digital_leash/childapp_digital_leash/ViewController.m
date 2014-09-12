//
//  ViewController.m
//  childapp_digital_leash
//
//  Created by Aditya Narayan on 9/12/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    NSLog(@"Started updating Location");
    
    //implementing return-key keyboard clear
    [self.usernameTextfield setDelegate:self];
    
    //Implementing tap-out clear-keyboard functionality for the textfields
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CoreLocation Methods
- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations {
    CLLocation *myLocation = [locations lastObject];
    
    latitude = [[NSNumber numberWithFloat:myLocation.coordinate.latitude] stringValue];
    longitude = [[NSNumber numberWithFloat:myLocation.coordinate.longitude] stringValue];
    
    NSLog(@"%@", latitude);
    NSLog(@"%@", longitude);
}



- (IBAction)startUpdatingButton:(id)sender {
}


#pragma mark UITextFieldDelegate methods
-(void)dismissKeyboard {
    [self.usernameTextfield resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.usernameTextfield resignFirstResponder];
    return YES;
}


@end
