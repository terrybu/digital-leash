//
//  ViewController.h
//  Digital Leash
//
//  Created by Aditya Narayan on 9/8/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLConnectionDelegate, UITextFieldDelegate> {
    
}

@property (strong, nonatomic) NSMutableURLRequest *myURLRequest;

//For Input Username and Create New User

@property (strong, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (strong, nonatomic) NSString *tempStringHolder;

- (IBAction)createNewUserButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *createNewUserConfirmLabel;


//From Check Location


@end
