// Configure Flutter web renderer
window.flutterWebRenderer = 'html';

// Load main Dart script
window.addEventListener('load', function(ev) {
  // Initialize Flutter
  var loading = document.querySelector('#loading');
  _flutter.loader.load({
    serviceWorker: {
      serviceWorkerVersion: serviceWorkerVersion,
    },
    onEntrypointLoaded: async function(engineInitializer) {
      // Initialize engine with HTML renderer
      let appRunner = await engineInitializer.initializeEngine({
        renderer: 'html',
        useColorEmoji: true
      });
      
      // Initialize platform view registry for web platform views
      if (window.hasOwnProperty('flutter_inappwebview')) {
        window.flutter_inappwebview.platformViewRegistry = {
          registerViewFactory: function(viewId, viewFactory) {
            // Register platform view factory
            var element = viewFactory(0);
            window.flutter_inappwebview._platformViewRegistry[viewId] = element;
          }
        };
      }

      // Run the app
      await appRunner.runApp();
      
      // Hide loading indicator if present
      if (loading) {
        loading.remove();
      }
    }
  });
});