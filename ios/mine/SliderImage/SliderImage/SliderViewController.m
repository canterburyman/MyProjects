//
//  SliderViewController.m
//  SliderImage
//
//  Created by Xinjun Email on 20/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SliderViewController.h"
#import "MapKit/MapKit.h"
#import "QuartzCore/QuartzCore.h"
#import "UIImage+Scale.h"


@interface ButtonInSlider : UIView
@property (retain, nonatomic) IBOutlet UIButton *button;

@end

@implementation ButtonInSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[[NSBundle mainBundle] loadNibNamed:@"ButtonInSlider" owner:self options:nil];
        //[self addSubview:self.button];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc {
    [_button release];
    [super dealloc];
}
@end

@interface SliderViewController ()

@property (retain, nonatomic) UIScrollView *sliderView;
@property int totalImageCount;
@end

@implementation SliderViewController
@synthesize sliderView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

#define BOTTOM_BOUNDARY 10
#define LEFT_BOUNDARY 5
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ButtonInSlider *buttonInSlider = [[[NSBundle mainBundle] loadNibNamed:@"ButtonInSlider" owner:self options:nil] lastObject];
    //ButtonInSlider *buttonInSlider = [[ButtonInSlider alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    CGFloat size = 45;
    CGRect bounds = self.view.bounds;
    self.sliderView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, bounds.size.height-size-BOTTOM_BOUNDARY, bounds.size.width, 80)] autorelease];
    self.sliderView.contentSize = CGSizeMake(1.5 * bounds.size.width, size);
    
	// Do any additional setup after loading the view.
  
    
    
    for (int i=0; i < 5; i++) {
        UIImage *firstImage = [UIImage imageNamed:@"Lake.jpg"];
        //UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        ButtonInSlider *firstButton = [[ButtonInSlider alloc] initWithFrame:CGRectMake(i*(LEFT_BOUNDARY+size)+LEFT_BOUNDARY, 0, size, size)];;
        
        //[[UIButton alloc] initWithFrame:CGRectMake(0, 0, size, size)];
        [firstButton setImage:firstImage forState:UIControlStateNormal];
        firstButton.layer.cornerRadius = 5;
        [firstButton.layer setMasksToBounds:YES];
        //firstButton.adjustsImageWhenHighlighted = NO;
        [firstButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        [self.sliderView addSubview:firstButton];
    }
    
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:bounds];
    [self.view addSubview:mapView];
    
    [self.view addSubview:self.sliderView];
    
}

-(void)click:(UIButton *) button
{
    NSLog(@"click button");

    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", @"Camera", nil];
    
    [actionSheet showInView:self.view];
    

}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            // Set source to the camera
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            
            // Delegate is self
            imagePicker.delegate = self;
            
            // Allow editing of image ?
            imagePicker.allowsEditing = YES;
            
            //Show image picker
            [self presentModalViewController:imagePicker animated:YES];	
        }
    }else if(buttonIndex == 1){
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
            
            // Set source to the camera
            imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            
            // Delegate is self
            imagePicker.delegate = self;
            
            // Allow editing of image ?
            imagePicker.allowsEditing = YES;
        
            //Show image picker
            [self presentModalViewController:imagePicker animated:YES];	
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"chosen image:%@", info);
    UIImage *newImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    int oldLength = [UIImagePNGRepresentation(newImage) length];
    UIImage *compressImage = [[[UIImage alloc] initWithData:UIImagePNGRepresentation(newImage)] scaleToSize:CGSizeMake(40, 40)];
    int length = [UIImagePNGRepresentation(compressImage) length];
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel image choose");
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
