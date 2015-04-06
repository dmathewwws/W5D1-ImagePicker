//
//  ViewController.m
//  W5D1 - ImagePicker
//
//  Created by Daniel Mathews on 2015-04-05.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
}

- (IBAction)pressedAdd:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Choose Photo" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }];
        
        [actionSheet addAction:camera];
    }
    
    UIAlertAction *galleryAction = [UIAlertAction actionWithTitle:@"From Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    [actionSheet addAction:galleryAction];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel   handler:^(UIAlertAction *action) {
        
    }];
    
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([picker sourceType] == UIImagePickerControllerSourceTypeCamera) {
        // Do something with an image from the camera
        UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
    }
    
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.imageView.image = originalImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
