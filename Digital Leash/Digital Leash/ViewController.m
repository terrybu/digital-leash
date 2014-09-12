//
//  ViewController.m
//  Digital Leash
//
//  Created by Aditya Narayan on 9/8/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //For CLLocation
    if([CLLocationManager locationServicesEnabled]){
        NSLog(@"location services enabled");
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self setLocationManager: locationManager];
        [self.locationManager setDelegate:self];
        [self.locationManager startUpdatingLocation];
        NSLog(@"Started updating Location");
    }

    //Setting delegate for UITextFieldDelegate
    [self.usernameTextfield setDelegate:self];
    [self.radiusTextfield setDelegate:self];
    
    
    //for Radius numberpad
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.radiusTextfield.inputAccessoryView = numberToolbar;
	
}




#pragma mark CLLocationManager Delegate Methods
- (void)locationManager:(CLLocationManager *)locationManager
     didUpdateLocations:(NSArray *)locations {
    self.myLocation = [locations lastObject];
    NSLog(@"%f", self.myLocation.coordinate.latitude);
    NSLog(@"%f", self.myLocation.coordinate.longitude);
    self.latitudeTextfield.text = [NSString stringWithFormat: @"%.5f", self.myLocation.coordinate.latitude];
    self.longitudeTextfield.text = [NSString stringWithFormat: @"%.5f", self.myLocation.coordinate.longitude];
}



- (IBAction)createNewUserButton:(id)sender {
    
    if (self.usernameTextfield.text && self.usernameTextfield.text.length > 0) {
        //creating the request URL
        NSURL *requestURL = [NSURL URLWithString:@"http://protected-wildwood-8664.herokuapp.com/users"];
        NSDictionary *userDetails = @{@"user": @{
                                              @"username": self.usernameTextfield.text,
                                              @"latitude": self.latitudeTextfield.text,
                                              @"longitude": self.longitudeTextfield.text,
                                              @"radius": self.radiusTextfield.text},
                                      @"commit":@"Create User",
                                      @"action":@"update",
                                      @"controller":@"users"
                                      };
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetails options:0 error:&error];
        NSString *myJSONString;
        myJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSData *myJSONrequest = [myJSONString dataUsingEncoding:NSUTF8StringEncoding];
        self.myURLRequest = [NSMutableURLRequest requestWithURL:requestURL];
        self.myURLRequest.HTTPMethod = @"POST";
        [self.myURLRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.myURLRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.myURLRequest setValue:[NSString stringWithFormat:@"%d", [myJSONrequest length]] forHTTPHeaderField:@"Content-Length"];
        [self.myURLRequest setHTTPBody: myJSONrequest];
        
        //create url connection and fire the request you made above
        NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest: self.myURLRequest delegate: self];
        self.createNewUserConfirmLabel.text = [NSString stringWithFormat:@"You did it, %@!",self.usernameTextfield.text];
        self.tempStringHolder = self.usernameTextfield.text;
        self.usernameTextfield.text = @"";
        
        [self.usernameTextfield resignFirstResponder];
    }

    else {
        NSLog(@"string too short");
        //Making a popup alert dialog WOOO
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your username is too short"
                                                        message:@"Obviously, your username has to be at least 1 character"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


#pragma mark NSURLConnection Delegate Methods

- (void) connection:(NSURLConnection* )connection didReceiveResponse:(NSURLResponse *)response {
    //this handler, gets hit ONCE
    //response has been received, we initialize the instance var we created in h file
    //then we append data to it in the didReceiveData method
    //    responseData = [[NSMutableData alloc] init];
}

- (void)connection: (NSURLConnection *)connection didReceiveData:(NSData *) dataYouGot {
    //this handler, gets hit SEVERAL TIMES
    //Append new data to the instance variable everytime new data comes in
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    //Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //this handler, gets hit ONCE
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now or do whatever you want
    
    NSLog(@"connection finished");
    NSLog(@"%@ was created on Oren's server", self.tempStringHolder);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}






#pragma mark UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.usernameTextfield resignFirstResponder];
    [self.radiusTextfield resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelNumberPad{
    [self.radiusTextfield resignFirstResponder];
    self.radiusTextfield.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = self.radiusTextfield.text;
    [self.radiusTextfield resignFirstResponder];
}



@end