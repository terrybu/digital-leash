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
    
    NSMutableData *responseData;
    
}

//For Input Username and Create New User
@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (strong, nonatomic) NSString *tempStringHolder;


//Action buttons
- (IBAction)createNewUserButton:(id)sender;
- (IBAction)updateUserButton:(id)sender;
- (IBAction)checkLocationButton:(id)sender;



//textfield that populates for YES or NO for Zone confirmation
@property (strong, nonatomic) IBOutlet UITextField *zoneConfirmationField;


//label that changes to notify confirmation when user clicks on "create new user" or "update existing user"
@property (strong, nonatomic) IBOutlet UILabel *ConfirmLabel;


//for Locations, CLLocation, GPS, lat, long, radius
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *myLocation;

@property (strong, nonatomic) IBOutlet UITextField *longitudeTextfield;

@property (strong, nonatomic) IBOutlet UITextField *latitudeTextfield;

@property (strong, nonatomic) IBOutlet UITextField *radiusTextfield;



//For making requests
@property (strong, nonatomic) NSMutableURLRequest *myURLRequest;



@end
