'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"android-chrome-192x192.png": "13308dac3f832a30a364ed6a1a819e50",
"android-chrome-512x512.png": "e4534be8b815c1f2c96ec2d58f0ecf44",
"apple-touch-icon.png": "6a6d583a428cd6d79943ee92bed4dc43",
"assets/AssetManifest.bin": "32b985c9d48cb4ef48b7dbf904f416ae",
"assets/AssetManifest.bin.json": "4611b8588749973023a281a88a945606",
"assets/AssetManifest.json": "d6f08ba3eb613e2c55dfdeef8f2131ef",
"assets/assets/icon.png": "b6d037e8aa6542dbeb816604e0f8a489",
"assets/assets/ingame/aggressive.png": "c432a3da10dfb636f73d317bb0ec3ec7",
"assets/assets/ingame/assaultrifle.png": "8dc6decfe357947213fa260cf1967153",
"assets/assets/ingame/autosentry.png": "6bfb7ccdddd87ce698d98ca981b0ad81",
"assets/assets/ingame/bat.png": "bbbc749844765a0cb33751ba0f70bee4",
"assets/assets/ingame/biotracker.png": "924f96f25222c00c8df76d4fed3d855e",
"assets/assets/ingame/bishop.png": "2cb10f70d98a87c1a567d5883f4bf2c3",
"assets/assets/ingame/bold.png": "4ff89d5ef1afb2c6fe97c7a72d30c0e2",
"assets/assets/ingame/bullpuprifle.png": "1edc7986af77b8ca91dd30910c52b3ba",
"assets/assets/ingame/burstcannon.png": "41d78453e8a225308d5c0182162b8c2e",
"assets/assets/ingame/burstpistol.png": "536141a34620b76d6691c0a65bead496",
"assets/assets/ingame/burstrifle.png": "fccfdd68c747969ad081b00af02cf706",
"assets/assets/ingame/burstsentry.png": "50c45a5f0478cc56fb598571e305b1e8",
"assets/assets/ingame/carbine.png": "1d558e58e4ba348e1751334941be8648",
"assets/assets/ingame/cfoam.png": "6e17d95189a0852d1124b46551958e90",
"assets/assets/ingame/chokemodshotgun.png": "9e7ca96aca6fbb3bd0d8597fc992f482",
"assets/assets/ingame/combatshotgun.png": "6f8488e1ec1f94be55f762f851c412d7",
"assets/assets/ingame/dauda.png": "6f69c5c23a7467c5d16907847613c4e9",
"assets/assets/ingame/dmr.png": "596f65535a672f985ea821ec2db9adf0",
"assets/assets/ingame/doubletaprifle.png": "fb2da4d88162601acd88453ff5521a2e",
"assets/assets/ingame/hackett.png": "db3eb300c9079d2056137776c31c75fe",
"assets/assets/ingame/hammer.png": "4e9171444ec996bc9c52df0e804851bc",
"assets/assets/ingame/heavyassaultrifle.png": "c350476c0dea83505daa71a7b4f94242",
"assets/assets/ingame/heavysmg.png": "921b7b8a4d5751d7bccde286970c9270",
"assets/assets/ingame/helautopistol.png": "0e614a3587b82402c4700754ea5aa5f2",
"assets/assets/ingame/helgun.png": "1fd0f649e938e52302aaf6c2479baf95",
"assets/assets/ingame/helrevolver.png": "d560b184a713294cfadeb314b0210a78",
"assets/assets/ingame/helrifle.png": "78e956dcfbc09503ce01c9c2507e4aed",
"assets/assets/ingame/helshotgun.png": "99760e48198b383483c8183a937e85f6",
"assets/assets/ingame/highcalpistol.png": "cc36ac9d569e283e3f6e85d069193077",
"assets/assets/ingame/knife.png": "aecfb5134671ea7446d58bb957b59c20",
"assets/assets/ingame/machinegunarbalist.png": "1117ff1a2f53f1c963cc8c3068022512",
"assets/assets/ingame/machinegunveruta.png": "7537f4a4f074e64e285cfcc6cee7b283",
"assets/assets/ingame/machinepistol.png": "a03cabc98c271b08af70d42ad6441a7d",
"assets/assets/ingame/minedeployer.png": "0a34b676ff1de53130d1ec155f8024e0",
"assets/assets/ingame/muted.png": "c3d135aaac9985ec0e54e63f5ec91273",
"assets/assets/ingame/pdw.png": "08d65216f2f311454c26f422f22837be",
"assets/assets/ingame/pistol.png": "b4a0c79580d3f9ad4d5aaf04bfaf1705",
"assets/assets/ingame/precisionrifle.png": "680cc9889cb38d921da56b9f351f43ce",
"assets/assets/ingame/prisoner_efficiency.png": "b106814afb234b24d3ba69f8bdfcbe5f",
"assets/assets/ingame/revolver.png": "77fb6afa8c02dbb5871490e188cc4081",
"assets/assets/ingame/rifle.png": "76eb646625110de54840591f1aeb27a4",
"assets/assets/ingame/sawedoffshotgun.png": "4d8bb7d0950f72befbf48918dfd9a759",
"assets/assets/ingame/scattergun.png": "8c9b13d0a96a0f4e999319109fd7ab9f",
"assets/assets/ingame/sector_main.png": "ec195529b55a3c50db231f4df4919cb1",
"assets/assets/ingame/sector_overload.png": "93d6a0258ebc8e366f540871162311b6",
"assets/assets/ingame/sector_secondary.png": "65a552ba865987096d289cb5d08a3aa8",
"assets/assets/ingame/shortrifle.png": "f292cacaa37f3b4d6ba7bfd1961797f2",
"assets/assets/ingame/shotgun.png": "eec7695f406d578a09e90ee26655d5b3",
"assets/assets/ingame/shotgunsentry.png": "fec830e8488b8dfc7282cd28bede8eec",
"assets/assets/ingame/slugshotgun.png": "b24fa54b670f7d39bafbe0c9c383237f",
"assets/assets/ingame/smg.png": "3cc0db58da09eeeca4e808161009bbf5",
"assets/assets/ingame/sniper.png": "d7bbd001896994a61300db13251c7017",
"assets/assets/ingame/snipersentry.png": "55ab1263252ffcd68f32bb9c0017529c",
"assets/assets/ingame/spear.png": "9ea04a6169bc91ad52c807d01f7ff35d",
"assets/assets/ingame/woods.png": "7cb7ff9d7d5bcff3f28500b97206927b",
"assets/FontManifest.json": "9a825267039377c019eb6b8e8e2d92e0",
"assets/fonts/fira_code/FiraCode-Regular.ttf": "301dd380625eb548238ae3c39ec9f12b",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/fonts/shared_tech/ShareTech-Regular.ttf": "1070bddc41a88e2b1745a34205d06c3d",
"assets/NOTICES": "18a8baca66136e2edf9f13c547365d44",
"assets/packages/community_material_icon/fonts/materialdesignicons-webfont.ttf": "84c7bd136590da0a6ed2c21df180c354",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "76bd55cc08e511bb603cc53003b81051",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "fe4e6158e0621262a33d1f224cb56fe0",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "08db72294d49e27f2d5603987dff8947",
"index.html": "f5750ec9167b96fad3f017880e8da0ca",
"/": "f5750ec9167b96fad3f017880e8da0ca",
"main.dart.js": "85e13f1a7efe9f761aa65d0cdaa27a85",
"manifest.json": "bfc6c8397b5e62254c068f062af1140c",
"site.webmanifest": "68808504d1d22a55416c0e3c8e59ac98",
"version.json": "b800482854414f1cbe4c8599b07c8aa3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
