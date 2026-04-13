{{flutter_js}}
{{flutter_build_config}}

// Force HTML renderer for SEO — CanvasKit renders on <canvas>, invisible to crawlers.
// HTML renderer uses real DOM elements (text, headings) that Google can index.
_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    let appRunner = await engineInitializer.initializeEngine({
      renderer: "html",
    });
    await appRunner.runApp();
  }
});
