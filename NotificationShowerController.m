#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 24.0f

@interface UIDevice (theiostream)
- (BOOL)isWildcat;
@end

@interface NotificationShowerController : NSObject <BBWeeAppController, UITextFieldDelegate>
{
	UIView *_view;
	UITextField *textField;
	NSMutableDictionary *dict;
}

@end

@implementation NotificationShowerController

- (void)dealloc {
	[_view release];
	[textField release];
	[super dealloc];
}

- (id)init
{
	if ((self = [super init])) {}
	return self;
}

- (UIView *)view
{
	if (!_view)
	{
		_view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
		
		dict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/am.theiostre.notificationshower.plist"];
		UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/NotificationShower.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
        UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
        bg.frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(15.0f, 0.0f, 440.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT);
        [_view addSubview:bg];
        [bg release];
		
		CGRect frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(20.0f, 0.0f, 430.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT);
		textField = [[UITextField alloc] initWithFrame:frame];
		textField.backgroundColor = [UIColor clearColor];
		textField.textColor = [UIColor whiteColor];
		if (![dict objectForKey:@"Text"])
			textField.text = @"Type something.";
		else
			textField.text = [dict objectForKey:@"Text"];
		textField.font = [UIFont fontWithName:@"Verdana" size:18.0];
		textField.textAlignment = UITextAlignmentCenter;
		textField.delegate = self;
		[_view addSubview:textField];
	}

	return _view;
}

- (void)textFieldDidEndEditing:(UITextField *)anotherTextField {
	[dict setObject:[anotherTextField text] forKey:@"Text"];
	[dict writeToFile:@"/var/mobile/Library/Preferences/am.theiostre.notificationshower.plist" atomically:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[aTextField resignFirstResponder];
	return YES;
}

- (float)viewHeight
{
	return VIEW_HEIGHT;
}

@end
