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



#pragma mark - IBAction Methods
- (IBAction)startUpdatingButton:(id)sender {
    username = self.usernameTextfield.text;
    
    if (username.length > 0) {
        
    //username validation done - get the dictionary in JSON and send it
    [self makePATCHrequest: [NSString stringWithFormat: @"http://protected-wildwood-8664.herokuapp.com/users/%@", username]];
    }
    else {
        //when username is not even 1 character, throw an error dialog
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your username is too short"
                                                        message:@"Obviously, your username has to be at least 1 character"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}



#pragma mark Custom methods for sending HTTP requests
-(void) makePATCHrequest:(NSString *)urlstring {
    //create your dictionary to be sent
    NSDictionary *childDict = @{
                                @"user":@{
                                        @"username": username,
                                        @"current_lat": latitude,
                                        @"current_longitude": longitude
                                        },
                                @"commit":@"Create User",
                                @"action":@"update",
                                @"controller":@"users"
                                };
    NSLog(childDict.descriptionInStringsFileFormat);
    
    //turn it into JSON and put it into your request
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:childDict options:0 error:&error];
    NSString *myJSONString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData *myJSONrequest = [myJSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *requestURL = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *myURLRequest = [NSMutableURLRequest requestWithURL:requestURL];
    myURLRequest.HTTPMethod = @"PATCH";
    [myURLRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [myURLRequest setHTTPBody: myJSONrequest];
    //create url connection and fire the request you made above
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest: myURLRequest delegate: self];
    connect = nil;
    
    
    NSLog(@"Done making PATCH request");
}




#pragma mark NSURLConnection Delegate Methods

- (void) connection:(NSURLConnection* )connection didReceiveResponse:(NSURLResponse *)response {
    //this handler, gets hit ONCE
    //response has been received, we initialize the instance var we created in h file
    //then we append data to it in the didReceiveData method
    //    responseData = [[NSMutableData alloc] init];
    NSLog(@"%@", [response description]);
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
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"%@", [error localizedDescription]);
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
