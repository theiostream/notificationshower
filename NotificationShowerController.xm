#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 70.0f

@interface NotificationShowerController : NSObject <BBWeeAppController, UITextFieldDelegate>
{
	UIView *_view;
	NSDictionary *dict;
	UILabel *lbl;
	UITextField *textField;
	NSString *trigger;
}

@end

@implementation NotificationShowerController

- (void)dealloc {
	[_view release];
	[lbl release];
	[textField release];
	[super dealloc];
}

- (id)init
{
	if ((self = [super init]))
	{
		
	}
	return self;
}

- (UIView *)view
{
	if (!_view)
	{
		dict = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/am.theiostre.notificationshower.plist"];
		_view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];

		UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StocksWeeApp.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
        UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
        bg.frame = CGRectMake(0.0f, 0.0f, 316.0f, VIEW_HEIGHT);
        [_view addSubview:bg];
        [bg release];

	textField = [[UITextField alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
	textField.backgroundColor = [UIColor clearColor];
	textField.textColor = [UIColor whiteColor];
	textField.placeholder = @"Type your reminder here.";
	textField.font = [UIFont fontWithName:@"Verdana" size:24.0];
	textField.textAlignment = UITextAlignmentCenter;
	textField.delegate = self;
	[textField setHidden:TRUE];
	

	lbl = [[UILabel alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
	lbl.backgroundColor = [UIColor clearColor];
	lbl.textColor = [UIColor whiteColor];
	NSString *fieldtext = textField.text;
	trigger = @"asd";
	if ([trigger isEqualToString:@"asd"]) {
	lbl.text = @"Overwrite this placeholder.. Click me!";
	}
	else {
	lbl.text = fieldtext;
	}
	lbl.textAlignment = UITextAlignmentCenter;
	lbl.font = [UIFont fontWithName:@"Verdana" size:24.0];
	lbl.userInteractionEnabled = YES;
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLabelWithGesture:)];
	[lbl addGestureRecognizer:tapGesture];
	[_view addSubview:lbl];
	[_view addSubview:textField];
	[tapGesture release];
	[lbl release];
	[textField release];
	
	}

	return _view;
}

- (void)didTapLabelWithGesture:(UITapGestureRecognizer *)tapGesture {
	[lbl setHidden:TRUE];
	[textField setHidden:FALSE];
	
}

- (BOOL)textFieldShouldReturn:(UITextField *) anotherTextField {
	
	[textField resignFirstResponder];
	[textField setHidden:TRUE];
	[lbl setHidden:FALSE];
	trigger = @"yay";

	return YES; //I hope it's YES
}

- (float)viewHeight
{
	return VIEW_HEIGHT;
}

@end
