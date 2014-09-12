//
//  ViewController.h
//  Digital Leash
//
//  Created by Aditya Narayan on 9/8/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, NSURLConnectionDelegate, UITextFieldDelegate> {
    
}

//For Input Username and Create New User
@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (strong, nonatomic) NSString *tempStringHolder;

- (IBAction)createNewUserButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *createNewUserConfirmLabel;


//for Locations, CLLocation, GPS, lat, long, radius
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *myLocation;

@property (strong, nonatomic) IBOutlet UITextField *longitudeTextfield;

@property (strong, nonatomic) IBOutlet UITextField *latitudeTextfield;

@property (strong, nonatomic) IBOutlet UITextField *radiusTextfield;



//For making requests
@property (strong, nonatomic) NSMutableURLRequest *myURLRequest;



@end
