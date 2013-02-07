#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 28.0f

@interface UIDevice (theiostream)
- (BOOL)isWildcat;
@end

@interface NotificationShowerController : NSObject <BBWeeAppController, UITextFieldDelegate>
{
	UIView *_view;
	UITextField *textField;
}

@end

@implementation NotificationShowerController

- (void)dealloc {
	[_view release];
	[textField release];
	[super dealloc];
}

- (UIView *)view
{
	if (!_view)
	{
		_view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
		
		NSString *string = [NSString stringWithContentsOfFile:@"/var/mobile/Library/notificationshower_i_am_sorry.txt" encoding:NSUTF8StringEncoding error:NULL];
		
		UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/NotificationShower.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
        UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
        bg.frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(4.0f, 0.0f, 470.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 312.0f, VIEW_HEIGHT);
        [_view addSubview:bg];
        [bg release];
		
		CGRect frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(4.0f, 2.0f, 470.0f, VIEW_HEIGHT-4.f) : CGRectMake(4.0f, 2.0f, 312.0f, VIEW_HEIGHT-4.f);
		textField = [[UITextField alloc] initWithFrame:frame];
		textField.backgroundColor = [UIColor clearColor];
		textField.textColor = [UIColor whiteColor];
		if (string == nil)
			textField.text = @"Type something.";
		else
			textField.text = string;
		textField.font = [UIFont fontWithName:@"Verdana" size:18.0];
		textField.textAlignment = UITextAlignmentCenter;
		textField.delegate = self;
		[_view addSubview:textField];
	}

	return _view;
}

- (void)textFieldDidEndEditing:(UITextField *)anotherTextField {
	[[anotherTextField text] writeToFile:@"/var/mobile/Library/notificationshower_i_am_sorry.txt" atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	NSLog(@"yay2");
	[aTextField resignFirstResponder];
	return YES;
}

- (float)viewHeight
{
	return VIEW_HEIGHT;
}

@end
