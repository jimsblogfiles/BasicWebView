//
//  ViewController.m
//  BasicWebView
//
//  Created by James Border on 6/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void)initMyWebView;

@end

@implementation ViewController

-(void)initMyWebView {
	
	UIWebView *myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(10.0, 10.0, 300.0, 460.0)];
	myWebView.autoresizesSubviews = YES;
	
	
	// make webview transparent if you'd like
	myWebView.opaque = NO;
	myWebView.backgroundColor = [UIColor clearColor];
	
	
	// take the bounce of if you'd like 
	//for (id subview in myWebView.subviews)
	//	if ([[subview class] isSubclassOfClass: [UIScrollView class]])
	//		((UIScrollView *)subview).bounces = NO;
	
	
	// remove shadows if you'd like
	if ([[myWebView subviews] count] > 0) {
		
		for (UIView* shadowView in [[[myWebView subviews] objectAtIndex:0] subviews]) {
			[shadowView setHidden:YES];
		}
		
		// unhide the last view so it is visible again because it has the content
		[[[[[myWebView subviews] objectAtIndex:0] subviews] lastObject] setHidden:NO];
		
	}
	
	
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"File" ofType:@"html"]isDirectory:NO];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[myWebView loadRequest:requestObj];
	
	// the previous lines in one line
	//[myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"File" ofType:@"html"]isDirectory:NO]]];
	
	[myWebView setDelegate:self];
	
	[self.view addSubview:myWebView];
	
}

#pragma mark -
#pragma mark DELEGATE METHODS

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

	NSString *requestString = [[request URL] absoluteString];
	NSLog(@"request string:%@",requestString);
	
	// say for instance you only want local files to show up here try this
	if ( ! [requestString hasPrefix:@"file:"] ) {
		return NO;
	}
	
	return YES;

}

-(void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Webview started load");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Webview finished load");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSLog(@"Webview failed load");	
}

#pragma mark -
#pragma mark 

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[self initMyWebView];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
