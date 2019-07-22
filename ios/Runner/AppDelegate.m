#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyAg2JiVvGTq9PI5u5KF3B5VXBVkuhDPQak"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
GMSPlacesClient.provideAPIKey("AIzaSyAg2JiVvGTq9PI5u5KF3B5VXBVkuhDPQak")
GMSServices.provideAPIKey("AIzaSyAg2JiVvGTq9PI5u5KF3B5VXBVkuhDPQak")
@end
