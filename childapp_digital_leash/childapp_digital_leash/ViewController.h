//
//  ViewController.h
//  childapp_digital_leash
//
//  Created by Aditya Narayan on 9/12/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, NSURLConnectionDelegate, UITextFieldDelegate> {
    
    CLLocationManager *locationManager;
    NSString *latitude, *longitude, *username;
    int callCount;
    
}


//properties
//@property (nonatomic) NSString *username;


//IBOutlets
@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;


// IBActions
- (IBAction)startUpdatingButton:(id)sender;

@end
